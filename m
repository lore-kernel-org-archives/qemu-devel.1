Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1da2bO-0006iD-Nj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1da2bN-0008I1-P6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:22:30 -0400
Date: Tue, 25 Jul 2017 19:21:45 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170725162145.algud34mtktskw2c@postretch>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-5-el13635@mail.ntua.gr>
	<20170724151247.GJ2784@stefanha-x1.localdomain>
	<20170725102908.6bwzz543pfi7ef7z@postretch>
	<20170725160941.GT23343@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgy2uvhvlp26dogk"
Content-Disposition: inline
In-Reply-To: <20170725160941.GT23343@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--pgy2uvhvlp26dogk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:09:41PM +0100, Stefan Hajnoczi wrote:
>On Tue, Jul 25, 2017 at 01:29:08PM +0300, Manos Pitsidianakis wrote:
>> On Mon, Jul 24, 2017 at 04:12:47PM +0100, Stefan Hajnoczi wrote:
>> > On Fri, Jul 14, 2017 at 12:45:18PM +0300, Manos Pitsidianakis wrote:
>> > > ThrottleGroup is converted to an object. This will allow the future
>> > > throttle block filter drive easy creation and configuration of throt=
tle
>> > > groups in QMP and cli.
>> > >
>> > > A new QAPI struct, ThrottleLimits, is introduced to provide a shared
>> > > struct for all throttle configuration needs in QMP.
>> > >
>> > > ThrottleGroups can be created via CLI as
>> > >     -object throttling-group,id=3Dfoo,x-iops-total=3D100,x-..
>> >
>> > Please make the QOM name and struct name consistent.  Either
>> > ThrottleGroup/throttle-group or ThrottlingGroup/throttling-group but n=
ot
>> > ThrottleGroup/throttling-group.
>>
>> I did this on purpose because current throttling has ThrottleGroup
>> internally and throttling.group in the command line. Should we keep this
>> only in legacy and make it throttle-group everywhere?
>
>I don't see a compatibility issue because -drive throttling.group=3D is a
>-drive property while THROTTLE_GROUP ("throttling-group") is a QOM class
>name.  They are unrelated and the QOM convention is for the
>typedef/struct name (ThrottleGroup) to be consistent with the QOM class
>name.
>
>Therefore it should be safe to use "throttle-group" as the QOM class
>name instead of "throttling-group".

I meant for consistency not compatibility. Otherwise it probably would=20
be better to keep throttle-group/ThrottleGroup in the new interfaces.
>
>> > > +    visit_type_int64(v, name, &value, &local_err);
>> > > +    if (local_err) {
>> > > +        goto fail;
>> > > +    }
>> > > +    if (value < 0) {
>> > > +        error_setg(&local_err, "Property value must be in range "
>> > > +                               "[0, %"PRId64"]", INT64_MAX);
>> >
>> > Please print the maximum value relevant to the actual field type inste=
ad
>> > of INT64_MAX.
>>
>> This checks the limits of the int64 field you give to QOM. I think you m=
ean
>> in the value assignment to each field that follows? In any case, since
>> unsigned is the only smaller field we could convert it to uint64_t/uint3=
2_t
>> internally.
>
>I'm saying that UNSIGNED fields are silently truncated if the value is
>larger than UINT_MAX, and also that the error message is misleading
>since UNSIGNED fields cannot take values in the whole range we print.

Yes, wouldn't it be better to convert the unsigned field burst_length to=20
uint64_t and take care of the overflow case? The field describes=20
seconds, but there's no reason to keep it that small.

--pgy2uvhvlp26dogk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAll3cBkACgkQc2J8L2kN
9xCUeg//T3SPoCgiaACCPHLhbARkkss+3FTGIfy+x7qn2cR8ifds4x8H9lRpW8pZ
ylAmk9wpp6Jx91Jk8DupSHBV6LvJsGVsDeNpBjkzhPnM8e/tA439ZXdv23gKBb9F
MQVM/bRe7GHeas7fpeOJOW8dhr5TNExRKV6UxDfRTqA9H+ZwQi5O8k6RLFtCMFq1
c6Jhdrj+oK7Tba05wfO3ejyF6Q/9euaX9Udq5lPFFo1EZF/DTr910xmSJR/cRr/3
DVzYREGjOGrbpG86hUuv/scuVLcj/+Wm8tBHjX/xcI9fdqNdEdB/zb2XmiW6YyvW
hpi3cqMtfmnFTlw/yGsHzwAsGiGN8WRSLXbEiW0sdDUf/m8RKpE/UNXnPHchNWYt
JLVInocVd2xaawevjBuAKMdpAHYmpf00tvvDoFDr931kW5klNU2oBEmc6pKRFfd3
S4AVH3eSE/z3YXXxzyuXHzZQzhI9pPmYJne30Qd8jMMBROa8Wm0BxJTtcgbMXsQj
l7yDqv7PIIwnZifMqIyCjnDdsT5XTIXJ2yq7cOb97o2UYf3MNGgHGibjAkHqLYl0
AQGKbfxuJaXeAGhY7ishtP3PL3wH4rvCYw2ZSEi3y0s7+sX/9X1U6gjrPiH7zV9j
q0KrmUmplfV2qcUZKjuMRjEkOLB/I/rTpO4dekiT6I8rcDNkLIU=
=NVcg
-----END PGP SIGNATURE-----

--pgy2uvhvlp26dogk--
