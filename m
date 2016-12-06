Received: from eggs.gnu.org ([2001:4830:134:3::10]:37031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jike.song@intel.com>) id 1cE5RN-0002St-5Z
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jike.song@intel.com>) id 1cE5RK-0003tG-3O
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:25:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:23892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jike.song@intel.com>) id 1cE5RJ-0003sZ-Qh
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:25:06 -0500
Message-ID: <58462160.7020107@intel.com>
Date: Tue, 06 Dec 2016 10:24:32 +0800
From: Jike Song <jike.song@intel.com>
MIME-Version: 1.0
References: <1476739332-4911-1-git-send-email-kwankhede@nvidia.com>
	<580DB32F.8040806@intel.com> <1480959854.28320.21.camel@redhat.com>
In-Reply-To: <1480959854.28320.21.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 00/12] Add Mediated device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com, cjia@nvidia.com, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kevin.tian@intel.com, bjsdjshi@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

On 12/06/2016 01:44 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>> Just want to share that we have published a KVMGT implementation
>> based on this v9 patchset, to:
>>
>> 	https://github.com/01org/gvt-linux/tree/gvt-next-kvmgt
>>
>> It doesn't utilize common routines introduced by 05+ patches yet.
>> The complete intel vGPU device-model is contained.
> 
> Tried to use this implementation.  Used the
> topic/gvt-next-kvmgt-mdev-2016-11-18 branch which looked like the most
> recent one.  Setup:
> 

Hi Gerd,

We didn't catch up with updating the newest kvmgt code accordingly,
partly because we are preparing the 'final' version to be upstreamed.

Will update a topic/gvt-next-kvmgt-2016-12-06 today, sorry for the
inconvenience :)

>   * Everything compiled as modules.
>   * iommu turned off for the igd (intel_iommu=on,igfx_off).
>   * Blacklisted i915 so dracut initrd doesn't load it
>     (rd.driver.blacklist=i915)
>   * tweaked module config so kvmgt is loaded before i915,
>     also enable gvt:
> 
>       # cat /etc/modprobe.d/kraxel-gvt.conf 
>       options i915 enable_gvt=1
>       softdep i915 pre: kvmgt
> 
> Everything seems to load fine.  Sysfs files are there, and I can create
> vgpus.
> 

Yes, everything looks good so far.

> Trying to assign a vgpu this way:
> 
>   -device vfio-pci,sysfsdev=/sys/class/mdev_bus/0000:00:02.0/<uuid>
> 
> fails though and gives this message in the kernel log:
> 
>   [  402.560350] [drm:intel_vgpu_open [kvmgt]] *ERROR* gvt: KVM is
> required to use Intel vGPU
> 
> Trying the same with a mtty sample device works and I can see the pci
> serial device in the guest.
> 
> Any clues what is going wrong?

The getting kvm instance code is missing in that branch, will be
contained in the new one.

> Has this version any support for exporting the guest display as dma-buf,
> so qemu can show it?  Or is this a headless vgpu?

No, this version doesn't have dma-buf support yet, we were using x11vnc
in guest to test it internally. I'll include you in the igvt-g-dev
mailing list for further discussion :)

--
Thanks,
Jike
