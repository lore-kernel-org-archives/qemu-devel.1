Received: from eggs.gnu.org ([2001:4830:134:3::10]:59322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2iF-0006PM-Et
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2iC-0008Qh-9o
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:41:27 -0500
Date: Sat, 1 Dec 2018 10:41:12 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181201104112.GI27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-11-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-11-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] nbd/client: Split handshake into two
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Fri, Nov 30, 2018 at 04:03:39PM -0600, Eric Blake wrote:
> An upcoming patch will add the ability for qemu-nbd to list
> the services provided by an NBD server.  Share the common
> code of the TLS handshake by splitting the initial exchange
> into a separate function, leaving only the export handling
> in the original function.  Functionally, there should be no
> change in behavior in this patch, although some of the code
> motion may be difficult to follow due to indentation changes
> (view with 'git diff -w' for a smaller changeset).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c     | 142 ++++++++++++++++++++++++++++++-----------------
>  nbd/trace-events |   2 +-
>  2 files changed, 92 insertions(+), 52 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index 1ed5009642e..a282712724d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -768,21 +768,22 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>      return received || opt == NBD_OPT_LIST_META_CONTEXT;
>  }
> 
> -int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> -                          const char *hostname, QIOChannel **outioc,
> -                          NBDExportInfo *info, Error **errp)
> +/* Start the handshake to the server.  After a positive return, the server
> + * is ready to accept additional NBD_OPT requests.
> + * Returns: negative errno: failure talking to server
> + *          0: server is oldstyle, client must still parse export size
> + *          1: server is newstyle, but can only accept EXPORT_NAME
> + *          2: server is newstyle, but lacks structured replies
> + *          3: server is newstyle and set up for structured replies
> + */
> +static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> +                               const char *hostname, QIOChannel **outioc,
> +                               bool structured_reply, bool *zeroes,
> +                               Error **errp)
>  {
>      uint64_t magic;
> -    bool zeroes = true;
> -    bool structured_reply = info->structured_reply;
> -    bool base_allocation = info->base_allocation;
> 
> -    trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");
> -
> -    assert(info->name);
> -    trace_nbd_receive_negotiate_name(info->name);
> -    info->structured_reply = false;
> -    info->base_allocation = false;
> +    trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");
> 
>      if (outioc) {
>          *outioc = NULL;
> @@ -827,7 +828,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>              clientflags |= NBD_FLAG_C_FIXED_NEWSTYLE;
>          }
>          if (globalflags & NBD_FLAG_NO_ZEROES) {
> -            zeroes = false;
> +            *zeroes = false;
>              clientflags |= NBD_FLAG_C_NO_ZEROES;
>          }
>          /* client requested flags */
> @@ -849,7 +850,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>              }
>          }
>          if (fixedNewStyle) {
> -            int result;
> +            int result = 0;
> 
>              if (structured_reply) {
>                  result = nbd_request_simple_option(ioc,
> @@ -858,42 +859,86 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                  if (result < 0) {
>                      return -EINVAL;
>                  }
> -                info->structured_reply = result == 1;
>              }
> +            return 2 + result;
> +        } else {
> +            return 1;
> +        }
> +    } else if (magic == NBD_CLIENT_MAGIC) {
> +        if (tlscreds) {
> +            error_setg(errp, "Server does not support STARTTLS");
> +            return -EINVAL;
> +        }
> +        return 0;
> +    } else {
> +        error_setg(errp, "Bad magic received");
> +        return -EINVAL;
> +    }
> +}
> 
> -            if (info->structured_reply && base_allocation) {
> -                result = nbd_negotiate_simple_meta_context(
> +/* Connect to server, complete negotiation, and move into transmission phase.
> + * Returns: negative errno: failure talking to server
> + *          0: server is connected
> + */
> +int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> +                          const char *hostname, QIOChannel **outioc,
> +                          NBDExportInfo *info, Error **errp)
> +{
> +    int result;
> +    bool zeroes = true;
> +    bool base_allocation = info->base_allocation;
> +    uint32_t oldflags;
> +
> +    assert(info->name);
> +    trace_nbd_receive_negotiate_name(info->name);
> +
> +    result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
> +                                 info->structured_reply, &zeroes, errp);
> +
> +    info->structured_reply = false;
> +    info->base_allocation = false;
> +    if (tlscreds && *outioc) {
> +        ioc = *outioc;
> +    }
> +
> +    switch (result) {
> +    case 3: /* newstyle, with structured replies */
> +        info->structured_reply = true;
> +        if (base_allocation) {
> +            result = nbd_negotiate_simple_meta_context(
>                          ioc, NBD_OPT_SET_META_CONTEXT,
>                          info->x_dirty_bitmap ?: "base:allocation",
>                          info, errp);
> -                if (result < 0) {
> -                    return -EINVAL;
> -                }
> -                info->base_allocation = result == 1;
> -            }
> -
> -            /* Try NBD_OPT_GO first - if it works, we are done (it
> -             * also gives us a good message if the server requires
> -             * TLS).  If it is not available, fall back to
> -             * NBD_OPT_LIST for nicer error messages about a missing
> -             * export, then use NBD_OPT_EXPORT_NAME.  */
> -            result = nbd_opt_go(ioc, info, errp);
>              if (result < 0) {
>                  return -EINVAL;
>              }
> -            if (result > 0) {
> -                return 0;
> -            }
> -            /* Check our desired export is present in the
> -             * server export list. Since NBD_OPT_EXPORT_NAME
> -             * cannot return an error message, running this
> -             * query gives us better error reporting if the
> -             * export name is not available.
> -             */
> -            if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
> -                return -EINVAL;
> -            }
> +            info->base_allocation = result == 1;
>          }
> +        /* fall through */
> +    case 2: /* newstyle, try OPT_GO */
> +        /* Try NBD_OPT_GO first - if it works, we are done (it
> +         * also gives us a good message if the server requires
> +         * TLS).  If it is not available, fall back to
> +         * NBD_OPT_LIST for nicer error messages about a missing
> +         * export, then use NBD_OPT_EXPORT_NAME.  */
> +        result = nbd_opt_go(ioc, info, errp);
> +        if (result < 0) {
> +            return -EINVAL;
> +        }
> +        if (result > 0) {
> +            return 0;
> +        }
> +        /* Check our desired export is present in the
> +         * server export list. Since NBD_OPT_EXPORT_NAME
> +         * cannot return an error message, running this
> +         * query gives us better error reporting if the
> +         * export name is not available.
> +         */
> +        if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
> +            return -EINVAL;
> +        }
> +        /* fall through */
> +    case 1: /* newstyle, but limited to EXPORT_NAME */
>          /* write the export name request */
>          if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
>                                      errp) < 0) {
> @@ -912,17 +957,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>              return -EINVAL;
>          }
>          info->flags = be16_to_cpu(info->flags);
> -    } else if (magic == NBD_CLIENT_MAGIC) {
> -        uint32_t oldflags;
> -
> +        break;
> +    case 0: /* oldstyle, parse length and flags */
>          if (*info->name) {
>              error_setg(errp, "Server does not support non-empty export names");
>              return -EINVAL;
>          }
> -        if (tlscreds) {
> -            error_setg(errp, "Server does not support STARTTLS");
> -            return -EINVAL;
> -        }
> 
>          if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
>              error_prepend(errp, "Failed to read export length: ");
> @@ -940,9 +980,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>              return -EINVAL;
>          }
>          info->flags = oldflags;
> -    } else {
> -        error_setg(errp, "Bad magic received");
> -        return -EINVAL;
> +        break;
> +    default:
> +        return result;
>      }
> 
>      trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 5d0d202fad2..570b04997ff 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -12,7 +12,7 @@ nbd_receive_starttls_new_client(void) "Setting up TLS"
>  nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
>  nbd_opt_meta_request(const char *opt, const char *context, const char *export) "Requesting to %s %s for export %s"
>  nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of context %s to id %" PRIu32
> -nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
> +nbd_start_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
>  nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
>  nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
>  nbd_receive_negotiate_name(const char *name) "Requesting NBD export name \"%s\""

Pretty much a straight splitting out of the nbd_start_negotiate
feature into a separate function.  The only tricky bit is the return
code between the two functions, but the codes are amply documented.

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
