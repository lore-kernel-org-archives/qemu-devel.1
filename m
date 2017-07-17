Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXDG4-0003GZ-TI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXDG3-0000Uj-Ma
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:08:48 -0400
References: <20170717192635.17880-1-eblake@redhat.com>
	<20170717192635.17880-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2cd61de1-e169-4aee-b91c-04960727278e@redhat.com>
Date: Mon, 17 Jul 2017 17:08:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170717192635.17880-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] nbd: Fix server reply to
 NBD_OPT_EXPORT_NAME of older clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org



On 07/17/2017 03:26 PM, Eric Blake wrote:
> A typo in commit 23e099c set the size of buf[] used in response
> to NBD_OPT_EXPORT_NAME according to the length needed for old-style
> negotiation (4 bytes of flag information) instead of the intended
> 2 bytes used in new style.  If the client doesn't enable
> NBD_FLAG_C_NO_ZEROES, then the server sends two bytes too many,
> and is then out of sync in response to the client's next command
> (the bug is masked when modern qemu is the client, since we enable
> the no zeroes flag).
> 
> While touching this code, add some more defines to nbd_internal.h
> rather than having quite so many magic numbers in the .c; also,
> use "" initialization rather than memset(), and tweak the oldstyle
> negotiation to better match the spec description of the layout
> (since the spec is big-endian, skipping two bytes as 0 followed by
> writing a 2-byte flag is the same as writing a zero-extended 4-byte
> flag), to make it a bit easier to follow compared to the spec.
> 
> [checkpatch.pl has some false positives in the comments]
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: defines rather than magic numbers [John]
> ---
>  nbd/nbd-internal.h |  8 ++++++--
>  nbd/server.c       | 18 ++++++++++--------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 4065bc68ac..396ddb4d3e 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -38,9 +38,13 @@
>   */
> 
>  /* Size of all NBD_OPT_*, without payload */
> -#define NBD_REQUEST_SIZE        (4 + 2 + 2 + 8 + 8 + 4)
> +#define NBD_REQUEST_SIZE            (4 + 2 + 2 + 8 + 8 + 4)
>  /* Size of all NBD_REP_* sent in answer to most NBD_OPT_*, without payload */
> -#define NBD_REPLY_SIZE          (4 + 4 + 8)
> +#define NBD_REPLY_SIZE              (4 + 4 + 8)
> +/* Size of reply to NBD_OPT_EXPORT_NAME */
> +#define NBD_REPLY_EXPORT_NAME_SIZE  (8 + 2 + 124)
> +/* Size of oldstyle negotiation */
> +#define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
> 
>  #define NBD_REQUEST_MAGIC       0x25609513
>  #define NBD_REPLY_MAGIC         0x67446698
> diff --git a/nbd/server.c b/nbd/server.c
> index 49ed57455c..82a78bf439 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -283,12 +283,16 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
>                                              Error **errp)
>  {
>      char name[NBD_MAX_NAME_SIZE + 1];
> -    char buf[8 + 4 + 124] = "";
> +    char buf[NBD_REPLY_EXPORT_NAME_SIZE] = "";
>      size_t len;
>      int ret;
> 
>      /* Client sends:
>          [20 ..  xx]   export name (length bytes)
> +       Server replies:
> +        [ 0 ..   7]   size
> +        [ 8 ..   9]   export flags
> +        [10 .. 133]   reserved     (0) [unless no_zeroes]

Alright, there's the 8, 2, 124.

>       */
>      trace_nbd_negotiate_handle_export_name();
>      if (length >= sizeof(name)) {
> @@ -800,22 +804,21 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>   */
>  static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>  {
> -    char buf[8 + 8 + 8 + 128];
> +    char buf[NBD_OLDSTYLE_NEGOTIATE_SIZE] = "";

huh, TIL.

>      int ret;
>      const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
>                                NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
>                                NBD_FLAG_SEND_WRITE_ZEROES);
>      bool oldStyle;
> 
> -    /* Old style negotiation header without options
> +    /* Old style negotiation header, no room for options
>          [ 0 ..   7]   passwd       ("NBDMAGIC")
>          [ 8 ..  15]   magic        (NBD_CLIENT_MAGIC)
>          [16 ..  23]   size
> -        [24 ..  25]   server flags (0)
> -        [26 ..  27]   export flags
> +        [24 ..  27]   export flags (zero-extended)
>          [28 .. 151]   reserved     (0)

And there's the 8, 8, 8, 4, 124.

> 
> -       New style negotiation header with options
> +       New style negotiation header, client can send options
>          [ 0 ..   7]   passwd       ("NBDMAGIC")
>          [ 8 ..  15]   magic        (NBD_OPTS_MAGIC)
>          [16 ..  17]   server flags (0)
> @@ -825,7 +828,6 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>      qio_channel_set_blocking(client->ioc, false, NULL);
> 
>      trace_nbd_negotiate_begin();
> -    memset(buf, 0, sizeof(buf));
>      memcpy(buf, "NBDMAGIC", 8);
> 
>      oldStyle = client->exp != NULL && !client->tlscreds;
> @@ -834,7 +836,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>                                        client->exp->nbdflags | myflags);
>          stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
>          stq_be_p(buf + 16, client->exp->size);
> -        stw_be_p(buf + 26, client->exp->nbdflags | myflags);
> +        stl_be_p(buf + 24, client->exp->nbdflags | myflags);

Makes sense to me.

> 
>          if (nbd_write(client->ioc, buf, sizeof(buf), errp) < 0) {
>              error_prepend(errp, "write failed: ");
> 

Thanks,

Reviewed-by: John Snow <jsnow@redhat.com>
