Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brian.johnson@hpe.com>) id 1et0k9-0004Iu-Bx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brian.johnson@hpe.com>) id 1et0k6-0005q3-7q
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:46:13 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:51602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brian.johnson@hpe.com>)
	id 1et0k6-0005o8-0a
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:46:10 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-4-marcandre.lureau@redhat.com>
	<91D51528-C2CA-41DF-921F-DBD5C2EC028C@apple.com>
	<CAJ+F1C+sTmv7M8QU2vqfPWE2Zej_DxJQF8aVSH5pZC8pqo8OZw@mail.gmail.com>
	<26353964-066c-5664-1d67-6a79a3d21ac9@redhat.com>
From: "Brian J. Johnson" <brian.johnson@hpe.com>
Message-ID: <5a8e107d-15f5-0278-9f89-5efb60de2719@hpe.com>
Date: Mon, 5 Mar 2018 18:45:47 -0600
MIME-Version: 1.0
In-Reply-To: <26353964-066c-5664-1d67-6a79a3d21ac9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] [PATCH 3/7] HACK: HobLib: workaround
 infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Andrew Fish <afish@apple.com>
Cc: edk2-devel@lists.01.org, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, QEMU <qemu-devel@nongnu.org>, Javier Martinez
	Canillas <javierm@redhat.com>

On 03/05/2018 12:22 PM, Laszlo Ersek wrote:
> PEIMs generally "execute in place" (XIP), i.e. they run from flash, not
> RAM. In this status they use "temporary RAM" (e.g. CPU caches configured
> like RAM) for stack & heap; whatever HOBs they produce are stored in
> "temp RAM" as well. Then one of the PEIMs "discovers permanent RAM"
> (basically it programs the memory controller and publishes the RAM
> ranges). In turn the PEI core "migrates" PEIMs from temporary to
> permanent RAM, including the HOB list.
> 
> Before the temporary RAM migration (when still executing in place from
> flash), PEIMs cannot have writeable global variables. For example,
> dynamic PCDs are also maintained in a HOB (the PCD HOB).
> 
> A PEIM normally cannot (and shouldn't) tell whether it is dispatched
> before or after permanent RAM is published. If needed, a PEIM can
> advertise that it depends on permanent RAM (for example because it needs
> a lot of heap memory) by including "gEfiPeiMemoryDiscoveredPpiGuid" in
> its DEPEX.
> 
> Finally, it seems like a PEIM can also express, "I'm fine with being
> dispatched from both flash (XIP) vs. permanent RAM, just the PEI core
> tell me whichever it is". Apparently, if the PEIM is dispatched from
> flash (before permanent RAM is available), its call to
> RegisterForShadow() returns EFI_SUCCESS (and then its entry point
> function will be invoked for a 2nd time, after the temp RAM migration).
> And when a PEIM is dispatched from RAM (either for the very first time,
> or for the second time, after being dispatched from flash first), the
> same call returns EFI_ALREADY_STARTED.
> 
> Honestly, I'm unsure what this is good for (both in general, and
> specifically for Tcg2Pei). Apparently, Tcg2Pei needs permanent RAM for
> doing the measurements (which makes sense); I just wonder what exactly
> it does so that it cannot simply specify
> "gEfiPeiMemoryDiscoveredPpiGuid" in its DEPEX.

I haven't looked at this particular PEIM.  But one case where 
registering for shadowing is useful is for improving performance when 
running from permanent RAM, where writable global variables are 
available.  For instance, when running from flash, a ReportStatusCode 
PEIM may need to go through a slow process to locate an output hardware 
device on every PPI call.  This may involve traversing the HOB list, 
consulting other PPIs, even probing hardware addresses.  But once it's 
shadowed to RAM, it can locate the device once, then cache its address 
in a global.  Not to mention that the code itself is far, far faster 
when run from RAM vs. flash.  (That's probably a key difference between 
a real machine and a VM.)

Also, I've personally written a PEIM which saves a bunch of internal 
state in a HOB, since that's the main writable storage when running from 
flash.  That state includes pointers to other data (in flash.)  Once the 
data is all shadowed to RAM, it updates the HOB to point to the data in 
RAM.  That way it's a lot faster to access the data.

I also have other PEIMs which are constrained (via DEPEX) to run *only* 
from RAM, since they have larger memory requirements than can be 
satisfied from temporary cache-as-RAM.  That's certainly a valid 
technique as well.

RegisterForShadow() is a useful tool for making the most of the 
restricted PEI environment.  And having it standardized like this is, as 
Andrew said, a lot better than the hacks people had to use beforehand.

Thanks,
-- 
Brian J. Johnson
Enterprise X86 Lab

Hewlett Packard Enterprise

brian.johnson@hpe.com
