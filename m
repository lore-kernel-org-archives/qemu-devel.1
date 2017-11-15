Received: from eggs.gnu.org ([2001:4830:134:3::10]:54096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3BI-0005DI-Gg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3BH-0001Al-1b
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:17:04 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9d9b3f9-480c-6e59-0e8a-1fd4f5e84b6a@redhat.com>
Date: Wed, 15 Nov 2017 20:16:49 +0100
MIME-Version: 1.0
In-Reply-To: <1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wRXKALswoS5T8svM5bnuoSlliOxvJAPp7"
Subject: Re: [Qemu-devel] [PATCH 4/5] block-stream: add compress option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wRXKALswoS5T8svM5bnuoSlliOxvJAPp7
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, jcody@redhat.com,
 armbru@redhat.com, dgilbert@redhat.com
Message-ID: <b9d9b3f9-480c-6e59-0e8a-1fd4f5e84b6a@redhat.com>
Subject: Re: [PATCH 4/5] block-stream: add compress option
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 11:16, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/block-core.json      |  4 ++++
>  include/block/block_int.h |  4 +++-
>  block/stream.c            | 16 ++++++++++++----
>  blockdev.c                | 13 ++++++++++++-
>  hmp.c                     |  2 ++
>  hmp-commands.hx           |  4 ++--
>  6 files changed, 35 insertions(+), 8 deletions(-)

Looks good to me overall, two notes below.

Max

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab96e34..b0d022f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2007,6 +2007,9 @@
>  #
>  # @speed:  the maximum speed, in bytes per second
>  #
> +# @compress: true to compress data, if the target format supports it.
> +#            (default: false). Since 2.12.
> +#

Too many full stops (one before, one after the parentheses).  Also, this
makes it sound a bit like it would still be possible to specify this
parameter even if the target doesn't support it (and it would just be
ignored then), but that's not true.

Also, the format most parameter documentation follows for block-stream
is more "@parameter: Description. Default. (Since version)".

So I'd suggest:

"true to compress data; may only be set if the target format supports
it.  Defaults to false if omitted.  (Since 2.12)"

But I won't argue too much over the format, so the following is OK, too:

"true to compress data; may only be set if the target format supports it
(default: false). (Since 2.12)"

>  # @on-error: the action to take on an error (default report).
>  #            'stop' and 'enospc' can only be used if the block device
>  #            supports io-status (see BlockInfo).  Since 1.3.
> @@ -2026,6 +2029,7 @@
>  { 'command': 'block-stream',
>    'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>              '*base-node': 'str', '*backing-file': 'str', '*speed': 'in=
t',
> +            '*compress': 'bool',
>              '*on-error': 'BlockdevOnError' } }
> =20
>  ##
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index a548277..093bf9b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -863,6 +863,7 @@ int is_windows_drive(const char *filename);
>   * @backing_file_str: The file name that will be written to @bs as the=

>   * the new backing file if the job completes. Ignored if @base is %NUL=
L.
>   * @speed: The maximum speed, in bytes per second, or 0 for unlimited.=

