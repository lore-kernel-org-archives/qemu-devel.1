Received: from eggs.gnu.org ([2001:4830:134:3::10]:42808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3l-0002um-Jx
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008N9-OU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008Mq-Ka
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0F511599FD
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 13:57:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Mar 2018 14:57:29 +0100
Message-Id: <20180329135730.95774-2-dgilbert@redhat.com>
In-Reply-To: <20180329135730.95774-1-dgilbert@redhat.com>
References: <20180329135730.95774-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] migration: fix pfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, quintela@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20180321113644.21899-1-marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.14.3
