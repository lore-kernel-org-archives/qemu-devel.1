Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggMH-0002BQ-8C
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cggMG-0006w5-5J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:30:05 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5eb9cc1f-527b-16a9-3ae9-e9993856b829@redhat.com>
Date: Wed, 22 Feb 2017 17:29:54 -0600
MIME-Version: 1.0
In-Reply-To: <1487710908-26356-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1NGt9JeEX2prPX3txqqhgcqpVGBwqUbbv"
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/5] block: Crude initial
 implementation of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1NGt9JeEX2prPX3txqqhgcqpVGBwqUbbv
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <5eb9cc1f-527b-16a9-3ae9-e9993856b829@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/5] block: Crude initial
 implementation of -blockdev
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:01 PM, Markus Armbruster wrote:
> The new command line option -blockdev works like QMP command
> blockdev-add.
>=20
> The option argument may be given in JSON syntax, exactly as in QMP.
> Example usage:
>=20
>     -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver":=
 "file", "filename": "foo.img"} }'
>=20
> The JSON argument doesn't exactly blend into the existing option
> syntax, so the traditional KEY=3DVALUE,... syntax is also supported,
> using dotted keys to do the nesting:
>=20
>     -blockdev node-name=3Dfoo,driver=3Draw,file.driver=3Dfile,file.file=
name=3Dfoo.img

Some of the list ideas were allowing mix-and-match or re-opening the
dict; do we want to allow any of these? (maybe as followups?)

-blockdev
node-name=3Dfoo,driver=3Draw,file=3D'{"driver":"file"}',file.filename=3Df=
oo.img


>=20
> Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
> right away would crash.  We need to stash the configuration for later
> instead.  This is crudely done, and bypasses QemuOpts, even though
> storing configuration is what QemuOpts is for.  Need to revamp option
> infrastructure to support QAPI types like BlockdevOptions.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx |  3 +++
>  vl.c            | 50 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
>  2 files changed, 53 insertions(+)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9936cf3..36a38d7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -512,6 +512,9 @@ Use @var{file} as CD-ROM image (you cannot use @opt=
ion{-hdc} and
>  using @file{/dev/cdrom} as filename (@pxref{host_drives}).
>  ETEXI
> =20
> +DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
> +    "-blockdev FIXME document\n", QEMU_OPTION_blockdev)

Adequate for an RFC, but I can see how you want to improve it.

> @@ -3095,6 +3104,37 @@ int main(int argc, char **argv, char **envp)
>                  drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, o=
ptarg,
>                            HD_OPTS);
>                  break;
> +            case QEMU_OPTION_blockdev:
> +                {
> +                    BlockdevOptions_queue *bdo =3D g_new(BlockdevOptio=
ns_queue, 1);
> +                    bool is_json =3D optarg[0] =3D=3D '{';
> +                    QObject *obj;
> +                    QDict *args;
> +                    Visitor *v;
> +
> +                    if (is_json) {
> +                        obj =3D qobject_from_json(optarg);
> +                        // TODO get error out of parser

Yeah, that's something we still need to improve.

> +                        if (!obj) {
> +                            error_report("invalid JSON");
> +                            exit(1);
> +                        }
> +                        args =3D qobject_to_qdict(obj);
> +                        assert(args);
> +                        v =3D qobject_input_visitor_new(QOBJECT(args),=
 true);
> +                    } else {
> +                        args =3D keyval_parse(optarg, "driver", &error=
_fatal);
> +                        v =3D qobject_input_visitor_new_autocast(QOBJE=
CT(args));
> +                    }

Pretty slick!  And answers my question: no mix-and-match of JSON and
dotted (all one or the other) within a single -blockdev argument.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1NGt9JeEX2prPX3txqqhgcqpVGBwqUbbv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrh7yAAoJEKeha0olJ0NqxOEH/jXra4Tfv+6TmMaSAHtQ3aPH
YgXteY5O1/rTKdW+UiE0f/5buFT00Eh9DozvCavginVJr5zx9TSxFcAsRYFWw5ZW
9qwhtEPVtW10vVLpB8e6Hj40xnIoB9MCzFVTc2rcNBIIucnhJ2PagdUZ8jfrgjbl
Rs8uNWpjV6CERiOqYKrlRn1a8wUEv6WpKb2hMX102pwLdEZBmJyZy/uJZx6NvuBk
+7MoUWldx0H8D3mSC8AjOvp94oaLRqp2ZJYpo1n8nbaqJsUyTylf9qbhw0XJGBOk
xw2jxWzQx3uZ3siEgyfIinYAp0ikCpdF7pq42yDG5/abIP1zP8xfm/oDYI+vV5Y=
=gv/a
-----END PGP SIGNATURE-----

--1NGt9JeEX2prPX3txqqhgcqpVGBwqUbbv--
