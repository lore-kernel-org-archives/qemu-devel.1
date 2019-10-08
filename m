Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C5C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2167A20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnoU-000674-6C
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iHnkB-0001ru-C9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iHnkA-0001UY-9c
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iHnkA-0001U7-4Y; Tue, 08 Oct 2019 07:33:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F6C444BD1;
 Tue,  8 Oct 2019 11:33:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA9A160BE0;
 Tue,  8 Oct 2019 11:33:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
Date: Tue,  8 Oct 2019 07:33:17 -0400
Message-Id: <20191008113318.7012-3-imammedo@redhat.com>
In-Reply-To: <20191008113318.7012-1-imammedo@redhat.com>
References: <20191008113318.7012-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 08 Oct 2019 11:33:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, hpoussin@reactos.org,
 qemu-ppc@nongnu.org, rth@twiddle.net, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rs6000mc_realize() violates memory_region_allocate_system_memory() contract
by calling it multiple times which could break -mem-path. Replace it with
plain memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/rs6000_mc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index df7c0006fc..66b14db5fa 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -144,6 +144,7 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     RS6000MCState *s = RS6000MC_DEVICE(dev);
     int socket = 0;
     unsigned int ram_size = s->ram_size / MiB;
+    Error *local_err = NULL;
 
     while (socket < 6) {
         if (ram_size >= 64) {
@@ -165,19 +166,21 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
         if (s->simm_size[socket]) {
             char name[] = "simm.?";
             name[5] = socket + '0';
-            memory_region_allocate_system_memory(&s->simm[socket], OBJECT(dev),
-                                                 name,
-                                                 s->simm_size[socket] * MiB);
+            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
+                                   s->simm_size[socket] * MiB, &local_err);
+            if (local_err) {
+                goto out;
+            }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
         }
     }
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
-        error_setg(errp, "RAM size incompatible with this board. "
+        error_setg(&local_err, "RAM size incompatible with this board. "
                    "Try again with something else, like %" PRId64 " MB",
                    s->ram_size / MiB - ram_size);
-        return;
+        goto out;
     }
 
     if (s->autoconfigure) {
@@ -193,6 +196,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
 
     isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
                              rs6000mc_port_list, s, "rs6000mc");
+out:
+    error_propagate(errp, local_err);
 }
 
 static const VMStateDescription vmstate_rs6000mc = {
-- 
2.18.1


