Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHho-00037e-9V
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhn-0003vn-7X
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:32 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQHhn-0003vW-1q
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:31 -0500
Received: by mail-pg0-x244.google.com with SMTP id 194so4901275pgd.0
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:56:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  8 Jan 2017 09:56:20 -0800
Message-Id: <20170108175620.6605-12-rth@twiddle.net>
In-Reply-To: <20170108175620.6605-1-rth@twiddle.net>
References: <20170108175620.6605-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/11] translate-all: Avoid -Werror=switch-bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

gcc 5.3.0 diagnoses

translate-all.c: In function ‘alloc_code_gen_buffer’:
translate-all.c:756:17: error: switch condition has boolean value
         switch (buf2 != MAP_FAILED) {
                 ^

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translate-all.c b/translate-all.c
index 3dd9214..2026293 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -753,7 +753,7 @@ static inline void *alloc_code_gen_buffer(void)
         size_t size2;
         void *buf2 = mmap(NULL, size + qemu_real_host_page_size,
                           PROT_NONE, flags, -1, 0);
-        switch (buf2 != MAP_FAILED) {
+        switch ((int)(buf2 != MAP_FAILED)) {
         case 1:
             if (!cross_256mb(buf2, size)) {
                 /* Success!  Use the new buffer.  */
-- 
2.9.3
