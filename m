Received: from eggs.gnu.org ([2001:4830:134:3::10]:35253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWOdU-0003Sl-Az
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWOdR-0001wx-Mv
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:37:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 Jan 2018 16:37:45 +0100
Message-Id: <1514907465-14530-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] crypto/ivgen-essiv: Fix problem with address
 sanitizer of Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org

When compiling QEMU with clang and -fsanitize=address, I get the
following error:

==9185==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffc7e9adf2f at pc 0x564cba001d88 bp 0x7ffc7e9adeb0 sp 0x7ffc7e9adea8
READ of size 16 at 0x7ffc7e9adf2f thread T0
    #0 0x564cba001d87 in qcrypto_ivgen_essiv_calculate .../crypto/ivgen-essiv.c:83
    #1 0x564cba001367 in qcrypto_ivgen_calculate .../crypto/ivgen.c:72
    #2 0x564cb9fec630 in test_ivgen .../tests/test-crypto-ivgen.c:148
    #3 0x7f98f4224b39 (/lib64/libglib-2.0.so.0+0x6fb39)
    #4 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
    #5 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
    #6 0x7f98f4224d02 (/lib64/libglib-2.0.so.0+0x6fd02)
    #7 0x7f98f4224f0d (/lib64/libglib-2.0.so.0+0x6ff0d)
    #8 0x7f98f4224f30 (/lib64/libglib-2.0.so.0+0x6ff30)
    #9 0x564cb9fec446 in main .../tests/test-crypto-ivgen.c:173
    #10 0x7f98f294fc04 in __libc_start_main (/lib64/libc.so.6+0x21c04)
    #11 0x564cb9fec1ac in _start (.../tests/test-crypto-ivgen+0xdb1ac)

Address 0x7ffc7e9adf2f is located in stack of thread T0 at offset 47 in frame
    #0 0x564cba00192f in qcrypto_ivgen_essiv_calculate .../crypto/ivgen-essiv.c:76

And indeed, the code is doing a "memcpy(data, (uint8_t *)&sector, ndata)"
here with "sector" being a uint64_t variable and ndata = 16.

Fix it by limiting the size of the memcpy correctly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 crypto/ivgen-essiv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index cba20bd..8944609 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -79,7 +79,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
     uint8_t *data = g_new(uint8_t, ndata);
 
     sector = cpu_to_le64(sector);
-    memcpy(data, (uint8_t *)&sector, ndata);
+    memcpy(data, (uint8_t *)&sector, MIN(ndata, sizeof(sector)));
     if (sizeof(sector) < ndata) {
         memset(data + sizeof(sector), 0, ndata - sizeof(sector));
     }
-- 
1.8.3.1
