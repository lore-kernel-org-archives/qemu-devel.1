Received: from eggs.gnu.org ([2001:4830:134:3::10]:57611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cjvC7-0003Va-FP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1cjvC4-0007JM-Dl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:56:59 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1cjvC4-0007J2-7k
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:56:56 -0500
Received: by mail-ua0-f174.google.com with SMTP id q7so95004737uaf.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 13:56:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303135150.12145-4-stefanha@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170303135150.12145-4-stefanha@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 3 Mar 2017 23:56:54 +0200
Message-ID: <CAMRbyytpufX+9xzshezDuYabbDNt+9jzQqk0NCL1FxmQWnRU+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 3/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Fri, Mar 3, 2017 at 3:51 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The max-size subcommand calculates the maximum size required by a new
> image file.  This can be used by users or management tools that need to
> allocate space on an LVM volume, SAN LUN, etc before creating or
> converting an image file.
>
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c       | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  qemu-img-cmds.hx |   6 ++
>  2 files changed, 202 insertions(+)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 98b836b..f0a5a85 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -59,6 +59,7 @@ enum {
>      OPTION_PATTERN = 260,
>      OPTION_FLUSH_INTERVAL = 261,
>      OPTION_NO_DRAIN = 262,
> +    OPTION_SIZE = 263,
>  };
>
>  typedef enum OutputFormat {
> @@ -4287,6 +4288,201 @@ out:
>      return 0;
>  }
>
> +static int img_max_size(int argc, char **argv)
> +{
> +    static const struct option long_options[] = {
> +        {"help", no_argument, 0, 'h'},
> +        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +        {"object", required_argument, 0, OPTION_OBJECT},
> +        {"output", required_argument, 0, OPTION_OUTPUT},
> +        {"size", required_argument, 0, OPTION_SIZE},
> +        {0, 0, 0, 0}
> +    };
> +    OutputFormat output_format = OFORMAT_HUMAN;
> +    BlockBackend *in_blk = NULL;
> +    BlockDriver *drv;
> +    const char *filename = NULL;
> +    const char *fmt = NULL;
> +    const char *out_fmt = "raw";
> +    char *options = NULL;
> +    char *snapshot_name = NULL;
> +    QemuOpts *opts = NULL;
> +    QemuOpts *object_opts = NULL;
> +    QemuOpts *sn_opts = NULL;
> +    QemuOptsList *create_opts = NULL;
> +    bool image_opts = false;
> +    uint64_t img_size = ~0ULL;
> +    uint64_t ret_size;
> +    Error *local_err = NULL;
> +    int ret = 1;
> +    int c;
> +
> +    while ((c = getopt_long(argc, argv, "hf:O:o:l:",
> +                            long_options, NULL)) != -1) {
> +        switch (c) {
> +        case '?':
> +        case 'h':
> +            help();
> +            break;
> +        case 'f':
> +            fmt = optarg;
> +            break;
> +        case 'O':
> +            out_fmt = optarg;
> +            break;
> +        case 'o':
> +            if (!is_valid_option_list(optarg)) {
> +                error_report("Invalid option list: %s", optarg);
> +                goto fail;
> +            }
> +            if (!options) {
> +                options = g_strdup(optarg);
> +            } else {
> +                char *old_options = options;
> +                options = g_strdup_printf("%s,%s", options, optarg);
> +                g_free(old_options);
> +            }
> +            break;
> +        case 'l':
> +            if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
> +                sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
> +                                                  optarg, false);
> +                if (!sn_opts) {
> +                    error_report("Failed in parsing snapshot param '%s'",
> +                                 optarg);
> +                    goto fail;
> +                }
> +            } else {
> +                snapshot_name = optarg;
> +            }
> +            break;
> +        case OPTION_OBJECT:
> +            object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
> +                                                  optarg, true);
> +            if (!object_opts) {
> +                goto fail;
> +            }
> +            break;
> +        case OPTION_IMAGE_OPTS:
> +            image_opts = true;
> +            break;
> +        case OPTION_OUTPUT:
> +            if (!strcmp(optarg, "json")) {
> +                output_format = OFORMAT_JSON;
> +            } else if (!strcmp(optarg, "human")) {
> +                output_format = OFORMAT_HUMAN;
> +            } else {
> +                error_report("--output must be used with human or json "
> +                             "as argument.");
> +                goto fail;
> +            }
> +            break;
> +        case OPTION_SIZE:
> +        {
> +            int64_t sval;
> +
> +            sval = cvtnum(optarg);
> +            if (sval < 0) {
> +                if (sval == -ERANGE) {
> +                    error_report("Image size must be less than 8 EiB!");
> +                } else {
> +                    error_report("Invalid image size specified! You may use "
> +                                 "k, M, G, T, P or E suffixes for ");
> +                    error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                                 "petabytes and exabytes.");
> +                }
> +                goto fail;
> +            }
> +            img_size = (uint64_t)sval;
> +        }
> +        break;
> +        }
> +    }
> +
> +    if (qemu_opts_foreach(&qemu_object_opts,
> +                          user_creatable_add_opts_foreach,
> +                          NULL, NULL)) {
> +        goto fail;
> +    }
> +
> +    if (argc - optind > 1) {
> +        error_report("At most one filename argument is allowed.");
> +        goto fail;
> +    } else if (argc - optind == 1) {
> +        filename = argv[optind];
> +    }
> +
> +    if (!filename &&
> +        (object_opts || image_opts || fmt || snapshot_name || sn_opts)) {
> +        error_report("--object, --image-opts, -f, and -l "
> +                     "require a filename argument.");
> +        goto fail;
> +    }
> +    if (filename && img_size != ~0ULL) {
> +        error_report("--size N cannot be used together with a filename.");
> +        goto fail;
> +    }
> +    if (!filename && img_size == ~0ULL) {
> +        error_report("Either --size N or one filename must be specified.");
> +        goto fail;
> +    }
> +
> +    if (filename) {
> +        in_blk = img_open(image_opts, filename, fmt, 0, false, false);
> +        if (!in_blk) {
> +            goto fail;
> +        }
> +    }
> +
> +    drv = bdrv_find_format(out_fmt);
> +    if (!drv) {
> +        error_report("Unknown file format '%s'", out_fmt);
> +        goto fail;
> +    }
> +    if (!drv->create_opts) {
> +        error_report("Format driver '%s' does not support image creation",
> +                     drv->format_name);
> +        goto fail;
> +    }
> +
> +    create_opts = qemu_opts_append(create_opts, drv->create_opts);
> +    opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
> +    if (options) {
> +        qemu_opts_do_parse(opts, options, NULL, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_report("Invalid options for file format '%s'", out_fmt);
> +            goto fail;
> +        }
> +    }
> +    if (img_size != ~0ULL) {
> +        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
> +    }
> +
> +    ret_size = bdrv_max_size(drv, opts, in_blk ? blk_bs(in_blk) : NULL,
> +                             &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        goto fail;
> +    }
> +
> +    if (output_format == OFORMAT_HUMAN) {
> +        printf("%" PRIu64 "\n", ret_size);
> +    } else {
> +        printf("{ \"size\": %" PRIu64 " }\n", ret_size);
> +    }
> +
> +    ret = 0;
> +
> +fail:

This looks more like out: to me, since we use it both for normal
and abnormal flows.

> +    qemu_opts_del(object_opts);
> +    qemu_opts_del(opts);
> +    qemu_opts_del(sn_opts);
> +    qemu_opts_free(create_opts);
> +    g_free(options);
> +    blk_unref(in_blk);
> +    return ret;
> +}
>
>  static const img_cmd_t img_cmds[] = {
>  #define DEF(option, callback, arg_string)        \
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 9c9702c..80997f9 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -87,3 +87,9 @@ STEXI
>  @item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
>  @end table
>  ETEXI
> +
> +DEF("max-size", img_max_size,
> +"max-size [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
> +STEXI
> +TODO max-size documentation
> +ETEXI
> --
> 2.9.3
>

Nir