> + * @compress: True to compress data.
>   * @on_error: The action to take upon error.
>   * @errp: Error object.
>   *
> @@ -875,7 +876,8 @@ int is_windows_drive(const char *filename);
>   */
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str=
,
> -                  int64_t speed, BlockdevOnError on_error, Error **err=
p);
> +                  int64_t speed, bool compress,
> +                  BlockdevOnError on_error, Error **errp);
> =20
>  /**
>   * commit_start:
> diff --git a/block/stream.c b/block/stream.c
> index e6f7234..75c9d66 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -38,23 +38,29 @@ typedef struct StreamBlockJob {
>      BlockdevOnError on_error;
>      char *backing_file_str;
>      int bs_flags;
> +    bool compress;
>  } StreamBlockJob;
> =20
>  static int coroutine_fn stream_populate(BlockBackend *blk,
>                                          int64_t offset, uint64_t bytes=
,
> -                                        void *buf)
> +                                        void *buf, bool compress)
>  {
>      struct iovec iov =3D {
>          .iov_base =3D buf,
>          .iov_len  =3D bytes,
>      };
>      QEMUIOVector qiov;
> +    int flags =3D BDRV_REQ_COPY_ON_READ;
> +
> +    if (compress) {
> +        flags |=3D BDRV_REQ_WRITE_COMPRESSED;
> +    }
> =20
>      assert(bytes < SIZE_MAX);
>      qemu_iovec_init_external(&qiov, &iov, 1);
> =20
>      /* Copy-on-read the unallocated clusters */
> -    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_=
ON_READ);
> +    return blk_co_preadv(blk, offset, qiov.size, &qiov, flags);
>  }
> =20
>  typedef struct {
> @@ -166,7 +172,7 @@ static void coroutine_fn stream_run(void *opaque)
>          }
>          trace_stream_one_iteration(s, offset, n, ret);
>          if (copy) {
> -            ret =3D stream_populate(blk, offset, n, buf);
> +            ret =3D stream_populate(blk, offset, n, buf, s->compress);=

>          }
>          if (ret < 0) {
>              BlockErrorAction action =3D
> @@ -227,7 +233,8 @@ static const BlockJobDriver stream_job_driver =3D {=

> =20
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str=
,
> -                  int64_t speed, BlockdevOnError on_error, Error **err=
p)
> +                  int64_t speed, bool compress,
> +                  BlockdevOnError on_error, Error **errp)
>  {
>      StreamBlockJob *s;
>      BlockDriverState *iter;
> @@ -267,6 +274,7 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
>      s->base =3D base;
>      s->backing_file_str =3D g_strdup(backing_file_str);
>      s->bs_flags =3D orig_bs_flags;
> +    s->compress =3D compress;
> =20
>      s->on_error =3D on_error;
>      trace_stream_start(bs, base, s);
> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24..18a56d9 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2968,6 +2968,7 @@ void qmp_block_stream(bool has_job_id, const char=
 *job_id, const char *device,
>                        bool has_base_node, const char *base_node,
>                        bool has_backing_file, const char *backing_file,=

>                        bool has_speed, int64_t speed,
> +                      bool has_compress, bool compress,
>                        bool has_on_error, BlockdevOnError on_error,
>                        Error **errp)
>  {
> @@ -2981,6 +2982,10 @@ void qmp_block_stream(bool has_job_id, const cha=
r *job_id, const char *device,
>          on_error =3D BLOCKDEV_ON_ERROR_REPORT;
>      }
> =20
> +    if (!has_compress) {
> +        compress =3D false;
> +    }
> +
>      bs =3D bdrv_lookup_bs(device, device, errp);
>      if (!bs) {
>          return;
> @@ -3034,11 +3039,17 @@ void qmp_block_stream(bool has_job_id, const ch=
ar *job_id, const char *device,
>          goto out;
>      }
> =20
> +    if (compress && bs->drv->bdrv_co_pwritev_compressed =3D=3D NULL) {=

> +        error_setg(errp, "Compression is not supported for this drive =
%s",
> +                   bdrv_get_device_name(bs));

I think just device instead of bdrv_get_device_name(bs) is better (or
bdrv_get_device_or_node_name(bs) at least).

> +        goto out;
> +    }
> +
>      /* backing_file string overrides base bs filename */
>      base_name =3D has_backing_file ? backing_file : base_name;
> =20
>      stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> -                 has_speed ? speed : 0, on_error, &local_err);
> +                 has_speed ? speed : 0, compress, on_error, &local_err=
);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto out;
> diff --git a/hmp.c b/hmp.c
> index 35a7041..854c88e 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1812,9 +1812,11 @@ void hmp_block_stream(Monitor *mon, const QDict =
*qdict)
>      const char *device =3D qdict_get_str(qdict, "device");
>      const char *base =3D qdict_get_try_str(qdict, "base");
>      int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
> +    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
> =20
>      qmp_block_stream(true, device, device, base !=3D NULL, base, false=
, NULL,
>                       false, NULL, qdict_haskey(qdict, "speed"), speed,=

> +                     qdict_haskey(qdict, "compress"), compress,
>                       true, BLOCKDEV_ON_ERROR_REPORT, &error);
> =20
>      hmp_handle_error(mon, &error);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 4afd57c..f6794bb 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -75,8 +75,8 @@ ETEXI
> =20
>      {
>          .name       =3D "block_stream",
> -        .args_type  =3D "device:B,speed:o?,base:s?",
> -        .params     =3D "device [speed [base]]",
> +        .args_type  =3D "device:B,speed:o?,base:s?,compress:o?",
> +        .params     =3D "device [speed [base]] [compress]",
>          .help       =3D "copy data from a backing file into a block de=
vice",
>          .cmd        =3D hmp_block_stream,
>      },
>=20



--wRXKALswoS5T8svM5bnuoSlliOxvJAPp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMkqESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnK8H/337POnwVtAVn+amrypTYu9KbUmDMAHJ
cLK7kcb+nNTrh5KQOTknsmFFd1x4X0ofGvONut/iA5udTCQF3uuPmz5v+wrstgHT
Kiwn/sHSLBl9+yrU+O49kJsEGEL5XI8+hK66pRcbC2BdjzovwhNsUwar5c/prpNY
LgxPVXoWIuEZttV3kixKZxhx7RwYEpvI6bSo8vULwcrZgiGMYDdDpMJf4rE+BvaT
vmQdc6iDWhAzJ93nUBhx3jOW6cQVUGjfi5ehN51CkgBrZByhHQ49BiVo5wTtIvfg
brIK4isDGZ4qGZkomZskbi6P6Iz9RCofznReyUkmNVN5QDjVp/qLzyc=
=m1Tf
-----END PGP SIGNATURE-----

--wRXKALswoS5T8svM5bnuoSlliOxvJAPp7--
