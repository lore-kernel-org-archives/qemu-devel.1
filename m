Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E3C55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CB02074B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/aewXUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CB02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaff8-0008Ee-EU
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafVz-0003uP-Nd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafVx-0004Bo-3G
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6uL0ifc3NOXN3CbpVzncRBe2N5ILAHhkVbRkNazYBs=;
 b=M/aewXUeFQBApWF/SQaFfwMaJsF0iPkTCVhxe37kMIPp7Gezwnr1Qu1wEOl/iobORabjDT
 oGwCoom/j0WlI8om3W5npZOL0BVJseaSUWH/Y2AUntGvz9MUKghLhA+GCxaJKD/cYTUrWw
 eNmS7q2Osa2FDVSZ0Gj13zZcmdXjWVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-4_vxVnc7ONCOoZ_h93DWfQ-1; Thu, 05 Nov 2020 08:41:17 -0500
X-MC-Unique: 4_vxVnc7ONCOoZ_h93DWfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C3319080B9
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 13:41:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64BC255790;
 Thu,  5 Nov 2020 13:41:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A68969B0C; Thu,  5 Nov 2020 14:41:12 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] usb-storage: add commandlog property
Date: Thu,  5 Nov 2020 14:41:08 +0100
Message-Id: <20201105134112.25119-3-kraxel@redhat.com>
In-Reply-To: <20201105134112.25119-1-kraxel@redhat.com>
References: <20201105134112.25119-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add property so scsi command logging can be switched
at runtime instead of compile time.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-storage.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index e317cde8fd48..d5cc6137443c 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -25,8 +25,6 @@
 #include "qom/object.h"
 #include "trace.h"
 
-//#define DEBUG_MSD
-
 /* USB requests.  */
 #define MassStorageReset  0xff
 #define GetMaxLun         0xfe
@@ -59,6 +57,7 @@ struct MSDState {
     /* usb-storage only */
     BlockConf conf;
     uint32_t removable;
+    bool commandlog;
     SCSIDevice *scsi_dev;
 };
 typedef struct MSDState MSDState;
@@ -451,9 +450,9 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
             assert(le32_to_cpu(s->csw.residue) == 0);
             s->scsi_len = 0;
             s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd, NULL);
-#ifdef DEBUG_MSD
-            scsi_req_print(s->req);
-#endif
+            if (s->commandlog) {
+                scsi_req_print(s->req);
+            }
             len = scsi_req_enqueue(s->req);
             if (len) {
                 scsi_req_continue(s->req);
@@ -684,6 +683,7 @@ static Property msd_properties[] = {
     DEFINE_BLOCK_PROPERTIES(MSDState, conf),
     DEFINE_BLOCK_ERROR_PROPERTIES(MSDState, conf),
     DEFINE_PROP_BIT("removable", MSDState, removable, 0, false),
+    DEFINE_PROP_BOOL("commandlog", MSDState, commandlog, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.27.0


