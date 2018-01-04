Received: from eggs.gnu.org ([2001:4830:134:3::10]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84v-0000hW-Kh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84r-0005YF-Vv
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX84r-0005XM-N2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E801C5B2FD
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:09:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:17 +0100
Message-Id: <20180104160523.22995-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/18] crypto: fix stack-buffer-overflow
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

ASAN complains about:

=3D=3D8856=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address=
 0x7ffd8a1fe168 at pc 0x561136cb4451 bp 0x7ffd8a1fe130 sp 0x7ffd8a1fd8e0
READ of size 16 at 0x7ffd8a1fe168 thread T0
    #0 0x561136cb4450 in __asan_memcpy (/home/elmarco/src/qq/build/tests/=
test-crypto-ivgen+0x110450)
    #1 0x561136d2a6a7 in qcrypto_ivgen_essiv_calculate /home/elmarco/src/=
qq/crypto/ivgen-essiv.c:83:5
    #2 0x561136d29af8 in qcrypto_ivgen_calculate /home/elmarco/src/qq/cry=
pto/ivgen.c:72:12
    #3 0x561136d07c8e in test_ivgen /home/elmarco/src/qq/tests/test-crypt=
o-ivgen.c:148:5
    #4 0x7f77772c3b04 in test_case_run /home/elmarco/src/gnome/glib/build=
dir/../glib/gtestutils.c:2237
    #5 0x7f77772c3ec4 in g_test_run_suite_internal /home/elmarco/src/gnom=
e/glib/builddir/../glib/gtestutils.c:2321
    #6 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnom=
e/glib/builddir/../glib/gtestutils.c:2333
    #7 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnom=
e/glib/builddir/../glib/gtestutils.c:2333
    #8 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnom=
e/glib/builddir/../glib/gtestutils.c:2333
    #9 0x7f77772c4184 in g_test_run_suite /home/elmarco/src/gnome/glib/bu=
ilddir/../glib/gtestutils.c:2408
    #10 0x7f77772c2e0d in g_test_run /home/elmarco/src/gnome/glib/builddi=
r/../glib/gtestutils.c:1674
    #11 0x561136d0799b in main /home/elmarco/src/qq/tests/test-crypto-ivg=
en.c:173:12
    #12 0x7f77756e6039 in __libc_start_main (/lib64/libc.so.6+0x21039)
    #13 0x561136c13d89 in _start (/home/elmarco/src/qq/build/tests/test-c=
rypto-ivgen+0x6fd89)

Address 0x7ffd8a1fe168 is located in stack of thread T0 at offset 40 in f=
rame
    #0 0x561136d2a40f in qcrypto_ivgen_essiv_calculate /home/elmarco/src/=
qq/crypto/ivgen-essiv.c:76

  This frame has 1 object(s):
    [32, 40) 'sector.addr' <=3D=3D Memory access at offset 40 overflows t=
his variable
HINT: this may be a false positive if your program uses some custom stack=
 unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow (/home/elmarco/src/qq/bu=
ild/tests/test-crypto-ivgen+0x110450) in __asan_memcpy
Shadow bytes around the buggy address:
  0x100031437bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100031437c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x100031437c20: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00[f3]f3 f3
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/ivgen-essiv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index cba20bde6c..ad4d926c19 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -79,7 +79,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *=
ivgen,
     uint8_t *data =3D g_new(uint8_t, ndata);
=20
     sector =3D cpu_to_le64(sector);
-    memcpy(data, (uint8_t *)&sector, ndata);
+    memcpy(data, (uint8_t *)&sector, MIN(sizeof(sector), ndata));
     if (sizeof(sector) < ndata) {
         memset(data + sizeof(sector), 0, ndata - sizeof(sector));
     }
--=20
2.15.1.355.g36791d7216
