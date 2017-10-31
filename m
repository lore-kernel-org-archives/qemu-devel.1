Received: from eggs.gnu.org ([2001:4830:134:3::10]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UhB-0004F3-1h
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Uh5-0000k3-FX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:01 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45408)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Uh5-0000jp-7z
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:55 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:55 +0300
Message-ID: <20171031112655.10516.5241.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 21/26] replay: check return values of fwrite
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
index d036a02..0f73fdc 100644
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
 
