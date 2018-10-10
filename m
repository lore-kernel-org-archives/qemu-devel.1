Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZY-0001e2-K5
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZT-0002KL-0m
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:43918)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZS-0002Jx-OF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:38 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:33:51 +0300
Message-ID: <20181010133351.24538.25271.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 03/19] replay: update docs for record/replay
 with block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

This patch updates the description of the command lines for using
record/replay with attached block devices.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 docs/replay.txt |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/replay.txt b/docs/replay.txt
index 3497585..2c2c5f6 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -27,7 +27,7 @@ Usage of the record/replay:
  * First, record the execution with the following command line:
     qemu-system-i386 \
      -icount shift=7,rr=record,rrfile=replay.bin \
-     -drive file=disk.qcow2,if=none,id=img-direct \
+     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
      -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
      -device ide-hd,drive=img-blkreplay \
      -netdev user,id=net1 -device rtl8139,netdev=net1 \
@@ -35,7 +35,7 @@ Usage of the record/replay:
  * After recording, you can replay it by using another command line:
     qemu-system-i386 \
      -icount shift=7,rr=replay,rrfile=replay.bin \
-     -drive file=disk.qcow2,if=none,id=img-direct \
+     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
      -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
      -device ide-hd,drive=img-blkreplay \
      -netdev user,id=net1 -device rtl8139,netdev=net1 \
@@ -223,7 +223,7 @@ Block devices record/replay module intercepts calls of
 bdrv coroutine functions at the top of block drivers stack.
 To record and replay block operations the drive must be configured
 as following:
- -drive file=disk.qcow2,if=none,id=img-direct
+ -drive file=disk.qcow2,if=none,snapshot,id=img-direct
  -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
  -device ide-hd,drive=img-blkreplay
 
@@ -252,6 +252,12 @@ This snapshot is created at start of recording and restored at start
 of replaying. It also can be loaded while replaying to roll back
 the execution.
 
+'snapshot' flag of the disk image must be removed to save the snapshots
+in the overlay (or original image) instead of using the temporary overlay.
+ -drive file=disk.ovl,if=none,id=img-direct
+ -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
+ -device ide-hd,drive=img-blkreplay
+
 Use QEMU monitor to create additional snapshots. 'savevm <name>' command
 created the snapshot and 'loadvm <name>' restores it. To prevent corruption
 of the original disk image, use overlay files linked to the original images.
