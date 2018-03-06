Received: from eggs.gnu.org ([2001:4830:134:3::10]:48094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVT-0004sm-RI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVS-0006KL-T0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:51 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVS-0006Jb-Lv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:50 -0500
Received: by mail-wr0-x230.google.com with SMTP id z12so20914602wrg.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:09 +0100
Message-Id: <1520342370-123606-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/34] sdhci-test: fix leaks
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

Fix the following ASAN reports:

==20125==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f0faea03a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
    #1 0x7f0fae450f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x562fffd526fc in machine_start /home/elmarco/src/qemu/tests/sdhci-test.c:180

Indirect leak of 152 byte(s) in 1 object(s) allocated from:
    #0 0x7f0faea03850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f0fae450f0c in g_malloc ../glib/gmem.c:94
    #2 0x562fffd5d21d in qpci_init_pc /home/elmarco/src/qemu/tests/libqos/pci-pc.c:122

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/sdhci-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 6b3a532..1d825eb 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -209,8 +209,10 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
 
 static void machine_stop(QSDHCI *s)
 {
+    qpci_free_pc(s->pci.bus);
     g_free(s->pci.dev);
     qtest_quit(global_qtest);
+    g_free(s);
 }
 
 static void test_machine(const void *data)
-- 
1.8.3.1
