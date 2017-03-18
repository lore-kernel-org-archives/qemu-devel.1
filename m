Received: from eggs.gnu.org ([2001:4830:134:3::10]:56307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cpKkf-0008Cv-6k
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 16:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cpKkb-0005th-1O
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 16:15:01 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1cpKka-0005tQ-Qq
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 16:14:56 -0400
Received: by mail-vk0-f46.google.com with SMTP id x75so55398868vke.2
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 13:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-5-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-5-stefanha@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 18 Mar 2017 20:14:45 +0000
Message-ID: <CAMRbyytgis39Ayj2Hd3_sqa2EBOov9oo0Ne0d+=CdehfgEynog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v2 4/8] qcow2: extract image creation option
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Wed, Mar 15, 2017 at 11:30 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> The image creation options parsed by qcow2_create() are also needed to
> implement .bdrv_measure().  Extract the parsing code, including input
> validation.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/qcow2.c | 109
> +++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 73 insertions(+), 36 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7c702f4..19be468 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2168,24 +2168,73 @@ static int64_t qcow2_calc_prealloc_size(int64_t
> total_size,
>      return meta_size + aligned_total_size;
>  }
>
> -static int qcow2_create2(const char *filename, int64_t total_size,
> -                         const char *backing_file, const char
> *backing_format,
> -                         int flags, size_t cluster_size, PreallocMode
> prealloc,
> -                         QemuOpts *opts, int version, int refcount_order,
> -                         Error **errp)
> +static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
>  {
> +    size_t cluster_size;
>      int cluster_bits;
> -    QDict *options;
>
> -    /* Calculate cluster_bits */
> +    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
> +                                         DEFAULT_CLUSTER_SIZE);
>      cluster_bits = ctz32(cluster_size);
>      if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits >
> MAX_CLUSTER_BITS ||
>          (1 << cluster_bits) != cluster_size)
>      {
>          error_setg(errp, "Cluster size must be a power of two between %d
> and "
>                     "%dk", 1 << MIN_CLUSTER_BITS, 1 << (MAX_CLUSTER_BITS -
> 10));
> -        return -EINVAL;
> +        return 0;
>      }
> +    return cluster_size;
> +}
> +
> +static int qcow2_opt_get_version_del(QemuOpts *opts, Error **errp)
> +{
> +    char *buf;
> +    int ret;
> +
> +    buf = qemu_opt_get_del(opts, BLOCK_OPT_COMPAT_LEVEL);
> +    if (!buf) {
> +        ret = 3; /* default */
> +    } else if (!strcmp(buf, "0.10")) {
> +        ret = 2;
> +    } else if (!strcmp(buf, "1.1")) {
> +        ret = 3;
> +    } else {
> +        error_setg(errp, "Invalid compatibility level: '%s'", buf);
> +        ret = -EINVAL;
> +    }
> +    g_free(buf);
> +    return ret;
> +}
> +
> +static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int
> version,
> +                                                Error **errp)
> +{
> +    uint64_t refcount_bits;
> +
> +    refcount_bits = qemu_opt_get_number_del(opts,
> BLOCK_OPT_REFCOUNT_BITS, 16);
> +    if (refcount_bits > 64 || !is_power_of_2(refcount_bits)) {
> +        error_setg(errp, "Refcount width must be a power of two and may
> not "
> +                   "exceed 64 bits");
> +        return 0;
> +    }
> +
> +    if (version < 3 && refcount_bits != 16) {
> +        error_setg(errp, "Different refcount widths than 16 bits require "
> +                   "compatibility level 1.1 or above (use compat=1.1 or "
> +                   "greater)");
> +        return 0;
> +    }
> +
> +    return refcount_bits;
> +}
> +
> +static int qcow2_create2(const char *filename, int64_t total_size,
> +                         const char *backing_file, const char
> *backing_format,
> +                         int flags, size_t cluster_size, PreallocMode
> prealloc,
> +                         QemuOpts *opts, int version, int refcount_order,
> +                         Error **errp)
> +{
> +    QDict *options;
>
>      /*
>       * Open the image file and write a minimal qcow2 header.
> @@ -2235,7 +2284,7 @@ static int qcow2_create2(const char *filename,
> int64_t total_size,
>      *header = (QCowHeader) {
>          .magic                      = cpu_to_be32(QCOW_MAGIC),
>          .version                    = cpu_to_be32(version),
> -        .cluster_bits               = cpu_to_be32(cluster_bits),
> +        .cluster_bits               = cpu_to_be32(ctz32(cluster_size)),
>

Is this related?


>          .size                       = cpu_to_be64(0),
>          .l1_table_offset            = cpu_to_be64(0),
>          .l1_size                    = cpu_to_be32(0),
> @@ -2371,8 +2420,8 @@ static int qcow2_create(const char *filename,
> QemuOpts *opts, Error **errp)
>      int flags = 0;
>      size_t cluster_size = DEFAULT_CLUSTER_SIZE;
>      PreallocMode prealloc;
> -    int version = 3;
> -    uint64_t refcount_bits = 16;
> +    int version;
> +    uint64_t refcount_bits;
>      int refcount_order;
>      Error *local_err = NULL;
>      int ret;
> @@ -2385,8 +2434,12 @@ static int qcow2_create(const char *filename,
> QemuOpts *opts, Error **errp)
>      if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
>          flags |= BLOCK_FLAG_ENCRYPT;
>      }
> -    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
> -                                         DEFAULT_CLUSTER_SIZE);
> +    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +        goto finish;
> +    }
>      buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
>      prealloc = qapi_enum_parse(PreallocMode_lookup, buf,
>                                 PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
> @@ -2396,16 +2449,10 @@ static int qcow2_create(const char *filename,
> QemuOpts *opts, Error **errp)
>          ret = -EINVAL;
>          goto finish;
>      }
> -    g_free(buf);
> -    buf = qemu_opt_get_del(opts, BLOCK_OPT_COMPAT_LEVEL);
> -    if (!buf) {
> -        /* keep the default */
> -    } else if (!strcmp(buf, "0.10")) {
> -        version = 2;
> -    } else if (!strcmp(buf, "1.1")) {
> -        version = 3;
> -    } else {
> -        error_setg(errp, "Invalid compatibility level: '%s'", buf);
> +
> +    version = qcow2_opt_get_version_del(opts, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          ret = -EINVAL;
>          goto finish;
>      }
> @@ -2428,19 +2475,9 @@ static int qcow2_create(const char *filename,
> QemuOpts *opts, Error **errp)
>          goto finish;
>      }
>
> -    refcount_bits = qemu_opt_get_number_del(opts, BLOCK_OPT_REFCOUNT_BITS,
> -                                            refcount_bits);
> -    if (refcount_bits > 64 || !is_power_of_2(refcount_bits)) {
> -        error_setg(errp, "Refcount width must be a power of two and may
> not "
> -                   "exceed 64 bits");
> -        ret = -EINVAL;
> -        goto finish;
> -    }
> -
> -    if (version < 3 && refcount_bits != 16) {
> -        error_setg(errp, "Different refcount widths than 16 bits require "
> -                   "compatibility level 1.1 or above (use compat=1.1 or "
> -                   "greater)");
> +    refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version,
> &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          ret = -EINVAL;
>          goto finish;
>      }
> --
> 2.9.3
>

Looks good
