Received: from eggs.gnu.org ([2001:4830:134:3::10]:41768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAX-000256-2W
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAR-000115-Gz
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:01 -0400
Date: Wed, 20 Sep 2017 14:39:02 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170920113902.ljcsl3y5c6kvo4eq@postretch>
References: <20170920101740.12490-1-stefanha@redhat.com>
	<w51fubh1vaz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhlz2vcktuuvob2k"
Content-Disposition: inline
In-Reply-To: <w51fubh1vaz.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--hhlz2vcktuuvob2k
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 01:08:52PM +0200, Alberto Garcia wrote:
>On Wed 20 Sep 2017 12:17:40 PM CEST, Stefan Hajnoczi wrote:
>> @@ -592,6 +592,17 @@ void throttle_group_attach_aio_context(ThrottleGrou=
pMember *tgm,
>>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
>>  {
>>      ThrottleTimers *tt =3D &tgm->throttle_timers;
>> +    ThrottleGroup *tg =3D container_of(tgm->throttle_state, ThrottleGro=
up, ts);
>> +
>> +    qemu_mutex_lock(&tg->lock);
>> +    if (timer_pending(tt->timers[0])) {
>> +        tg->any_timer_armed[0] =3D false;
>> +    }
>> +    if (timer_pending(tt->timers[1])) {
>> +        tg->any_timer_armed[1] =3D false;
>> +    }
>> +    qemu_mutex_unlock(&tg->lock);
>> +
>>      throttle_timers_detach_aio_context(tt);
>>      tgm->aio_context =3D NULL;
>>  }
>
>I'm sorry that I didn't noticed this in my previous e-mail, but after
>this call you might have destroyed the timer that was set for that
>throttling group, so if there are pending requests waiting it can happen
>that no one wakes them up.
>
>I think that the queue needs to be restarted after this, probably after
>having reattached the context (or actually after detaching it already,
>but then what happens if you try to restart the queue while aio_context
>is NULL?).

aio_co_enter in the restart queue function requires that aio_context is=20
non-NULL. Perhaps calling throttle_group_restart_tgm in=20
throttle_group_attach_aio_context will suffice.

--hhlz2vcktuuvob2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnCU1UACgkQc2J8L2kN
9xA20xAA1QiKrAxotb8IbNFcd2OPhLvq/Kiw7ASLGBXqFItDyMK8uTCMxzQiWeBu
qi2ZZ9k78/YD+5DkMAczMPLKfIb4wIp9sa7NcnEOx/c5XCkfJ+K/4MbuvA1U6D1w
NndSAUEPo3mdodQgvaogik3/DDWlurwntMpGS4EDL02gUi8D0Q/Om0r6JBqmmklE
4mbhbWRDzz5Wtz65UtCVh91mMDXhpvoc645gblHzRqX1+0OGuc8LDJdSKfWgNrPr
vYpqoyaoX3gOPheZlN1Pg9cuGvsw6a0c/NJVKrxflHtIhrKCWg5sGgEqRwCaLsVz
XMyWboGchxCIAR0eJDK4TrdcLeb3ADa5fPlXKDQBH2Ba/hGUtq2SMqKVqwziVzF4
x5+iz/UmUHkfMhmSQ0777x+yYFKiyEHNSRDr7G9MJ33WelwULux4DwZjuqApoNHA
Iwz2z3PUuboiDqiLybpg3ax23Y2R21Ksk+kq3xdigrLzJAqXxtYdKZ+dCc/1suVt
XCja6vpO4s8I9BJM/ep+7m2UDaItoBFPPa7zkp5pRF3K/3u735OgCPda67FQqEEd
itQPyRdaiLIGgvCy/RBefhY/ukBEAtbtVY1LAW0WNjLrW4f/ZMbeIGSj9QXgA+I7
4wivFmnLkAxgJPLZKQEBxrjYdsulgbiFERiJtxHT6rKETWIwlmU=
=N6Of
-----END PGP SIGNATURE-----

--hhlz2vcktuuvob2k--
