Received: from eggs.gnu.org ([2001:4830:134:3::10]:46021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbfc-0005S2-3r
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbNN-00040F-Fc
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:49:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:54142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvbNN-0003zw-7E
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:49:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvbNM-0003uZ-1r
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:49:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0D45B2E80CB
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:49:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Aug 2018 04:35:56 -0000
From: Thomas Huth <721825@bugs.launchpad.net>
Reply-To: Bug 721825 <721825@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110219161957.9055.80104.malonedeb@gandwana.canonical.com>
Message-Id: <153569015679.30951.12915574415225461600.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 721825] Re: VDI block driver bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Low

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/721825

Title:
  VDI block driver bugs

Status in QEMU:
  Triaged

Bug description:
  Chunqiang Tang reports the following issues with the VDI block driver,
  these are present in QEMU 0.14:

  "Bug 1. The most serious bug is caused by race condition in updating a ne=
w =

  bmap entry in memory and on disk. Considering the following operation =

  sequence. =

    O1: VM issues a write to sector X
    O2: VDI allocates a new bmap entry and updates in-memory s->bmap
    O3: VDI writes data to disk
    O4: The disk I/O for writing sector X fails
    O5: VDI reports error to VM and returns.

  Note that the bmap entry is updated in memory, but not persisted on disk. =

  Now consider another write that immediately follows:
    P1: VM issues a write to sector X+1, which locates in the same block as =

  the previously used sector X.
    P2: s->bmap already has one entry for the block, and hence VDI writes =

  data directly without persisting the new s->bmap entry on disk.
    P3: The write disk I/O succeeds
    P4: VDI report success to VM, but the bitmap entry is still not =

  persisted on disk.

  Now suppose the VM powers off gracefully (i.e., the QEMU process quits) =

  and reboots. The second write to sector X+1, which is reported as finishe=
d =

  successfully, is simply lost, because the corresponding in-memory s->bmap =

  entry is never persisted on disk. This is exactly what FVD's testing tool =

  discovers. After the block device is closed and then re-opened, disk =

  content verification fails.

  This is just one example of the problem. Race condition plus host crash =

  also causes problems. Consider another example below.
    Q1: VM issues a write to sector X
    Q2: VDI allocates a new bmap entry and updates in-memory s->bmap
    Q3: VDI writes sector X to disk and waits for the callback
    Q4: VM issues a write to another sector X+1, which is in the same block =

  as sector X.
    Q5: VDI sees the bitmap entry in s->bmap is already allocated, and =

  writes sector X+1 to disk.
    Q6: Write to sector X+1 finishes, and VDI's callback is invoked.
    Q7: VDI acknowledges to the VM the completion of writing sector X+1
    Q8: After observing the completion of writing sector X+1, VM issues a =

  flush to ensure that sector X+1 is persisted on disk.
    Q9: VDI finishes the flush and acknowledge the completion of the =

  operation.
    Q10: ... (some other arbitrary operations, but the disk I/O for writing =

  sector X is still not finished....)
    Q11: The host crashes

  Now the new bitmap entry is not persisted on disk, while both writing to =

  sector X+1 and the flush has been acknowledged as finished. Sector X+1 is =

  lost, which is a corruption. This problem exists even if it uses O_DSYNC. =

  The root cause of the problem is that, if a request updates in-memory =

  s->bmap, another request that sees this update assumes that the update is =

  already persisted on disk, which is not.

  Bug 2: Similar to the bugs the FVD testing tool found for QCOW2, there ar=
e =

  several cases of the code below on failure handling path without setting =

  error return code, which mistakenly reports failure as success. This =

  mistake is caught by FVD when doing image content validation.
         if (acb->hd_aiocb =3D=3D NULL) {
             /* missing     ret =3D -EIO; */
              goto done; =

          } =


  Bug 3: Similar to the bugs the FVD testing tool found for QCOW2, =

  vdi_aio_cancel does not perform a complete clean up and there are several =

  related bugs. First, memory buffer is not freed, acb->orig_buf and =

  acb->block_buffer. Second, acb->bh is not cancelled. Third, =

  vdi_aio_setup() does not initialize acb->bh to NULL so that when a reques=
t =

  acb is cancelled and then later reused for another request, its acb->bh !=
=3D =

  NULL and the new request fails in  vdi_schedule_bh(). This is caught by =

  FVD's testing tool, when it observes that no I/O failure is injected but =

  VDI reports a failed I/O request, which indicates a bug in the driver."

  http://permalink.gmane.org/gmane.comp.emulators.qemu/94340

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/721825/+subscriptions
