Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG61n-0006i8-Kw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG61m-0001Lf-KM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:59:19 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-3-berrange@redhat.com>
	<f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
Date: Wed, 31 May 2017 10:59:08 -0500
MIME-Version: 1.0
In-Reply-To: <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qub4VeGOm2kvasBo6tFEmM9fHwGIo9Dad"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] iotests: fix remainining tests to
 work with LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qub4VeGOm2kvasBo6tFEmM9fHwGIo9Dad
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <73621dcd-ace7-c7fa-8dd2-701ea7d6d249@redhat.com>
Subject: Re: [PATCH v5 2/5] iotests: fix remainining tests to work with LUKS
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-3-berrange@redhat.com>
 <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
In-Reply-To: <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 10:33 AM, Max Reitz wrote:
> On 2017-05-09 19:33, Daniel P. Berrange wrote:
>> The tests 033, 140, 145 and 157 were all broken
>> when run with LUKS, since they did not correctly use
>> the required image opts args syntax to specify the
>> decryption secret. Further, the 120 test simply does
>> not make sense to run with luks, as the scenario
>> exercised is not relevant.
>>
>> The test 181 was broken when run with LUKS because
>> it didn't take account of fact that $TEST_IMG was
>> already in image opts syntax. The launch_qemu
>> helper also didn't register the secret object
>> providing the LUKS password.

>> =20
>> +if test "$IMGOPTSSYNTAX" =3D "true"
>> +then
>> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,$TEST_IMG
>=20
> I would like to propose wrapping this (or at least $TEST_IMG) in quotes=
,

Makes no difference in assignment context (other than consistency that
it's an easier rule to always quote even when not necessary, than it is
to remember which contexts don't need quoting).

> but I'm aware of the fact that the whole test environment breaks if you=

> have a TEST_DIR with whitespace in it, so I don't mind...
>=20
> (But it is a bit weird to put $TEST_IMG into quotes below and then use
> $SYSEMU_DRIVE_ARG unquoted.)

Assigning to SYSEMU_DRIVE_ARG without quotes works even if TEST_IMG
contains spaces, but expanding SYSEMU_DRIVE_ARGS without quotes indeed
breaks (whether or not you assigned with quotes).

>=20
>> +    SYSEMU_EXTRA_ARGS=3D""
>> +else
>> +    SYSEMU_DRIVE_ARG=3Dif=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST=
_IMG",driver=3D$IMGFMT
>> +    SYSEMU_EXTRA_ARGS=3D""
>> +fi
>> +
>>  keep_stderr=3Dy \
>> -_launch_qemu -drive if=3Dnone,media=3Dcdrom,id=3Ddrv,file=3D"$TEST_IM=
G",format=3D$IMGFMT \
>> +_launch_qemu $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \

Yes, you want "$SYSEMU_DRIVE_ARG" here.


> Please use spaces instead of tabs.
>=20
> (I know there are a lot of tabs in the test files already, but accordin=
g
> to CODING_STYLE, that is just wrong.)

=2Edir-locals.el may need a tweak to be taught that files in qemu-iotests=

should not prefer TABs.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qub4VeGOm2kvasBo6tFEmM9fHwGIo9Dad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLuhMAAoJEKeha0olJ0NqGVQIAJpem1HNh8dZvlO1ONgNnLCw
LfslPgzVpclS48Cn1UJxZD9yyRJwjpUtRBzn2zT9Md1gNZhCJKYmXirHP6OSzF3O
h8QM5mtPkWwfDW1WakfyQSu8VsgLLhSBysa4cT43xtgpaS4WpHyN8KC2Ghz3RUhI
Q9AmSSjS1IhCGY3P8qlFys+MjagQaQXIOGa72PEBcJ3pjKf5Njuq23+cPhYLoBa5
gl1NcrLzfaAtPNPjyILKAI4YtT9MjeONtVbsFxNuDOYa+ndrSV+LuLmTULhnQrfx
p6LxUCA1B7T3fHxqWhKctFGf5sI+UTD95O36GgJfw9p9e/W3Jbpdzz2T0AWW/s8=
=O/HC
-----END PGP SIGNATURE-----

--qub4VeGOm2kvasBo6tFEmM9fHwGIo9Dad--
