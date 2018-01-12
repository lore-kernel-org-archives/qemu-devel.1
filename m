Received: from eggs.gnu.org ([2001:4830:134:3::10]:46364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZwRe-0005gu-Qx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZwRd-0002lG-Rx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:20:18 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <76132a6d-3d2f-92ba-d05d-93c20dbe9025@virtuozzo.com>
Date: Fri, 12 Jan 2018 13:20:07 +0300
MIME-Version: 1.0
In-Reply-To: <20180110230825.18321-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 5/6] nbd/server: Add helper functions
 for parsing option payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

11.01.2018 02:08, Eric Blake wrote:
> Rather than making every callsite perform length sanity checks
> and error reporting, add the helper functions nbd_opt_read()
> and nbd_opt_drop() that use the length stored in the client
> struct; also add an assertion that optlen is reduced to zero
> after each option is handled.
>
> Note that the call in nbd_negotiate_handle_export_name() does
> not use the new helper (in part because the server cannot
> reply to NBD_OPT_EXPORT_NAME - it either succeeds or the
> connection drops).
>
> Based on patches by Vladimir Sementsov-Ogievskiy.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 123 ++++++++++++++++++++++++++++++-----------------------------
>   1 file changed, 63 insertions(+), 60 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index d23bc2918a..ec8c3be019 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -229,6 +229,41 @@ nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
>       return ret;
>   }
>
> +/* Drop remainder of the current option, after sending a reply with

looks a bit weird: actually you drop the remainder _before_ sending a reply)

> + * the given error type and message. Return -errno on read or write

also, unrelated note, -errno is always forced to -EIO, because of 
nbd_read realization.
and this note applies to many other places here. It is correct (EIO is 
errno, why not?),
but it may be not bad to note it somewhere..

> + * failure; or 0 if connection is still live. */
> +static int GCC_FMT_ATTR(4, 5)
> +nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
> +             const char *fmt, ...)
> +{
> +    int ret = nbd_drop(client->ioc, client->optlen, errp);
> +
> +    client->optlen = 0;
> +    if (!ret) {
> +        va_list va;
> +
> +        va_start(va, fmt);
> +        ret = nbd_negotiate_send_rep_verr(client, type, errp, fmt, va);
> +        va_end(va);
> +    }
> +    return ret;
> +}

[..]

> @@ -812,14 +819,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                   break;
>
>               default:
> -                if (nbd_drop(client->ioc, length, errp) < 0) {
> -                    return -EIO;
> -                }
> -                ret = nbd_negotiate_send_rep_err(client,
> -                                                 NBD_REP_ERR_UNSUP, errp,
> -                                                 "Unsupported option 0x%"
> -                                                 PRIx32 " (%s)", option,
> -                                                 nbd_opt_lookup(option));
> +                ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
> +                                   "Unsupported option 0x%" PRIx32 " (%s)",
> +                                   option, nbd_opt_lookup(option));
>                   break;
>               }
>           } else {
> @@ -842,6 +844,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>           if (ret < 0) {
>               return ret;
>           }
> +        assert(!client->optlen);

isn't it from 2/6?

>       }
>   }
>

anyway,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
