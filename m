Received: from eggs.gnu.org ([2001:4830:134:3::10]:46805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmLOR-0003GP-AW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmLOQ-0005XV-A3
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:51:59 -0400
References: <20170828112952.22965-1-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a80aaf11-a962-c9d6-e271-c8ad5e1365b7@redhat.com>
Date: Mon, 28 Aug 2017 09:51:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170828112952.22965-1-kchamart@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sS1PJdlDWxTKdp9QgIo4rVSXp2VK145lb"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Extend non-shared storage
 migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sS1PJdlDWxTKdp9QgIo4rVSXp2VK145lb
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com,
 kwolf@redhat.com, dgilbert@redhat.com
Message-ID: <a80aaf11-a962-c9d6-e271-c8ad5e1365b7@redhat.com>
Subject: Re: [PATCH] qemu-iotests: Extend non-shared storage migration test
 (194)
References: <20170828112952.22965-1-kchamart@redhat.com>
In-Reply-To: <20170828112952.22965-1-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2017 06:29 AM, Kashyap Chamarthy wrote:
> This is the follow-up patch that was discussed[*] as part of feedback t=
o
> qemu-iotest 194.
>=20
> Changes in this patch:
>=20
>   - Supply 'job-id' parameter to `drive-mirror` invocation.
>=20
>   - Issue `block-job-cancel` command on the source QEMU to gracefully
>     complete the mirroring operation.
>=20
>   - Stop the NBD server on the destination QEMU.
>=20
>   - Finally, exit once the event BLOCK_JOB_COMPLETED is emitted.
>=20
> With the above, the test will also be (almost) in sync with the
> procedure outlined in the document live-block-operations.rst[+]
> (section: "QMP invocation for live storage migration with
> ``drive-mirror`` + NBD").
>=20
> [*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.h=
tml
>     -- qemu-iotests: add 194 non-shared storage migration test
> [+] https://git.qemu.org/gitweb.cgi?p=3Dqemu.git;a=3Dblob;f=3Ddocs/inte=
rop/live-block-operations.rst
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> I wonder:
>   - Is it worth printing the MIGRATION event state change?

I think waiting for both the BLOCK_JOB_COMPLETED and MIGRATION events
make sense (in other words, let's check both events in the expected
order, rather than just one or the other).

>   - Since we're not checking on the MIGRATION event anymore, can
>     the migration state change events related code (that is triggerred
>     by setting 'migrate-set-capabilities') be simply removed?

If we're going to mirror libvirt's non-shared storage migration
sequence, I think we want to keep everything, rather than drop the
migration half.

> ---
>  tests/qemu-iotests/194     | 17 ++++++++++++-----
>  tests/qemu-iotests/194.out | 14 ++++++++------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index 8028111e21bed5cf4a2e8e32dc04aa5a9ea9caca..8d746be9d0033f478f11886=
ee93f95b0fa55bab0 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -46,16 +46,17 @@ iotests.log('Launching NBD server on destination...=
')
>  iotests.log(dest_vm.qmp('nbd-server-start', addr=3D{'type': 'unix', 'd=
ata': {'path': nbd_sock_path}}))
>  iotests.log(dest_vm.qmp('nbd-server-add', device=3D'drive0', writable=3D=
True))
> =20
> -iotests.log('Starting drive-mirror on source...')
> +iotests.log('Starting `drive-mirror` on source...')
>  iotests.log(source_vm.qmp(
>                'drive-mirror',
>                device=3D'drive0',
>                target=3D'nbd+unix:///drive0?socket=3D{0}'.format(nbd_so=
ck_path),
>                sync=3D'full',
>                format=3D'raw', # always raw, the server handles the for=
mat
> -              mode=3D'existing'))
> +              mode=3D'existing',
> +              job_id=3D'mirror-job0'))
> =20
> -iotests.log('Waiting for drive-mirror to complete...')
> +iotests.log('Waiting for `drive-mirror` to complete...')

So, up to here is okay,

>  iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
>              filters=3D[iotests.filter_qmp_event])
> =20
> @@ -66,8 +67,14 @@ dest_vm.qmp('migrate-set-capabilities',
>              capabilities=3D[{'capability': 'events', 'state': True}])
>  iotests.log(source_vm.qmp('migrate', uri=3D'unix:{0}'.format(migration=
_sock_path)))
> =20
> +iotests.log('Gracefully ending the `drive-mirror` job on source...')
> +iotests.log(source_vm.qmp('block-job-cancel', device=3D'mirror-job0'))=

> +
> +iotests.log('Stopping the NBD server on destination...')
> +iotests.log(dest_vm.qmp('nbd-server-stop'))
> +
>  while True:
> -    event =3D source_vm.event_wait('MIGRATION')
> +    event =3D source_vm.event_wait('BLOCK_JOB_COMPLETED')

And this event makes sense for catching the block-job-cancel, but I
think you STILL want to keep a while loop for catching migration as well.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sS1PJdlDWxTKdp9QgIo4rVSXp2VK145lb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmkLf8ACgkQp6FrSiUn
Q2qfywf/WEHt9DoAzEZLGoSz7e5UUNqoaxJbYdgfCwFPObZWfUzXzSYUwvnSH4kJ
xyv1CCnbOtf961qiduVCso/ykv4TEVuX8zL80+q1eqiN0ht5G1VQSSAQ0vn09XTE
zZnsiXBhF9eYWK8oqmIZBoACquczLtMDucPsWbShsb8+czlHpJxs40OfSMvSrW3o
2O9RyZ9fkeVF4V+qWCWl7IygYiF1AxlqnLzx3MVAUdHWTpDTr+dQp4gVuLr3Wgew
DZMy3hkmfK0Yl9G31L55WE8LIUgES/rhxE65nrHn8WiS+v9NYgsaf7DnzBkNlArp
0kH2iRzJGM+9108LJbDBIH8XO59QYg==
=CjGj
-----END PGP SIGNATURE-----

--sS1PJdlDWxTKdp9QgIo4rVSXp2VK145lb--
