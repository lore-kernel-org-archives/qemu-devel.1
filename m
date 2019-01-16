Received: from eggs.gnu.org ([209.51.188.92]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjoj3-00006x-5C
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjoiy-0005yG-KS
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:11:37 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc4780d7-dc96-e050-dfe0-1a47d99893d5@redhat.com>
Date: Wed, 16 Jan 2019 11:11:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G9VjP6kpjiP9mi3qUrA3K4nJ7ELjcrqcF"
Subject: Re: [Qemu-devel] [PATCH v4 10/10] iotests: test nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G9VjP6kpjiP9mi3qUrA3K4nJ7ELjcrqcF
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <bc4780d7-dc96-e050-dfe0-1a47d99893d5@redhat.com>
Subject: Re: [PATCH v4 10/10] iotests: test nbd reconnect
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-11-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Add test, which starts backup to nbd target and restarts nbd server
> during backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/220        | 67 +++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/220.out    |  7 +++++
>  tests/qemu-iotests/group      |  1 +
>  tests/qemu-iotests/iotests.py |  4 +++
>  4 files changed, 79 insertions(+)
>  create mode 100755 tests/qemu-iotests/220
>  create mode 100644 tests/qemu-iotests/220.out
>=20

Test 220 has been created in the meantime; the obvious resolution is to
pick a new test number.

> diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
> new file mode 100755
> index 0000000000..c9702a7dad
> --- /dev/null
> +++ b/tests/qemu-iotests/220
> @@ -0,0 +1,67 @@
> +#!/usr/bin/env python

> +
> +import iotests
> +from iotests import qemu_img_create, file_path, qemu_nbd_popen
> +
> +disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')=

> +nbd_uri =3D 'nbd+unix:///exp?socket=3D' + nbd_sock
> +
> +qemu_img_create('-f', iotests.imgfmt, disk_a, '5M')
> +qemu_img_create('-f', iotests.imgfmt, disk_b, '5M')
> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgf=
mt, disk_b)
> +time.sleep(1)
> +
> +vm =3D iotests.VM().add_drive(disk_a)
> +vm.launch()
> +vm.hmp_qemu_io('drive0', 'write 0 5M')
> +
> +print 'blockdev-add:', vm.qmp('blockdev-add', node_name=3D'backup0', d=
river=3D'raw',
> +                              file=3D{'driver':'nbd',
> +                                    'export': 'exp',
> +                                    'server': {'type': 'unix',
> +                                               'path': nbd_sock}})
> +print 'blockdev-backup:', vm.qmp('blockdev-backup', device=3D'drive0',=

> +                                 sync=3D'full', target=3D'backup0')
> +
> +time.sleep(1)
> +print 'Kill NBD server'
> +srv.kill()
> +
> +jobs =3D vm.qmp('query-block-jobs')['return']
> +if jobs and jobs[0]['offset'] < jobs[0]['len']:
> +    print 'Backup job is still in progress'
> +
> +time.sleep(1)

That's a lot of sleep()s for a test marked quick. Are we sure it won't
fail under heavy load? Can you make the test more reliable by looking
for specific events rather than just a fixed-length sleep?

> +
> +print 'Start NBD server'
> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgf=
mt, disk_b)
> +
> +try:
> +    e =3D vm.event_wait('BLOCK_JOB_COMPLETED')
> +    print e['event'], ':', e['data']
> +except:
> +    pass
> +
> +print 'blockdev-del:', vm.qmp('blockdev-del', node_name=3D'backup0')
> +srv.kill()
> +vm.shutdown()
> diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
> new file mode 100644
> index 0000000000..dae1a49d9f
> --- /dev/null
> +++ b/tests/qemu-iotests/220.out
> @@ -0,0 +1,7 @@
> +blockdev-add: {u'return': {}}
> +blockdev-backup: {u'return': {}}
> +Kill NBD server
> +Backup job is still in progress
> +Start NBD server
> +BLOCK_JOB_COMPLETED : {u'device': u'drive0', u'type': u'backup', u'spe=
ed': 0, u'len': 5242880, u'offset': 5242880}
> +blockdev-del: {u'return': {}}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index b973dc842d..ee2473c6a3 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -219,6 +219,7 @@
>  217 rw auto quick
>  218 rw auto quick
>  219 rw auto
> +220 rw auto quick
>  221 rw auto quick
>  222 rw auto quick
>  223 rw auto quick
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 4e67fbbe96..17bc8c8e32 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -185,6 +185,10 @@ def qemu_nbd(*args):
>      '''Run qemu-nbd in daemon mode and return the parent's exit code''=
'
>      return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
> =20
> +def qemu_nbd_popen(*args):
> +    '''Run qemu-nbd in daemon mode and return the parent's exit code''=
'
> +    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(ar=
gs))
> +
>  def compare_images(img1, img2, fmt1=3Dimgfmt, fmt2=3Dimgfmt):
>      '''Return True if two image files are identical'''
>      return qemu_img('compare', '-f', fmt1,
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--G9VjP6kpjiP9mi3qUrA3K4nJ7ELjcrqcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/ZbwACgkQp6FrSiUn
Q2rPIAgAmPXLXMsvUadWVRp9dkAtHhqahYMd0LjCebQt8NuntWuqThnTVRxcm5LZ
J2mp2VLESWlAQp7i5mYLKxFUrUKjf70SypT0b7Rc01x5+XSvyde4529QZ0bL57yn
VYw7CsNP+emLGrJS7haIHcunZzgKjdcmC/rpBOrRomERz1F0A5NlRKSd5l4qcVlJ
PCx0u5lVSaMynExcqnKz8jEaB7paEhDgv7wDgZxHW/rjhzTY/ouL9jOEHlmINe4a
xPS7XxE2QD5T0sHx48+jtnDqS6lGYCZiBz9wZJggRaTTsXpIi0R3/DjgviQ0lnPn
6N7srW3/E2VO0j2lJXrMlJjSlYLONg==
=Wgtt
-----END PGP SIGNATURE-----

--G9VjP6kpjiP9mi3qUrA3K4nJ7ELjcrqcF--
