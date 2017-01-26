Received: from eggs.gnu.org ([2001:4830:134:3::10]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGP-0003ZN-6u
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGK-00053X-77
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42572)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjGJ-00053P-VT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:48 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 26 Jan 2017 15:34:51 +0300
Message-ID: <20170126123451.5412.95683.stgit@PASHA-ISP>
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 7/9] replay: disable default snapshot for
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 vl.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index def0520..bddb2bc 100644
--- a/vl.c
+++ b/vl.c
@@ -3198,7 +3198,13 @@ int main(int argc, char **argv, char **envp)
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
