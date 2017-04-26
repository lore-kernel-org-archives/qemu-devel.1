Received: from eggs.gnu.org ([2001:4830:134:3::10]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3Khs-0007LY-GB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3Khn-00064B-Ip
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3Khn-00062C-AZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:01:55 -0400
Date: Wed, 26 Apr 2017 12:01:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170426110144.GF2098@work-vm>
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> On 04/24/2017 09:12 PM, Dr. David Alan Gilbert wrote:
> > * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> >> On 04/24/2017 04:35 PM, Dr. David Alan Gilbert wrote:
> >>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> >>>> On 04/24/2017 12:53 PM, Dr. David Alan Gilbert wrote:
> >>>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> >>>>>> David, Juan,
> >>>>>>
> >>>>>> I can trigger a hang of postcopy migration (when I do it early) so
> >>>>>> that both sides are in paused state. Looks like one thread is still
> >>>>>> loading vmstates for virtio and this load accesses guest memory and
> >>>>>> triggers a userfault.
> >>>>>
> >>>>> It's perfectly legal for the destination to cause a userfault as it
> >>>>> loads the virtio queue - the virtio queue should be being loaded by
> >>>>> the main thread from the buffer while the 'listening' thread is
> >>>>> waiting for the incoming page data.
> >>>>>
> >>>>> Can you turn on the following tracing please: destination: 
> >>>>> postcopy_ram_fault_thread_request postcopy_place_page 
> >>>>> postcopy_place_page_zero
> >>>>>
> >>>>> source: migrate_handle_rp_req_pages ram_save_queue_pages
> >>>>>
> >>>>> You should see: virtio does the access userfault generates a fault 
> >>>>> postcopy_ram_fault_thread_request sends the request to the source
> >>>>>
> >>>>> the source sees migrate_handle_rp_req_pages queues it with
> >>>>> ram_save_queue_pages
> >>>>>
> >>>>> the destination sees the page arrive and postcopy_place_page or
> >>>>> postcopy_place_page_zero
> >>>>>
> >>>>> some of that might disappear if the page was already on it's way.
> >>>>
> >>>>
> >>>> the last event on the source are
> >>>> [..]
> >>>> 58412@1493037953.747988:postcopy_place_page host=0x3ff92246000
> >>>> 58412@1493037953.747992:postcopy_place_page host=0x3ff92247000
> >>>
> >>> How do you see those on the source???
> >>
> >> It was the previous migrate (I did it in a loop forth and back)
> >> The problem happens on the migrate back.
> > 
> > OK, good.
> > 
> >>>
> >>>> 58412@1493037956.804210:migrate_handle_rp_req_pages in s390.ram at 41d9000 len 1000
> >>>> 58412@1493037956.804216:ram_save_queue_pages s390.ram: start: 41d9000 len: 100
> >>>>
> >>>
> >>> Is that a typo? I'm expecting those two 'len' fields to be the same?
> >>
> >> Yes, its a cut'n' paste "miss the last byte"
> > 
> > Good.
> > 
> > Ok, before digging further, is this a new bug or does it happen on older
> > QEMU?  Have you got a rune to reproduce it on x86?
> > 
> >>
> >>>
> >>>> On the target a see lots of
> >>>>
> >>>> 39741@1493037958.833710:postcopy_place_page_zero host=0x3ff9befa000
> >>>> 39741@1493037958.833716:postcopy_place_page host=0x3ff9befb000
> >>>> 39741@1493037958.833759:postcopy_place_page host=0x3ff9befc000
> >>>> 39741@1493037958.833818:postcopy_place_page host=0x3ff9befd000
> >>>> 39741@1493037958.833819:postcopy_place_page_zero host=0x3ff9befe000
> >>>> 39741@1493037958.833822:postcopy_place_page host=0x3ff9beff000
> >>>>
> >>>> So we have about 2 seconds of traffic going on after that request,
> >>>> I assume its precopy related.
> >>>>
> >>>> Looking back on the target history there was
> >>>> 39741@1493037956.804337:postcopy_ram_fault_thread_request Request for HVA=3ff618d9000 rb=s390.ram offset=41d9000
> >>>>
> >>>> In fact it seems to be the first and only request:
> >>>>
> >>>> # cat /tmp/test0.trace | grep -v postcopy_place_page
> >>>>
> >>>> 39741@1493037956.804337:postcopy_ram_fault_thread_request Request for HVA=3ff618d9000 rb=s390.ram offset=41d9000
> >>>
> >>> OK, does the HVA there correspond to the address that your virtio device is blocking on?
> >>
> >> yes it is the same page.
> >>
> >>
> >>> (or at least the start of the page)
> >>> Do you see a postcopy_place_page with a host= the same HVA ?
> >>
> >> no
> > 
> > Hmm, that's bad.
> > The flow is:
> >     Precopy
> >        (a) Send pages
> >     Switch to postcopy
> >        (b) Send discards for pages that have been changed after
> >            (a)
> >     Postcopy
> >        (c) Keep sending pages until we run out
> >        (d) But send pages we're asked for first
> > 
> >  (d) might be ignored if the source thinks the page was already sent or not dirty.
> > 
> > So we need to figure out:
> >   1) If the source sent the pages during (a)
> >   2) If the source discarded it during (b)
> >   3) If it sent it again any time in c/d
> >   4) If it ignored the request from d
> > 
> > 
> > So please turn on the traces:
> >     get_queued_page_not_dirty                should help with (4)
> >     get_queued_page                          should help with (4)
> >     ram_discard_range                        should help with (2)
> >     loadvm_postcopy_ram_handle_discard       should help with (2)
> >     qemu_savevm_send_postcopy_ram_discard    should help with (2)
> > 
> > add near the top of ram_save_page in ram.c:
> >   fprintf(stderr, "%s: %s:%zx\n", __func__, block->idstr, (size_t)offset);
> > 
> >    should help with 1, 3
> 
> 
> source:
> 28863@1493200554.418978:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419047:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419056:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419064:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419071:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419077:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419083:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419088:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419094:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419100:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419106:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419112:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419117:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419123:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419130:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419138:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419145:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419151:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419156:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419163:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419169:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419174:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419179:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419184:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419189:qemu_savevm_send_postcopy_ram_discard s390.ram: 12d
> 28863@1493200554.419208:qemu_savevm_send_postcopy_ram_discard s390.ram: 9d
> 28863@1493200554.818195:migrate_handle_rp_req_pages in s390.ram at 3c6b000 len 1000
> 28863@1493200554.818208:ram_save_queue_pages s390.ram: start: 3c6b000 len: 1000
> 28863@1493200554.818469:get_queued_page_not_dirty s390.ram/3c6b000 ram_addr=3c6b000 (sent=0)

