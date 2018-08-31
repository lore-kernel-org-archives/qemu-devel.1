Received: from eggs.gnu.org ([208.118.235.92]:37358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvhVh-0005Hg-Ls
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvhVe-0006u8-Cn
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fvhVe-0006ty-5m
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:38 -0400
Date: Fri, 31 Aug 2018 12:22:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180831112229.GE2376@work-vm>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831103855.GC2376@work-vm>
	<6aabaa18-33f1-dea3-0824-74f78fcb2d0c@redhat.com>
	<20180831104302.GD2376@work-vm>
	<8d71de77-9fa8-4100-41be-8e1d689ba98b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d71de77-9fa8-4100-41be-8e1d689ba98b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

* David Hildenbrand (david@redhat.com) wrote:
> On 31.08.2018 12:43, Dr. David Alan Gilbert wrote:
> > * David Hildenbrand (david@redhat.com) wrote:
> >>
> >>>>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> >>>>  {
> >>>>      const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
> >>>> @@ -168,6 +184,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >>>>      for (item = list; item; item = g_slist_next(item)) {
> >>>>          MemoryDeviceState *md = item->data;
> >>>>          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
> >>>> +        const char *id = memory_device_id(md);
> >>>>          uint64_t md_size, md_addr;
> >>>>  
> >>>>          md_addr = mdc->get_addr(md);
> >>>> @@ -178,8 +195,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >>>>  
> >>>>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
> >>>>              if (hint) {
> >>>> -                const DeviceState *d = DEVICE(md);
> >>>> -                error_setg(errp, "address range conflicts with '%s'", d->id);
> >>>> +                error_setg(errp, "address range conflicts with '%s'",
> >>>> +                           id ? id : 0);
> >>>
> >>> What's that 'id ? id : 0' trick for?
> >>
> >> 0 -> "", then it actually makes sense :)
> >>
> >> I'll fix this up, thanks!
> > 
> > Except that:
> > 
> >    address range conflicts with ''
> > isn't very helpful.
> > Why would you get a NULL id ?
> 
> This is easy: don't specify an id for a memory device:
> 
> Unfortunately, if the user does not give ids to devices, there is no way
> of telling him what we are talking about.
> 
> qemu-system-x86_64 -machine pc -m 4G,maxmem=20G,slots=4 \
> 	-object memory-backend-ram,id=mem0,size=4G \
> 	-object memory-backend-ram,id=mem1,size=4G \
> 	-device pc-dimm,memdev=mem0,addr=0x140000000 \
> 	-device pc-dimm,memdev=mem1,addr=0x140000000
> 
> qemu-system-x86_64: -device pc-dimm,memdev=mem1,addr=0x140000000:
> address range conflicts with '(null)'
> 
> (I thought providing NULL would lead to a crash, but it is actually
> handled properly)
> 
> So while not being able to indicate an id is not nice, I can simply
> forward the id directly here.

OK, or use something like  id ? id : "(unnamed)"

Dave

> Thanks!
> 
> > 
> > Dave
> > 
> >>
> >> -- 
> >>
> >> Thanks,
> >>
> >> David / dhildenb
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
