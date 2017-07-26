Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRJh-0000uz-CI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRJc-0001mW-Gd
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1daRJc-0001lo-AM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C37478ED2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:45:47 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 26 Jul 2017 12:45:44 -0600
Message-ID: <20170726184539.1315.14711.stgit@gimli.home>
In-Reply-To: <20170726184421.1315.42536.stgit@gimli.home>
References: <20170726184421.1315.42536.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] vfio/platform: fix use of freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

free the data _after_ using it.

hw/vfio/platform.c:126:29: warning: Use of memory after it is freed
        qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
                            ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 7c09deda6143..da84abf4fc4c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -120,11 +120,11 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
     *pfd =3D event_notifier_get_fd(intp->interrupt);
     qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
     ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
     if (ret < 0) {
         error_report("vfio: Failed to set trigger eventfd: %m");
         qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
     }
+    g_free(irq_set);
     return ret;
 }
=20
