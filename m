Received: from eggs.gnu.org ([2001:4830:134:3::10]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaP-0007IA-Ld
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaK-0003FY-W1
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:04 -0500
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Mon,  5 Nov 2018 21:38:34 +0000
Message-Id: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/5] off-by-one and NULL pointer accesses
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

v4 -> v5
Based on further feedback from Max Reitz:
Dropped v4 patch1 (configure --disable-avx2) as Thomas Huth already pulle=
d it.=20
Dropped v4 patch6 (dump_qlist) as it was just an unnecessary assert
Dropped v4 patch8 'patch fixing NULL pointer dereference in kvm_arch_init=
_vcpu()'
  so as to limit this seies to block changes (will send in a separate ser=
ies).
patch1: no change (v4 patch2)
patch2: Switched to using ?: in return (v4 patch3)
patch3: Added Max's R-b (v4 patch4)
patch4: couple of changes based on feedback from Max (v4 patch5)
patch5: no change (v4 patch7)

Liam Merwick (5):
  job: Fix off-by-one assert checks for JobSTT and JobVerbTable
  block: Null pointer dereference in blk_root_get_parent_desc()
  qemu-img: assert block_job_get() does not return NULL in img_commit()
  block: Fix potential Null pointer dereferences in vvfat.c
  qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()

 block/block-backend.c  |  3 ++-
 block/qcow2-refcount.c | 18 ++++++++++--------
 block/vvfat.c          | 49 +++++++++++++++++++++++++++++++++-----------=
-----
 job.c                  |  4 ++--
 qemu-img.c             |  1 +
 5 files changed, 48 insertions(+), 27 deletions(-)

--=20
1.8.3.1
