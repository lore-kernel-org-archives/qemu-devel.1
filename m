Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJo9-00015S-GU
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJo5-0002Qn-J3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:46:01 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42284)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fBJo5-0002PX-Ag
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:45:57 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Apr 2018 15:45:45 +0300
Message-ID: <20180425124545.17182.52891.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 02/17] replay: disable default snapshot for
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 vl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index fce1fd1..ca4239c 100644
--- a/vl.c
+++ b/vl.c
@@ -3226,7 +3226,13 @@ int main(int argc, char **argv, char **envp)
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
@@ -4529,7 +4535,7 @@ int main(int argc, char **argv, char **envp)
         qapi_free_BlockdevOptions(bdo->bdo);
         g_free(bdo);
     }
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+    if (snapshot) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
