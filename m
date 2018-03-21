Received: from eggs.gnu.org ([2001:4830:134:3::10]:45187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyc3P-0000Og-EV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyc3K-0001hx-Qx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:37:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eyc3K-0001hB-Nq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:37:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74D80406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:36:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:36:44 +0100
Message-Id: <20180321113644.21899-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: fix pfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fix leak spotted by ASAN:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7fe1abb80a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7fe1aaf1bf75 in g_malloc0 ../glib/gmem.c:124
    #2 0x7fe1aaf1c249 in g_malloc0_n ../glib/gmem.c:355
    #3 0x55f4841cfaa9 in postcopy_ram_fault_thread /home/elmarco/src/qemu=
/migration/postcopy-ram.c:596
    #4 0x55f48479447b in qemu_thread_start /home/elmarco/src/qemu/util/qe=
mu-thread-posix.c:504
    #5 0x7fe1a043550a in start_thread (/lib64/libpthread.so.0+0x750a)

Regression introduced with commit 00fa4fc85b00f1a8a810068d158a7a66e88658e=
b.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/postcopy-ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index efd77939af..4a0b33b373 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -754,6 +754,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
     }
     trace_postcopy_ram_fault_thread_exit();
+    g_free(pfd);
     return NULL;
 }
=20
--=20
2.16.2.521.g9aa15f885a
