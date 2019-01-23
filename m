Received: from eggs.gnu.org ([209.51.188.92]:53769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharadwaj.rayala@rubrik.com>) id 1gmMxF-0006nh-EJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharadwaj.rayala@rubrik.com>) id 1gmMxC-0002yj-4f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:49 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bharadwaj.rayala@rubrik.com>)
	id 1gmMxB-0002Ws-0L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:45 -0500
Received: by mail-vs1-xe33.google.com with SMTP id v205so1874031vsc.3
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:08:25 -0800 (PST)
MIME-Version: 1.0
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
	<e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
In-Reply-To: <e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
From: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>
Date: Wed, 23 Jan 2019 23:38:12 +0530
Message-ID: <CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>, Suman Swaroop <suman.swaroop@rubrik.com>, kchamart@redhat.com, John Snow <jsnow@redhat.com>, qemu-discuss@nongnu.org

Replied inline.

On Wed, Jan 23, 2019 at 3:25 AM Eric Blake <eblake@redhat.com> wrote:

> On 1/22/19 1:29 PM, Bharadwaj Rayala wrote:
> > Hi,
> >
> > TL(Cant)R: I am trying to figure out a workflow for doing incremental
> > drive-backups using dirty-bitmaps. Feels qemu lacks some essential
> features
> > to achieve it.
> >
> > I am trying to build a backup workflow(program) using drive-backup along
> > with dirty bitmaps to take backups of kvm vms. EIther pull/push model
> works
> > for me. Since drive-backup push model is already implemented, I am
> > going forward with it. I am not able to figure out a few details and
> > couldn't find any documentation around it. Any help would be appreciated
> >
> > Context: I would like to take recoverable, consistent, incremental
> > backups of kvm vms, whose disks are backed either by qcow2 or raw images.
> > Lets say there is a vm:vm1 with drive1 backed by image chain( A <-- B ).
> > This are the rough steps i would like to do.
> >
> > Method 1:
> > Backup:
> > 1. Perform a full backup using `drive-backup(drive1, sync=full, dest =
> > /nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1,
> > bitmap1)`. Store the vm config seperately
> > 2. Perform an incremental backup using `drive-backup(drive1,
> > sync=incremental, mode=existing, bitmap=bitmap1, dest=/nfs/vm1/drive1)`.
> > Store the vm config seperately
> > 3. Rinse and repeat.
> > Recovery(Just the latest backup, incremental not required):
> >     Copy the full qcow2 from nfs to host storage. Spawn a new vm with the
> > same vm config.
> > Temporary quick recovery:
> >     Create a new qcow2 layer on top of existing /nfs/vm1/drive1 on the
> nfs
> > storage itself. Spawn a new vm with disk on nfs storage itself.
>
> Sounds like it should work; using qemu to push the backup out.
>
> > were
> > Issues i face:
> > 1. Does the drive-backup stall for the whole time the block job is in
> > progress. This is a strict no for me. I didnot find any documentation
> > regarding it but a powerpoint presentation(from kaskyapc) mentioning it.
> > (Assuming yes!)
>
> The drive-backup is running in parallel to the guest.  I'm not sure what
> stalls you are seeing - but as qemu is doing all the work, it DOES have
> to service both guest requests and the work to copy out the backup;
> also, if you have known-inefficient lseek() situations, there may be
> cases where qemu is doing a lousy job (there's work underway on the list
> to improve qemu's caching of lseek() data).
>
>
Eric, I watched your kvm forum video
https://www.youtube.com/watch?v=zQK5ANionpU. Which cleared out somethings
for me. Lets say you have a disk of size 10GB, I had assumed that, if
drive-backup has copied till 2 gb offset, that wouldnt qemu have to stall
writes coming from guest b/w 2gb and 10gb ? Unless qemu does some internal
qcow snapshoting at the start of the backup job and committing at the end.
But if i get it correctly from what you explained, qemu doesnot create a
new qcow file, but when a write comes from the guest to the live image, old
block is first written to the backup synchronously before writing new data
to the live qcow2 file. This would not stall the writes, but this would
slow down the writes of the guest, as an extra write to target file on
secondary storage(over nfs) has to happen first. If the old block write to
nfs fails, does backup fail with on-target-error appropriately set? or does
it stall the guest write ?


> > 2. Is the backup consistent? Are the drive file-systems quiesced on
> backup?
> > (Assuming no!)
>
> If you want the file systems quiesced on backup, then merely bracket
> your transaction that kicks off the drive-backup inside guest-agent
> commands that freeze and thaw the disk.  So, consistency is not default
> (because it requires trusting the guest), but is possible.
>
>
Ok. Method 2 below would not even be required if both the above issues can
be solved.


> >
> > To achieve both of the above, one hack i could think of was to take a
> > snapshot and read from the snapshot.
> >
> > Method 2:
> > 1. Perform a full backup using `drive-backup(drive1, sync=full, dest =
> > /nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1,
> > bitmap1)`. Store the vm config seperately
> > 2. Perform the incremental backup by
> >      a. add bitmap2 to drive1 `block-dirty-bitmap-add(drive1, bitmap2)`.
> >      b. Take a vm snapshot with drive1(exclude memory, quiesce). The
> drive1
> > image chain is now A<--B<--C.
> >      c. Take incremental using bitmap1 but using data from node B.
> > `drive-backup(*#nodeB*, sync=incremental, mode=existing, bitmap=bitmap1,
> > dest=/nfs/vm1/drive1)`
> >      d. Delete bitmap1 `block-dirty-bitmap-delete(drive1, bitmap1)`
> >      e. Delete vm snapshot on drive1. The drive1 image chain is now A
> <--B.
> >      f. bitmap2 now tracks the changes from incrementa 1 to incremental
> 2.
> >
> > Drawbacks with this method would be(had it worked) that incremental
> backups
> > would contain dirty blocks that are a superset of the actual blocks that
> > are changed between the snapshot and the last snapshot.(Incremental x
> would
> > contain blocks that have changed when incremental x-1 backup was in
> > progress). But there are no correctness issues.
> >
> >
> > *I cannot do this because drive-backup doesnot allow bitmap and node that
> > the bitmap is attached to, to be different. :( *
>
> It might, as long as the bitmap is found on the backing chain (I'm a bit
> fuzzier on that case, but KNOW that for pull-mode backups, my libvirt
> code is definitely relying on being able to access the bitmap from the
> backing file of the BDS being exported over NBD).
>
>
Sorry. I dont get this. So lets say this was the drive-1 I had. A(raw) <---
B (qcow2) . @suman(cc'ed) created a bitmap(bitmap1) on device:drive-1 ,
then took a snapshot of it. At this point the chain would be something like
A(raw) <-- B(qcow2 -  snapshot)  <--- C(qcow2 - live). Would the bitmap
that was created on drive-1 still be attached to #nodeB or would it be
attached to #nodeC. Would it have all the dirty blocks from "bitmap-add to
now" or would it only have dirty blocks from "bitmap-add to snapshot".
If the bitmap's now attached to live drive-1( i.e, nodeC) it would have all
the dirty blocks, but then can i do a drive-backup(bitmap1, src=#nodeB).

If the bitmap stays attached to ( nodeB), it would have only dirty blocks
till the point snapshot C is created. But this is a problem, as a backup
workflow/program shouldnot restrict users from creating other snapshots.
Backup workflow can take additional snapshots as done in method2 above if
it wants, and then remove the snapshot once the backup job is done. I guess
this problem would be there for the pull based model as well. I am
currently trying my workflow on an rhev cluster, and i donot want my backup
workflow to interfere with snapshots triggered from rhevm/ovirt.


> > Some other issues i was facing that i worked around:
> > 1. Lets say i have to backup a vm with 2 disks(both at a fixed point in
> > time, either both fail or both pass). To atomically do a bitmap-add and
> > drive-backup(sync=full) i can use transcations. To achieve a backup at a
> > fixed point in time, i can use transaction with multiple drive-backups.
> To
> > either fail the whole backup or succeed(when multiple drives are
> present),
> > i can use completion-mode = grouped. But then i cant combine them as its
> > not supported. i.e, do a
> >     Transaction{drive-backup(drive1), dirty-bitmap-add(drive1,
> > bitmap1),drive-backup(drive2), dirty-bitmap-add(drive2, bitmap1),
> > completion-mode=grouped}.
>
> What error message are you getting?  I'm not surprised if
> completion-mode=grouped isn't playing nicely with bitmaps in
> transactions, although that should be something that we should fix.
>

error says grouped completion-mode not allowed with command
'drity-bitmap-add'


>
> >  Workaround: Create bitmaps first, then take full. Effect: Incrementals
> > would be a small superset of actual changed blocks.
> > 2. Why do I need to dismiss old jobs to start a new job on node. I want
> to
> > retain the block-job end state for a day before i clear them. So i set
> > auto-dismiss to false. This doesnot allow new jobs to run unless the old
> > job is dismissed even if state=concluded.
>
> Yes, there is probably more work needed to make parallel jobs do what
> people want.
>
> >  Workaround: no workaround, store the end-job-status somewhere else.
> > 3. Is there a way pre 2.12 to achieve auto-finalise = false in a
> > transaction. Can I somehow add a dummy block job, that will only finish
> > when i want to finalise the actual 2 disks block jobs? My backup workflow
> > needs to run on env's pre 2.12.
>
> Ouch - backups pre-2.12 have issues.  If I had not read this paragraph,
> my recommendation would be to stick to 3.1 and use pull-mode backups
> (where you use NBD to learn which portions of the image were dirtied,
> and pull those portions of the disk over NBD rather than qemu pushing
> them); I even have a working demo of preliminary libvirt code driving
> that which I presented at last year's KVM Forum.
>

What do you mean by issues? Do you mean any data/corruption bugs or lack of
some nice functionality that we are talking here?


>
> >  Workaround: Couldnot achieve this. So if an incremental fails after
> block
> > jobs succeed before i can ensure success(have to do some metadata
> > operations on my side), i retry with sync=full mode.
> >
> >
> > *So what is the recommeded way of taking backups with incremental bitmaps
> > ? *
> > Thanks you for taking time to read through this.
> >
> > Best,
> > Bharadwaj.
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org


Thanks a lot Eric for spending your time in answering my queries. I dont
know if you work with Kashyap Chamarthy, but your help and his blogs are
lifesavers.

Thank you,
Bharadwaj.
