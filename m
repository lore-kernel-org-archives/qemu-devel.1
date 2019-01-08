Received: from eggs.gnu.org ([209.51.188.92]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggsdu-0002mO-OT
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggsdq-0002Yc-PC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ggsdq-0002Sf-GB
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:46:06 -0500
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
	<154693620998.25278.657579942079364570.malone@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4b207e5-2b98-1bcf-05e0-1228a548c936@redhat.com>
Date: Tue, 8 Jan 2019 08:46:02 -0600
MIME-Version: 1.0
In-Reply-To: <154693620998.25278.657579942079364570.malone@gac.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kk7l5dIM0Mu6PnslXsTLWer0kYU8qAi9Y"
Subject: Re: [Qemu-devel] [Bug 1810603] Re: QEMU QCow Images grow
 dramatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1810603 <1810603@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kk7l5dIM0Mu6PnslXsTLWer0kYU8qAi9Y
From: Eric Blake <eblake@redhat.com>
To: Bug 1810603 <1810603@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <c4b207e5-2b98-1bcf-05e0-1228a548c936@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1810603] Re: QEMU QCow Images grow dramatically
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
 <154693620998.25278.657579942079364570.malone@gac.canonical.com>
In-Reply-To: <154693620998.25278.657579942079364570.malone@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 2:30 AM, Lenny Helpline wrote:
> I don't have many commands handy, as we manage almost everything throug=
h
> libvirt manager.
>=20
> 3) create a snapshot of the lined clone:
>=20
> virsh snapshot-create-as --domain <VMNAME> --name "test" --halt
>=20
> 4) revert the snapshot every X minutes / hours:
>=20
> virsh destroy <VMNAME>
> virsh snapshot-revert --snapshotname test --running --force
>=20
> Does that help?

Yes. It shows that you are taking internal snapshots, rather than
external.  Note that merely reverting to an internal snapshot does not
delete that snapshot, and also note that although qemu has code for
deleting internal snapshots, I doubt that it currently reclaims the disk
space that was previously in use by that snapshot but no longer needed.
Internal snapshots do not get much attention these days, because most of
our work is focused on external snapshots.

If you were to use external snapshots, then every time you wanted to
create a point in time that you might need to roll back to, you create a
new external snapshot, turning:

image1

into

image1 <- temp_overlay

then, at the point when you are done with the work in temp_overlay2, you
reset the domain back to using image1 and throw away the old
temp_overlay (or, recreate temp_overlay to be blank, which is the same
as going back to the state in image1); thus, the size of image1 never
grows because you are doing all work in temp_overlay, and rolling back
no longer keeps the changes that were done in a previous branch of work
the way internal snapshots are doing.

In libvirt terms, you could create an external snapshot by adding
--diskspec $disk,snapshot=3Dexternal for each $disk of your domain (virsh=

domblklist can be used to get the list of valid $disk names).  But
libvirt support for reverting to external snapshots is still not
completely rounded out, so you'll have to do a bit more leg work on your
end to piece things back together.

Asking on the libvirt list may give you better insights on how best to
use libvirt to drive external snapshots to accomplish your setup of
frequently reverting to older points in time.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Kk7l5dIM0Mu6PnslXsTLWer0kYU8qAi9Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw0t6oACgkQ3g5py3or
ov1Ymgf/Ubo46k78MYNBRYPXWMGFUR9cJXuTLEBve+Dxd/mO6LDQBwKFnED3dZkb
e23MSg50wUCni14q+4Inj5c5jauH2HL/il3RUTTc1Nm+Y9cLyFAPTtU/C7ZoXhHa
IO+vreVgfWXcuVOnGA2Yztnha63v+8ql0B4oFM28y0WxxoAMYLejq45tA4XoO6B3
Ju5wfNOJxpwsRBj9+5/ySn6+0yRsLI97tyhxo660aaAKgLpLB3RpmxTvcGd9LDMI
rRJPhkOa5LmBHdk6I8FhE3Z4uSkdmYSXpikb7pBYVOA/t6fIpn0KgohQVcS8iw+u
hWI78zBjgLWJ5aTBzaFiK8dqdVGtYA==
=twVp
-----END PGP SIGNATURE-----

--Kk7l5dIM0Mu6PnslXsTLWer0kYU8qAi9Y--
