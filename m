Received: from eggs.gnu.org ([209.51.188.92]:51990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvxd-0007m8-5B
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvxc-00087v-7s
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33390)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gqvxc-00087i-0R
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:20:04 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Feb 2019 11:20:04 +0300
Message-ID: <154935480433.7509.6439846085623193495.stgit@pasha-VirtualBox>
In-Reply-To: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v12 04/25] replay: update docs for
 record/replay with block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch updates the description of the command lines for using
record/replay with attached block devices.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 docs/replay.txt |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/replay.txt b/docs/replay.txt
index 3497585f5a..2c2c5f6118 100644
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
