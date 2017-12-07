Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eMjsD-0000wk-CO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 19:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eMjs9-0007HY-CZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 19:17:09 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eMjs9-0007FF-3e
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 19:17:05 -0500
Received: by mail-pf0-x244.google.com with SMTP id j124so3302691pfc.2
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 16:17:04 -0800 (PST)
References: <20171205205409.5348.53070.stgit@gimli.home>
	<9519f733-ddb1-beea-830b-4c9cda69ca67@ozlabs.ru>
	<20171205183039.5fe06906@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7b091604-46ad-8516-4900-7a51fe3c0412@ozlabs.ru>
Date: Thu, 7 Dec 2017 11:16:58 +1100
MIME-Version: 1.0
In-Reply-To: <20171205183039.5fe06906@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] vfio: Fix vfio-kvm group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com

On 06/12/17 12:30, Alex Williamson wrote:
> On Wed, 6 Dec 2017 12:02:01 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 06/12/17 08:09, Alex Williamson wrote:
>>> Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
>>> attaching") moved registration of groups with the vfio-kvm device from
>>> vfio_get_group() to vfio_connect_container(), but it missed the case
>>> where a group is attached to an existing container and takes an early
>>> exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
>>> (without viommu) all groups are connected to the same container and
>>> thus only the first group gets registered with the vfio-kvm device.
>>> This becomes a problem if we then hot-unplug the devices associated
>>> with that first group and we end up with KVM being misinformed about
>>> any vfio connections that might remain.  Fix by including the call to
>>> vfio_kvm_device_add_group() in this early exit path.
>>>
>>> Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
>>> Cc: qemu-stable@nongnu.org # qemu-2.10+
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>
>>> This bug also existed in QEMU 2.10, but I think the fix is sufficiently
>>> obvious (famous last words) to propose for 2.11 at this late date.  If
>>> the first group is hot unplugged then KVM may revert to code emulation
>>> that assumes no non-coherent DMA is present on some systems.  Also for
>>> KVMGT, if the vGPU is not the first device registered, then the
>>> notifier to enable linkages to KVM would not be called.  Please review.  
>>
>> For what it is worth
>>
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Thanks!
> 
>> Sorry for the breakage...
>>
>> One question - how was this discovered? I'd love to set up a test
>> environment on my old thinkpad x230 if possible.
> 
> Assign two devices from separate iommu groups, hot unplug the first
> device, followed by the second device.  The second unplug will trigger:
> 
> qemu-kvm: Failed to remove group ## from KVM VFIO device: No such file or directory
> 
> Laptops don't have many devices and we're not good about keeping up
> with ACS quirks on laptop chipsets, so it might be difficult to find
> the prerequisite setup there.  Thanks,


This is actually easy to reproduce on the spapr platform as reusing the
same container is what we do these days, at least till we get multiple PHB
support in libvirt :-/



-- 
Alexey
