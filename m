Received: from eggs.gnu.org ([209.51.188.92]:58163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gizui-0008I4-Fq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gizug-0005D6-N1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:56:16 -0500
References: <1543204678-26914-1-git-send-email-pizhenwei@bytedance.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8b4c7e6-c218-b830-5f71-bb67c7a9939e@redhat.com>
Date: Mon, 14 Jan 2019 11:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <1543204678-26914-1-git-send-email-pizhenwei@bytedance.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Ru8qtlwALoy3Kz6emd9PNv3rH2FnMDl2"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Check effective size in
 truncate operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhenwei pi <pizhenwei@bytedance.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Ru8qtlwALoy3Kz6emd9PNv3rH2FnMDl2
From: Max Reitz <mreitz@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <e8b4c7e6-c218-b830-5f71-bb67c7a9939e@redhat.com>
Subject: Re: [PATCH] file-posix: Check effective size in truncate operation
References: <1543204678-26914-1-git-send-email-pizhenwei@bytedance.com>
In-Reply-To: <1543204678-26914-1-git-send-email-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 04:57, zhenwei pi wrote:
> Function raw_co_truncate does not check effective size for BLK device f=
ile,
> and QEMU may notify guest without any size changing.
>=20
> Two cases can be reproduced easily by qmp command:
> CASE 1:
> 1, create a logical volume(12M) by LVM, and guest uses this volume as "=
vdb"
> 2, run qmp command : virsh qemu-monitor-command INSTANCE '{"execute":
> "block_resize", "arguments":{"device":"drive-virtio-disk1","size":12582=
912}}'
>=20
> The effective size(12M) is equal to the argument(12M) and the real devi=
ce file
> size(12M). QEMU should ignore this command and has no need to notify gu=
est.

I don't quite see the issue here.  The command is valid, why would it be
an error?  And I don't see the harm in notifying the guest either.

> CASE 2:
> 1, create a logical volume(12M) by LVM, and guest uses this volume as "=
vdb"
> 2, resize LV to 16M by lvresize command
> 3, run qmp command : virsh qemu-monitor-command INSTANCE '{"execute":
> "block_resize", "arguments":{"device":"drive-virtio-disk1","size":10485=
760}}'
>=20
> The device file size actually grew, but the argument(10M) is less than =
the
> effective size(12M). This command should fail, but QEMU still report su=
ccess.

Nor do I see a real problem here.  It isn't dangerous if qemu trusts the
user, but it may break existing use cases to error out if the user
specifies a length that's too short.

In fact, I would suppose if you want to shrink an LVM volume, the
correct way to do it is to first shrink the virtual device in qemu (with
block_resize), and only then shrink the physical device on the host;
otherwise, qemu might issue requests beyond the end of the physical
disk.  This change would break that.

Max


--2Ru8qtlwALoy3Kz6emd9PNv3rH2FnMDl2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8aIoACgkQ9AfbAGHV
z0CocwgApyygpPQoezr3USuxVSy/PNcKbqiGXcwGomLlph1rPgwkPdsrlCuWhweL
CObFr68vbPJ3bu4eyVxngtfJKzDrQ9hvf0HW3fBTnu1AK6r7/VUHavXVEjgQ8YWU
irk1yUWWkNMoYWIK1cP9ds4uhPO1Zi3I8rSUzU8nkZJU9agyTILAnP4L1Kc3r0Ey
YCnmLfAq5rOhh8TBp7LV6cTBPxPESMrpifXI53CvTelVIYA04RvSjeUxTIknXC/e
0Lw/fd4hkAZXvf+dXOtQSnxT+SFFnuqG2wJvoSftUjYOXnT7W+7JAca+EXlduMcD
ULeuMQKsStgfsaC+A8fz5vuGoBLncw==
=4A6A
-----END PGP SIGNATURE-----

--2Ru8qtlwALoy3Kz6emd9PNv3rH2FnMDl2--
