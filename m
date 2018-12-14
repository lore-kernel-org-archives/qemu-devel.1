Received: from eggs.gnu.org ([2001:4830:134:3::10]:38393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofi-00005F-Vk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofi-0004R6-5Y
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofh-0004QX-Pc
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so16399604wmh.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:05 +0000
Message-Id: <20181214144214.1260-14-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/22] hw/block/tc58128.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-8-peter.maydell@linaro.org
---
 hw/block/tc58128.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 808ad76ba60..d0fae248dcc 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -38,7 +38,8 @@ static void init_dev(tc58128_dev * dev, const char *filename)
     memset(dev->flash_contents, 0xff, FLASH_SIZE);
     if (filename) {
 	/* Load flash image skipping the first block */
-	ret = load_image(filename, dev->flash_contents + 528 * 32);
+        ret = load_image_size(filename, dev->flash_contents + 528 * 32,
+                              FLASH_SIZE - 528 * 32);
 	if (ret < 0) {
             if (!qtest_enabled()) {
                 error_report("Could not load flash image %s", filename);
-- 
2.19.2
