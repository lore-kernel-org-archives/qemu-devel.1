Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCW-0005Fw-Fu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCT-0001mu-Cl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCT-0001lx-2I
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jnk4130283
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:08 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku13k5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:07 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:07 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:45:00 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-67-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 66/67] msmouse: Fix segfault caused by free the
 chr before chardev cleanup.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Lin Ma <lma@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Lin Ma <lma@suse.com>

Segfault happens when leaving qemu with msmouse backend:

 #0  0x00007fa8526ac975 in raise () at /lib64/libc.so.6
 #1  0x00007fa8526add8a in abort () at /lib64/libc.so.6
 #2  0x0000558be78846ab in error_exit (err=16, msg=0x558be799da10 ...
 #3  0x0000558be7884717 in qemu_mutex_destroy (mutex=0x558be93be750) at ...
 #4  0x0000558be7549951 in qemu_chr_free_common (chr=0x558be93be750) at ...
 #5  0x0000558be754999c in qemu_chr_free (chr=0x558be93be750) at ...
 #6  0x0000558be7549a20 in qemu_chr_delete (chr=0x558be93be750) at ...
 #7  0x0000558be754a8ef in qemu_chr_cleanup () at qemu-char.c:4643
 #8  0x0000558be755843e in main (argc=5, argv=0x7ffe925d7118, ...

The chr was freed by msmouse close callback before chardev cleanup,
Then qemu_mutex_destroy triggered raise().

Because freeing chr is handled by qemu_chr_free_common, Remove the free from
msmouse_chr_close to avoid double free.

Fixes: c1111a24a3358ecd2f17be7c8b117cfe8bc5e5f8
Cc: qemu-stable@nongnu.org
Signed-off-by: Lin Ma <lma@suse.com>
Message-Id: <20160915143158.4796-1-lma@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9e14037f05e99ca3b8a33d8be9a2a636bbf09326)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 backends/msmouse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/backends/msmouse.c b/backends/msmouse.c
index aceb6dc..85d08f7 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -139,7 +139,6 @@ static void msmouse_chr_close (struct CharDriverState *chr)
 
     qemu_input_handler_unregister(mouse->hs);
     g_free(mouse);
-    g_free(chr);
 }
 
 static QemuInputHandler msmouse_handler = {
-- 
1.9.1
