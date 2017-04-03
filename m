Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv2dT-0001dw-Vp
	for Qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv2dQ-0005NL-SF
	for Qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:07:11 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
Date: Mon, 3 Apr 2017 09:07:02 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NAIUsWaQ3DL3qQJ1d5u0XSsOMjjQ0mXrd"
Subject: [Qemu-devel] help debugging throttle crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NAIUsWaQ3DL3qQJ1d5u0XSsOMjjQ0mXrd
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Alberto Garcia <berto@igalia.com>, qemu block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
Subject: help debugging throttle crash
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm trying to investigate
https://bugzilla.redhat.com/show_bug.cgi?id=3D1428810, which is a crash
that can be easily reproduced with the following steps:

$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
-device virtio-scsi-pci,bus=3Dpci.0  -drive
id=3Ddrive_image2,if=3Dnone,format=3Draw,file=3Dfile2,bps=3D512000,iops=3D=
100,group=3Dfoo
-device scsi-hd,id=3Dimage2,drive=3Ddrive_image2 -drive
id=3Ddrive_image3,if=3Dnone,format=3Draw,file=3Dfile3,bps=3D512000,iops=3D=
100,group=3Dfoo
-device scsi-hd,id=3Dimage3,drive=3Ddrive_image3
{'execute':'qmp_capabilities'}
{'execute':'device_del','arguments':{'id':'image3'}}
{'execute':'system_reset'}

At this point, it looks like no one is calling
throttle_group_unregister_blk() as a result of the 'device_del', which
leaves stale memory around (I was able to confirm this under gcc - a
breakpoint on that function never fires); then the 'system_reset' causes
next_throttle_token() to dereference the stale memory and crash.
However, I have no idea where the unplug action should be removing the
BB from the throttle group.  Is it as simple as adding it to
blk_io_unplug(), or will that be violating other constraints on making
sure the throttle group is first drained before removing the BB from the
group as one of the final steps during its hot unplug?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org




--NAIUsWaQ3DL3qQJ1d5u0XSsOMjjQ0mXrd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4lcGAAoJEKeha0olJ0NqeZYIAKYQiFot11WYfmIv/xwsqpqV
1djf0F/mc1GQR7eeiRv9jvgk/PBnChcYX8+AGeLCitjCZ9bfRHBgr0YNbFEFpxUo
F/tzE227GGzjeW6abSX7nAu8JB/nf2Bd8M6UXyHmCfqG0yngPBgziv0mSdyvHTF9
w80NS0ueQ2JnqQHGSgWJuvYvHW2RQUrQ8vCv4o6jFm6V84tQQujiDzZFKuwRJR3Q
sTWskExyX8WAI1mCBmByCBwwoJ1FWTkhB7qpaC7F5T0KHL2aR1wi0eIuXZ0/XdlC
yF8/jj1HxJJzBqVDD3G+FrSGkXYlGSj2AqHw1BQvwb/BMP2o7gQTzF8m420aD04=
=h6Hl
-----END PGP SIGNATURE-----

--NAIUsWaQ3DL3qQJ1d5u0XSsOMjjQ0mXrd--
