Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrTp-0006dv-6d
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrTk-0005T7-Af
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:41:48 -0500
Date: Fri, 30 Nov 2018 22:41:14 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130224114.GE27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/14] nbd/client: Refactor return of
 nbd_receive_negotiate()
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

On Fri, Nov 30, 2018 at 04:03:38PM -0600, Eric Blake wrote:
> The function could only ever return 0 or -EINVAL; make this
> clearer by dropping a useless 'fail:' label.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 51 +++++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index 27785c55d0a..1ed5009642e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -773,7 +773,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                            NBDExportInfo *info, Error **errp)
>  {
>      uint64_t magic;
> -    int rc;
>      bool zeroes = true;
>      bool structured_reply = info->structured_reply;
>      bool base_allocation = info->base_allocation;
> @@ -784,31 +783,30 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>      trace_nbd_receive_negotiate_name(info->name);
>      info->structured_reply = false;
>      info->base_allocation = false;
> -    rc = -EINVAL;
> 
>      if (outioc) {
>          *outioc = NULL;
>      }
>      if (tlscreds && !outioc) {
>          error_setg(errp, "Output I/O channel required for TLS");
> -        goto fail;
> +        return -EINVAL;
>      }
> 
>      if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
>          error_prepend(errp, "Failed to read data: ");
> -        goto fail;
> +        return -EINVAL;
>      }
>      magic = be64_to_cpu(magic);
>      trace_nbd_receive_negotiate_magic(magic);
> 
>      if (magic != NBD_INIT_MAGIC) {
>          error_setg(errp, "Invalid magic received");
> -        goto fail;
> +        return -EINVAL;
>      }
> 
>      if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
>          error_prepend(errp, "Failed to read magic: ");
> -        goto fail;
> +        return -EINVAL;
>      }
>      magic = be64_to_cpu(magic);
>      trace_nbd_receive_negotiate_magic(magic);
> @@ -820,7 +818,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> 
>          if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
>              error_prepend(errp, "Failed to read server flags: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          globalflags = be16_to_cpu(globalflags);
>          trace_nbd_receive_negotiate_server_flags(globalflags);
> @@ -836,18 +834,18 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>          clientflags = cpu_to_be32(clientflags);
>          if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
>              error_prepend(errp, "Failed to send clientflags field: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          if (tlscreds) {
>              if (fixedNewStyle) {
>                  *outioc = nbd_receive_starttls(ioc, tlscreds, hostname, errp);
>                  if (!*outioc) {
> -                    goto fail;
> +                    return -EINVAL;
>                  }
>                  ioc = *outioc;
>              } else {
>                  error_setg(errp, "Server does not support STARTTLS");
> -                goto fail;
> +                return -EINVAL;
>              }
>          }
>          if (fixedNewStyle) {
> @@ -858,7 +856,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                                                     NBD_OPT_STRUCTURED_REPLY,
>                                                     errp);
>                  if (result < 0) {
> -                    goto fail;
> +                    return -EINVAL;
>                  }
>                  info->structured_reply = result == 1;
>              }
> @@ -869,7 +867,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                          info->x_dirty_bitmap ?: "base:allocation",
>                          info, errp);
>                  if (result < 0) {
> -                    goto fail;
> +                    return -EINVAL;
>                  }
>                  info->base_allocation = result == 1;
>              }
> @@ -881,7 +879,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>               * export, then use NBD_OPT_EXPORT_NAME.  */
>              result = nbd_opt_go(ioc, info, errp);
>              if (result < 0) {
> -                goto fail;
> +                return -EINVAL;
>              }
>              if (result > 0) {
>                  return 0;
> @@ -893,25 +891,25 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>               * export name is not available.
>               */
>              if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
> -                goto fail;
> +                return -EINVAL;
>              }
>          }
>          /* write the export name request */
>          if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
>                                      errp) < 0) {
> -            goto fail;
> +            return -EINVAL;
>          }
> 
>          /* Read the response */
>          if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
>              error_prepend(errp, "Failed to read export length: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          info->size = be64_to_cpu(info->size);
> 
>          if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
>              error_prepend(errp, "Failed to read export flags: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          info->flags = be16_to_cpu(info->flags);
>      } else if (magic == NBD_CLIENT_MAGIC) {
> @@ -919,43 +917,40 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> 
>          if (*info->name) {
>              error_setg(errp, "Server does not support non-empty export names");
> -            goto fail;
> +            return -EINVAL;
>          }
>          if (tlscreds) {
>              error_setg(errp, "Server does not support STARTTLS");
> -            goto fail;
> +            return -EINVAL;
>          }
> 
>          if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
>              error_prepend(errp, "Failed to read export length: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          info->size = be64_to_cpu(info->size);
> 
>          if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
>              error_prepend(errp, "Failed to read export flags: ");
> -            goto fail;
> +            return -EINVAL;
>          }
>          oldflags = be32_to_cpu(oldflags);
>          if (oldflags & ~0xffff) {
>              error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
> -            goto fail;
> +            return -EINVAL;
>          }
>          info->flags = oldflags;
>      } else {
>          error_setg(errp, "Bad magic received");
> -        goto fail;
> +        return -EINVAL;
>      }
> 
>      trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
>      if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
>          error_prepend(errp, "Failed to read reserved block: ");
> -        goto fail;
> +        return -EINVAL;
>      }
> -    rc = 0;
> -
> -fail:
> -    return rc;
> +    return 0;
>  }
> 

Simple refactoring:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
