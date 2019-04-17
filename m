Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB191C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF512073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF512073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGq4V-0008AM-QO
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:18:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptR-0007g6-DS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptQ-0003cJ-9T
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGptP-0003au-U0
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26D2CC007344
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12054608C2;
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 079AA1132A03; Wed, 17 Apr 2019 21:06:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:33 +0200
Message-Id: <20190417190641.26814-8-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-1-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 17 Apr 2019 19:06:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/15] vfio: Report warnings with
 warn_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417190633.R0k27-X_S0jBeTgrnlYulqFZBB0ukDuNFu73J3vRqxg@z>

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/vfio/pci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 504019c458..0142819ea6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
         if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
-            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
-                         vdev->vbasedev.name);
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified romfile\n");
         }
         return;
     }
@@ -973,11 +975,16 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 
     if (vfio_blacklist_opt_rom(vdev)) {
         if (dev->opts && qemu_opt_get(dev->opts, "rombar")) {
-            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified non zero value for rombar\n",
-                         vdev->vbasedev.name);
+            warn_report("Device at %s is known to cause system instability"
+                        " issues during option rom execution",
+                        vdev->vbasedev.name);
+            error_printf("Proceeding anyway since user specified"
+                         " non zero value for rombar\n");
         } else {
-            error_printf("Warning : Rom loading for device at %s has been disabled due to system instability issues. Specify rombar=1 or romfile to force\n",
-                         vdev->vbasedev.name);
+            warn_report("Rom loading for device at %s has been disabled"
+                        " due to system instability issues",
+                        vdev->vbasedev.name);
+            error_printf("Specify rombar=1 or romfile to force\n");
             return;
         }
     }
-- 
2.17.2


