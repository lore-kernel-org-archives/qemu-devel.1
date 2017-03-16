Received: from eggs.gnu.org ([2001:4830:134:3::10]:59301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKUi-0007tT-TQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKUf-0007qU-L2
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:46:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coKUf-0007pC-Bt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:46:21 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-7-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2b0e4c7b-254e-2b58-ab35-a73545e3671a@redhat.com>
Date: Thu, 16 Mar 2017 02:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170315092940.1367-7-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iDesH8C1J13OAa0eIm0jFIgBUSoFTIifc"
Subject: Re: [Qemu-devel] [RFC v2 6/8] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDesH8C1J13OAa0eIm0jFIgBUSoFTIifc
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <2b0e4c7b-254e-2b58-ab35-a73545e3671a@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 6/8] qemu-img: add measure subcommand
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-7-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-7-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> The measure subcommand calculates the size required by a new image file=
=2E
> This can be used by users or management tools that need to allocate
> space on an LVM volume, SAN LUN, etc before creating or converting an
> image file.
>=20
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c       | 213 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qemu-img-cmds.hx |   9 +++

Looking forward to the documentation in the non-RFC version. O:-)

>  2 files changed, 222 insertions(+)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 98b836b..e8c6dcc 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -59,6 +59,7 @@ enum {
>      OPTION_PATTERN =3D 260,
>      OPTION_FLUSH_INTERVAL =3D 261,
>      OPTION_NO_DRAIN =3D 262,
> +    OPTION_SIZE =3D 263,
>  };
> =20
>  typedef enum OutputFormat {
> @@ -4287,6 +4288,218 @@ out:
>      return 0;
>  }
> =20
> +static void dump_json_block_measure_info(BlockMeasureInfo *info)
> +{
> +    QString *str;
> +    QObject *obj;
> +    Visitor *v =3D qobject_output_visitor_new(&obj);
> +
> +    visit_type_BlockMeasureInfo(v, NULL, &info, &error_abort);
> +    visit_complete(v, &obj);
> +    str =3D qobject_to_json_pretty(obj);
> +    assert(str !=3D NULL);
> +    printf("%s\n", qstring_get_str(str));
> +    qobject_decref(obj);
> +    visit_free(v);
> +    QDECREF(str);
> +}
> +
> +static int img_measure(int argc, char **argv)
> +{
> +    static const struct option long_options[] =3D {
> +        {"help", no_argument, 0, 'h'},
> +        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +        {"object", required_argument, 0, OPTION_OBJECT},
> +        {"output", required_argument, 0, OPTION_OUTPUT},
> +        {"size", required_argument, 0, OPTION_SIZE},
> +        {0, 0, 0, 0}
> +    };
> +    OutputFormat output_format =3D OFORMAT_HUMAN;
> +    BlockBackend *in_blk =3D NULL;
> +    BlockDriver *drv;
> +    const char *filename =3D NULL;
> +    const char *fmt =3D NULL;
> +    const char *out_fmt =3D "raw";
> +    char *options =3D NULL;
> +    char *snapshot_name =3D NULL;
> +    QemuOpts *opts =3D NULL;
> +    QemuOpts *object_opts =3D NULL;
> +    QemuOpts *sn_opts =3D NULL;
> +    QemuOptsList *create_opts =3D NULL;
> +    bool image_opts =3D false;
> +    uint64_t img_size =3D ~0ULL;
> +    BlockMeasureInfo info;
> +    Error *local_err =3D NULL;
> +    int ret =3D 1;
> +    int c;
> +
> +    while ((c =3D getopt_long(argc, argv, "hf:O:o:l:",
> +                            long_options, NULL)) !=3D -1) {
> +        switch (c) {
> +        case '?':
> +        case 'h':
> +            help();
> +            break;
> +        case 'f':
> +            fmt =3D optarg;
> +            break;
> +        case 'O':
> +            out_fmt =3D optarg;
> +            break;
> +        case 'o':
> +            if (!is_valid_option_list(optarg)) {
> +                error_report("Invalid option list: %s", optarg);
> +                goto out;
> +            }
> +            if (!options) {
> +                options =3D g_strdup(optarg);
> +            } else {
> +                char *old_options =3D options;
> +                options =3D g_strdup_printf("%s,%s", options, optarg);=

> +                g_free(old_options);
> +            }
> +            break;
> +        case 'l':
> +            if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
> +                sn_opts =3D qemu_opts_parse_noisily(&internal_snapshot=
_opts,
> +                                                  optarg, false);
> +                if (!sn_opts) {
> +                    error_report("Failed in parsing snapshot param '%s=
'",
> +                                 optarg);
> +                    goto out;
> +                }
> +            } else {
> +                snapshot_name =3D optarg;
> +            }
> +            break;
> +        case OPTION_OBJECT:
> +            object_opts =3D qemu_opts_parse_noisily(&qemu_object_opts,=

> +                                                  optarg, true);
> +            if (!object_opts) {
> +                goto out;
> +            }
> +            break;
> +        case OPTION_IMAGE_OPTS:
> +            image_opts =3D true;
> +            break;
> +        case OPTION_OUTPUT:
> +            if (!strcmp(optarg, "json")) {
> +                output_format =3D OFORMAT_JSON;
> +            } else if (!strcmp(optarg, "human")) {
> +                output_format =3D OFORMAT_HUMAN;
> +            } else {
> +                error_report("--output must be used with human or json=
 "
> +                             "as argument.");
> +                goto out;
> +            }
> +            break;
> +        case OPTION_SIZE:
> +        {
> +            int64_t sval;
> +
> +            sval =3D cvtnum(optarg);
> +            if (sval < 0) {
> +                if (sval =3D=3D -ERANGE) {
> +                    error_report("Image size must be less than 8 EiB!"=
);
> +                } else {
> +                    error_report("Invalid image size specified! You ma=
y use "
> +                                 "k, M, G, T, P or E suffixes for ");
> +                    error_report("kilobytes, megabytes, gigabytes, ter=
abytes, "
> +                                 "petabytes and exabytes.");

BTW, I love how we say "EiB" in these error messages but the non-i
suffixes the user can specify are still power-of-two units.

(Also, this error message explicitly says "kilobytes" and so on instead
of "kibibytes". I'm fine with it not least because it's pre-existing,
though. (Furthermore, I'd rather have it be "EB" than the latter message
contain "kibibytes, mebibytes" and so on.))

> +                }
> +                goto out;
> +            }
> +            img_size =3D (uint64_t)sval;
> +        }
> +        break;
> +        }
> +    }
> +
> +    if (qemu_opts_foreach(&qemu_object_opts,
> +                          user_creatable_add_opts_foreach,
> +                          NULL, NULL)) {
> +        goto out;
> +    }
> +
> +    if (argc - optind > 1) {
> +        error_report("At most one filename argument is allowed.");

Not exactly like convert, then. :-(

But, yeah, it wouldn't really work for the current interface and we can
always extend it later.

(But maybe that means the interface could be better. Maybe this central
function here could collect a statistics of allocated/zero/free/...
clusters of the input image (with a cluster size somehow specified by
the output image driver, however that's supposed to work...) and pass it
to the output driver. That would also save us from replicating the input
block query code for all of the block drivers that implement
bdrv_measure().)

Max

> +        goto out;
> +    } else if (argc - optind =3D=3D 1) {
> +        filename =3D argv[optind];
> +    }
> +
> +    if (!filename &&
> +        (object_opts || image_opts || fmt || snapshot_name || sn_opts)=
) {
> +        error_report("--object, --image-opts, -f, and -l "
> +                     "require a filename argument.");
> +        goto out;
> +    }
> +    if (filename && img_size !=3D ~0ULL) {
> +        error_report("--size N cannot be used together with a filename=
=2E");
> +        goto out;
> +    }
> +    if (!filename && img_size =3D=3D ~0ULL) {
> +        error_report("Either --size N or one filename must be specifie=
d.");
> +        goto out;
> +    }
> +
> +    if (filename) {
> +        in_blk =3D img_open(image_opts, filename, fmt, 0, false, false=
);
> +        if (!in_blk) {
> +            goto out;
> +        }
> +    }
> +
> +    drv =3D bdrv_find_format(out_fmt);
> +    if (!drv) {
> +        error_report("Unknown file format '%s'", out_fmt);
> +        goto out;
> +    }
> +    if (!drv->create_opts) {
> +        error_report("Format driver '%s' does not support image creati=
on",
> +                     drv->format_name);
> +        goto out;
> +    }
> +
> +    create_opts =3D qemu_opts_append(create_opts, drv->create_opts);
> +    opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
> +    if (options) {
> +        qemu_opts_do_parse(opts, options, NULL, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_report("Invalid options for file format '%s'", out_f=
mt);
> +            goto out;
> +        }
> +    }
> +    if (img_size !=3D ~0ULL) {
> +        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abo=
rt);
> +    }
> +
> +    bdrv_measure(drv, opts, in_blk ? blk_bs(in_blk) : NULL, &info, &lo=
cal_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        goto out;
> +    }
> +
> +    if (output_format =3D=3D OFORMAT_HUMAN) {
> +        printf("required bytes: %" PRIu64 "\n", info.required_bytes);
> +        printf("fully allocated bytes: %" PRIu64 "\n",
> +               info.fully_allocated_bytes);
> +    } else {
> +        dump_json_block_measure_info(&info);
> +    }
> +
> +    ret =3D 0;
> +
> +out:
> +    qemu_opts_del(object_opts);
> +    qemu_opts_del(opts);
> +    qemu_opts_del(sn_opts);
> +    qemu_opts_free(create_opts);
> +    g_free(options);
> +    blk_unref(in_blk);
> +    return ret;
> +}
> =20
>  static const img_cmd_t img_cmds[] =3D {
>  #define DEF(option, callback, arg_string)        \
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 9c9702c..57ef70f 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -85,5 +85,14 @@ DEF("amend", img_amend,
>      "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t =
cache] -o options filename")
>  STEXI
>  @item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @v=
ar{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
> +ETEXI
> +
> +DEF("measure", img_measure,
> +"measure [--output=3Dofmt] [-O output_fmt] [-o options] [--size N | [-=
-object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]"=
)
> +STEXI
> +@item measure [--output=3D@var{ofmt}] [-O @var{output_fmt}] [-o @var{o=
ptions}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f =
@var{fmt}] [-l @var{snapshot_param}] @var{filename}]
> +ETEXI
> +
> +STEXI
>  @end table
>  ETEXI
>=20



--iDesH8C1J13OAa0eIm0jFIgBUSoFTIifc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ7mQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATQ0H/2Y7PvY7wRPDKhk1bf+6+oiG/2JAD+M4
j+8ejZ3y4a3Z+5DO6/Q28w3MdiMyRXUMu0uEl/JhHED3EIGN+G9xDJOAKHUbEghq
5l0Bz9KeRcTWizDvYkGR/UXWSuRZw1VKuteTJzAgo4VyPASRDFLb23nb2TD50zEk
Ja9XHWWnhsCyfq773ovPw11tcQlM/Kv16huTrRdEbpLH5PbyEdmwAp75NA5cdLzY
URWGgm5syNbRfFAALvZW4bfXUjdt1L/p7XrW/NzA9y9u1t0aD9vdqwgBL/0g2XCG
S1QCCsnECbnsmQJ+4PLUA5vY5GZsQDekGJasszbn/yPoDpq5oA/auvU=
=YHB3
-----END PGP SIGNATURE-----

--iDesH8C1J13OAa0eIm0jFIgBUSoFTIifc--
