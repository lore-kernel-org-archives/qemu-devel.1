Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5FS-0007sy-A8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5FR-0005aM-Da
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:22 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG5FR-0005ZN-6w
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:09:21 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 7so122366400wmo.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:09:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 31 May 2017 16:09:33 +0100
Message-Id: <20170531150933.10156-3-alex.bennee@linaro.org>
In-Reply-To: <20170531150933.10156-1-alex.bennee@linaro.org>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The thread-id of 0 means any CPU but we then ignore the fact we find
the first_cpu in this case who can have an index of 0. Instead of
bailing out just test if we have managed to match up thread-id to a
CPU.

Otherwise you get:
  gdb_handle_packet: command='vCont;C04:0;c'
  put_packet: reply='E22'

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a249846954..29c9ed3002 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
              * CPU first, and only then we can use its index.
              */
             cpu = find_cpu(idx);
-            /* invalid CPU/thread specified */
-            if (!idx || !cpu) {
+            /* invalid thread specified, cpu not found. */
+            if (!cpu) {
                 res = -EINVAL;
                 goto out;
             }
-- 
2.13.0
