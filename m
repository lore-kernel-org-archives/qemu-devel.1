Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMLo-0000EX-Ci
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMLl-0004EO-9k
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coMLl-0004EA-0z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:45:17 -0400
Date: Thu, 16 Mar 2017 11:45:09 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316034509.GL11074@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-7-stefanha@redhat.com>
	<2b0e4c7b-254e-2b58-ab35-a73545e3671a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <2b0e4c7b-254e-2b58-ab35-a73545e3671a@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 6/8] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 02:46:12AM +0100, Max Reitz wrote:
> On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> > The measure subcommand calculates the size required by a new image file.
> > This can be used by users or management tools that need to allocate
> > space on an LVM volume, SAN LUN, etc before creating or converting an
> > image file.
> >=20
> > Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-img.c       | 213 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  qemu-img-cmds.hx |   9 +++
>=20
> Looking forward to the documentation in the non-RFC version. O:-)

Thanks for reminding me that the qemu-img man page needs documentation
for this new sub-command :).

> >  2 files changed, 222 insertions(+)
> >=20
> > diff --git a/qemu-img.c b/qemu-img.c
> > index 98b836b..e8c6dcc 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -59,6 +59,7 @@ enum {
> >      OPTION_PATTERN =3D 260,
> >      OPTION_FLUSH_INTERVAL =3D 261,
> >      OPTION_NO_DRAIN =3D 262,
> > +    OPTION_SIZE =3D 263,
> >  };
> > =20
> >  typedef enum OutputFormat {
> > @@ -4287,6 +4288,218 @@ out:
> >      return 0;
> >  }
> > =20
> > +static void dump_json_block_measure_info(BlockMeasureInfo *info)
> > +{
> > +    QString *str;
> > +    QObject *obj;
> > +    Visitor *v =3D qobject_output_visitor_new(&obj);
> > +
> > +    visit_type_BlockMeasureInfo(v, NULL, &info, &error_abort);
> > +    visit_complete(v, &obj);
> > +    str =3D qobject_to_json_pretty(obj);
> > +    assert(str !=3D NULL);
> > +    printf("%s\n", qstring_get_str(str));
> > +    qobject_decref(obj);
> > +    visit_free(v);
> > +    QDECREF(str);
> > +}
> > +
> > +static int img_measure(int argc, char **argv)
> > +{
> > +    static const struct option long_options[] =3D {
> > +        {"help", no_argument, 0, 'h'},
> > +        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> > +        {"object", required_argument, 0, OPTION_OBJECT},
> > +        {"output", required_argument, 0, OPTION_OUTPUT},
> > +        {"size", required_argument, 0, OPTION_SIZE},
> > +        {0, 0, 0, 0}
> > +    };
> > +    OutputFormat output_format =3D OFORMAT_HUMAN;
> > +    BlockBackend *in_blk =3D NULL;
> > +    BlockDriver *drv;
> > +    const char *filename =3D NULL;
> > +    const char *fmt =3D NULL;
> > +    const char *out_fmt =3D "raw";
> > +    char *options =3D NULL;
> > +    char *snapshot_name =3D NULL;
> > +    QemuOpts *opts =3D NULL;
> > +    QemuOpts *object_opts =3D NULL;
> > +    QemuOpts *sn_opts =3D NULL;
> > +    QemuOptsList *create_opts =3D NULL;
> > +    bool image_opts =3D false;
> > +    uint64_t img_size =3D ~0ULL;
> > +    BlockMeasureInfo info;
> > +    Error *local_err =3D NULL;
> > +    int ret =3D 1;
> > +    int c;
> > +
> > +    while ((c =3D getopt_long(argc, argv, "hf:O:o:l:",
> > +                            long_options, NULL)) !=3D -1) {
> > +        switch (c) {
> > +        case '?':
> > +        case 'h':
> > +            help();
> > +            break;
> > +        case 'f':
> > +            fmt =3D optarg;
> > +            break;
> > +        case 'O':
> > +            out_fmt =3D optarg;
> > +            break;
> > +        case 'o':
> > +            if (!is_valid_option_list(optarg)) {
> > +                error_report("Invalid option list: %s", optarg);
> > +                goto out;
> > +            }
> > +            if (!options) {
> > +                options =3D g_strdup(optarg);
> > +            } else {
> > +                char *old_options =3D options;
> > +                options =3D g_strdup_printf("%s,%s", options, optarg);
> > +                g_free(old_options);
> > +            }
> > +            break;
> > +        case 'l':
> > +            if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
> > +                sn_opts =3D qemu_opts_parse_noisily(&internal_snapshot=
_opts,
> > +                                                  optarg, false);
> > +                if (!sn_opts) {
> > +                    error_report("Failed in parsing snapshot param '%s=
'",
> > +                                 optarg);
> > +                    goto out;
> > +                }
> > +            } else {
> > +                snapshot_name =3D optarg;
> > +            }
> > +            break;
> > +        case OPTION_OBJECT:
> > +            object_opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> > +                                                  optarg, true);
> > +            if (!object_opts) {
> > +                goto out;
> > +            }
> > +            break;
> > +        case OPTION_IMAGE_OPTS:
> > +            image_opts =3D true;
> > +            break;
> > +        case OPTION_OUTPUT:
> > +            if (!strcmp(optarg, "json")) {
> > +                output_format =3D OFORMAT_JSON;
> > +            } else if (!strcmp(optarg, "human")) {
> > +                output_format =3D OFORMAT_HUMAN;
> > +            } else {
> > +                error_report("--output must be used with human or json=
 "
> > +                             "as argument.");
> > +                goto out;
> > +            }
> > +            break;
> > +        case OPTION_SIZE:
> > +        {
> > +            int64_t sval;
> > +
> > +            sval =3D cvtnum(optarg);
> > +            if (sval < 0) {
> > +                if (sval =3D=3D -ERANGE) {
> > +                    error_report("Image size must be less than 8 EiB!"=
);
> > +                } else {
> > +                    error_report("Invalid image size specified! You ma=
y use "
> > +                                 "k, M, G, T, P or E suffixes for ");
> > +                    error_report("kilobytes, megabytes, gigabytes, ter=
abytes, "
> > +                                 "petabytes and exabytes.");
>=20
> BTW, I love how we say "EiB" in these error messages but the non-i
> suffixes the user can specify are still power-of-two units.
>=20
> (Also, this error message explicitly says "kilobytes" and so on instead
> of "kibibytes". I'm fine with it not least because it's pre-existing,
> though. (Furthermore, I'd rather have it be "EB" than the latter message
> contain "kibibytes, mebibytes" and so on.))
>=20
> > +                }
> > +                goto out;
> > +            }
> > +            img_size =3D (uint64_t)sval;
> > +        }
> > +        break;
> > +        }
> > +    }
> > +
> > +    if (qemu_opts_foreach(&qemu_object_opts,
> > +                          user_creatable_add_opts_foreach,
> > +                          NULL, NULL)) {
> > +        goto out;
> > +    }
> > +
> > +    if (argc - optind > 1) {
> > +        error_report("At most one filename argument is allowed.");
>=20
> Not exactly like convert, then. :-(
>=20
> But, yeah, it wouldn't really work for the current interface and we can
> always extend it later.
>=20
> (But maybe that means the interface could be better. Maybe this central
> function here could collect a statistics of allocated/zero/free/...
> clusters of the input image (with a cluster size somehow specified by
> the output image driver, however that's supposed to work...) and pass it
> to the output driver. That would also save us from replicating the input
> block query code for all of the block drivers that implement
> bdrv_measure().)

I will look into this for the next revision, thanks.

Stefan

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYygpFAAoJEJykq7OBq3PIV/kIAKiys2mIhHUQj2vmAfQTABJO
g+eGEMqYWn5YClZZKLFDPvIGIFxsayiFHeHl45Beu1SK4MEykj6rGIlhsUoIGEHg
n3nG1s+vSB0sTFwPMuXX5Eh0+vWslefQSz1vNjfVNbOHWIZ2z8+LjvgjeXUFe3TM
cznxBEghMTVNUbhlKVhMv8qq8LGpQdqI7aWjL/sah7YkYcfoe4FFBQhFQhNGUoh7
6lIlazuZDgvCM3Ck7bzLmctuFlFp14nckyLkARJMCn12WiNnQrMeiD+cLIWdbVzy
bIolZao9uC80uNJnJGTsS8l7xqHknrSVkB9c9y9qeQp6gD6hM8nJtAzL4YqqjCk=
=C0tv
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
