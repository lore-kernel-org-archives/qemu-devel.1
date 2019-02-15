Received: from eggs.gnu.org ([209.51.188.92]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guRTE-0005ez-06
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guRTC-0000jz-0D
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:35:11 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1guRTB-0000iX-Bl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:35:09 -0500
Received: by mail-pg1-x542.google.com with SMTP id u9so399384pgo.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 16:35:09 -0800 (PST)
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
Date: Fri, 15 Feb 2019 11:35:02 +1100
MIME-Version: 1.0
In-Reply-To: <20190214163743.7162ad53@w520.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>



On 15/02/2019 10:37, Alex Williamson wrote:
> On Thu, 14 Feb 2019 16:21:40 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>>
>> This implements a subdriver for NVIDIA V100 GPU with coherent memory and
>> NPU/ATS support available in the POWER9 CPU.
>>
>> 1/4 is a preparation for bigger DMA windows.
>> 2/4 is a small cleanup.
>>
>> Here is the kernel driver:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci?h=v5.0-rc6&id=7f92891778dff62303c070ac81de7b7d80de331a
>>
>> SLOF changes already went in.
>>
>> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (posted separately).
> 
> TBH, I'm not sure it was the best idea to let it live or die on it's
> own when it now creates a build dependency for this series.
I am sure that patch is disgustingly primitive and can make it to
upstream in just one click and the rest of the series will take more
time anyway (always does :) ).

>> This is based on sha1
>> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem for mac99 machine".
> 
> Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
> there dependencies we need to wait for in the ppc tree as well?

There are few changes in spapr_pci so conflicts are possible, every time
when David updates his tree and I rebase I get some minor ones.

>> Please comment. Thanks.
> 
> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:
> 
> .../qemu.git/hw/vfio/spapr.c: In function ‘vfio_spapr_create_window’:
> .../qemu.git/hw/vfio/spapr.c:212:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>          error_report("Failed to create a window, ret = %d (%m)", ret);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Agrh. How exactly do you make them errors, not warnings? I get no
warning/error with --disable-werror but not having  --disable-werror
prints warnings, not errors so it does not fail the build and easy to miss.

> Is this series expected to go in through the ppc branch given the bulk
> of the changes are there?  Thanks,

I think so.


-- 
Alexey
