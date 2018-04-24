Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fAzt1-0003Bd-89
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fAzt0-000558-21
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:29:43 -0400
Date: Tue, 24 Apr 2018 17:29:32 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180424152932.tszber3blx32luro@kamzik.brq.redhat.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-4-git-send-email-zhuyijun@huawei.com>
	<20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83868CA39@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83868CA39@FRAEML521-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory region
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Apr 19, 2018 at 09:06:30AM +0000, Shameerali Kolothum Thodi wrote:
> > From: Andrew Jones [mailto:drjones@redhat.com]
> > Instead of using memory region aliases, it would be best if each RAM
> > region was modeled with pc-dimms, as that would move us towards supporting
> > memory hotplug and allow the regions to be explicitly identified
> > (start/size) on the command line - supporting migration. Actually, how
> > does this series address migration? What if the host we migrate to doesn't
> > have the same reserved regions in sysfs?
> 
> Thanks for going through this series and comments.
> 
> I am looking into reviving this series based on the new proposed vfio iova 
> interface[1]. The vfio interface will now provide  a list of valid iova ranges.
> That means, instead of working on reserved regions to find out the valid
>  memory regions, the code here will have the valid regions list directly.
> 
> The above comment of yours mentions about modelling the memory regions
> with pc-dimms. If I understand that proposal correctly, in case the iova list
> has  multiple entries in it(means there are holes in the memory) the extra
> regions has to be added as a pc-dimm slot memory.

Hi Shameer,

iiuc, the concern is that the valid region list may look something like
this made up example:

 0x000e0000000 0x000000011fffffff
 0x00180000000 0x00000002ffffffff
 0x02000000000 0x0000011fffffffff
 0x22000000000 0xffffffffffffffff

You then want to avoid overlapping the holes with memory, because the
holes represent regions that may have platform devices assigned, which
need to keep 1:1 gpa -> hpa mappings.

If that's the case, then I think the biggest problem with the made up
example is the initial hole [0x0 0xdfffffff], as that would overlap the
currently hard coded base of RAM (0x40000000). Indeed we were thinking
that the base of RAM would be modeled as a non-pluggable dimm of size
1G at the 1G boundary. As for the rest of memory (for memory > 1G), in
the made up example we could just allocate a single pc-dimm from a memory
region representing the [0x22000000000 0xffffffffffffffff] range without
any hassle.

> Having gone through
> the Qemu source, I am not sure what is the best way to accomplish that.
> (of course I am not that familiar with the Qemu source). Is it ok to invoke
> qdev_device_add() from here? Any pointers on this is very appreciated.

I'm not an expert on that (nor any of this stuff, really - hopefully what
I've written above isn't completely bonkers). I've CC'ed Igor for help.
I've also CC'ed Eric, because of the magic word 'vfio'.

> 
> One more point is, considering the fact that ARM64 linux kernel still doesn't
> support hotplug memory at the moment, not sure how much we gain
> from the pc-dimm model.

It will eventually. Moving towards the pc-dimm model now, in order to
handle the non-contiguous memory needs, will go a long ways to enabling
hotplug later.

Thanks,
drew

> 
> Please let me know your thoughts on this.
> 
> Thanks,
> Shameer
> 
> [1]. https://lkml.org/lkml/2018/4/18/293
