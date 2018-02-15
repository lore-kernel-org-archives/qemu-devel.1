Received: from eggs.gnu.org ([2001:4830:134:3::10]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2h-0005tN-PJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2h-0000q7-1x
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2g-0000pq-UG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AF304023112
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:26:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:52 +0100
Message-Id: <20180215212552.26997-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] sdhci-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fix the following ASAN reports:

=3D=3D20125=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f0faea03a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7f0fae450f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x562fffd526fc in machine_start /home/elmarco/src/qemu/tests/sdhci=
-test.c:180

Indirect leak of 152 byte(s) in 1 object(s) allocated from:
    #0 0x7f0faea03850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f0fae450f0c in g_malloc ../glib/gmem.c:94
    #2 0x562fffd5d21d in qpci_init_pc /home/elmarco/src/qemu/tests/libqos=
/pci-pc.c:122

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/sdhci-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 493023fd0c..8a7099398c 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -209,8 +209,10 @@ static QSDHCI *machine_start(const struct sdhci_t *t=
est)
=20
 static void machine_stop(QSDHCI *s)
 {
+    qpci_free_pc(s->pci.bus);
     g_free(s->pci.dev);
     qtest_quit(global_qtest);
+    g_free(s);
 }
=20
 static void test_machine(const void *data)
--=20
2.16.1.73.g5832b7e9f2
