Received: from eggs.gnu.org ([2001:4830:134:3::10]:41338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEIu-0007Qg-8F
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEIp-00020Z-B1
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:33:08 -0400
Date: Wed, 11 Jul 2018 13:32:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711123259.GA31228@stefanha-x1.localdomain>
References: <20180704145410.794-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 03:54:10PM +0100, Stefan Hajnoczi wrote:

Sorry you weren't CCed originally, Berto.  This one is for you! :)

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
>=20
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 36cc0430c3..e297b04e17 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -564,6 +564,10 @@ void throttle_group_unregister_tgm(ThrottleGroupMemb=
er *tgm)
> =20
>      qemu_mutex_lock(&tg->lock);
>      for (i =3D 0; i < 2; i++) {
> +        if (timer_pending(tgm->throttle_timers.timers[i])) {
> +            tg->any_timer_armed[i] =3D false;
> +            schedule_next_request(tgm, i);
> +        }
>          if (tg->tokens[i] =3D=3D tgm) {
>              token =3D throttle_group_next_tgm(tgm);
>              /* Take care of the case where this is the last tgm in the g=
roup */
> --=20
> 2.17.1
>=20
>=20

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRfj7AAoJEJykq7OBq3PIe1IH/0sk3mZtU+oJf4Oa1IngAQLK
N7FY1tK8i2gV1oOuLCUf722JCsiotBNUsdgWRY4UEzjPwI7sWeoRhsjhFUxiUFel
KW43S5aZhN0M2F8UmZyeOZsIouFdEsXBraxbmY6ciyfG2F6PG5mwy4EX9SxTdtWh
wOD6QBWC/sbWKpI+uEsCzBULa92p/oVAGoNDFBnD5dARrscdTXUuhhjobkCuYlRg
AO5HGukwWhe4BwsTMJ9QJaZ9bD1cvaehvXekFG7m04gi+wAUQzQX9uhvvSCvc2HR
MwrvLJ2ifMX10DqmCYYp/w+JvPT8P3G6IVXlKCXQAKpc9Ux743xDexfbezDo/uA=
=ZvKN
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
