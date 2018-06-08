Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fRKZv-0008IA-AT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fRKZs-0006Np-7k
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:49:31 -0400
Date: Fri, 8 Jun 2018 12:49:18 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1101464854.41407684.1528476558802.JavaMail.zimbra@redhat.com>
In-Reply-To: <1284106852.41406322.1528475894625.JavaMail.zimbra@redhat.com>
References: <1514187226.13662.28.camel@intel.com>
	<20180530144450.GB5973@stefanha-x1.localdomain>
	<20180530160719.GD4311@localhost.localdomain>
	<20180531104838.GC27838@stefanha-x1.localdomain>
	<EC8A4E314CF1574AB62C80421BD983393409C805@SHSMSX104.ccr.corp.intel.com>
	<972381772.41213876.1528444764393.JavaMail.zimbra@redhat.com>
	<HK2PR06MB053129599D241467115689E6EB7B0@HK2PR06MB0531.apcprd06.prod.outlook.com>
	<1284106852.41406322.1528475894625.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junyan He <junyan.he@hotmail.com>
Cc: Junyan He <junyan.he@intel.com>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

> Hi Junyan,

Just want to add in same email thread there is discussion by Stefan & Kevin describing 
ways of handling NVDIMM similar to block device with the pros & cons of the approach. 

In light of that we have to consider this as memory but support of qcow2 is required 
for snapshot, handling block errors and other advance features. 

Hope this helps. 

Thanks, 
Pankaj 

> > I think nvdimm kind memory can really save the content(no matter real or
> > emulated). But I think it is still
> 

> > memory, as I understand, its data should be stored in the qcow2 image or
> > some
> > external snapshot data
> 

> > image, so that we can copy this qcow2 image to other place and restore the
> > same environment.
> 

> Emulated NVDIMM is just a file backed mmaped region in guest address space.
> So, whatever IO
> operations guest does its done directly in memory pages and synced to backup
> file.

> For this usecase, normally 'raw' image format is supported. If we have to
> support qcow2 format, we have to
> mmap different chunks for ranges of host virtual memory regions into guest
> address space so that whenever guest does IO
> into some offset host/qemu knows the corresponding location. Also, there is
> need to manage large number of these
> small chunks.

> > Qcow2 image contain all vm state, disk data and memory data, so I think
> > nvdimm's data should also be
> 

> > stored in this qcow2 image.
> 

> That will not work for emulated NVDIMM. I guest same is for pass-through or
> actual NVDIMM.

> > I am really a new guy in vmm field and do not know the usage of qcow2 with
> > DAX. So far as I know, DAX
> 

> > is a kernel FS option to let the page mapping bypass all block device logic
> > and can improve performance.
> 

> > But qcow2 is a user space file format used by qemu to emulate disks(Am I
> > right?), so I have no idea about
> 

> > that.
> 

> FYI DAX is direct access, whenever guest does file operations to DAX capable
> NVDIMM device, it bypasses
> regular block device logic and uses iomap calls to direct IO into the NVDIMM
> device. But qcow2 disk emulation
> part is host thing and it should be able to provide support, if it provides a
> mmaped area as guest physical or host
> virtual address.

> Thanks,
> Pankaj

> > Thanks
> 

> > Junyan
> 

> > From: Qemu-devel <qemu-devel-bounces+junyan.he=gmx.com@nongnu.org> on
> > behalf
> > of Pankaj Gupta <pagupta@redhat.com>
> 
> > Sent: Friday, June 8, 2018 7:59:24 AM
> 
> > To: Junyan He
> 
> > Cc: Kevin Wolf; qemu block; qemu-devel@nongnu.org; Stefan Hajnoczi; Max
> > Reitz
> 
> > Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
> > incremental snapshot
> 

> > Hi Junyan,
> 

> > AFAICU you are trying to utilize qcow2 capabilities to do incremental
> 
> > snapshot. As I understand NVDIMM device (being it real or emulated), its
> 
> > contents are always be backed up in backing device.
> 

> > Now, the question comes to take a snapshot at some point in time. You are
> 
> > trying to achieve this with qcow2 format (not checked code yet), I have
> > below
> 
> > queries:
> 

> > - Are you implementing this feature for both actual DAX device pass-through
> 
> > as well as emulated DAX?
> 
> > - Are you using additional qcow2 disk for storing/taking snapshots? How we
> > are
> 
> > planning to use this feature?
> 

