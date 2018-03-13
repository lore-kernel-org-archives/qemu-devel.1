Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiv-0006Ym-0h
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsit-0004I4-7l
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:48 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsis-0004HK-SR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:47 -0400
Received: by mail-wm0-x229.google.com with SMTP id a20so16164583wmd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:18 +0100
Message-Id: <20180313224719.4954-69-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 68/69] replay: update documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch clarifies the description of the record/replay feature
in docs/replay.txt

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095333.1060.1331.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 docs/replay.txt | 72 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/docs/replay.txt b/docs/replay.txt
index 959633e7ea..2e21e9ccb0 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -7,14 +7,10 @@ See the COPYING file in the top-level directory.
 Record/replay
 -------------
 
-Record/replay functions are used for the reverse execution and deterministic
-replay of qemu execution. This implementation of deterministic replay can
-be used for deterministic debugging of guest code through a gdb remote
-interface.
-
+Record/replay functions are used for the deterministic replay of qemu execution.
 Execution recording writes a non-deterministic events log, which can be later
 used for replaying the execution anywhere and for unlimited number of times.
-It also supports checkpointing for faster rewinding during reverse debugging.
+It also supports checkpointing for faster rewind to the specific replay moment.
 Execution replaying reads the log and replays all non-deterministic events
 including external input, hardware clocks, and interrupts.
 
@@ -28,16 +24,36 @@ Deterministic replay has the following features:
    input devices.
 
 Usage of the record/replay:
- * First, record the execution, by adding the following arguments to the command line:
-   '-icount shift=7,rr=record,rrfile=replay.bin -net none'.
-   Block devices' images are not actually changed in the recording mode,
+ * First, record the execution with the following command line:
+    qemu-system-i386 \
+     -icount shift=7,rr=record,rrfile=replay.bin \
+     -drive file=disk.qcow2,if=none,id=img-direct \
+     -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
+     -device ide-hd,drive=img-blkreplay \
+     -netdev user,id=net1 -device rtl8139,netdev=net1 \
+     -object filter-replay,id=replay,netdev=net1
+ * After recording, you can replay it by using another command line:
+    qemu-system-i386 \
+     -icount shift=7,rr=replay,rrfile=replay.bin \
+     -drive file=disk.qcow2,if=none,id=img-direct \
+     -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
+     -device ide-hd,drive=img-blkreplay \
+     -netdev user,id=net1 -device rtl8139,netdev=net1 \
+     -object filter-replay,id=replay,netdev=net1
+   The only difference with recording is changing the rr option
+   from record to replay.
+ * Block device images are not actually changed in the recording mode,
    because all of the changes are written to the temporary overlay file.
- * Then you can replay it by using another command
-   line option: '-icount shift=7,rr=replay,rrfile=replay.bin -net none'
- * '-net none' option should also be specified if network replay patches
-   are not applied.
-
-Papers with description of deterministic replay implementation:
+   This behavior is enabled by using blkreplay driver. It should be used
+   for every enabled block device, as described in 'Block devices' section.
+ * '-net none' option should be specified when network is not used,
+   because QEMU adds network card by default. When network is needed,
+   it should be configured explicitly with replay filter, as described
+   in 'Network devices' section.
+ * Interaction with audio devices and serial ports are recorded and replayed
+   automatically when such devices are enabled.
+
+Academic papers with description of deterministic replay implementation:
 http://www.computer.org/csdl/proceedings/csmr/2012/4666/00/4666a553-abs.html
 http://dl.acm.org/citation.cfm?id=2786805.2803179
 
@@ -46,8 +62,11 @@ Modifications of qemu include:
  * saving different asynchronous events (e.g. system shutdown) into the log
  * synchronization of the bottom halves execution
  * synchronization of the threads from thread pool
- * recording/replaying user input (mouse and keyboard)
+ * recording/replaying user input (mouse, keyboard, and microphone)
  * adding internal checkpoints for cpu and io synchronization
+ * network filter for recording and replaying the packets
+ * block driver for making block layer deterministic
+ * serial port input record and replay
 
 Locking and thread synchronisation
 ----------------------------------
@@ -77,12 +96,11 @@ Non-deterministic events
 Our record/replay system is based on saving and replaying non-deterministic
 events (e.g. keyboard input) and simulating deterministic ones (e.g. reading
 from HDD or memory of the VM). Saving only non-deterministic events makes
-log file smaller, simulation faster, and allows using reverse debugging even
-for realtime applications.
+log file smaller and simulation faster.
 
 The following non-deterministic data from peripheral devices is saved into
 the log: mouse and keyboard input, network packets, audio controller input,
-USB packets, serial port input, and hardware clocks (they are non-deterministic
+serial port input, and hardware clocks (they are non-deterministic
 too, because their values are taken from the host machine). Inputs from
 simulated hardware, memory of VM, software interrupts, and execution of
 instructions are not saved into the log, because they are deterministic and
@@ -205,7 +223,7 @@ Block devices record/replay module intercepts calls of
 bdrv coroutine functions at the top of block drivers stack.
 To record and replay block operations the drive must be configured
 as following:
- -drive file=disk.qcow,if=none,id=img-direct
+ -drive file=disk.qcow2,if=none,id=img-direct
  -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
  -device ide-hd,drive=img-blkreplay
 
@@ -234,6 +252,12 @@ This snapshot is created at start of recording and restored at start
 of replaying. It also can be loaded while replaying to roll back
 the execution.
 
+Use QEMU monitor to create additional snapshots. 'savevm <name>' command
+created the snapshot and 'loadvm <name>' restores it. To prevent corruption
+of the original disk image, use overlay files linked to the original images.
+Therefore all new snapshots (including the starting one) will be saved in
+overlays and the original image remains unchanged.
+
 Network devices
 ---------------
 
@@ -255,6 +279,14 @@ Audio data is recorded and replay automatically. The command line for recording
 and replaying must contain identical specifications of audio hardware, e.g.:
  -soundhw ac97
 
+Serial ports
+------------
+
+Serial ports input is recorded and replay automatically. The command lines
+for recording and replaying must contain identical number of ports in record
+and replay modes, but their backends may differ.
+E.g., '-serial stdio' in record mode, and '-serial null' in replay mode.
+
 Replay log format
 -----------------
 
-- 
2.14.3
