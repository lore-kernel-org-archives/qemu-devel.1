Received: from eggs.gnu.org ([2001:4830:134:3::10]:35094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHaq-0005Cg-0W
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHal-0006bQ-Tc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:28:16 -0500
References: <20171113152424.25381-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1b881fe-c715-b5e2-c8a1-4cb4af2ba341@virtuozzo.com>
Date: Mon, 13 Nov 2017 19:27:55 +0300
MIME-Version: 1.0
In-Reply-To: <20171113152424.25381-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

13.11.2017 18:24, Eric Blake wrote:
> When using error prepend(), it is necessary to end with a space
> in the format string; otherwise, messages come out incorrectly,
> such as when connecting to a socket that hangs up immediately:
>
> can't open device nbd://localhost:10809/: Failed to read dataUnexpected end-of-file before all bytes were read
>
> Originally botched in commit e44ed99d, then several more instances
> added in the meantime.
>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/client.c | 50 ++++++++++++++++++++++++++------------------------
>   1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 1880103d2a..4e15fc484d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -79,12 +79,12 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
>       stl_be_p(&req.length, len);
>
>       if (nbd_write(ioc, &req, sizeof(req), errp) < 0) {
> -        error_prepend(errp, "Failed to send option request header");
> +        error_prepend(errp, "Failed to send option request header: ");
>           return -1;
>       }
>
>       if (len && nbd_write(ioc, (char *) data, len, errp) < 0) {
> -        error_prepend(errp, "Failed to send option request data");
> +        error_prepend(errp, "Failed to send option request data: ");
>           return -1;
>       }
>
> @@ -113,7 +113,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
>   {
>       QEMU_BUILD_BUG_ON(sizeof(*reply) != 20);
>       if (nbd_read(ioc, reply, sizeof(*reply), errp) < 0) {
> -        error_prepend(errp, "failed to read option reply");
> +        error_prepend(errp, "failed to read option reply: ");
>           nbd_send_opt_abort(ioc);
>           return -1;
>       }
> @@ -166,7 +166,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
>           msg = g_malloc(reply->length + 1);
>           if (nbd_read(ioc, msg, reply->length, errp) < 0) {
>               error_prepend(errp, "failed to read option error 0x%" PRIx32
> -                          " (%s) message",
> +                          " (%s) message: ",
>                             reply->type, nbd_rep_lookup(reply->type));
>               goto cleanup;
>           }
> @@ -277,7 +277,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
>           return -1;
>       }
>       if (nbd_read(ioc, &namelen, sizeof(namelen), errp) < 0) {
> -        error_prepend(errp, "failed to read option name length");
> +        error_prepend(errp, "failed to read option name length: ");
>           nbd_send_opt_abort(ioc);
>           return -1;
>       }
> @@ -290,7 +290,8 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
>       }
>       if (namelen != strlen(want)) {
>           if (nbd_drop(ioc, len, errp) < 0) {
> -            error_prepend(errp, "failed to skip export name with wrong length");
> +            error_prepend(errp,
> +                          "failed to skip export name with wrong length: ");
>               nbd_send_opt_abort(ioc);
>               return -1;
>           }
> @@ -299,14 +300,14 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
>
>       assert(namelen < sizeof(name));
>       if (nbd_read(ioc, name, namelen, errp) < 0) {
> -        error_prepend(errp, "failed to read export name");
> +        error_prepend(errp, "failed to read export name: ");
>           nbd_send_opt_abort(ioc);
>           return -1;
>       }
>       name[namelen] = '\0';
>       len -= namelen;
>       if (nbd_drop(ioc, len, errp) < 0) {
> -        error_prepend(errp, "failed to read export description");
> +        error_prepend(errp, "failed to read export description: ");
>           nbd_send_opt_abort(ioc);
>           return -1;
>       }
> @@ -390,7 +391,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               return -1;
>           }
>           if (nbd_read(ioc, &type, sizeof(type), errp) < 0) {
> -            error_prepend(errp, "failed to read info type");
> +            error_prepend(errp, "failed to read info type: ");
>               nbd_send_opt_abort(ioc);
>               return -1;
>           }
> @@ -405,13 +406,13 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>                   return -1;
>               }
>               if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
> -                error_prepend(errp, "failed to read info size");
> +                error_prepend(errp, "failed to read info size: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
>               be64_to_cpus(&info->size);
>               if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
> -                error_prepend(errp, "failed to read info flags");
> +                error_prepend(errp, "failed to read info flags: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -428,7 +429,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               }
>               if (nbd_read(ioc, &info->min_block, sizeof(info->min_block),
>                            errp) < 0) {
> -                error_prepend(errp, "failed to read info minimum block size");
> +                error_prepend(errp, "failed to read info minimum block size: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -441,7 +442,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               }
>               if (nbd_read(ioc, &info->opt_block, sizeof(info->opt_block),
>                            errp) < 0) {
> -                error_prepend(errp, "failed to read info preferred block size");
> +                error_prepend(errp,
> +                              "failed to read info preferred block size: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -455,7 +457,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               }
>               if (nbd_read(ioc, &info->max_block, sizeof(info->max_block),
>                            errp) < 0) {
> -                error_prepend(errp, "failed to read info maximum block size");
> +                error_prepend(errp, "failed to read info maximum block size: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -467,7 +469,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>           default:
>               trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
>               if (nbd_drop(ioc, len, errp) < 0) {
> -                error_prepend(errp, "Failed to read info payload");
> +                error_prepend(errp, "Failed to read info payload: ");
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -618,7 +620,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>       }
>
>       if (nbd_read(ioc, buf, 8, errp) < 0) {
> -        error_prepend(errp, "Failed to read data");
> +        error_prepend(errp, "Failed to read data: ");
>           goto fail;
>       }
>
> @@ -637,7 +639,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>       }
>
>       if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
> -        error_prepend(errp, "Failed to read magic");
> +        error_prepend(errp, "Failed to read magic: ");
>           goto fail;
>       }
>       magic = be64_to_cpu(magic);
> @@ -649,7 +651,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>           bool fixedNewStyle = false;
>
>           if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
> -            error_prepend(errp, "Failed to read server flags");
> +            error_prepend(errp, "Failed to read server flags: ");
>               goto fail;
>           }
>           globalflags = be16_to_cpu(globalflags);
> @@ -665,7 +667,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>           /* client requested flags */
>           clientflags = cpu_to_be32(clientflags);
>           if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
> -            error_prepend(errp, "Failed to send clientflags field");
> +            error_prepend(errp, "Failed to send clientflags field: ");
>               goto fail;
>           }
>           if (tlscreds) {
> @@ -727,13 +729,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>
>           /* Read the response */
>           if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
> -            error_prepend(errp, "Failed to read export length");
> +            error_prepend(errp, "Failed to read export length: ");
>               goto fail;
>           }
>           be64_to_cpus(&info->size);
>
>           if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
> -            error_prepend(errp, "Failed to read export flags");
> +            error_prepend(errp, "Failed to read export flags: ");
>               goto fail;
>           }
>           be16_to_cpus(&info->flags);
> @@ -750,13 +752,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>           }
>
>           if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
> -            error_prepend(errp, "Failed to read export length");
> +            error_prepend(errp, "Failed to read export length: ");
>               goto fail;
>           }
>           be64_to_cpus(&info->size);
>
>           if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
> -            error_prepend(errp, "Failed to read export flags");
> +            error_prepend(errp, "Failed to read export flags: ");
>               goto fail;
>           }
>           be32_to_cpus(&oldflags);
> @@ -772,7 +774,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>
>       trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
>       if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
> -        error_prepend(errp, "Failed to read reserved block");
> +        error_prepend(errp, "Failed to read reserved block: ");
>           goto fail;
>       }
>       rc = 0;

If you go that way,
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
