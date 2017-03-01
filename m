Received: from eggs.gnu.org ([2001:4830:134:3::10]:41723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0DA-0003UI-Aq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0D9-0001i9-DG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0D9-0001hv-7d
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:06:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7118361E73
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:06:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:46 +0400
Message-Id: <20170301090453.11075-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/28] tests: fix virtio-scsi-test leak
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

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/virtio-scsi-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 69220ef07b..0eabd56fd9 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -63,7 +63,7 @@ static void qvirtio_scsi_pci_free(QVirtIOSCSI *vs)
         qvirtqueue_cleanup(vs->dev->bus, vs->vq[i], vs->qs->alloc);
     }
     qvirtio_pci_device_disable(container_of(vs->dev, QVirtioPCIDevice, v=
dev));
-    g_free(vs->dev);
+    qvirtio_pci_device_free((QVirtioPCIDevice *)vs->dev);
     qvirtio_scsi_stop(vs->qs);
     g_free(vs);
 }
--=20
2.12.0.rc2.3.gc93709801
