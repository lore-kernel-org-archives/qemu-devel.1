Received: from eggs.gnu.org ([2001:4830:134:3::10]:44238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1essGb-0000FL-Gg
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1essGY-0007Iy-Qm
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:43:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1essGY-0007IC-Lq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:43:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F4E484221
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 15:43:02 +0000 (UTC)
From: mrezanin@redhat.com
Date: Mon,  5 Mar 2018 16:42:55 +0100
Message-Id: <1520264575-26506-1-git-send-email-mrezanin@redhat.com>
Subject: [Qemu-devel] [PATCH] Use CONFIG_VHOST_USER_SCSI to enable
 vhost-scsi-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Miroslav Rezanina <mrezanin@redhat.com>

From: Miroslav Rezanina <mrezanin@redhat.com>

Currently, "defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)"
is used to enable/disable vhost-scsi-pci build as this condition
is used to enable/disable CONFIG_VHOST_USER_SCSI too.

However, when CONFIG_VHOST_USER_SCSI is manually disable vhost-scsi-pci
is still registered although it should be disabled.

Changing condition to use CONFIG_VHOST_USER_SCSI so vhost-scsi-pci
can be controled by CONFIG_VHOST_USER_SCSI option.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1e8ab7b..df59d6b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2163,7 +2163,7 @@ static const TypeInfo vhost_scsi_pci_info = {
 };
 #endif
 
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+#if defined(CONFIG_VHOST_USER_SCSI)
 /* vhost-user-scsi-pci */
 static Property vhost_user_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
@@ -2696,7 +2696,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+#if defined(CONFIG_VHOST_USER_SCSI)
     type_register_static(&vhost_user_scsi_pci_info);
 #endif
 #ifdef CONFIG_VHOST_VSOCK
-- 
1.8.3.1
