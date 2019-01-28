Received: from eggs.gnu.org ([209.51.188.92]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goBeL-0000ZN-5K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goBeJ-00072X-UU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:28:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goBeJ-0006uI-NL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:28:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so19181930wrs.8
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:28:18 -0800 (PST)
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
	<ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
	<CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0efa9e7b-cefe-071a-ef6c-9cab6419a521@redhat.com>
Date: Mon, 28 Jan 2019 19:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 1/28/19 7:02 PM, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 17:47, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Cc'ing Thomas/Paolo for Makefile rules...
>>
>> On 1/24/19 12:43 PM, Gerd Hoffmann wrote:
>>> Oops, fails the build:
>>>
>>>   LINK    lm32-softmmu/qemu-system-lm32
>>> hw/lm32/milkymist.o: In function `milkymist_init':
>>> milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_create'
>>
>> The problem comes from patch #2:
>>
>>> diff --git a/default-configs/lm32-softmmu.mak
>> b/default-configs/lm32-softmmu.mak
>>> index 4889348a10..4049b23562 100644
>>> --- a/default-configs/lm32-softmmu.mak
>>> +++ b/default-configs/lm32-softmmu.mak
>>> @@ -2,7 +2,7 @@
>>>
>>>  CONFIG_LM32=y
>>>  CONFIG_MILKYMIST=y
>>> -CONFIG_MILKYMIST_TMU2=$(CONFIG_OPENGL)
>>> +CONFIG_MILKYMIST_TMU2=$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
>>>  CONFIG_FRAMEBUFFER=y
>>>  CONFIG_PTIMER=y
>>>  CONFIG_PFLASH_CFI01=y
>>> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
>>> index 97acd5b6cb..079e702f25 100644
>>> --- a/hw/display/Makefile.objs
>>> +++ b/hw/display/Makefile.objs
>>> @@ -29,8 +29,8 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
>>>  common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
>>>
>>>  common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
>>> -milkymist-tmu2.o-cflags := $(X11_CFLAGS)
>>> -milkymist-tmu2.o-libs := $(X11_LIBS)
>>> +milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
>>> +milkymist-tmu2.o-libs := $(X11_LIBS) $(OPENGL_LIBS)
>>>
>>>  obj-$(CONFIG_OMAP) += omap_dss.o
>>>  obj-$(CONFIG_OMAP) += omap_lcdc.o
>>
>> Using $(call land) seems to break CONFIG_MILKYMIST_TMU2 availability in
>> $(common-obj), while it works correctly in the per-target $(obj).
>> I'm not sure what is the cause, but moving milkymist-tmu2.o to $(obj)
>> makes more sense and fix this, so I'll go this way.
> 
> Something weird definitely seems to be going on here -- 'call land'
> ought not to be broken in this situation.
> 
> I don't understand why the build/config-all-devices.mak versions of
> the defines of CONFIG_FOO variables are so weird:
> 
> CONFIG_ACPI:=$(findstring y,$(CONFIG_ACPI)y)
> 
> ...are they really intended to be self-referential like that?
> 
> The per-target ones in build/foo-softmmu/config-devices.mak are
> more like what I expected:
> 
> CONFIG_VGA=y
> 
> Paolo, git blame says you wrote the makefile rune back in 2013:
> I don't suppose you can remember the intent ?

Now than Kconfig is in good usable shape, I'm pretty sure Paolo doesn't
want to remember ;) Our time is better worth spent on Kconfig than
fixing those issues.

For this series goal (remove SDL1!) I'll go with moving LM32/Milkymist
devices to $(obj). Hopefully the next patch will be in Kconfig :)
