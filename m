Received: from eggs.gnu.org ([2001:4830:134:3::10]:35636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7h-0008DX-P5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7f-000157-3G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7e-00014M-Ts
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:15 -0400
Received: by mail-wm0-x232.google.com with SMTP id i127so140860454wma.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:50 +0100
Message-Id: <20170704144859.17644-3-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 02/11] reginfo.c: always return 1 on
 OP_TESTEND
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

In the master/apprentice setup the response byte of 1 is returned by
write_fn. However when tracing it will happily report 0 as it
successfully writes the last bytes. To avoid running of the end when
tracing we just always return 1 at this point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 reginfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/reginfo.c b/reginfo.c
index d9d37b3..76f24f9 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -39,7 +39,10 @@ int send_register_info(write_fn write_fn, void *uc)
 
     switch (op) {
     case OP_TESTEND:
-        return write_fn(&ri, sizeof(ri));
+        write_fn(&ri, sizeof(ri));
+        /* if we are tracing write_fn will return 0 unlike a remote
+           end, hence we force return of 1 here */
+        return 1;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
-- 
2.13.0
