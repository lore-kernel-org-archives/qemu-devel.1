Received: from eggs.gnu.org ([2001:4830:134:3::10]:51140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cOozC-0003V5-DV
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cOozB-0002NV-87
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:04:26 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cOozB-0002Mm-3X
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:04:25 -0500
Received: by mail-vk0-x232.google.com with SMTP id 137so289899571vkl.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 09:04:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170104032811.GY12761@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
	<20170104032811.GY12761@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jan 2017 17:04:02 +0000
Message-ID: <CAFEAcA91zZTPzXGfRSGSQM9kK5cG4Ci-hm7Q4Jd5odfxT+OHHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 4 January 2017 at 03:28, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> On Tue, Jan 03, 2017 at 10:02:21PM +0800, =E8=B5=B5=E5=B0=8F=E5=BC=BA wro=
te:
>> Hi=EF=BC=8Cdavid=EF=BC=9A
>>
>>    To my understanding=EF=BC=8Cwhat must be put in the realize function =
 is
>>    code which depends on property values. What's the benefit of
>>    moving memory region initialization into realize function?  I can
>>    not figure out, can you make some explanations?
>
> If nothing else it's better in realize() for consistency with other
> devices.

I'm not sure we're terribly consistent at all, really. My understanding
was about the same as =E8=B5=B5=E5=B0=8F=E5=BC=BA -- put stuff in init unle=
ss it has to
go in realize because it depends on properties or might fail or
has permanent effects on the simulation.
Lots of existing devices do memory_region_init* calls in
their init functions.
We should probably write down our preferences somewhere, perhaps
http://wiki.qemu.org/Documentation/QOMConventions

> I'm not familiar enough with the details to be sure, but I also think
> it's not safe in instance_init.  Once memory regions are registered,
> the device can potentially interact with other devices in the virtual
> machine.  realize() is sequenced to expect that, instance_init is not.

Hmm, that doesn't sound right to me. The other devices will only
interact with the memory regions when the calling code has
finished doing the create/realize/map memory regions sequence --
an MR on its own doesn't do anything unless somebody maps it into
an address space.

thanks
-- PMM
