Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdWK-0004Vu-EX
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdWJ-000082-FS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:50:56 -0400
References: <20180606183738.31688-1-mreitz@redhat.com>
	<CAFEAcA-GnSTh7aOEYm8g0DiFKP_o3LgPs_OHO8x0nPKuGU2-bw@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e08539e-62cc-ae4f-c770-8e366252a1b0@redhat.com>
Date: Wed, 6 Jun 2018 20:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-GnSTh7aOEYm8g0DiFKP_o3LgPs_OHO8x0nPKuGU2-bw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FyY3tioH7lkIUrnRjOwjVXOvvLUfTHurV"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FyY3tioH7lkIUrnRjOwjVXOvvLUfTHurV
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <0e08539e-62cc-ae4f-c770-8e366252a1b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
References: <20180606183738.31688-1-mreitz@redhat.com>
 <CAFEAcA-GnSTh7aOEYm8g0DiFKP_o3LgPs_OHO8x0nPKuGU2-bw@mail.gmail.com>
In-Reply-To: <CAFEAcA-GnSTh7aOEYm8g0DiFKP_o3LgPs_OHO8x0nPKuGU2-bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 20:41, Peter Maydell wrote:
> On 6 June 2018 at 19:37, Max Reitz <mreitz@redhat.com> wrote:
>> 219 has two issues that may lead to sporadic failure, both of which ar=
e
>> the result of issuing query-jobs too early after a job has been
>> modified.  This can then lead to different results based on whether th=
e
>> modification has taken effect already or not.
>>
>> First, query-jobs is issued right after the job has been created.
>> Besides its current progress possibly being in any random state (which=

>> has already been taken care of), its total progress too is basically
>> arbitrary, because the job may not yet have been able to determine it.=

>> This patch addresses this by just filtering the total progress, like
>> what has been done for the current progress already.  However, for mor=
e
>> clarity, the filtering is changed to replace the values by a string
>> 'FILTERED' instead of deleting them.
>>
>> Secondly, query-jobs is issued right after a job has been resumed.  Th=
e
>> job may or may not yet have had the time to actually perform any I/O,
>> and thus its current progress may or may not have advanced.  To make
>> sure it has indeed advanced (which is what the reference output alread=
y
>> assumes), insert a sleep of 100 ms before query-jobs is invoked.  With=
 a
>> slice time of 100 ms, a buffer size of 64 kB and a speed of 256 kB/s,
>> this should be the right amount of time to let the job advance by
>> exactly 64 kB.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> v2: Changed the query-jobs progress filtering [Eric]
>> ---
>=20
> I know nothing about the iotests, so this might be off-base,
> but this looks rather like "try to fix a race condition by
> adding a sleep", which generally doesn't work very well ?

The job tested here already has its own timing (copying 64 kB four times
a second, in 100 ms steps), so a sleep is not too bad.  What is
happening is that the job is put to sleep, then reawakened and it should
do one copy step immediately afterwards.  Then it won't do anything for
250 ms.

Now waiting 100 ms should really be enough to make that "immediate" step
actually happening, and it doesn't really hurt because we have 250 ms
anyway.

But I think it should be possible without the sleep (by repeatedly
querying the progress), I'll give it a try.

Max


--FyY3tioH7lkIUrnRjOwjVXOvvLUfTHurV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYLQYACgkQ9AfbAGHV
z0AHiwgAwruWTqwlug+ilLJtPtZjCvgeokLZplPWtL/v4M6yeJJi9KcHtryDMlde
JWUhIGwY3RHnf57WkbBHzyCGuX/lceRLp13ZcSDEtKm8lqUwYh3/jaA4uWHAHL2r
+WeSrGt287UZjEZUUIfZOmDfN2AVC5hhOkVjgQ61H6/driOwGUn/r+ONrrarpds5
IGLlGQ8sF5c1JxptMLnAZoW/OJKRVi8VNRlPZQgxFnknJrgiVjVTs1S9EffLW4hH
XKFmpH1L+x3SppUHCW+in5YIv1NeVLmz3n9LpRMZMc7SXOkr7WYWMmaEFy2AqLqW
BxMWWShYYUhPlunwGJPZrAUhLgEAiA==
=mTNA
-----END PGP SIGNATURE-----

--FyY3tioH7lkIUrnRjOwjVXOvvLUfTHurV--
