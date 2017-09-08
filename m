Received: from eggs.gnu.org ([2001:4830:134:3::10]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dqNNz-0000gP-Ol
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dqNNy-0007jT-V3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:48:11 -0400
Date: Fri, 8 Sep 2017 20:47:16 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170908174716.mxylb5ftm3ygk67m@postretch>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-5-el13635@mail.ntua.gr>
	<20170907132611.GG4461@dhcp-200-186.str.redhat.com>
	<20170908154459.5xpyczgpvim75o62@postretch>
	<20170908160011.GA17516@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2k4vhbnw4eccbmrb"
Content-Disposition: inline
In-Reply-To: <20170908160011.GA17516@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>


--2k4vhbnw4eccbmrb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 06:00:11PM +0200, Kevin Wolf wrote:
>Am 08.09.2017 um 17:44 hat Manos Pitsidianakis geschrieben:
>> On Thu, Sep 07, 2017 at 03:26:11PM +0200, Kevin Wolf wrote:
>> > We shouldn't really need any throttling code in
>> > blk_root_drained_begin/end any more now because the throttle node will
>> > be drained. If this code is necessary, a bdrv_drain() on an explicit
>> > throttle node will work differently from one on an implicit one.
>> >
>> > Unfortunately, this seems to be true about the throttle node. Implicit
>> > throttle nodes will keep ignoring the throttle limit in order to
>> > complete the drain request quickly, where as explicit throttle nodes
>> > will process their requests at the configured speed before the drain
>> > request can be completed.
>> >
>> > This doesn't feel right to me, both should behave the same.
>> >
>> > Kevin
>> >
>>
>> I suppose we can implement bdrv_co_drain and increase io_limits_disabled
>> from inside the driver. And then remove the implicit filter logic from
>> blk_root_drained_begin. But there's no _end callback equivalent so we ca=
n't
>> decrease io_limits_disabled at the end of the drain. So I think there are
>> two options:
>>
>> - make a bdrv_co_drain_end cb and recurse in blk_root_drain_end for all
>> children to call it. Old behavior of I/O bursts (?) during a drain is  k=
ept.
>
>This is the solution I was thinking of. It was always odd to have a
>drained_begin/end pair in the external interface and in BdrvChildRole,
>but not in BlockDriver. So it was to be expected that we'd need this
>sooner or later.
>
>> - remove io_limits_disabled and let throttled requests obey limits  duri=
ng a
>> drain
>
>This was discussed earlier (at least when the disable code was
>introduced in BlockBackend, but I think actually more than once), and
>even though everyone agreed that ignoring the limits is ugly, we
>seem to have come to the conclusion that it's the least bad option.
>blk_drain() blocks and makes everything else hang, so we don't want it
>to wait for several seconds.
>
>Kevin

That makes sense. I will look into this and resubmit the series with=20
this additional change.

--2k4vhbnw4eccbmrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmy16QACgkQc2J8L2kN
9xDWmQ/+PWxUu2c+l0BcJ5pOpAVdcRC2JcNK1j68hK3eZhZw8kM1QUSJ2Rcovjhw
hzw3FT7KFZVdU5zc3SNxWdisYZOBQApen4iPtuw3WN3adm8zPpgh/6/tZ1QByuia
jeKob9NFyaxJczaxgwIt8YdGvZdUB9kR1LnoAYDCht7bAQNdMJw341XF4jvYkduk
BhqngkDOmDCIgtaBGoNMkJ6m9a4yDVfvpAvAUbDQHFn0xAwROZk/0uqPL/kzEPdi
mL3R+D/4sz4BIl1FHLCTSOA0/XQB4D6unwytgevU7E+alt7sbCtYmbAr+PNEBEW+
ueo492xQI22I0Y0p5TkgJ3M2sOy3FjS8upkNG0tRFsA16TMwei7vu3jZErwAwOUG
LQ0tcUOtp0NSsx5fL8MksRQZu8dfX+SZUfKYxSsO7sNaN+8b5QN82iDvwJ+r+0G2
j3n4nPf4A/IobdXAueJQ2ijdEbPmgJyH+dQwSgpPq2bVDONvrNV7P9QslGD3gcXZ
bu2ACGWIg4iduQnki/TFOrTmFEhovX/Vmo5gCUFZnKGgZfE3UyEpomoFmT6NDQeY
A87gfrL9LfzAn5UkeL2jSH3Aywkr+j6rgPaoEWROToraU20hD1xVMkXaHQMfxUMv
mvNIgTvimxHfgNcsCSSfLF0BrG+9y0yg22VjQ6EwPquthH5fJPU=
=r9t+
-----END PGP SIGNATURE-----

--2k4vhbnw4eccbmrb--
