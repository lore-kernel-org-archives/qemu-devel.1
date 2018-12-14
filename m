Received: from eggs.gnu.org ([2001:4830:134:3::10]:38381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofh-0008VU-Pr
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofg-0004QN-Mo
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofg-0004Pt-FC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id f81so6003708wmd.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.30
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:04 +0000
Message-Id: <20181214144214.1260-13-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/22] hw/i386/multiboot.c: Don't use
 load_image()
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

While we are converting the code, add the missing error check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-7-peter.maydell@linaro.org
---
 hw/i386/multiboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 1a4344f5fc3..62340687e8e 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -343,7 +343,11 @@ int load_multiboot(FWCfgState *fw_cfg,
             mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_mod_length + mbs.mb_buf_size);
             mbs.mb_buf = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
 
-            load_image(one_file, (unsigned char *)mbs.mb_buf + offs);
+            if (load_image_size(one_file, (unsigned char *)mbs.mb_buf + offs,
+                                mbs.mb_buf_size - offs) < 0) {
+                error_report("Error loading file '%s'", one_file);
+                exit(1);
+            }
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
 
-- 
2.19.2