OK, the source is ignoring the request because it thinks the page has
already been sent and hasn't been redirtied.

> I also get 
> ram_save_page: s390.ram:3c6b000

and you said in your other message that happens before the discards, which
means it's precopy, and that's why you don't see the 'place_page'.

> target (without postcopy_place)
> 10929@1493200553.657966:ram_discard_range s390.ram: start: 0 5dc00000

That's start of day I think, so we can ignore that (I think!)

> 10929@1493200554.428226:loadvm_postcopy_ram_handle_discard 

....

> 10929@1493200554.438231:ram_discard_range s390.ram: start: 3bf6000 1000
> 10929@1493200554.438233:ram_discard_range s390.ram: start: 3bfd000 1000
> 10929@1493200554.438235:ram_discard_range s390.ram: start: 3c06000 4000
> 10929@1493200554.438240:loadvm_postcopy_ram_handle_discard 
> 10929@1493200554.438241:ram_discard_range s390.ram: start: 3c79000 3000

Well, it's not discarded the 3c6b000 page, so the page we received
during precopy should still be there, and it shouldn't fault.

In migration/ram.c in ram_load, before the line:
           switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {

can you add:
    fprintf(stderr, "%s: addr=%zx flags=%zx host=%p\n", __func__, addr, flags, host);

that should show the incoming blocks during precopy and we should be able
to see the page coming in.
Hmm, I have a theory, if the flags field has bit 1 set, i.e. RAM_SAVE_FLAG_COMPRESS
then try changing ram_handle_compressed to always do the memset.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
