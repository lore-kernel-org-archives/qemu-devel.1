Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPRu3-0000hZ-Mm
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 08:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPRu2-00032o-MG
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 08:14:31 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPRu2-00031f-HK
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 08:14:30 -0400
Received: by mail-oi0-x244.google.com with SMTP id l22-v6so18385533oib.4
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 05:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACPK8XfOZezMM2fL1aNoPx7Gjc1zeCJf5MNaS4FOPfZ5XABB2w@mail.gmail.com>
References: <20180601144328.23817-1-peter.maydell@linaro.org>
	<20180601144328.23817-3-peter.maydell@linaro.org>
	<CACPK8XfOZezMM2fL1aNoPx7Gjc1zeCJf5MNaS4FOPfZ5XABB2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Jun 2018 13:14:09 +0100
Message-ID: <CAFEAcA_ixGE+noHpuPVyRZCKnWqL-Nx6QqUxaj_fx+VLdKfKcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/armv7m: Remove unused
 armv7m_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Julia Suvorova <jusual@mail.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 3 June 2018 at 01:48, Joel Stanley <joel@jms.id.au> wrote:
> Hi Peter,
>
> On 2 June 2018 at 00:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Remove the now-unused armv7m_init() function. This was a legacy from
>> before we properly QOMified ARMv7M, and it has some flaws:
>>
>>  * it combines work that needs to be done by an SoC object (creating
>>    and initializing the TYPE_ARMV7M object) with work that needs to
>>    be done by the board model (setting the system up to load the ELF
>>    file specified with -kernel)
>>  * TYPE_ARMV7M creation failure is fatal, but an SoC object wants to
>>    arrange to propagate the failure outward
>>  * it uses allocate-and-create via qdev_create() whereas the current
>>    preferred style for SoC objects is to do creation in-place
>>
>> Board and SoC models can instead do the two jobs this function
>> was doing themselves, in the right places and with whatever their
>> preferred style/error handling is.

>> -DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>> -                         const char *kernel_filename, const char *cpu_type)
>> -{
>> -    DeviceState *armv7m;
>> -
>> -    armv7m = qdev_create(NULL, TYPE_ARMV7M);
>> -    qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
>> -    qdev_prop_set_string(armv7m, "cpu-type", cpu_type);
>> -    object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory()),
>> -                                     "memory", &error_abort);
>
> It looks like the snippet above is going to be a cut/paste for all v7m machines.

If you look at pretty much all the v7m machines except stellaris,
they don't use this code fragment. (Instead you have an
object_initialize()/qdev_set_parent_bus() in the SoC container's
init function, calls to set properties and realize in the container's
realize, and a call to armv7m_load_kernel() in the board code.)

I agree that what you might call the "modern style" of writing
SoC containers like that has a lot of boilerplate, but that's
not specific to the armv7m object, and if we want to reduce
boilerplate we should look at how we can do it consistently
across devices.

thanks
-- PMM
