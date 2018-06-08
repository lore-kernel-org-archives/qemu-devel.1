Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fRCJ3-0002hb-Fr
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fRCJ2-0002HL-0J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:59:33 -0400
Date: Fri, 8 Jun 2018 03:59:24 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <972381772.41213876.1528444764393.JavaMail.zimbra@redhat.com>
In-Reply-To: <EC8A4E314CF1574AB62C80421BD983393409C805@SHSMSX104.ccr.corp.intel.com>
References: <1514187226.13662.28.camel@intel.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
	<20180514134846.GD5182@stefanha-x1.localdomain>
	<20180530144450.GB5973@stefanha-x1.localdomain>
	<20180530160719.GD4311@localhost.localdomain>
	<20180531104838.GC27838@stefanha-x1.localdomain>
	<EC8A4E314CF1574AB62C80421BD983393409C805@SHSMSX104.ccr.corp.intel.com>
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
To: Junyan He <junyan.he@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


Hi Junyan,

AFAICU you are trying to utilize qcow2 capabilities to do incremental
snapshot. As I understand NVDIMM device (being it real or emulated), its
contents are always be backed up in backing device.  

Now, the question comes to take a snapshot at some point in time. You are 
trying to achieve this with qcow2 format (not checked code yet), I have below 
queries:

- Are you implementing this feature for both actual DAX device pass-through 
  as well as emulated DAX?
- Are you using additional qcow2 disk for storing/taking snapshots? How we are 
  planning to use this feature?

Reason I asked this question is if we concentrate on integrating qcow2
with DAX, we will have a full fledged solution for most of the use-cases. 

Thanks,
Pankaj 

