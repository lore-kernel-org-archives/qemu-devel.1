Received: from eggs.gnu.org ([2001:4830:134:3::10]:38915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfn-0000p0-7J
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfk-0002N0-71
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:43 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36410)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIfj-0002MD-Tx
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:13:40 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:13:41 +0300
Message-ID: <20180725121340.12867.23448.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 05/24] replay: finish record/replay before
 closing the disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

After recent updates block devices cannot be closed on qemu exit.
This happens due to the block request polling when replay is not finished.
Therefore now we stop execution recording before closing the block devices.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 replay/replay.c |    2 ++
 vl.c            |    1 +
 2 files changed, 3 insertions(+)

diff --git a/replay/replay.c b/replay/replay.c
index 8228261..58a986f 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -366,6 +366,8 @@ void replay_finish(void)
     g_free(replay_snapshot);
     replay_snapshot = NULL;
 
+    replay_mode = REPLAY_MODE_NONE;
+
     replay_finish_events();
 }
 
diff --git a/vl.c b/vl.c
index 2a6d987..e86d295 100644
--- a/vl.c
+++ b/vl.c
@@ -4653,6 +4653,7 @@ int main(int argc, char **argv, char **envp)
 
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
+    replay_finish();
 
     job_cancel_sync_all();
     bdrv_close_all();
