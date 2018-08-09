Received: from eggs.gnu.org ([2001:4830:134:3::10]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fngZZ-0007CS-WE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fngZZ-000296-2z
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:45:34 -0400
Date: Thu, 9 Aug 2018 10:45:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180809104516.5ae705c3@redhat.com>
In-Reply-To: <20e89178-2ba6-b752-bac5-c208d608a02a@redhat.com>
References: <43c1349e-1ca6-4890-07c0-7bfa35ab914d@redhat.com>
	<5311fed5-7f13-a177-b967-db6e3ed028b9@redhat.com>
	<405e3f2b-3044-d7fc-8df4-b07a8487470f@redhat.com>
	<f2d61062-21df-4478-bc61-c32e92329cf8@redhat.com>
	<57030c9f-c3d1-49a8-090e-d6b316e7a818@redhat.com>
	<fc6a29d4-1094-8d29-d415-fc30d5e30c31@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA838712003@FRAEML521-MBX.china.huawei.com>
	<fd7e2831-86a8-c2a1-fe0c-d9784bc2d3cb@redhat.com>
	<20180711151740.3d119e95@redhat.com>
	<5e65f669-69f6-53aa-0337-2825ce353b5e@redhat.com>
	<20180712144516.zsjvfrruduirzqug@kamzik.brq.redhat.com>
	<6047361a-be99-fc7f-5270-5ab3b4ab84e2@redhat.com>
	<20180718150044.4c542d21@redhat.com>
	<20e89178-2ba6-b752-bac5-c208d608a02a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 06/15] hw/arm/virt: Allocate device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

On Wed, 8 Aug 2018 11:33:23 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 07/18/2018 03:00 PM, Igor Mammedov wrote:
> [...]
> >>>
> >>> I think Igor wants one contiguous region for RAM, where additional
> >>> space can be reserved for hotplugging.    
> >> This is not compliant with 2012 ARM white paper, although I don't really
> >> know if this document truly is a reference (did not get any reply).  
> > it's upto QEMU to pick layout, if we have maxmem (upto 256Gb) we could
> > accommodate legacy req and put single device_memory in 1Gb-256Gb GPA gap,
> > if it's more we can move whole device_memory to 2Tb, 8Tb ...
> > that keeps things manageable for us and fits specs (if such exist).
> > WE should make selection of the next RAM base deterministic is possible
> > when layout changes due to maxram size or IOVA, so that we won't need
> > to use compat knobs/checks to keep machine migratable.  
> Sorry for the delay. I was out of the office those past weeks.
> 
> OK understood. Your preferred approach is to have a contiguous memory
> region (initial + hotplug). So this depends on the FW capability to
> support flexible RAM base. Let's see how this dependency gets resolved.
I think Drew had already a look at FW side of the issue and has
a prototype to works with.
Once he's back in the office he planned to work on upstreaming EDK
and qemu parts.
 
> This series does not bump the non hotpluggable memory region limit,
> which is still limited to 255GB. The only way to add more memory is
> though PCDIMM or NVDIMM (max 2TB atm). To do so you need to add ,maxmem
> and ,slots options which need to be on both source and dest, right, +
> the PCDIMM/NVDIMM device option lines? Also the series checks the
> destination has at least the same IPA range capability as the source,
> which conditions the fact the requested device_memory size can be
> accommodated. At the moment I fail to see what are the other compat
> knobs I must be prepared to handle.
it looks the same to me.

We might use presence of slot/maxmem options as a knob to switch
to a new all DIMM layout (initial + hotplug) with floating ram base.
That way guests/fw that are designed to work with fixed RAM base will
work just fine by default and guests/fw that are to work with
mem hotplug or large RAM need vfio holes will use floating RAM base.
Does it seem reasonable?


> Thanks
> 
> Eric
> > 
> > [...]
> >   
