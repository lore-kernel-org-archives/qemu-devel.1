Received: from eggs.gnu.org ([209.51.188.92]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grhJq-0004eC-At
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grhJp-00089Q-IH
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:10 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grhJn-00087R-Ga
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:54:08 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Feb 2019 11:53:46 +0100
Message-Id: <20190207105347.22337-3-laurent@vivier.eu>
In-Reply-To: <20190207105347.22337-1-laurent@vivier.eu>
References: <20190207105347.22337-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] linux-user: Check sscanf return value in
 open_net_route()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity warns (CID 1390634) that open_net_route() is not
checking the return value from sscanf(), which means that
it might then use values that aren't initialized.

Errors here should in general not happen since we're passing
an assumed-good /proc/net/route from the host kernel, but
if we do fail to parse a line then just skip it in the output
we pass to the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190205174207.9278-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5b9d75fbb4..a69c734aa0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6767,9 +6767,15 @@ static int open_net_route(void *cpu_env, int fd)
         char iface[16];
         uint32_t dest, gw, mask;
         unsigned int flags, refcnt, use, metric, mtu, window, irtt;
-        sscanf(line, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
-                     iface, &dest, &gw, &flags, &refcnt, &use, &metric,
-                     &mask, &mtu, &window, &irtt);
+        int fields;
+
+        fields = sscanf(line,
+                        "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
+                        iface, &dest, &gw, &flags, &refcnt, &use, &metric,
+                        &mask, &mtu, &window, &irtt);
+        if (fields != 11) {
+            continue;
+        }
         dprintf(fd, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
                 iface, tswap32(dest), tswap32(gw), flags, refcnt, use,
                 metric, tswap32(mask), mtu, window, irtt);
-- 
2.20.1
