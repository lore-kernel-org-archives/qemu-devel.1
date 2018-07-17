Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffL5J-0002Tc-SE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffL5G-0000BM-NH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:11:49 -0400
Date: Tue, 17 Jul 2018 09:11:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180717081143.GA28999@stefanha-x1.localdomain>
References: <20180704145410.794-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20180704145410.794-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle-groups: fix hang
 when group member leaves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 03:54:10PM +0100, Stefan Hajnoczi wrote:
> Throttle groups consist of members sharing one throttling state
> (including bps/iops limits).  Round-robin scheduling is used to ensure
> fairness.  If a group member already has a timer pending then other
> groups members do not schedule their own timers.  The next group member
> will have its turn when the existing timer expires.
>=20
> A hang may occur when a group member leaves while it had a timer
> scheduled.  Although the code carefully removes the group member from
> the round-robin list, it does not schedule the next member.  Therefore
> remaining members continue to wait for the removed member's timer to
> expire.
>=20
> This patch schedules the next request if a timer is pending.
> Unfortunately the actual bug is a race condition that I've been unable
> to capture in a test case.
>=20
> Sometimes drive2 hangs when drive1 is removed from the throttling group:
>=20
>   $ qemu ... -drive if=3Dnone,id=3Ddrive1,cache=3Dnone,format=3Dqcow2,fil=
e=3Ddata1.qcow2,iops=3D100,group=3Dfoo \
>              -device virtio-blk-pci,id=3Dvirtio-blk-pci0,drive=3Ddrive1 \
>              -drive if=3Dnone,id=3Ddrive2,cache=3Dnone,format=3Dqcow2,fil=
e=3Ddata2.qcow2,iops=3D10,group=3Dfoo \
>              -device virtio-blk-pci,id=3Dvirtio-blk-pci1,drive=3Ddrive2
>   (guest-console1)# fio -filename /dev/vda 4k-seq-read.job
>   (guest-console2)# fio -filename /dev/vdb 4k-seq-read.job
>   (qmp) {"execute": "block_set_io_throttle", "arguments": {"device": "dri=
ve1","bps": 0,"bps_rd": 0,"bps_wr": 0,"iops": 0,"iops_rd": 0,"iops_wr": 0}}
>=20
> Reported-by: Nini Gu <ngu@redhat.com>
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1535914
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/throttle-groups.c | 4 ++++
>  1 file changed, 4 insertions(+)

Berto is away in July.  I am merging this fix for QEMU 3.0.  If there
are any comments when Berto is back I'll send a follow-up patch.

Applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTaS+AAoJEJykq7OBq3PID+kH/2gAmhtJYf65SbQAaLkI1U0P
o1OSmQRc27vlb0ZYM8umUdr1oNzyfXqprMLQ0BYYh+d+AjQ1hwcYKv8Kqhk9EmLY
kHjIEas27Kgps6dRaJpfinyp8HQGEuK4JxQwW7VSQG2jkLOXw38uWPqmBgB3T7Yc
M4JFVvAeN2QL6BmgkFnW1Vpt3VkDXcEIsGMFjFD+v+osoghkMjI5XSseuCycmEuE
A5QXEeFyNi+xBShEy4JwNaaJZgDHmHT7KJ2R4MOuNcdrmPP87i5V4mW10ce1uGok
hxYhM7AjQym7ZgVu1qs9XXeuGcHQznEx7PKbtYUOyI/sEB2+0FHh5D0ZRAPynpg=
=FZAm
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
