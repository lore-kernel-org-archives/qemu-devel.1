Received: from eggs.gnu.org ([209.51.188.92]:40676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44P-0001F7-Dg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44M-0003IQ-Sr
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44J-0003Av-4n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rPm122274
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8pqf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:56 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:54 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:58 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-25-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/97] vnc: fix memleak of the
 "vnc-worker-output" name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Wu <peter@lekensteyn.nl>, Gerd Hoffmann <kraxel@redhat.com>

From: Peter Wu <peter@lekensteyn.nl>

Fixes repeated memory leaks of 18 bytes when using VNC:

    Direct leak of 831024 byte(s) in 46168 object(s) allocated from:
        ...
        #4 0x7f6d2f919bdd in g_strdup_vprintf glib/gstrfuncs.c:514
        #5 0x56085cdcf660 in buffer_init util/buffer.c:59
        #6 0x56085ca6a7ec in vnc_async_encoding_start ui/vnc-jobs.c:177
        #7 0x56085ca6b815 in vnc_worker_thread_loop ui/vnc-jobs.c:240

Fixes: 543b95801f98 ("vnc: attach names to buffers")
Cc: Gerd Hoffmann <kraxel@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180807221830.3844-1-peter@lekensteyn.nl
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 0ae0b069aa8f23a138cc6d2d83edaa5c22f948a5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/vnc-jobs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index b0b15d42a8..929391f85d 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, =
VncState *local)
=20
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
+    buffer_free(&local->output);
     orig->tight =3D local->tight;
     orig->zlib =3D local->zlib;
     orig->hextile =3D local->hextile;
@@ -278,7 +279,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
         /* Copy persistent encoding data */
         vnc_async_encoding_end(job->vs, &vs);
=20
-	qemu_bh_schedule(job->vs->bh);
+        qemu_bh_schedule(job->vs->bh);
     }  else {
         buffer_reset(&vs.output);
         /* Copy persistent encoding data */
--=20
2.17.1
