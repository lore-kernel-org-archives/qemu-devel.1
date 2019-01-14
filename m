Received: from eggs.gnu.org ([209.51.188.92]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Vg-0003he-K5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Ve-00056c-Lj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:46:40 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-6-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
Date: Mon, 14 Jan 2019 15:46:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9ksm1RvvaENdLvAs0zV9IQ9RhTC0g3eqh"
Subject: Re: [Qemu-devel] [PATCH v5 05/11] iotests: allow resume_drive by
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ksm1RvvaENdLvAs0zV9IQ9RhTC0g3eqh
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
Subject: Re: [PATCH v5 05/11] iotests: allow resume_drive by node name
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> After node graph changes, we may not be able to resume_drive by device
> name (backing files are not recursively searched). So, lets allow to
> resume by node-name. Set constant name for breakpoints, to avoid
> introducing extra parameters.

Hm, I don't quite understand this reason.  Is this so you can create
breakpoints on one node (which falls through to the first blkdebug node)
and then remove them from another (falling through to the same blkdebug
node)?

Wouldn't it be better to let the user specify the breakpoint name?

Max

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 76877ad584..c9779f432f 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -415,11 +415,11 @@ class VM(qtest.QEMUQtestMachine):
>              self.pause_drive(drive, "write_aio")
>              return
>          self.qmp('human-monitor-command',
> -                    command_line=3D'qemu-io %s "break %s bp_%s"' % (dr=
ive, event, drive))
> +                    command_line=3D'qemu-io %s "break %s bp_0"' % (dri=
ve, event))
> =20
>      def resume_drive(self, drive):
>          self.qmp('human-monitor-command',
> -                    command_line=3D'qemu-io %s "remove_break bp_%s"' %=
 (drive, drive))
> +                    command_line=3D'qemu-io %s "remove_break bp_0"' % =
(drive))
> =20
>      def hmp_qemu_io(self, drive, cmd):
>          '''Write to a given drive using an HMP command'''
> @@ -543,13 +543,14 @@ class QMPTestCase(unittest.TestCase):
>          self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_fi=
lename[5:])),
>                           self.vm.flatten_qmp_object(reference))
> =20
> -    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False):
> +    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False,
> +                        resume_node=3DNone):
>          '''Cancel a block job and wait for it to finish, returning the=
 event'''
>          result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, for=
ce=3Dforce)
>          self.assert_qmp(result, 'return', {})
> =20
>          if resume:
> -            self.vm.resume_drive(drive)
> +            self.vm.resume_drive(resume_node or drive)
> =20
>          cancelled =3D False
>          result =3D None
>=20



--9ksm1RvvaENdLvAs0zV9IQ9RhTC0g3eqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8oKwACgkQ9AfbAGHV
z0D0sggAoZ1Pe+svGp4d0imvxKB2U3sWkpZ1sQyFxBfYL8fx3U8YEZvhWioUmlTi
0bfkAAkto2/x6WFyxOu3PJshfV3ZPiLuGjINXBphVVo7eaQhRUjOu0/Bd7f0dNhS
iYcweXwdHHXELS2iuR29uTopN6wsg/QWasKvZujUTcaP3WmWd4KqHP6MvN7vSiEf
TRDrg0TlpldIbEoqo3+X4FmOQin2SnA+gA+0Z1nnOGBnExwZc4hkXhC4AcHQ/grO
pQhUPAGAwrJdvYNTK8G1VK4qQQI+6+3YjDaKa/kDM71c1Bi6/tJuquc46FGruuM5
i23qgcrvsy7Oh1QcgS4PkVm2JmL+gg==
=ZfsI
-----END PGP SIGNATURE-----

--9ksm1RvvaENdLvAs0zV9IQ9RhTC0g3eqh--
