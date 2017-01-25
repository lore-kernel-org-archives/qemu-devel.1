Received: from eggs.gnu.org ([2001:4830:134:3::10]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWRqk-0003fs-TG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWRqh-0003HX-1e
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:59:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cWRqg-0003H8-PV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:59:10 -0500
References: <1485362572-7246-1-git-send-email-den@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
Date: Wed, 25 Jan 2017 18:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <1485362572-7246-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fR8JFlkg23WDKm6SMTJppkd7IRHHM7cUT"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add missed BDRV_O_NOCACHE when
 block device is opened without file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fR8JFlkg23WDKm6SMTJppkd7IRHHM7cUT
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <1e511c84-c9fa-1d4e-8a73-e48c0b29a59a@redhat.com>
Subject: Re: [PATCH 1/1] block: add missed BDRV_O_NOCACHE when block device is
 opened without file
References: <1485362572-7246-1-git-send-email-den@openvz.org>
In-Reply-To: <1485362572-7246-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

[CC-ing John]

On 25.01.2017 17:42, Denis V. Lunev wrote:
> Technically there is a problem when the guest DVD is created by libvirt=

> with AIO mode 'native' on Linux. Current QEMU is unable to start the
> domain configured as follows:
>     <disk type=3D'file' device=3D'cdrom'>
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>=

>       <target dev=3D'sdb' bus=3D'scsi'/>
>       <readonly/>
>     </disk>
> The problem comes from the combination of 'cache' and 'io' options.
>=20
> 'io' option is common option and it is removed from block driver
> specific options. 'cache' originally is not. The patch makes 'cache'
> option common. This works fine as long as cdrom media insertion
> later on.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  blockdev.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

There was a Red Hat BZ for this:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1342999

There is now a corresponding BZ for libvirt:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1377321

The gist is that it was determined to be a problem with libvirt.

RHEL has a downstream commit to work around this issue by ignoring the
cache mode set for empty CD-ROMs -- but that is only because that was
simpler than fixing libvirt.

(Note that it's ignoring the cache mode instead of actually evaluating it=
=2E)

> May be this has already discussed, but still. AIO=3Dnative for CDROM wi=
thout
> media seems important case.

First, I personally don't find aio=3Dnative very important for CD-ROM
drives. Yes, we shouldn't make IDE CD-ROM slower than necessary, but I
don't think aio=3Dnative will make the difference between "Slow like
CD-ROMs are in reality" and "As fast as virtio".

Second, all this patch does is revert some changes done by commit
91a097e7478940483e76d52217f05bc05b98d5a5, which was very deliberate.

Third, you may then be asking for the recommended way to put an
aio=3Dnative medium into a CD-ROM drive. Good thing you ask, because we
have a way that we want to recommend but can't because it's still
considered experimental:

The BDS is added using blockdev-add, with all of the appropriate caching
and aio options. Then it's inserted into the drive using the
x-blockdev-insert-medium command, and the drive is closed using
blockdev-close-tray.

There are a couple of issues with this: First, blockdev-add and
x-blockdev-insert-medium are still experimental. The good news are that
I think the reason why the latter is experimental has actually
disappeared and we can just drop the x- by now. The
not-so-good-but-not-so-bad-either news are that we plan to get
blockdev-add declared non-experimental for 2.9. Let's see how it goes.

The other issue is that of course it's more cumbersome to use than a
simple 'change' via HMP. I argue that if someone communicates with a VM
by hand, they either have to deal with this added complexity or they
cannot use aio=3Dnative for CD-ROM drives -- which, as I said, I don't
think is too bad.

However, there is a reason why you cannot set cache/aio for an empty
drive and it's simply that it doesn't make sense.

Max


--fR8JFlkg23WDKm6SMTJppkd7IRHHM7cUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI52oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AceUH/2m6xbQ7R2ycYSI7efcpjhZg3eZnR1ye
Gh0Yv5lbYyOvpQ0XaJ7ZVHYlOop+/k4v+zz4VyZiBZNJ8zmF9HF/O4bRAPwF6Qx0
bvJm2bvOqJpzTx4/P3F8Iun9qgCFHPIN3n5bNohc3x/KN4OKMws4n3bUCwHhqARL
IO2BGLQFN6D9iV+diShKvFLXyEhtJa069i0pk9A+4d9sd7lowr9uPbVKBePhGFAI
LxMKeOV4fBYGCIrGjSLn470j2Y3P7PDIDb2RWK8ka6jmWLajmVEApshbVmz3HULx
Se6LNYQOEkpeWgv6iZ9EELsORKMJ7iE/tpPZ3PM0JOyIFJU2YXHg75M=
=GJDC
-----END PGP SIGNATURE-----

--fR8JFlkg23WDKm6SMTJppkd7IRHHM7cUT--
