Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9p2B-0000ah-Ev
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9p28-0007EC-Dy
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:42:19 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:46186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9p28-0007Cn-7l
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:42:16 -0400
Received: from player796.ha.ovh.net (unknown [10.109.105.78])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 53EB2AC6B5
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 11:42:14 +0200 (CEST)
References: <20180420124835.7268-1-peter.maydell@linaro.org>
	<20180420124835.7268-3-peter.maydell@linaro.org>
	<f80b3748-12d4-de8b-1661-e07a7d33b60a@kaod.org>
	<CAFEAcA8g_qcXj7ErMNODexU4k2k56nYUSzoh3WX06mZTVRMLLg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <11085e2c-69dd-93b1-ebeb-5b7c1257e26e@kaod.org>
Date: Sat, 21 Apr 2018 11:42:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8g_qcXj7ErMNODexU4k2k56nYUSzoh3WX06mZTVRMLLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/aspeed: don't make 'boot_rom'
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Rob Herring <robh@kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 04/21/2018 11:34 AM, Peter Maydell wrote:
> On 21 April 2018 at 10:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> On 04/20/2018 02:48 PM, Peter Maydell wrote:
>>> Currently we use memory_region_init_ram_nomigrate() to create
>>> the "aspeed.boot_rom" memory region, and we don't manually
>>> register it with vmstate_register_ram(). This currently
>>> means that its contents are migrated but as a ram block
>>> whose name is the empty string; in future it may mean they
>>> are not migrated at all. Use memory_region_init_ram() instead.
>>>
>>> Note that this is a cross-version migration compatibility break
>>> for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.
>>
>> Migration does not work for these.
>=20
> Well, at least we're not breaking anything :-)
> Do you know why migration doesn't work?

A quick migration test shows that :

qemu-system-arm: Missing section footer for aspeed.timerctrl
qemu-system-arm: load of migration failed: Invalid argument

which is surprising, the state looks correct. I will dig in.=20

Thanks,

C.


    "aspeed.timerctrl (8)": {
        "ctrl": "0x00000003",
        "ctrl2": "0x00000000",
        "timers": [
            {
                "id": "0x00",
                "level": "0x00000000",
                "timer": "00 00 00 29 aa bd 88 44",
                "reload": "0xffffffff",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x01",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x02",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x03",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0xffffffff",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x04",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x05",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x06",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            },
            {
                "id": "0x07",
                "level": "0x00000000",
                "timer": "ff ff ff ff ff ff ff ff",
                "reload": "0x00000000",
                "match": [
                    "0x00000000",
                    "0x00000000"
                ]
            }
        ]
    },
