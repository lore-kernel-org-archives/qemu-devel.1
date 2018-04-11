Received: from eggs.gnu.org ([2001:4830:134:3::10]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6D3R-0007KL-22
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6D3N-0004G9-3L
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:32:41 -0400
References: <20180404150146.23281-1-stefanha@redhat.com>
	<5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
	<20180410081158.GA20090@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e11e634f-761f-de8e-8af3-c5bad2e6f920@redhat.com>
Date: Wed, 11 Apr 2018 12:32:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180410081158.GA20090@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jqScGj4zAexhjvVmTq0VIiI5uZPsx5LBw"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jqScGj4zAexhjvVmTq0VIiI5uZPsx5LBw
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
Message-ID: <e11e634f-761f-de8e-8af3-c5bad2e6f920@redhat.com>
Subject: Re: [PATCH for-2.12 v2] qemu-iotests: update 185 output
References: <20180404150146.23281-1-stefanha@redhat.com>
 <5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
 <20180410081158.GA20090@stefanha-x1.localdomain>
In-Reply-To: <20180410081158.GA20090@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-04-10 10:11, Stefan Hajnoczi wrote:
> On Wed, Apr 04, 2018 at 06:16:12PM +0200, Max Reitz wrote:
>> On 2018-04-04 17:01, Stefan Hajnoczi wrote:
>>  =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
>>
>> This seems to be independent of whether there is actually data on
>> TEST_IMG (the commit source), so something doesn't seem quite right wi=
th
>> the block job throttling here...?
>=20
> I've been playing around with this test failure.  Let's leave it broken=

> (!) in QEMU 2.12 because this test has uncovered a block job ratelimit
> issue that's not a regression.  The fix shouldn't be rushed.

OK for me.

> block/mirror.c calculates delay_ns but then discards it:
>=20
>   static void coroutine_fn mirror_run(void *opaque)
>   {
>       ...
>=20
>       for (;;) {
>           ...delay_ns is calculated based on job speed...
>=20
>           ret =3D 0;
>           trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>           if (block_job_is_cancelled(&s->common) && s->common.force) {
>               break;
>           } else if (!should_complete) {
>               delay_ns =3D (s->in_flight =3D=3D 0 && cnt =3D=3D 0 ? SLI=
CE_TIME : 0);
> 	        ^--- we discard it!
>               block_job_sleep_ns(&s->common, delay_ns);
>           }
>           s->last_pause_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>       }
>=20
>       ...
>   }

Uh, nice.

> This is why the mirror-based tests are completing even though we'd
> expect them to only reach the "next" iteration due to the job speed.
>=20
> Increasing the 4 MB write operation in the test to >16 MB (the mirror
> buffer size) doesn't solve the problem because the next QMP command wil=
l
> race with the job's 0 ns sleep.  It would just make the test unreliable=
=2E
>=20
> I'll work on the following for QEMU 2.13:
>=20
> 1. Avoid spurious block_job_enter() from block_job_drain().  This
>    eliminates the extra block job iteration that changed the output in
>    the first place.
>=20
> 2. Honor the job speed in block/mirror.c.
>=20
> The end result will be that the test output will not require changes.

Thanks!

Max


--jqScGj4zAexhjvVmTq0VIiI5uZPsx5LBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrN5DwACgkQ9AfbAGHV
z0DOnQgAsRwsuZ0pZCka1/Hnc3kIkyJ4t4CZKQVnBnhQE/4BwW/35mk+Z/dOcQ33
uBPnuZULt2E77Ft+vuo6vcbd7azEYvakdY0lI6E4Bawy7JlfVhuDUl7hKZ+/fdbL
8LA7E6oPOyd2yNcLt7Rf0mvjHEb+5UfpfPfop1QUxeQyAVOIpPXd+ZaT/ZH+CIvy
C8PvMuVZaIKQ4swKeYRiIvJg+3fJLdKb4Pn8IFCPXW/6Pn0KBpsG60n5aIYuB8Fp
Oe3LN2E4ELj57Wbx0MEfIM789Vu4l0tfPP8+VZ6WLdISvFLewz4j0+efdr472e8o
bian5hhP7KBwYel0Jnt1W0KFX1SexQ==
=UBaJ
-----END PGP SIGNATURE-----

--jqScGj4zAexhjvVmTq0VIiI5uZPsx5LBw--
