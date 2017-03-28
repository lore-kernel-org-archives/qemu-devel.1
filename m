Received: from eggs.gnu.org ([2001:4830:134:3::10]:37129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cswEL-0002MQ-Db
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cswEI-00017A-B2
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cswEI-00016v-3D
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:30 -0400
Date: Tue, 28 Mar 2017 19:52:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170328185224.GI5740@work-vm>
References: <20170323210124.12300-1-quintela@redhat.com>
	<5023e01f-ee47-d066-eb7b-0ac4b8837283@huawei.com>
	<87d1d7844y.fsf@secure.mitica>
	<31202c71-ced1-3cdd-e1a1-829daf5d2819@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31202c71-ced1-3cdd-e1a1-829daf5d2819@huawei.com>
Subject: Re: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Hongyang <yanghongyang@huawei.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org

* Yang Hongyang (yanghongyang@huawei.com) wrote:
> 
> 
> On 2017/3/24 16:34, Juan Quintela wrote:
> > Yang Hongyang <yanghongyang@huawei.com> wrote:
> >> Hi Juan,
> >>
> >>   First of all, I like the refactor patchset about RAMState, it makes
> >> things clean, great!
> > 
> > Thanks.
> > 
> > The whole idea of the series was to make testing changes easier.
> > 
> >> On 2017/3/24 5:01, Juan Quintela wrote:
> >>> Hi
> >>>
> >>> This series split the migration and unsent bitmaps by ramblock.  This
> >>> makes it easier to synchronize in small bits.  This is on top of the
> >>> RAMState and not-hotplug series.
> >>>
> >>> Why?
> >>>
> >>> reason 1:
> >>>
> >>> People have complained that by the time that we detect that a page is
> >>> sent, it has already been marked dirty "again" inside kvm, so we are
> >>> going to send it again.  On top of this patch, my idea is, for words
> >>> of the bitmap that have any bit set, just synchonize the bitmap before
> >>> sending the pages.  I have not looking into performance numbers yet,
> >>> jsut asking for comments about how it is done.
> >>
> >> Here you said 'synchonize the bitmap before sending the pages', do you
> >> mean synchronize the bitmap from kvm? If so, I doubt the performance...
> >> because every synchronization will require a ioctl(). If not, the
> >> synchronization of per block is useless.
> >>
> >> Currently, migration thread will synchronize the bitmap from kvm every
> >> iter(migration_bitmap_sync()). The RAMBlock already has kind of per block
> >> bitmap for this kind of sync. And the migration bitmap is used to put all
> >> those per block bitmap together for data sending use.
> > 
> > Hi
> > For huge memory machines, we are doing it always in one go.
> > 
> > 
> > bitmap_sync(1TB RAM)
> > walk bitmap for 512MB of RAM, at that point, it is very probable that
> > this page is again dirty in the KVM bitmap, so, we send it, but as it is
> > dirty again, we would have to send it in the next pass.  This sent is
> > completely useless.
> 
> I got your point, the problem is KVM do not have the ability to sync in
> small chunks currently, even it has, it will generate lots of ioctls:
> KVM bitmap sync is per Memory Region IIRC, think we have a 1T mem
> guest, 16 MRs for example, currently, every iter we need to do 16 ioctls.
> But if we sync in small chunks, 64M for example, we might need to do
> 16384 ioctls in the worst case. eg:mem press(dirty rate) is very high.

Yes but I think people  have suggested it should have that ability for a long
time; so hopefully we can add it.

I'd assumed the sizes of these chunks would be a bit bigger, a few GB each maybe
and also assumed we'd have a separate thread that was doing the syncing from
a different thread to the one doing the writing, trying to keep ahead of the
write pointer.

Even with the structure Juan has here, we could get to syncing each NUMA
node separately like that which would kind of makes some sense.

Dave

> 
> > 
> > So my idea is to split things in smaller chunks.  As we have to do an
> > ioctl, we wouldn't want to synchronize page by page, but perhaps 16MB at
> > a time, 64MB, anything less than the whole amount of memory.
> > 
> > Later, Juan.
> > 
> 
> -- 
> Thanks,
> Yang
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
