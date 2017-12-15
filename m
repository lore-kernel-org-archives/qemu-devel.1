Received: from eggs.gnu.org ([2001:4830:134:3::10]:35275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePm8y-0006Kh-7O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePm8s-0007AI-4H
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:19:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ePm8r-000785-Qc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:18:54 -0500
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
Date: Fri, 15 Dec 2017 10:18:48 +0100
MIME-Version: 1.0
In-Reply-To: <e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V5ooKwgLD63o1RKtBlWEKHcCraIwqUkhH"
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seeteena <s1seetee@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V5ooKwgLD63o1RKtBlWEKHcCraIwqUkhH
From: Max Reitz <mreitz@redhat.com>
To: seeteena <s1seetee@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org
Message-ID: <b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
Subject: Re: [PATCH v1] hmp: 'info snapshots' not showing the id
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20171212164114.GF2409@work-vm>
 <e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
In-Reply-To: <e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-13 05:50, seeteena wrote:
> Hi David,
>=20
> While creating snapshots when tag name '0' used in the very first and f=
ollowed by tag name '1' then snapshot created with tag name '0' is gettin=
g erased.=20
> A snapshot is identified by a name computed either from an id, which is=
 basically a numerical counter starting at 1 for qcow2, or from a tag, wh=
ich is a string (provided
> by the user or automatically computed).=20
>=20
> (qemu) savevm 0
>=20
> This creates a snapshot with tag '0' and id '1'.

That's something someone has complained about already, as far as I
remember, and this is indeed an issue.

>> (qemu) savevm 1
>=20
> This deletes snapshot with name '1' (ie, with id '1') and creates snaps=
hot with tag '1' and id '1'.

I think this is the issue, not info snapshots.

> From the output of 'info snapshots' id '1' is not seen for tag '0' inst=
ead seeing an empty field.
>=20
> ID        TAG                 VM SIZE                DATE       VM CLOC=
K
> --        0                      338M 2017-10-16 13:44:35   00:02:07.49=
1
>=20
> If an ID shown as '1' in the above then user can understand the above d=
ocumented stuff i.e "If there is already a snapshot with the same tag or =
ID, it is replaced".
> The '--' in ID field is annoying.

Maybe, but this patch is wrong still.  Commit 3a1ee711904 says exactly wh=
y:

> The patch uses snapshot name instead of snapshot id to determine whethe=
r a
> snapshot is fully available and uses '--' instead of snapshot id in out=
put
> because the snapshot id is not guaranteed to be the same on all images.=


info snapshots first shows a list of snapshots that are present on all
disks.  However, those are matched by name and not by ID, so the ID is
not necessarily the same.

Therefore, we can only print it if it is.  Sure, we can do that, but
your patch is missing that check.

Example:

$ qemu-img create -f qcow2 foo.qcow2 64M
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-img create -f qcow2 bar.qcow2 64M
Formatting 'bar.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-img snapshot -c common_snapshot foo.qcow2
$ qemu-img snapshot -c bar_snapshot bar.qcow2
$ qemu-img snapshot -c common_snapshot bar.qcow2
$ qemu-system-x86_64 -hda foo.qcow2 -hdb bar.qcow2 -monitor stdio
$ qemu-img snapshot -l foo.qcow2
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         common_snapshot           0 2017-12-15 10:09:17   00:00:00.000
$ qemu-img snapshot -l bar.qcow2
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.000
2         common_snapshot           0 2017-12-15 10:09:28   00:00:00.000
QEMU 2.9.1 monitor - type 'help' for more information
(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
--        common_snapshot           0 2017-12-15 10:09:17   00:00:00.000

List of partial (non-loadable) snapshots on 'ide0-hd1':
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.000

With your patch:

(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         common_snapshot           0 2017-12-15 10:09:17   00:00:00.000

List of partial (non-loadable) snapshots on 'ide0-hd1':
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         bar_snapshot              0 2017-12-15 10:09:25   00:00:00.000

Max


--V5ooKwgLD63o1RKtBlWEKHcCraIwqUkhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlozk3gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZZMH/A0RDUD7+QZ7m3ZlSQUbXCrjDdtwfikU
A8fmUFfLmdiY1zGg6nXp8xHkxGFnr5IDheCwor3+2LCbZxaCXkSP6Zr+XZqIoKQD
uX4YPQ9F1Mhk1WusA3HQ7tuAONTpweClrxaAoQnPqAUpqyfAM1gLODf2v8yIE2uN
i3ZUErYwJLVfu7Y7qArkPq5QDHIHGygDs5C+dS4nJNeiLRU2Gl2ehQrEDa/0A6h3
44kiQaH1mZiHg7TRjYW3c5KeBUVkYitW5NNJr7KnaKpBj5wU7gqithfv1So9w5aY
whd+x7v+jlXt1fDvo1/KAZBmpDrNhT98Qh2Ka9ufny9Zz2x1uM5MKYg=
=c7Gn
-----END PGP SIGNATURE-----

--V5ooKwgLD63o1RKtBlWEKHcCraIwqUkhH--
