Received: from eggs.gnu.org ([2001:4830:134:3::10]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQcn0-0002Vh-4H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQcmw-0000r9-TQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:04:06 -0400
Date: Wed, 6 Jun 2018 20:04:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <fe2799d9-0a74-774a-1b97-59365afa1c8b@amsat.org>
Message-ID: <alpine.BSF.2.21.1806061936550.94568@zero.eik.bme.hu>
References: <cover.1528069840.git.balaton@eik.bme.hu>
	<6f3e8e1070c12d1a8321f4fdb6f65d56adc2767b.1528069840.git.balaton@eik.bme.hu>
	<20180606063606.GJ17757@umbus.fritz.box>
	<alpine.BSF.2.21.1806061558010.42561@zero.eik.bme.hu>
	<fe2799d9-0a74-774a-1b97-59365afa1c8b@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc4xx_i2c: Rewrite PPC4xx I2C
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Wed, 6 Jun 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/06/2018 11:03 AM, BALATON Zoltan wrote:
>> On Wed, 6 Jun 2018, David Gibson wrote:
>>> On Mon, Jun 04, 2018 at 01:50:40AM +0200, BALATON Zoltan wrote:
>>>> I2C emulation currently is just enough for U-Boot to access SPD
>>>> EEPROMs but features that guests use to access I2C devices are not
>>>> correctly emulated. Rewrite to implement missing features to make it
>>>> work with all clients.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> Maybe this could be split up into more patches but because the
>>>> previous implementation was wrong only allowing U-Boot to pass and n=
o
>>>> clients could access I2C devices before this rewrite it probably doe=
s
>>>> not worth to try to make it a lot of small changes instead of droppi=
ng
>>>> the previous hack and rewrite following features of real hardware mo=
re
>>>> closely. (It turns out that each client driver accesses I2C in a
>>>> different way so we need to implement almost all features of the
>>>> hardware to please everyone.)
>>>
>>> The trouble is that because I don't really have a good test setup for
>>> this, I'm pretty reluctant to apply such a total rewrite without acks
>>> from more people who've tested it.? That or reviewing the changes
>>> myself, which I can't really do when it's in one big lump like this.
>>
>> OK, I've sent a v2 where this patch is split up to smaller pieces that
>> are hopefully easier to review. However this i2c emulation was only a
>> stub originally which was hacked together to make U-Boot happy when
>> added the sam460ex machine and this is the first version that attempts
>> to really model the device so that guests can also use it. Therefore I
>> think there's not a high chance of breaking anything important. I've
>> tested this with AROS, Linux, AmigaOS and MorphOS and they seem to be
>> able to read the RTC so it should work better than the previous versio=
n.
>
> Are those images publicly accessible? (thinking about adding acceptance
> qtests).

AROS is available, get the sam440-ppc-boot-iso from this page:
http://aros.sourceforge.net/nightly1.php
for latest nightly build which should work.

There are several Linux images available around the net but none seems to=
=20
be fully working (and may have bugs even on real hardware) so I don't kno=
w=20
about a good one to try. I test with booting a kernel directly via -kerne=
l=20
option but couldn't get a distro running and recent upstream kernels seem=
=20
to have a bug finding SM501 display. Older and/or patched kernels for=20
Sam460ex seem to work better but haven't tested all of those.

AmigaOS and MorphOS are closed source. Only MorphOS is available publicly=
=20
as a demo but that's not booting yet for some reason and (at least some=20
of) its developers are against running it on QEMU and said that won't=20
support attempts getting it to work. Therefore I'll have to find out what=
=20
it's missing in emulation without their help. (Just mentioning it in case=
=20
someone tries to ask for help and get an unfriendly reply or no reply at=20
all. This does not bother me testing with it and improving emulation to=20
the point where it will work as well. But I think it may have bugs on rea=
l=20
hardware as well because I've seen forum posts about problems with PCI=20
devices on real sam460 which is what I see on QEMU as well.)

Not sure if there are any other OSes that run on real hardware that I=20
should be aware of. There was a Haiku port attempted which is what this=20
emulation started from (to help that porting) but not sure if there was=20
any progress with that since.

Regards,
BALATON Zoltan
