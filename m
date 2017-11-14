Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQL-0000cG-Da
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQI-00076N-8v
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52826)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQI-00075u-0r
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:22 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:18:29 +0300
Message-ID: <20171114081829.27640.69432.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 21/26] replay: check return values of
 fwrite
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

This patch adds error reporting when fwrite cannot completely
save the buffer to the file.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 replay/replay-internal.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index a1a7686..1888400 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -62,7 +62,9 @@ void replay_put_array(const uint8_t *buf, size_t size)
 {
     if (replay_file) {
         replay_put_dword(size);
-        fwrite(buf, 1, size, replay_file);
+        if (fwrite(buf, 1, size, replay_file) != size) {
+            error_report("replay write error");
+        }
     }
 }
 