> 
> Dear all:
> 
> I just switched from graphic/media field to virtualization at the end of the
> last year,
> so I am sorry that though I have already try my best but I still feel a
> little dizzy
> about your previous discussion about NVDimm via block layer:)
> In today's qemu, we use the SaveVMHandlers functions to handle both snapshot
> and migration.
> So for nvdimm kind memory, its migration and snapshot use the same way as the
> ram(savevm_ram_handlers). But the difference is the size of nvdimm may be
> huge, and the load
> and store speed is slower. According to my usage, when I use 256G nvdimm as
> memory backend,
> it may take more than 5 minutes to complete one snapshot saving, and after
> saving the qcow2
> image is bigger than 50G. For migration, this may not be a problem because we
> do not need
> extra disk space and the guest is not paused when in migration process. But
> for snapshot,
> we need to pause the VM and the user experience is bad, and we got concerns
> about that.
> I posted this question in Jan this year but failed to get enough reply. Then
> I sent a RFC patch
> set in Mar, basic idea is using the dependency snapshot and dirty log trace
> in kernel to
> optimize this.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04530.html
> 
> I use the simple way to handle this,
> 1. Separate the nvdimm region from ram when do snapshot.
> 2. If the first time, we dump all the nvdimm data the same as ram, and enable
> dirty log trace
> for nvdimm kind region.
> 3. If not the first time, we find the previous snapshot point and add
> reference to its clusters
> which is used to store nvdimm data. And this time, we just save dirty page
> bitmap and dirty pages.
> Because the previous nvdimm data clusters is ref added, we do not need to
> worry about its deleting.
> 
> I encounter a lot of problems:
> 1. Migration and snapshot logic is mixed and need to separate them for
> nvdimm.
> 2. Cluster has its alignment. When do snapshot, we just save data to disk
> continuous. Because we
> need to add ref to cluster, we really need to consider the alignment. I just
> use a little trick way
> to padding some data to alignment now, and I think it is not a good way.
> 3. Dirty log trace may have some performance problem.
> 
> In theory, this manner can be used to handle all kind of huge memory
> snapshot, we need to find the
> balance between guest performance(Because of dirty log trace) and snapshot
> saving time.
> 
> Thanks
> Junyan
> 
> 
> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Thursday, May 31, 2018 6:49 PM
> To: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>; He, Junyan <junyan.he@intel.com>; Pankaj
> Gupta <pagupta@redhat.com>; qemu-devel@nongnu.org; qemu block
> <qemu-block@nongnu.org>
> Subject: Re: [Qemu-block] [Qemu-devel] Some question about savem/qcow2
> incremental snapshot
> 
> On Wed, May 30, 2018 at 06:07:19PM +0200, Kevin Wolf wrote:
> > Am 30.05.2018 um 16:44 hat Stefan Hajnoczi geschrieben:
> > > On Mon, May 14, 2018 at 02:48:47PM +0100, Stefan Hajnoczi wrote:
> > > > On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> > > > > Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> > > > > > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > > > > > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > > > > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > > > > > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > > > > > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > > > > > > >> I think it makes sense to invest some effort into such
> > > > > > > >> interfaces, but be prepared for a long journey.
> > > > > > > > 
> > > > > > > > I like the suggestion but it needs to be followed up with
> > > > > > > > a concrete design that is feasible and fair for Junyan and
> > > > > > > > others to implement.
> > > > > > > > Otherwise the "long journey" is really just a way of
> > > > > > > > rejecting this feature.
> > > 
> > > The discussion on NVDIMM via the block layer has runs its course.
> > > It would be a big project and I don't think it's fair to ask Junyan
> > > to implement it.
> > > 
> > > My understanding is this patch series doesn't modify the qcow2
> > > on-disk file format.  Rather, it just uses existing qcow2 mechanisms
> > > and extends live migration to identify the NVDIMM state state region
> > > to share the clusters.
> > > 
> > > Since this feature does not involve qcow2 format changes and is just
> > > an optimization (dirty blocks still need to be allocated), it can be
> > > removed from QEMU in the future if a better alternative becomes
> > > available.
> > > 
> > > Junyan: Can you rebase the series and send a new revision?
> > > 
> > > Kevin and Max: Does this sound alright?
> > 
> > Do patches exist? I've never seen any, so I thought this was just the
> > early design stage.
> 
> Sorry for the confusion, the earlier patch series was here:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04530.html
> 
> > I suspect that while it wouldn't change the qcow2 on-disk format in a
> > way that the qcow2 spec would have to be change, it does need to
> > change the VMState format that is stored as a blob within the qcow2 file.
> > At least, you need to store which other snapshot it is based upon so
> > that you can actually resume a VM from the incremental state.
> > 
> > Once you modify the VMState format/the migration stream, removing it
> > from QEMU again later means that you can't load your old snapshots any
> > more. Doing that, even with the two-release deprecation period, would
> > be quite nasty.
> > 
> > But you're right, depending on how the feature is implemented, it
> > might not be a thing that affects qcow2 much, but one that the
> > migration maintainers need to have a look at. I kind of suspect that
> > it would actually touch both parts to a degree that it would need
> > approval from both sides.
> 
> VMState wire format changes are minimal.  The only issue is that the previous
> snapshot's nvdimm vmstate can start at an arbitrary offset in the qcow2
> cluster.  We can find a solution to the misalignment problem (I think
> Junyan's patch series adds padding).
> 
> The approach references existing clusters in the previous snapshot's vmstate
> area and only allocates new clusters for dirty NVDIMM regions.
> In the non-qcow2 case we fall back to writing the entire NVDIMM contents.
> 
> So instead of:
> 
>   write(qcow2_bs, all_vmstate_data); /* duplicates nvdimm contents :( */
> 
> do:
> 
>   write(bs, vmstate_data_upto_nvdimm);
>   if (is_qcow2(bs)) {
>       snapshot_clone_vmstate_range(bs, previous_snapshot,
>                                    offset_to_nvdimm_vmstate);
>       overwrite_nvdimm_dirty_blocks(bs, nvdimm);
>   } else {
>       write(bs, nvdimm_vmstate_data);
>   }
>   write(bs, vmstate_data_after_nvdimm);
> 
> Stefan
> 
> 
