Received: from eggs.gnu.org ([2001:4830:134:3::10]:41724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYq-0007TI-8b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYm-00058a-BH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:48 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:38255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYm-00054s-1T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:44 -0500
Received: by mail-wr0-x22f.google.com with SMTP id x1so857527wrb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:44 +0100
Message-Id: <1515756676-3860-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/52] crypto: fix stack-buffer-overflow error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

ASAN complains about:

==8856==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffd8a1fe168 at pc 0x561136cb4451 bp 0x7ffd8a1fe130 sp 0x7ffd8a1fd8e0
READ of size 16 at 0x7ffd8a1fe168 thread T0
    #0 0x561136cb4450 in __asan_memcpy (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x110450)
    #1 0x561136d2a6a7 in qcrypto_ivgen_essiv_calculate /home/elmarco/src/qq/crypto/ivgen-essiv.c:83:5
    #2 0x561136d29af8 in qcrypto_ivgen_calculate /home/elmarco/src/qq/crypto/ivgen.c:72:12
    #3 0x561136d07c8e in test_ivgen /home/elmarco/src/qq/tests/test-crypto-ivgen.c:148:5
    #4 0x7f77772c3b04 in test_case_run /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2237
    #5 0x7f77772c3ec4 in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2321
    #6 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
    #7 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
    #8 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
    #9 0x7f77772c4184 in g_test_run_suite /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2408
    #10 0x7f77772c2e0d in g_test_run /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:1674
    #11 0x561136d0799b in main /home/elmarco/src/qq/tests/test-crypto-ivgen.c:173:12
    #12 0x7f77756e6039 in __libc_start_main (/lib64/libc.so.6+0x21039)
    #13 0x561136c13d89 in _start (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x6fd89)

Address 0x7ffd8a1fe168 is located in stack of thread T0 at offset 40 in frame
    #0 0x561136d2a40f in qcrypto_ivgen_essiv_calculate /home/elmarco/src/qq/crypto/ivgen-essiv.c:76

  This frame has 1 object(s):
    [32, 40) 'sector.addr' <== Memory access at offset 40 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x110450) in __asan_memcpy
Shadow bytes around the buggy address:
  0x100031437bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x100031437c20: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00[f3]f3 f3
  0x100031437c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb

It looks like the rest of the code copes with ndata being larger than
sizeof(sector), so limit the memcpy() range.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180104160523.22995-13-marcandre.lureau@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 crypto/ivgen-essiv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index cba20bd..ad4d926 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -79,7 +79,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
     uint8_t *data = g_new(uint8_t, ndata);
 
     sector = cpu_to_le64(sector);
-    memcpy(data, (uint8_t *)&sector, ndata);
+    memcpy(data, (uint8_t *)&sector, MIN(sizeof(sector), ndata));
     if (sizeof(sector) < ndata) {
         memset(data + sizeof(sector), 0, ndata - sizeof(sector));
     }
-- 
1.8.3.1
