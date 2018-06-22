Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fWNI5-0007Yr-LC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fWNI2-0003nx-EY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:43:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fWNI2-0003mE-8H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:43:54 -0400
Date: Fri, 22 Jun 2018 15:43:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180622144346.GC2415@work-vm>
References: <c7c8dfc5-d7b3-a22e-586c-4436214c7b9f@redhat.com>
	<20180622161158.3a88c371@redhat.com>
	<cbb7f70c-20ff-324b-e286-ec881db00925@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb7f70c-20ff-324b-e286-ec881db00925@redhat.com>
Subject: Re: [Qemu-devel] [Question] inconsistent memory amount statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eugene Crosser <evgenii.cherkashin@profitbricks.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 22.06.2018 16:11, Igor Mammedov wrote:
> > On Fri, 22 Jun 2018 09:41:15 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> >> Starting qemu with and querying some outputs:
> >>
> >> [...]
> >> -m 4G,maxmem=20G,slots=2 \
> >> -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
> >> [...]
> >> -device virtio-balloon \
> >> -object memory-backend-ram,id=mem0,size=8G \
> >> -device pc-dimm,id=dimm0,memdev=mem0 \
> >> -object memory-backend-ram,id=mem1,size=8G \
> >> -device nvdimm,id=dimm1,memdev=mem1,node=1
> >>
> >> (qemu) info numa
> >> info numa
> >> 2 nodes
> >> node 0 cpus: 0 1
> >> node 0 size: 10240 MB
> >> node 0 plugged: 0 MB
> >> node 1 cpus: 2 3
> >> node 1 size: 10240 MB
> >> node 1 plugged: 0 MB
> >>
> >>
> >> (qemu) info memory_size_summary
> >> info memory_size_summary
> >> base memory: 4294967296
> >> plugged memory: 17179869184
> >>
> >> (qemu) info memory-devices
> >> info memory-devices
> >> Memory device [dimm]: "dimm0"
> >>   addr: 0x140000000
> >>   slot: 0
> >>   node: 0
> >>   size: 8589934592
> >>   memdev: /objects/mem0
> >>   hotplugged: false
> >>   hotpluggable: true
> >> Memory device [nvdimm]: "dimm1"
> >>   addr: 0x340000000
> >>   slot: 1
> >>   node: 1
> >>   size: 8589934592
> >>   memdev: /objects/mem1
> >>   hotplugged: false
> >>   hotpluggable: true
> >>
> >>
> >> (qemu) info balloon
> >> info balloon
> >> balloon: actual=12288
> >>
> >>
> >> 1. "info numa"
> >> - considers both, pc-dimm and nvdimm
> >> - "-device ..." are considered as "!plugged" although it could be
> >>   theoretically "unplugged"
> > I'd think that this part is broken there should be no difference
> > -device vs device_add here (the only difference here is cold/hot-plugged).
> 
> I agree, it is "coldplugged" and should therefore be considered as
> "plugged". I'll prepare a patch, then we can discuss.
> 
> > 
> >> - device_add devices are considered as "plugged"
> >  
> >>
> >> 2. "info memory_size_summary"
> >> - considers both, pc-dimm and nvdimm
> >> - "-device ..." are considered as "plugged"
> >> - device_add devices are considered as "plugged"
> >>
> >> 3. "info balloon"
> >> - does not consider nvdimm devices to calculate "actual"
> >> -- actual = get_current_ram_size() - inflated
> >> -- get_current_ram_size() does not consider nvdimm
> >>
> >> So we have some inconsistency in regards of
> >> 1. What is considered memory and what not (pc-dimm vs nvdimm)
> >> 2. What is considered plugged memory (-device vs. device_add)
> >>
> >>
> >> Is this what we expect? I think we should make up our mind
> >>
> >> a) what "plugged" means
> >> b) which stats should consider "nvdimm" and which not.
> >>
> >> I would have guessed that "nvdimms" might be memory devices but should
> >> never count towards memory statistics ("not actually ram" - they might
> >> be OK).
> > well, it depends. 
> > nvdimm might be actually battery powered RAM with nvram backend.
> 
> I agree that it depends. So I wonder if virtio-balloon should be fixed
> too, to consider nvdimms. (the complete balloon interface is broken, one
> does not specify how much memory to inflate/deflate, but how much memory
> the guest should have. One of the reasons why I dislike global balloon
> drivers. They don't play nicely along with memory devices (that are e.g.
> got hotplugged, or nvdimm). But that is a different story :) ).

Balloon and NVDimm feels a bit different; if you're actually holding
persistent data on the nvdimm you don't want to blow away pages when you
want some more RAM to play with on the host.

Dave

> >  
> >> Especially "info memory_size_summary" ... "plugged-memory - amount of
> >> memory that was hot-plugged" - this seems to be wrong. And I wonder if
> >> we should exclude nvdimm from that.
> > These summary interfaces look broken to me as what is memory might be
> > unclear. It would be better if we just provide primitives to query/list
> > individual and let user do the math the way he/she prefers.
> 
> We have such an interface for memory devices (info memory-devices), but
> not for initial memory. That is at least now accessible via "info
> memory_size_summary".
> 
> > 
> > Wrt QEMU's CLI interface /VM it emulates/ it's all RAM,
> > so if we report some statistics we probably should include nvdimm as well.
> 
> I agree.
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
