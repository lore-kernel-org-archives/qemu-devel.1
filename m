Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GG-0006vx-IF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GE-00041P-Ju
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57920)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GC-0003gi-JV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:45 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 17 Jan 2019 10:38:33 +0300
Message-ID: <20190117073833.5399.68807.stgit@pasha-VirtualBox>
In-Reply-To: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v10 18/24] replay: describe reverse debugging
 in docs/replay.txt
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

This patch updates the documentation and describes usage of the reverse
debugging in QEMU+GDB.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 docs/replay.txt |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/replay.txt b/docs/replay.txt
index 2c2c5f6..8447fdd 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -293,6 +293,39 @@ for recording and replaying must contain identical number of ports in record
 and replay modes, but their backends may differ.
 E.g., '-serial stdio' in record mode, and '-serial null' in replay mode.
 
+Reverse debugging
+-----------------
+
+Reverse debugging allows "executing" the program in reverse direction.
+GDB remote protocol supports "reverse step" and "reverse continue"
+commands. The first one steps single instruction backwards in time,
+and the second one finds the last breakpoint in the past.
+
+Recorded executions may be used to enable reverse debugging. QEMU can't
+execute the code in backwards direction, but can load a snapshot and
+replay forward to find the desired position or breakpoint.
+
+The following GDB commands are supported:
+ - reverse-stepi (or rsi) - step one instruction backwards
+ - reverse-continue (or rc) - find last breakpoint in the past
+
+Reverse step loads the nearest snapshot and replays the execution until
+the required instruction is met.
+
+Reverse continue may include several passes of examining the execution
+between the snapshots. Each of the passes include the following steps:
+ 1. loading the snapshot
+ 2. replaying to examine the breakpoints
+ 3. if breakpoint or watchpoint was met
+    - loading the snaphot again
+    - replaying to the required breakpoint
+ 4. else
+    - proceeding to the p.1 with the earlier snapshot
+
+Therefore usage of the reverse debugging requires at least one snapshot
+created in advance. See the "Snapshotting" section to learn about running
+record/replay and creating the snapshot in these modes.
+
 Replay log format
 -----------------
 
