Received: from eggs.gnu.org ([209.51.188.92]:46314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guVFv-0005uQ-BH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guVDI-00004t-Gu
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:35:01 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1guVDI-0008OL-12
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:35:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id y1so4176631pgk.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 20:34:59 -0800 (PST)
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
	<f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
	<20190215032436.GG4573@umbus.fritz.box>
	<d6f2f973-f57a-f5f0-c20b-9a574e05bd7b@ozlabs.ru>
	<20190215035447.GI4573@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <36b41743-e218-3b2e-7f96-6feee7849a66@ozlabs.ru>
Date: Fri, 15 Feb 2019 15:34:52 +1100
MIME-Version: 1.0
In-Reply-To: <20190215035447.GI4573@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>



On 15/02/2019 14:54, David Gibson wrote:
> On Fri, Feb 15, 2019 at 02:32:14PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 15/02/2019 14:24, David Gibson wrote:
>>> On Fri, Feb 15, 2019 at 11:35:02AM +1100, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 15/02/2019 10:37, Alex Williamson wrote:
>>>>> On Thu, 14 Feb 2019 16:21:40 +1100
>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>
>>>>>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>>>>>>
>>>>>> This implements a subdriver for NVIDIA V100 GPU with coherent memory and
>>>>>> NPU/ATS support available in the POWER9 CPU.
>>>>>>
>>>>>> 1/4 is a preparation for bigger DMA windows.
>>>>>> 2/4 is a small cleanup.
>>>>>>
>>>>>> Here is the kernel driver:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci?h=v5.0-rc6&id=7f92891778dff62303c070ac81de7b7d80de331a
>>>>>>
>>>>>> SLOF changes already went in.
>>>>>>
>>>>>> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (posted separately).
>>>>>
>>>>> TBH, I'm not sure it was the best idea to let it live or die on it's
>>>>> own when it now creates a build dependency for this series.
>>>> I am sure that patch is disgustingly primitive and can make it to
>>>> upstream in just one click and the rest of the series will take more
>>>> time anyway (always does :) ).
>>>>
>>>>>> This is based on sha1
>>>>>> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem for mac99 machine".
>>>>>
>>>>> Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
>>>>> there dependencies we need to wait for in the ppc tree as well?
>>>>
>>>> There are few changes in spapr_pci so conflicts are possible, every time
>>>> when David updates his tree and I rebase I get some minor ones.
>>>>
>>>>>> Please comment. Thanks.
>>>>>
>>>>> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:
>>>>>
>>>>> .../qemu.git/hw/vfio/spapr.c: In function ‘vfio_spapr_create_window’:
>>>>> .../qemu.git/hw/vfio/spapr.c:212:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>>>          error_report("Failed to create a window, ret = %d (%m)", ret);
>>>>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>> cc1: all warnings being treated as errors
>>>>
>>>> Agrh. How exactly do you make them errors, not warnings? I get no
>>>> warning/error with --disable-werror but not having  --disable-werror
>>>> prints warnings, not errors so it does not fail the build and easy to miss.
>>>
>>> Are you sure it's printing warnings with --enable-werror?  Otherwise
>>> it sounds like you just have a compiler version that's not picking
>>> this up.
>>
>> Ah, here is my mistake - I thought not having --disable-werror means
>> that it is enabled as ./configure does not advertise  "--enable-werror":
>>
>> [fstn1-p1 qemu]$ ./configure --help | grep werror
>>   --disable-werror         disable compilation abort on warning
>>
>>
>> Apparently it is a tri-state flag :)
> 
> Um.. no.. I believe it should be on by default as well, I was just
> saying --enable-werror because I thought it was clearer than the
> double negative in "without --disable-werror".

The default value of werror is "":

https://git.qemu.org/?p=qemu.git;a=blob;f=configure;h=a61682c3c727f467ce2710c7469a33b261da8ff6;hb=HEAD#l935



-- 
Alexey
