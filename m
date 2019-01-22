Received: from eggs.gnu.org ([209.51.188.92]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharadwaj.rayala@rubrik.com>) id 1gm1nJ-0007Uh-K1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharadwaj.rayala@rubrik.com>) id 1gm1jz-0002TW-5C
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:29:45 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f]:36238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bharadwaj.rayala@rubrik.com>)
	id 1gm1jy-0002MJ-OW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:29:43 -0500
Received: by mail-ua1-x92f.google.com with SMTP id j3so8484304uap.3
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:29:39 -0800 (PST)
MIME-Version: 1.0
From: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>
Date: Wed, 23 Jan 2019 00:59:27 +0530
Message-ID: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Cc: kchamart@redhat.com, Suman Swaroop <suman.swaroop@rubrik.com>, kashyap.cv@gmail.com

Hi,

TL(Cant)R: I am trying to figure out a workflow for doing incremental
drive-backups using dirty-bitmaps. Feels qemu lacks some essential features
to achieve it.

I am trying to build a backup workflow(program) using drive-backup along
with dirty bitmaps to take backups of kvm vms. EIther pull/push model works
for me. Since drive-backup push model is already implemented, I am
going forward with it. I am not able to figure out a few details and
couldn't find any documentation around it. Any help would be appreciated

Context: I would like to take recoverable, consistent, incremental
backups of kvm vms, whose disks are backed either by qcow2 or raw images.
Lets say there is a vm:vm1 with drive1 backed by image chain( A <-- B ).
This are the rough steps i would like to do.

Method 1:
Backup:
1. Perform a full backup using `drive-backup(drive1, sync=full, dest =
/nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1,
bitmap1)`. Store the vm config seperately
2. Perform an incremental backup using `drive-backup(drive1,
sync=incremental, mode=existing, bitmap=bitmap1, dest=/nfs/vm1/drive1)`.
Store the vm config seperately
3. Rinse and repeat.
Recovery(Just the latest backup, incremental not required):
    Copy the full qcow2 from nfs to host storage. Spawn a new vm with the
same vm config.
Temporary quick recovery:
    Create a new qcow2 layer on top of existing /nfs/vm1/drive1 on the nfs
storage itself. Spawn a new vm with disk on nfs storage itself.
were
Issues i face:
1. Does the drive-backup stall for the whole time the block job is in
progress. This is a strict no for me. I didnot find any documentation
regarding it but a powerpoint presentation(from kaskyapc) mentioning it.
(Assuming yes!)
2. Is the backup consistent? Are the drive file-systems quiesced on backup?
(Assuming no!)

To achieve both of the above, one hack i could think of was to take a
snapshot and read from the snapshot.

Method 2:
1. Perform a full backup using `drive-backup(drive1, sync=full, dest =
/nfs/vm1/drive1)`. Use transaction to do `block-dirty-bitmap-add(drive1,
bitmap1)`. Store the vm config seperately
2. Perform the incremental backup by
     a. add bitmap2 to drive1 `block-dirty-bitmap-add(drive1, bitmap2)`.
     b. Take a vm snapshot with drive1(exclude memory, quiesce). The drive1
image chain is now A<--B<--C.
     c. Take incremental using bitmap1 but using data from node B.
`drive-backup(*#nodeB*, sync=incremental, mode=existing, bitmap=bitmap1,
dest=/nfs/vm1/drive1)`
     d. Delete bitmap1 `block-dirty-bitmap-delete(drive1, bitmap1)`
     e. Delete vm snapshot on drive1. The drive1 image chain is now A <--B.
     f. bitmap2 now tracks the changes from incrementa 1 to incremental 2.

Drawbacks with this method would be(had it worked) that incremental backups
would contain dirty blocks that are a superset of the actual blocks that
are changed between the snapshot and the last snapshot.(Incremental x would
contain blocks that have changed when incremental x-1 backup was in
progress). But there are no correctness issues.


*I cannot do this because drive-backup doesnot allow bitmap and node that
the bitmap is attached to, to be different. :( *
Some other issues i was facing that i worked around:
1. Lets say i have to backup a vm with 2 disks(both at a fixed point in
time, either both fail or both pass). To atomically do a bitmap-add and
drive-backup(sync=full) i can use transcations. To achieve a backup at a
fixed point in time, i can use transaction with multiple drive-backups. To
either fail the whole backup or succeed(when multiple drives are present),
i can use completion-mode = grouped. But then i cant combine them as its
not supported. i.e, do a
    Transaction{drive-backup(drive1), dirty-bitmap-add(drive1,
bitmap1),drive-backup(drive2), dirty-bitmap-add(drive2, bitmap1),
completion-mode=grouped}.
 Workaround: Create bitmaps first, then take full. Effect: Incrementals
would be a small superset of actual changed blocks.
2. Why do I need to dismiss old jobs to start a new job on node. I want to
retain the block-job end state for a day before i clear them. So i set
auto-dismiss to false. This doesnot allow new jobs to run unless the old
job is dismissed even if state=concluded.
 Workaround: no workaround, store the end-job-status somewhere else.
3. Is there a way pre 2.12 to achieve auto-finalise = false in a
transaction. Can I somehow add a dummy block job, that will only finish
when i want to finalise the actual 2 disks block jobs? My backup workflow
needs to run on env's pre 2.12.
 Workaround: Couldnot achieve this. So if an incremental fails after block
jobs succeed before i can ensure success(have to do some metadata
operations on my side), i retry with sync=full mode.


*So what is the recommeded way of taking backups with incremental bitmaps
? *
Thanks you for taking time to read through this.

Best,
Bharadwaj.
