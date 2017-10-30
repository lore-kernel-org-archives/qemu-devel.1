Received: from eggs.gnu.org ([2001:4830:134:3::10]:56985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Dm9-0004fU-F1
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Dm4-0002zW-VG
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:23:01 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
Date: Mon, 30 Oct 2017 20:22:41 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 06/12] nbd/server: Refactor zero-length
 option check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

27.10.2017 13:40, Eric Blake wrote:
> Consolidate the response for a non-zero-length option payload
> into a new function, nbd_reject_length().  This check will
> also be used when introducing support for structured replies.
>
> Note that STARTTLS response differs based on time: if the connection
> is still unencrypted, we set fatal to true (a client that can't
> request TLS correctly may still think that we are ready to start
> the TLS handshake, so we must disconnect); while if the connection
> is already encrypted, the client is sending a bogus request but
> is no longer at risk of being confused by continuing the connection.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v6: split, rework logic to avoid subtle regression on starttls [Vladimir]
> v5: new patch
> ---
>   nbd/server.c | 74 +++++++++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 6af708662d..a98f5622c9 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -253,21 +253,10 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
>
>   /* Process the NBD_OPT_LIST command, with a potential series of replies.
>    * Return -errno on error, 0 on success. */
> -static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
> -                                     Error **errp)
> +static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
>   {
>       NBDExport *exp;
>
> -    if (length) {
> -        if (nbd_drop(client->ioc, length, errp) < 0) {
> -            return -EIO;
> -        }
> -        return nbd_negotiate_send_rep_err(client->ioc,
> -                                          NBD_REP_ERR_INVALID, NBD_OPT_LIST,
> -                                          errp,
> -                                          "OPT_LIST should not have length");
> -    }
> -
>       /* For each export, send a NBD_REP_SERVER reply. */
>       QTAILQ_FOREACH(exp, &exports, next) {
>           if (nbd_negotiate_send_rep_list(client->ioc, exp, errp)) {
> @@ -531,7 +520,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
>   /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
>    * new channel for all further (now-encrypted) communication. */
>   static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
> -                                                 uint32_t length,
>                                                    Error **errp)
>   {
>       QIOChannel *ioc;
> @@ -540,15 +528,6 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
>
>       trace_nbd_negotiate_handle_starttls();
>       ioc = client->ioc;
> -    if (length) {
> -        if (nbd_drop(ioc, length, errp) < 0) {
> -            return NULL;
> -        }
> -        nbd_negotiate_send_rep_err(ioc, NBD_REP_ERR_INVALID, NBD_OPT_STARTTLS,
> -                                   errp,
> -                                   "OPT_STARTTLS should not have length");
> -        return NULL;
> -    }
>
>       if (nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
>                                  NBD_OPT_STARTTLS, errp) < 0) {
> @@ -584,6 +563,34 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
>       return QIO_CHANNEL(tioc);
>   }
>
> +/* nbd_reject_length: Handle any unexpected payload.
> + * @fatal requests that we quit talking to the client, even if we are able
> + * to successfully send an error to the guest.
> + * Return:
> + * -errno  transmission error occurred or @fatal was requested, errp is set
> + * 0       error message successfully sent to client, errp is not set
> + */
> +static int nbd_reject_length(NBDClient *client, uint32_t length,
> +                             uint32_t option, bool fatal, Error **errp)
> +{
> +    int ret;
> +
> +    assert(length);
> +    if (nbd_drop(client->ioc, length, errp) < 0) {
> +        return -EIO;
> +    }
> +    ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID,
> +                                     option, errp,
> +                                     "option '%s' should have zero length",
> +                                     nbd_opt_lookup(option));
> +    if (fatal && !ret) {
> +        error_setg(errp, "option '%s' should have zero length",
> +                   nbd_opt_lookup(option));
> +        return -EINVAL;
> +    }
> +    return ret;
> +}
> +
>   /* nbd_negotiate_options
>    * Process all NBD_OPT_* client option commands, during fixed newstyle
>    * negotiation.
> @@ -674,7 +681,13 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>               }
>               switch (option) {
>               case NBD_OPT_STARTTLS:
> -                tioc = nbd_negotiate_handle_starttls(client, length, errp);
> +                if (length) {
> +                    /* Unconditionally drop the connection if the client
> +                     * can't start a TLS negotiation correctly */
> +                    nbd_reject_length(client, length, option, true, errp);
> +                    return -EINVAL;

why not to return nbd_reject_length's result? this EINVAL may not 
correspond to errp (about EIO for example)..

with or without this fixed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +                }
> +                tioc = nbd_negotiate_handle_starttls(client, errp);
>                   if (!tioc) {
>                       return -EIO;
>                   }
> @@ -709,7 +722,12 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>           } else if (fixedNewstyle) {
>               switch (option) {
>               case NBD_OPT_LIST:
> -                ret = nbd_negotiate_handle_list(client, length, errp);
> +                if (length) {
> +                    ret = nbd_reject_length(client, length, option, false,
> +                                            errp);
> +                } else {
> +                    ret = nbd_negotiate_handle_list(client, errp);
> +                }
>                   break;
>
>               case NBD_OPT_ABORT:
> @@ -735,10 +753,10 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                   break;
>
>               case NBD_OPT_STARTTLS:
> -                if (nbd_drop(client->ioc, length, errp) < 0) {
> -                    return -EIO;
> -                }
> -                if (client->tlscreds) {
> +                if (length) {
> +                    ret = nbd_reject_length(client, length, option, false,
> +                                            errp);
> +                } else if (client->tlscreds) {
>                       ret = nbd_negotiate_send_rep_err(client->ioc,
>                                                        NBD_REP_ERR_INVALID,
>                                                        option, errp,


-- 
Best regards,
Vladimir
