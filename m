Received: from eggs.gnu.org ([2001:4830:134:3::10]:54905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinbr-000357-En
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinbq-0002Tt-DU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:38:55 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-19-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5cad5e8-3027-c5e7-5d6d-c04009c905cc@redhat.com>
Date: Tue, 28 Feb 2017 13:38:46 -0600
MIME-Version: 1.0
In-Reply-To: <1488194450-28056-19-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jeGBvAepPqMwQ329BkwV8x4MBbUjPI68g"
Subject: Re: [Qemu-devel] [PATCH 18/24] block: Initial implementation of
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jeGBvAepPqMwQ329BkwV8x4MBbUjPI68g
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com
Message-ID: <e5cad5e8-3027-c5e7-5d6d-c04009c905cc@redhat.com>
Subject: Re: [PATCH 18/24] block: Initial implementation of -blockdev
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-19-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:20 AM, Markus Armbruster wrote:
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
>=20
> This does not yet support lists or downstream extensions, i.e. keys
> with __RFQDN_ prefix, but the next few patches will take care of that.
>=20
> Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
> right away would crash.  We need to stash the configuration for later
> instead.  This is crudely done, and bypasses QemuOpts, even though
> storing configuration is what QemuOpts is for.  Need to revamp option
> infrastructure to support QAPI types like BlockdevOptions.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx |  7 +++++++
>  vl.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index bf458f8..8f02264 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -532,6 +532,13 @@ Use @var{file} as CD-ROM image (you cannot use @op=
tion{-hdc} and
>  using @file{/dev/cdrom} as filename (@pxref{host_drives}).
>  ETEXI
> =20
> +DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
> +    "-blockdev driver[,node-name=3DN][,discard=3Dignore|unmap]\n"

Maybe "-blockdev [driver=3D]DRIVER[,node-name".....

to call out that you use driver as an implied key? But I'm also fine
with what you wrote (it's sufficient enough for a human reading it, and
the help output is not scraped by libvirt).

> +    "          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
> +    "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"=

> +    "          [,driver specific parameters...]\n"
> +    "                configure a block backend\n", QEMU_ARCH_ALL)
> +
>  DEF("drive", HAS_ARG, QEMU_OPTION_drive,
>      "-drive [file=3Dfile][,if=3Dtype][,bus=3Dn][,unit=3Dm][,media=3Dd]=
[,index=3Di]\n"
>      "       [,cyls=3Dc,heads=3Dh,secs=3Ds[,trans=3Dt]][,snapshot=3Don|=
off]\n"

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jeGBvAepPqMwQ329BkwV8x4MBbUjPI68g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtdHGAAoJEKeha0olJ0NqTLIH/0tg+vOgGYysqtHn6MaN2+50
jAyRzl5aJHzze+hzRcY9yyfN8bXJWJXnLlzygf5DCQVPlC9K+TTmU29i5cDImB14
qdPP0FB0aavMBQ0o1U16e3jXazAGpwhiPviEpplz2/fBtzTUpRo33IKi2BMcTDvB
8VHJ0n1xEnn6LXiNOC3zJ6F7krTBtXL5CJRKzMDLIWBUsAjbap17uzA7gW/eRe1P
XxbsBiq7xueO1iWUOVwp/HdVRcitgAlgjLZxXUg/CglpQlupLwIDr+dbu3XqH/Pc
L3zTDxsnXNAZ1Aij/ADRrFN3W0Y1shYKkHaW4wo2xHSgHrv40/DXkgb/NmTqIWM=
=WgEI
-----END PGP SIGNATURE-----

--jeGBvAepPqMwQ329BkwV8x4MBbUjPI68g--
