Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVV-0004vB-Df
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVR-0006J1-G0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:53 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVR-0006I1-8Q
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:49 -0500
Received: by mail-wm0-x233.google.com with SMTP id x7so22123961wmc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:08 +0100
Message-Id: <1520342370-123606-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/34] ahci-test: fix opts leak of skip tests
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

Fixes the following ASAN report:

Direct leak of 128 byte(s) in 8 object(s) allocated from:
    #0 0x7fefce311850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7fefcdd5ef0c in g_malloc ../glib/gmem.c:94
    #2 0x559b976faff0 in create_ahci_io_test /home/elmarco/src/qemu/tests/ahci-test.c:1810

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/ahci-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 2342fe3..fb3cd84 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1823,6 +1823,7 @@ static void create_ahci_io_test(enum IOMode type, enum AddrMode addr,
     if ((addr == ADDR_MODE_LBA48) && (offset == OFFSET_HIGH) &&
         (mb_to_sectors(test_image_size_mb) <= 0xFFFFFFF)) {
         g_test_message("%s: skipped; test image too small", name);
+        g_free(opts);
         g_free(name);
         return;
     }
-- 
1.8.3.1
