Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXt-0007rs-0g
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXs-0002PA-4V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:56 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:38:58 +0100
Message-Id: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/8] off-by-one and NULL pointer accesses
 detected by static analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

Below are a number of fixes to some off-by-one, read outside array bounds=
, and
NULL pointer accesses detected by an internal Oracle static analysis tool=
 (Parfait).
https://labs.oracle.com/pls/apex/f?p=3Dlabs:49:::::P49_PROJECT_ID:13

I have also included a patch to add a command-line option to configure to
select if AVX2 is used or not (keeping the existing behaviour by default).
My motivation was avoiding an issue with the static analysis tool but Net=
Spectre
was announced as I was working on this and I felt it may have more genera=
l uses.

v1 -> v2
Based on feedback from Eric Blake:
patch2: reworded commit message to clarify issue
patch6: Reverted common qlist routines and added assert to qlist_dump ins=
tead
patch7: Fixed incorrect logic
patch8: Added QEMU_BUILD_BUG_ON to catch future =D1=96nstance at compile-=
time

v2 -> v3
Based on feedback from Eric Blake:
patch6: removed double space from commit message
patch8: removed unnecessary comment and updated QEMU_BUILD_BUG_ON to use =
ARRAY_SIZE
Added Eric's R-b to patches 6,7,8

v3 -> v4
Based on feedback from Max Reitz:
patch2: Added R-b from John Snow
patch3: fixed blk_get_attached_dev_id() instead of checking return value
patch4: switched to assert()
patch5: numerous changes based on feedback from Max
patch6: updated commit message
patch7: (was patch8): Added Max's R-b
patch8: (new): patch fixing NULL pointer dereference in kvm_arch_init_vcp=
u()

I also dropped the 'io: potential unnecessary check in qio_channel_comman=
d_new_spawn()'
patch from v3 - it was correct but of no benefit to staic analysis checki=
ng

Liam Merwick (8):
  configure: Provide option to explicitly disable AVX2
  job: Fix off-by-one assert checks for JobSTT and JobVerbTable
  block: Null pointer dereference in blk_root_get_parent_desc()
  qemu-img: assert block_job_get() does not return NULL in img_commit()
  block: Fix potential Null pointer dereferences in vvfat.c
  block: dump_qlist() may dereference a Null pointer
  qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()
  kvm: Potential NULL pointer dereference in kvm_arch_init_vcpu()

 block/block-backend.c  |  6 +++++-
 block/qapi.c           |  2 ++
 block/qcow2-refcount.c | 18 ++++++++++--------
 block/vvfat.c          | 33 ++++++++++++++++++++++++++++-----
 configure              | 11 +++++++++--
 dtc                    |  2 +-
 job.c                  |  4 ++--
 qemu-img.c             |  1 +
 target/i386/kvm.c      |  4 +++-
 9 files changed, 61 insertions(+), 20 deletions(-)

--=20
1.8.3.1
