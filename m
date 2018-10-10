Received: from eggs.gnu.org ([2001:4830:134:3::10]:33645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZO-0001YI-Oy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZN-0002I1-Vx
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:43882)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEZN-0002HS-KU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:33 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:33:45 +0300
Message-ID: <20181010133345.24538.84595.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 02/19] replay: disable default snapshot for
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
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 vl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 4e25c78..46238d2 100644
--- a/vl.c
+++ b/vl.c
@@ -3124,7 +3124,13 @@ int main(int argc, char **argv, char **envp)
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
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
@@ -4416,7 +4422,7 @@ int main(int argc, char **argv, char **envp)
         qapi_free_BlockdevOptions(bdo->bdo);
         g_free(bdo);
     }
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+    if (snapshot) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
