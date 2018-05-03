Received: from eggs.gnu.org ([2001:4830:134:3::10]:54239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fEAMZ-0007bA-A7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fEAMX-0004DO-7G
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:17:19 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <26f63bd9-4f91-fd46-631c-5f12c04fc9e0@virtuozzo.com>
Date: Thu, 3 May 2018 12:17:03 +0300
MIME-Version: 1.0
In-Reply-To: <20180501211336.986372-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/client: Support requests of
 additional block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

02.05.2018 00:13, Eric Blake wrote:
> The NBD spec is clarifying [1] that a server may want to advertise
> different limits for READ/WRITE (in our case, 32M) than for
> TRIM/ZERO (in our case, nearly 4G).  Implement the client
> side support for these alternate limits, by always requesting
> the new information (a compliant server must ignore the
> request if it is unknown), and by validating anything reported
> by the server before populating the block layer limits.
>
> [1] https://lists.debian.org/nbd/2018/03/msg00048.html
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> The given URL for the NBD spec was v3; it will change to be a v4
> version of that patch in part to point back to this qemu commit
> as a proof of implementation.
> ---
>   include/block/nbd.h |   4 ++
>   block/nbd.c         |  15 ++++++-
>   nbd/client.c        | 116 +++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>   nbd/trace-events    |   2 +
>   4 files changed, 131 insertions(+), 6 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index cbf51628f78..90ddef32bb3 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -270,6 +270,10 @@ struct NBDExportInfo {
>       uint32_t min_block;
>       uint32_t opt_block;
>       uint32_t max_block;
> +    uint32_t min_trim;
> +    uint32_t max_trim;
> +    uint32_t min_zero;
> +    uint32_t max_zero;
>
>       uint32_t meta_base_allocation_id;
>   };
> diff --git a/block/nbd.c b/block/nbd.c
> index 1e2b3ba2d3b..823d10b251d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -478,8 +478,19 @@ static void nbd_refresh_limits(BlockDriverState *bs,=
 Error **errp)
>       uint32_t max =3D MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_bloc=
k);
>
>       bs->bl.request_alignment =3D min ? min : BDRV_SECTOR_SIZE;
> -    bs->bl.max_pdiscard =3D max;
> -    bs->bl.max_pwrite_zeroes =3D max;
> +    if (s->info.max_trim) {
> +        bs->bl.max_pdiscard =3D MIN(s->info.max_trim, BDRV_REQUEST_MAX_B=
YTES);
> +    } else {
> +        bs->bl.max_pdiscard =3D max;
> +    }
> +    bs->bl.pdiscard_alignment =3D s->info.min_trim;
> +    if (s->info.max_zero) {
> +        bs->bl.max_pwrite_zeroes =3D MIN(s->info.max_zero,
> +                                       BDRV_REQUEST_MAX_BYTES);
> +    } else {
> +        bs->bl.max_pwrite_zeroes =3D max;
> +    }
> +    bs->bl.pwrite_zeroes_alignment =3D s->info.min_zero;
>       bs->bl.max_transfer =3D max;
>
>       if (s->info.opt_block &&
> diff --git a/nbd/client.c b/nbd/client.c
> index 0abb195b856..f1364747ba1 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -337,16 +337,18 @@ static int nbd_opt_go(QIOChannel *ioc, const char *=
wantname,
>       info->flags =3D 0;
>
>       trace_nbd_opt_go_start(wantname);
> -    buf =3D g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
> +    buf =3D g_malloc(4 + len + 2 + 3 * 2 * info->request_sizes + 1);

Hmm, what "+1" means?

>       stl_be_p(buf, len);
>       memcpy(buf + 4, wantname, len);
> -    /* At most one request, everything else up to server */
> -    stw_be_p(buf + 4 + len, info->request_sizes);
> +    /* Either 0 or 3 requests, everything else up to server */
> +    stw_be_p(buf + 4 + len, 3 * info->request_sizes);
>       if (info->request_sizes) {
>           stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
> +        stw_be_p(buf + 4 + len + 2 + 2, NBD_INFO_TRIM_SIZE);
> +        stw_be_p(buf + 4 + len + 2 + 2 + 2, NBD_INFO_ZERO_SIZE);
>       }
>       error =3D nbd_send_option_request(ioc, NBD_OPT_GO,
> -                                    4 + len + 2 + 2 * info->request_size=
s,
> +                                    4 + len + 2 + 3 * 2 * info->request_=
sizes,
>                                       buf, errp);

magic chunk) Change looks correct. Is it worth introducing a buf_len=20
variable, to
not retype it?

>       g_free(buf);
>       if (error < 0) {
> @@ -467,6 +469,72 @@ static int nbd_opt_go(QIOChannel *ioc, const char *w=
antname,
>                                                info->max_block);
>               break;
>
> +        case NBD_INFO_TRIM_SIZE:
> +            if (len !=3D sizeof(info->min_trim) * 2) {
> +                error_setg(errp, "remaining trim info len %" PRIu32
> +                           " is unexpected size", len);
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            if (nbd_read(ioc, &info->min_trim, sizeof(info->min_trim),
> +                         errp) < 0) {
> +                error_prepend(errp, "failed to read info minimum trim si=
ze: ");
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            be32_to_cpus(&info->min_trim);
> +            if (nbd_read(ioc, &info->max_trim, sizeof(info->max_trim),
> +                         errp) < 0) {
> +                error_prepend(errp,
> +                              "failed to read info maximum trim size: ")=
;
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            be32_to_cpus(&info->max_trim);
> +            if (!info->min_trim || !info->max_trim ||
> +                (info->max_trim !=3D UINT32_MAX &&
> +                 !QEMU_IS_ALIGNED(info->max_trim, info->min_trim))) {
> +                error_setg(errp, "server trim sizes %" PRIu32 "/%" PRIu3=
2
> +                           " are not valid", info->min_trim, info->max_t=
rim);
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }

Didn't you forget to check that min_trim is a power of two?

> +            trace_nbd_opt_go_info_trim_size(info->min_trim, info->max_tr=
im);
> +            break;
> +
> +        case NBD_INFO_ZERO_SIZE:
> +            if (len !=3D sizeof(info->min_zero) * 2) {
> +                error_setg(errp, "remaining zero info len %" PRIu32
> +                           " is unexpected size", len);
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            if (nbd_read(ioc, &info->min_zero, sizeof(info->min_zero),
> +                         errp) < 0) {
> +                error_prepend(errp, "failed to read info minimum zero si=
ze: ");
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            be32_to_cpus(&info->min_zero);
> +            if (nbd_read(ioc, &info->max_zero, sizeof(info->max_zero),
> +                         errp) < 0) {
> +                error_prepend(errp,
> +                              "failed to read info maximum zero size: ")=
;
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            be32_to_cpus(&info->max_zero);
> +            if (!info->min_zero || !info->max_zero ||
> +                (info->max_zero !=3D UINT32_MAX &&
> +                 !QEMU_IS_ALIGNED(info->max_zero, info->min_zero))) {
> +                error_setg(errp, "server zero sizes %" PRIu32 "/%" PRIu3=
2
> +                           " are not valid", info->min_zero, info->max_z=
ero);
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            trace_nbd_opt_go_info_zero_size(info->min_zero, info->max_ze=
ro);
> +            break;
> +

hmm, so, now nbd_opt_go() is full of very-very similar code parts, which=20
may worth some refactoring now or in future.

Are we going to add similar limits for BLOCK_STATUS? and for CACHE? I=20
have an idea: why not to make an universal option for it in
protocol? Something like

option INFO_CMD_SIZE:
 =C2=A0 uint16_t command
 =C2=A0 uint32_t min_block
 =C2=A0 uint32_t max_block

and server can send several such options. Most of semantics for these=20
additional limits are common, so it will simplify both documentation
and realization..

I'll copy this to nbd thread and it is better to discuss it in it.

>           default:
>               trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
>               if (nbd_drop(ioc, len, errp) < 0) {
> @@ -483,6 +551,46 @@ static int nbd_opt_go(QIOChannel *ioc, const char *w=
antname,
>           error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
>           return -1;
>       }
> +    if (info->min_trim) {
> +        if (!info->min_block) {
> +            error_setg(errp, "broken server sent INFO_TRIM_SIZE without"
> +                       " INFO_BLOCK_SIZE");
> +            return -1;
> +        }
> +        if (info->min_trim < info->opt_block) {
> +            error_setg(errp, "broken server sent INFO_TRIM_SIZE with"
> +                       " minimum trim %" PRIu32 " less than preferred bl=
ock %"
> +                       PRIu32, info->min_trim, info->opt_block);
> +            return -1;
> +        }
> +        if (info->max_trim < info->max_block) {
> +            error_setg(errp, "broken server sent INFO_TRIM_SIZE with"
> +                       " maximum trim %" PRIu32 " less than maximum bloc=
k %"
> +                       PRIu32, info->max_trim, info->max_block);
> +            return -1;
> +        }
> +        info->max_trim =3D QEMU_ALIGN_DOWN(info->max_trim, info->min_blo=
ck);
> +    }
> +    if (info->min_zero) {
> +        if (!info->min_block) {
> +            error_setg(errp, "broken server sent INFO_ZERO_SIZE without"
> +                       " INFO_BLOCK_SIZE");
> +            return -1;
> +        }
> +        if (info->min_zero < info->opt_block) {
> +            error_setg(errp, "broken server sent INFO_ZERO_SIZE with"
> +                       " minimum zero %" PRIu32 " less than preferred bl=
ock %"
> +                       PRIu32, info->min_zero, info->opt_block);
> +            return -1;
> +        }
> +        if (info->max_zero < info->max_block) {
> +            error_setg(errp, "broken server sent INFO_ZERO_SIZE with"
> +                       " maximum zero %" PRIu32 " less than maximum bloc=
k %"
> +                       PRIu32, info->max_zero, info->max_block);
> +            return -1;
> +        }
> +        info->max_zero =3D QEMU_ALIGN_DOWN(info->max_zero, info->min_blo=
ck);
> +    }
>       trace_nbd_opt_go_success();
>       return 1;
>   }
> diff --git a/nbd/trace-events b/nbd/trace-events
> index dee081e7758..ddb9d0a2b3e 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -6,6 +6,8 @@ nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO=
 for export '%s'"
>   nbd_opt_go_success(void) "Export is good to go"
>   nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown i=
nfo %d (%s)"
>   nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32=
_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
> +nbd_opt_go_info_trim_size(uint32_t minimum, uint32_t maximum) "Trim size=
s are 0x%" PRIx32 ", 0x%" PRIx32
> +nbd_opt_go_info_zero_size(uint32_t minimum, uint32_t maximum) "Zero size=
s are 0x%" PRIx32 ", 0x%" PRIx32
>   nbd_receive_query_exports_start(const char *wantname) "Querying export =
list for '%s'"
>   nbd_receive_query_exports_success(const char *wantname) "Found desired =
export name '%s'"
>   nbd_receive_starttls_new_client(void) "Setting up TLS"


--=20
Best regards,
Vladimir
