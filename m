Received: from eggs.gnu.org ([2001:4830:134:3::10]:52175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUZ7b-0001yH-E4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUZ7X-0006PU-9l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:53:07 -0400
Date: Mon, 10 Jul 2017 14:52:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170710135242.GC6770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-4-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498733831-15254-4-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2 3/8] block/qcow2: parse compress create
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

On Thu, Jun 29, 2017 at 12:57:06PM +0200, Peter Lieven wrote:
> this adds parsing and validation for the compress create
> options. They are only validated but not yet used.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c             | 56 +++++++++++++++++++++++++++++++++++++++++++++--
>  block/qcow2.h             |  9 ++++++++
>  include/block/block_int.h |  2 ++
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2f94f03..308121a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2144,7 +2144,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
>                           const char *backing_file, const char *backing_format,
>                           int flags, size_t cluster_size, PreallocMode prealloc,
>                           QemuOpts *opts, int version, int refcount_order,
> -                         Error **errp)
> +                         const char *compress_format_name,
> +                         uint8_t compress_level, Error **errp)
>  {
>      int cluster_bits;
>      QDict *options;
> @@ -2390,11 +2391,24 @@ out:
>      return ret;
>  }
>  
> +static int qcow2_compress_format_from_name(char *fmt)
> +{
> +    if (!fmt || !fmt[0]) {
> +        return QCOW2_COMPRESS_ZLIB_COMPAT;
> +    } else if (g_str_equal(fmt, "zlib")) {
> +        return QCOW2_COMPRESS_ZLIB;
> +    } else {
> +        return -EINVAL;
> +    }
> +}
> +
>  static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
>  {
>      char *backing_file = NULL;
>      char *backing_fmt = NULL;
>      char *buf = NULL;
> +    char *compress_format_name = NULL;
> +    uint64_t compress_level = 0;
>      uint64_t size = 0;
>      int flags = 0;
>      size_t cluster_size = DEFAULT_CLUSTER_SIZE;
> @@ -2475,15 +2489,40 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
>  
>      refcount_order = ctz32(refcount_bits);
>  
> +    compress_format_name = qemu_opt_get_del(opts,
> +                                            BLOCK_OPT_COMPRESS_FORMAT);
> +    ret = qcow2_compress_format_from_name(compress_format_name);
> +    if (ret < 0) {
> +        error_setg(errp, "Compress format '%s' is not supported",
> +                   compress_format_name);
> +        goto finish;
> +    }
> +    compress_level = qemu_opt_get_number_del(opts, BLOCK_OPT_COMPRESS_LEVEL,
> +                                             compress_level);
> +    if (ret == QCOW2_COMPRESS_ZLIB_COMPAT && compress_level > 0) {
> +        error_setg(errp, "Compress level can only be defined in conjunction"
> +                   " with compress format");
> +        ret = -EINVAL;
> +        goto finish;
> +    }
> +    if ((ret == QCOW2_COMPRESS_ZLIB && compress_level > 9) ||
> +        compress_level > 0xff) {
> +        error_setg(errp, "Compress level %" PRIu64 " is not supported for"
> +                   " format '%s'", compress_level, compress_format_name);
> +        ret = -EINVAL;
> +        goto finish;
> +    }

This is where the QAPI schema bits would fit in. eg instead of calling the
various qemu_opts_get* functions, do something like this:

    QDict *options, *compressopts = NULL;
    Qcow2Compress *compress = NULL;

    options = qemu_opts_to_qdict(opts, NULL);
    qdict_extract_subqdict(options, &compressopts, "compress.");

    v = qobject_input_visitor_new_keyval(QOBJECT(compressopts));
    
    visit_type_Qcow2Compress(v, &compress, &local_err);
    if (local_err) {
        ret= -EINVAL;
	goto finish;
    }


    ..do whatever you need with the 'compress' object now...

    visit_free(v);
    QDECREF(encryptopts);
    QDECREF(options);


Eventually the entire of the qcow2 create codepath will be qemu opts based,
so all the subdict/visitor steps will be able to go away, leaving you to
just use the Qcow2Compress struct immediately.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
