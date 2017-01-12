Received: from eggs.gnu.org ([2001:4830:134:3::10]:48241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRgbL-0002Hp-1z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRgbH-0006QZ-Tl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:43:39 -0500
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
Date: Thu, 12 Jan 2017 08:43:26 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VInmtTetNvFLL0mJoPkFUjN2Vlict4E5k"
Subject: Re: [Qemu-devel] How to online resize qemu disk with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VInmtTetNvFLL0mJoPkFUjN2Vlict4E5k
From: Eric Blake <eblake@redhat.com>
To: Bob Chen <a175818323@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>
Message-ID: <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
Subject: Re: [Qemu-devel] How to online resize qemu disk with nbd protocol?
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
In-Reply-To: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 04:22 AM, Bob Chen wrote:
> Hi,
>=20
>=20
> My qemu runs on a 3rd party distributed block storage, and the disk bac=
kend
> protocol is nbd.
>=20
> I notices that there are differences between default qcow2 local disk a=
nd
> my nbd disk, in terms of resizing the disk on the fly.
>=20
> Local qcow2 disk could work no matter using qemu-img resize=20

No. Don't EVER use 'qemu-img resize' while a qemu process is actively
serving a VM guest.  Two concurrent modifiers to a qcow2 file is
unsupported, and is highly likely to corrupt your guest's view of the
disk, if not the entire qcow2 file.

> or qemu monitor
> 'block_resize',

Yes, that is the only supported way to do an online resize.

> but the nbd disk seemed to fail to detect the backend size
> change(had resized the disk on EBS at first). It said "this feature or
> command is not currently supported".

That's because the NBD protocol lacks a resize command.  You'd have to
first get that proposed as an NBD extension before qemu could support it.=


>=20
> Is that possible to hack qemu nbd code, making it the same way as resiz=
ing
> local qcow2 disk? I have the interface to resize EBS disk at backend.

Anything is possible in open source with enough time and patches, but
the place to tackle this is to first propose an extension to the NBD
protocol (I've added the NBD list in cc).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VInmtTetNvFLL0mJoPkFUjN2Vlict4E5k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd5YOAAoJEKeha0olJ0NqlkQH/Rml9MpvU7GgOd4QJZPyad4c
n4V/9eTl+2rnuaxA3vvdXemLyDtLDzD5AGkTJPiGHyIaGPdTJU8j+CY24LkURTkN
hTzmUaGc9Eye6j5HzB+4/TY+yKnap/P9eJ3mIeZ+AMv8s4xY7jkoYaNSk9jGph4R
PpByMEDucHGXiPLDvUe54BOEZx7Uj5wyozAUM22fPxz2wKEGHhPZK5fTaERcT1fE
MHKkXkdua7h44JFt9R1GEIscad6FXUcjKoGkiYs72jgioZX64SXeGD5qRHifHfjs
WMt4cVCse/FGQPfXFR5wmrjbvi5iB/tgxXo0/cN7O5KjwLBrFiGp45Gkeaa7lsc=
=zEuV
-----END PGP SIGNATURE-----

--VInmtTetNvFLL0mJoPkFUjN2Vlict4E5k--
