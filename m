Received: from eggs.gnu.org ([2001:4830:134:3::10]:42986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRU-0005J9-QF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRU-0006lJ-2S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:40 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 28 Feb 2017 13:55:38 +0300
Message-ID: <20170228105538.1284.15548.stgit@PASHA-ISP>
In-Reply-To: <20170228105521.1284.11059.stgit@PASHA-ISP>
References: <20170228105521.1284.11059.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 3/3] replay: disable default snapshot for
 record/replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, dovgaluk@ispras.ru, qemu-block@nongnu.org, mreitz@redhat.com

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 vl.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 876a55a..1b85923 100644
--- a/vl.c
+++ b/vl.c
@@ -3140,7 +3140,13 @@ int main(int argc, char **argv, char **envp)
                 drive_add(IF_PFLASH, -1, optarg, PFLASH_OPTS);
                 break;
             case QEMU_OPTION_snapshot:
-                snapshot = 1;
+                {
+                    Error *blocker = NULL;
+                    snapshot = 1;
+                    error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED,
+                               "-snapshot");
+                    replay_add_blocker(blocker);
+                }
                 break;
             case QEMU_OPTION_hdachs:
                 {
