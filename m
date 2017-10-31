Received: from eggs.gnu.org ([2001:4830:134:3::10]:50042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfU-0002gM-34
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfT-0006qt-7N
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:16 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44930)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfS-0006pe-VZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:15 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:25:15 +0300
Message-ID: <20171031112515.10516.53243.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 03/26] replay: disable default snapshot for
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 vl.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 7aa59f0..a8e0d03 100644
--- a/vl.c
+++ b/vl.c
@@ -3314,7 +3314,13 @@ int main(int argc, char **argv, char **envp)
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
