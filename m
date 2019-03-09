Received: from eggs.gnu.org ([209.51.188.92]:47407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wik-0003wK-9a
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wij-0000af-Bn
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:38 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wij-0000Zs-4e
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:37 -0500
Received: by mail-wr1-x433.google.com with SMTP id n2so23650011wrw.8
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:10 +0100
Message-Id: <1552117698-12355-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/25] oslib-posix: Ignore fcntl("/dev/null",
 F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Previous to OpenBSD 6.3 [1], fcntl(F_SETFL) is not permitted on
memory devices.
Trying this call sets errno to ENODEV ("not a memory device"):

  19 ENODEV Operation not supported by device.
    An attempt was made to apply an inappropriate function to a device,
    for example, trying to read a write-only device such as a printer.

Do not assert fcntl failures in this specific case (errno set to ENODEV)
on OpenBSD. This fixes:

  $ lm32-softmmu/qemu-system-lm32
  assertion "f != -1" failed: file "util/oslib-posix.c", line 247, function "qemu_set_nonblock"
  Abort trap (core dumped)

[1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
  "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
  the memory devices (/dev/null, /dev/zero, etc) need to permit them."

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
Message-Id: <20190307142822.8531-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/oslib-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 37c5854..326d92d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -244,7 +244,19 @@ void qemu_set_nonblock(int fd)
     f = fcntl(fd, F_GETFL);
     assert(f != -1);
     f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
+#ifdef __OpenBSD__
+    if (f == -1) {
+        /*
+         * Previous to OpenBSD 6.3, fcntl(F_SETFL) is not permitted on
+         * memory devices and sets errno to ENODEV.
+         * It's OK if we fail to set O_NONBLOCK on devices like /dev/null,
+         * because they will never block anyway.
+         */
+        assert(errno == ENODEV);
+    }
+#else
     assert(f != -1);
+#endif
 }
 
 int socket_set_fast_reuse(int fd)
-- 
1.8.3.1