> > Reason I asked this question is if we concentrate on integrating qcow2
> 
> > with DAX, we will have a full fledged solution for most of the use-cases.
> 

> > Thanks,
> 
> > Pankaj
> 

> > >
> 
> > > Dear all:
> 
> > >
> 
> > > I just switched from graphic/media field to virtualization at the end of
> > > the
> 
> > > last year,
> 
> > > so I am sorry that though I have already try my best but I still feel a
> 
> > > little dizzy
> 
> > > about your previous discussion about NVDimm via block layer:)
> 
> > > In today's qemu, we use the SaveVMHandlers functions to handle both
> > > snapshot
> 
> > > and migration.
> 
> > > So for nvdimm kind memory, its migration and snapshot use the same way as
> > > the
> 
> > > ram(savevm_ram_handlers). But the difference is the size of nvdimm may be
> 
> > > huge, and the load
> 
> > > and store speed is slower. According to my usage, when I use 256G nvdimm
> > > as
> 
> > > memory backend,
> 
> > > it may take more than 5 minutes to complete one snapshot saving, and
> > > after
> 
> > > saving the qcow2
> 
> > > image is bigger than 50G. For migration, this may not be a problem
> > > because
> > > we
> 
> > > do not need
> 
> > > extra disk space and the guest is not paused when in migration process.
> > > But
> 
> > > for snapshot,
> 
> > > we need to pause the VM and the user experience is bad, and we got
> > > concerns
> 
> > > about that.
> 
> > > I posted this question in Jan this year but failed to get enough reply.
> > > Then
> 
> > > I sent a RFC patch
> 
> > > set in Mar, basic idea is using the dependency snapshot and dirty log
> > > trace
> 
> > > in kernel to
> 
> > > optimize this.
> 
> > >
> 
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04530.html
> 
> > >
> 
> > > I use the simple way to handle this,
> 
> > > 1. Separate the nvdimm region from ram when do snapshot.
> 
> > > 2. If the first time, we dump all the nvdimm data the same as ram, and
> > > enable
> 
> > > dirty log trace
> 
> > > for nvdimm kind region.
> 
> > > 3. If not the first time, we find the previous snapshot point and add
> 
> > > reference to its clusters
> 
> > > which is used to store nvdimm data. And this time, we just save dirty
> > > page
> 
> > > bitmap and dirty pages.
> 
> > > Because the previous nvdimm data clusters is ref added, we do not need to
> 
> > > worry about its deleting.
> 
> > >
> 
> > > I encounter a lot of problems:
> 
> > > 1. Migration and snapshot logic is mixed and need to separate them for
> 
> > > nvdimm.
> 
> > > 2. Cluster has its alignment. When do snapshot, we just save data to disk
> 
> > > continuous. Because we
> 
> > > need to add ref to cluster, we really need to consider the alignment. I
> > > just
> 
> > > use a little trick way
> 
> > > to padding some data to alignment now, and I think it is not a good way.
> 
> > > 3. Dirty log trace may have some performance problem.
> 
> > >
> 
> > > In theory, this manner can be used to handle all kind of huge memory
> 
> > > snapshot, we need to find the
> 
> > > balance between guest performance(Because of dirty log trace) and
> > > snapshot
> 
> > > saving time.
> 
> > >
> 
> > > Thanks
> 
> > > Junyan
> 
> > >
> 
> > >
> 
> > > -----Original Message-----
> 
> > > From: Stefan Hajnoczi [ mailto:stefanha@redhat.com ]
> 
> > > Sent: Thursday, May 31, 2018 6:49 PM
> 
> > > To: Kevin Wolf <kwolf@redhat.com>
> 
> > > Cc: Max Reitz <mreitz@redhat.com>; He, Junyan <junyan.he@intel.com>;
> > > Pankaj
> 
> > > Gupta <pagupta@redhat.com>; qemu-devel@nongnu.org; qemu block
> 
> > > <qemu-block@nongnu.org>
> 
> > > Subject: Re: [Qemu-block] [Qemu-devel] Some question about savem/qcow2
> 
> > > incremental snapshot
> 
> > >
> 
> > > On Wed, May 30, 2018 at 06:07:19PM +0200, Kevin Wolf wrote:
> 
> > > > Am 30.05.2018 um 16:44 hat Stefan Hajnoczi geschrieben:
> 
> > > > > On Mon, May 14, 2018 at 02:48:47PM +0100, Stefan Hajnoczi wrote:
> 
> > > > > > On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> 
> > > > > > > Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> 
> > > > > > > > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> 
> > > > > > > > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> 
> > > > > > > > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> 
> > > > > > > > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> 
> > > > > > > > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> 
> > > > > > > > > >> I think it makes sense to invest some effort into such
> 
> > > > > > > > > >> interfaces, but be prepared for a long journey.
> 
> > > > > > > > > >
> 
> > > > > > > > > > I like the suggestion but it needs to be followed up with
> 
> > > > > > > > > > a concrete design that is feasible and fair for Junyan and
> 
> > > > > > > > > > others to implement.
> 
> > > > > > > > > > Otherwise the "long journey" is really just a way of
> 
> > > > > > > > > > rejecting this feature.
> 
> > > > >
> 
> > > > > The discussion on NVDIMM via the block layer has runs its course.
> 
> > > > > It would be a big project and I don't think it's fair to ask Junyan
> 
> > > > > to implement it.
> 
> > > > >
> 
> > > > > My understanding is this patch series doesn't modify the qcow2
> 
> > > > > on-disk file format. Rather, it just uses existing qcow2 mechanisms
> 
> > > > > and extends live migration to identify the NVDIMM state state region
> 
> > > > > to share the clusters.
> 
> > > > >
> 
> > > > > Since this feature does not involve qcow2 format changes and is just
> 
> > > > > an optimization (dirty blocks still need to be allocated), it can be
> 
> > > > > removed from QEMU in the future if a better alternative becomes
> 
> > > > > available.
> 
> > > > >
> 
> > > > > Junyan: Can you rebase the series and send a new revision?
> 
> > > > >
> 
> > > > > Kevin and Max: Does this sound alright?
> 
> > > >
> 
> > > > Do patches exist? I've never seen any, so I thought this was just the
> 
> > > > early design stage.
> 
> > >
> 
> > > Sorry for the confusion, the earlier patch series was here:
> 
> > >
> 
> > > https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04530.html
> 
> > >
> 
> > > > I suspect that while it wouldn't change the qcow2 on-disk format in a
> 
> > > > way that the qcow2 spec would have to be change, it does need to
> 
> > > > change the VMState format that is stored as a blob within the qcow2
> > > > file.
> 
> > > > At least, you need to store which other snapshot it is based upon so
> 
> > > > that you can actually resume a VM from the incremental state.
> 
> > > >
> 
> > > > Once you modify the VMState format/the migration stream, removing it
> 
> > > > from QEMU again later means that you can't load your old snapshots any
> 
> > > > more. Doing that, even with the two-release deprecation period, would
> 
> > > > be quite nasty.
> 
> > > >
> 
> > > > But you're right, depending on how the feature is implemented, it
> 
> > > > might not be a thing that affects qcow2 much, but one that the
> 
> > > > migration maintainers need to have a look at. I kind of suspect that
> 
> > > > it would actually touch both parts to a degree that it would need
> 
> > > > approval from both sides.
> 
> > >
> 
> > > VMState wire format changes are minimal. The only issue is that the
> > > previous
> 
> > > snapshot's nvdimm vmstate can start at an arbitrary offset in the qcow2
> 
> > > cluster. We can find a solution to the misalignment problem (I think
> 
> > > Junyan's patch series adds padding).
> 
> > >
> 
> > > The approach references existing clusters in the previous snapshot's
> > > vmstate
> 
> > > area and only allocates new clusters for dirty NVDIMM regions.
> 
> > > In the non-qcow2 case we fall back to writing the entire NVDIMM contents.
> 
> > >
> 
> > > So instead of:
> 
> > >
> 
> > > write(qcow2_bs, all_vmstate_data); /* duplicates nvdimm contents :( */
> 
> > >
> 
> > > do:
> 
> > >
> 
> > > write(bs, vmstate_data_upto_nvdimm);
> 
> > > if (is_qcow2(bs)) {
> 
> > > snapshot_clone_vmstate_range(bs, previous_snapshot,
> 
> > > offset_to_nvdimm_vmstate);
> 
> > > overwrite_nvdimm_dirty_blocks(bs, nvdimm);
> 
> > > } else {
> 
> > > write(bs, nvdimm_vmstate_data);
> 
> > > }
> 
> > > write(bs, vmstate_data_after_nvdimm);
> 
> > >
> 
> > > Stefan
> 
> > >
> 
> > >
> 
