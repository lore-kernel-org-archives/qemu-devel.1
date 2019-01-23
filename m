Received: from eggs.gnu.org ([209.51.188.92]:45178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmL90-0000tc-J7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmL8z-0004lv-Do
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:12:50 -0500
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<20190123110417.69e41c38@doriath>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
Date: Wed, 23 Jan 2019 17:12:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190123110417.69e41c38@doriath>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ouLGEjgWsov3zzZK40w9zBRnCjSk84Cul"
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ouLGEjgWsov3zzZK40w9zBRnCjSk84Cul
From: Max Reitz <mreitz@redhat.com>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, dgilbert@redhat.com
Message-ID: <b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
Subject: Re: Aborts in iotest 169
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
 <20190123110417.69e41c38@doriath>
In-Reply-To: <20190123110417.69e41c38@doriath>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 17:04, Luiz Capitulino wrote:
> On Wed, 23 Jan 2019 16:48:49 +0100
> Max Reitz <mreitz@redhat.com> wrote:
>=20
>> Hi,
>>
>> When running 169 in parallel (e.g. like so:
>>
>> $ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done
>>
>> in four different shells), I get aborts:
>=20
> OK, is this part of a test-suite that's also running migration
> tests in parallel or in sequence? In other words, what does
> iotests have to do with migration (sorry if this is stupid
> question, but it's been years I don't do qemu).

They run migration tests in sequence, but if you run multiple test
instances in parallel, well, then they will be run in parallel.

The only reason I CC'd you was because you were so prominent in git
blame. O:-)

> More below.
>=20
> [...]
>=20
>> The backtrace always goes like this:
>>
>> (gdb) bt
>> #0  0x00007f0acf5cc53f in raise () at /lib64/libc.so.6
>> #1  0x00007f0acf5b6895 in abort () at /lib64/libc.so.6
>> #2  0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_POSTMIGR=
ATE)
>> at vl.c:742
>> #3  0x000055a46ebbb1a6 in runstate_set
>> (new_state=3Dnew_state@entry=3DRUN_STATE_POSTMIGRATE) at vl.c:730
>> #4  0x000055a46ed39129 in migration_iteration_finish (s=3D0x55a4708be0=
00)
>> at migration/migration.c:2972
>> #5  0x000055a46ed39129 in migration_thread
>> (opaque=3Dopaque@entry=3D0x55a4708be000) at migration/migration.c:3130=

>> #6  0x000055a46eea665a in qemu_thread_start (args=3D<optimized out>) a=
t
>> util/qemu-thread-posix.c:502
>>
>>
>> #7  0x00007f0acf76258e in start_thread () at /lib64/libpthread.so.0
>> #8  0x00007f0acf6916a3 in clone () at /lib64/libc.so.6
>> (gdb) frame 2
>> #2  0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_POSTMIGR=
ATE)
>> at vl.c:742
>> 742             abort();
>> (gdb) print current_run_state
>> $1 =3D RUN_STATE_RUNNING
>>
>>
>> Neither of migration or runstates are my strong suite, so I thought I'=
d
>> report it before diving into it.
>=20
> So, the problem seems to be that qemu is going from running state to
> postmigrate state. IIRC, this is is an invalid state transition. The
> valid states to transition to depends if this guest is the source or
> target for migration.
>=20
> When this happened in the past it meant some QEMU code skipped a
> transition, but I can't tell what this has to do with iotests.

Well, this iotest (which tests a migration configuration) sometimes
apparently results in this invalid transition.  But that can't be just
the test's fault, as qemu should handle that gracefully.

It's probably an issue in the migration code and not so much in vl.c, yes=
=2E..

Max


--ouLGEjgWsov3zzZK40w9zBRnCjSk84Cul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIknMACgkQ9AfbAGHV
z0C6jwgAxJnctQrRcj/my5+8/0eD0LLkeWHaAXIh5S/Aj5jAPuKBd8Raf6/YIX+C
HZ6NbreSUbm4XefcvfqVLttXvN76F9jJHvkaANVZcC+Z2TcvSTz9EwhykvSEhoMq
jL9rZn6fZHtYlZPYw79opRhApgXJlEVQIq9tcg5K3MT0JXmcyi32sjWY2aLMCmL4
b2/mvl5KY8Mcat5gRkuFc0ElFRUQu2GFe3/LLIKVrTflYxySTMiCPX/5Vx+F/cSX
gMn4eSn0vwJbUv/1F/aN1GThgFORGok7vaYXc9CNACKKiebv2myrCg9TaaZHszzm
i/RhWTIEaHAB0nKmJWnRm44D+h5zFA==
=t8p0
-----END PGP SIGNATURE-----

--ouLGEjgWsov3zzZK40w9zBRnCjSk84Cul--
