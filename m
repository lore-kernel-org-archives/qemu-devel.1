Received: from eggs.gnu.org ([2001:4830:134:3::10]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEbof-0006ux-Gu
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEboe-000479-Rr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:36:09 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
	<CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <325f0743-7fca-0aab-c0f2-1ab46f94864b@redhat.com>
Date: Fri, 4 May 2018 16:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bz0VUjDa37RgdZ4xfC4Tkd2V7Y28eveBJ"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>, eblake@redhat.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bz0VUjDa37RgdZ4xfC4Tkd2V7Y28eveBJ
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>, eblake@redhat.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <325f0743-7fca-0aab-c0f2-1ab46f94864b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
 <bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
 <CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
In-Reply-To: <CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-03 15:06, =E5=8F=B6=E6=AE=8B=E9=A3=8E wrote:
>=20
> Thanks for your review, Eric.
> Yes, the wr_highest_offset can tell the end offset at runtime, and=C2=A0=

> write_threshold similar to it. But in my situation, I need to know=C2=A0=

> the allocated end without a vm running.

Oh, I've just seen that your patch doesn't even get the allocated size,
it actually determines the highest allocated offset.  Well, those are
two different things.  You should not return this value via
qcow2_get_allocated_file_size().  I'm not sure where it should go
(probably wr_highest_offset?) and how it should be presented in
qemu-img, though.

Also note that bdrv_get_allocated_file_size() is called by QMP's
query-named-block-nodes and query-block, both of which are online
synchronous functions.  It should not take a long time, specifically it
should not scan the whole qcow2 file.

Max


--Bz0VUjDa37RgdZ4xfC4Tkd2V7Y28eveBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrsb8gACgkQ9AfbAGHV
z0C06ggAiVFXqCBc8UdI96hembLlKwerjpZXq9FYA1oDLq2X4HQafYzfvKVLSvOA
/AhRnqDeKda9yDSNdCePNjRQqInUzZj8KQyVOcWda12C2NimrXT7bX3xkEFf3+FC
cwN+IQxwEXVj42kcko2oY0emaIJAEEv1hzXMNjjHX7kHu2Uopvq6G7HpU5djI6Vz
G1Te+evNabHc5PGjRhCZzux/VVWjCQhcM+tx/yrRiUCxx5Iqsozn730QHh8V/n1X
xV2Y3oI3TvSKpF0NMvvdmnyjqgaTnyxaGsUl+oh/F7PkpQMv98X15wjE6a3r2egD
6sfAO4F9E3q1kmjU1t8Hc+EbH/UE/w==
=ZIwD
-----END PGP SIGNATURE-----

--Bz0VUjDa37RgdZ4xfC4Tkd2V7Y28eveBJ--
