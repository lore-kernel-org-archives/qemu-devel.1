Received: from eggs.gnu.org ([209.51.188.92]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4k2-0007Zj-Pg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4k0-0001Vl-Br
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:42:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4jz-0001JF-Uh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:42:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so4589227wrt.7
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:42:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:42:07 +0000
Message-Id: <20190205174207.9278-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: Check sscanf return value in
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
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Coverity warns (CID 1390634) that open_net_route() is not
checking the return value from sscanf(), which means that
it might then use values that aren't initialized.

Errors here should in general not happen since we're passing
an assumed-good /proc/net/route from the host kernel, but
if we do fail to parse a line then just skip it in the output
we pass to the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b5786d4fc1f..894678aa8b4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6762,9 +6762,15 @@ static int open_net_route(void *cpu_env, int fd)
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
