Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE08C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B68320720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCIKLLRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B68320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIc6-0004jW-QF
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIb3-00033s-BW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIb1-0005VG-JM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qWpc9lIScV+M2rFXmNrjrCgZvcXIh2hCmScus9pENU=;
 b=HCIKLLRCgpGDT7/8Bpvt97pbB7QkYEz5bOncvjVovOat9OktUSIhgwf56x0B/Ro/xmG0WT
 vcTetZN/foW/nwdAK3fT1alOb4LmJc5cEiFy9Irs/K3ZR1eavsagHXVkI7EZzbAg/xZcqQ
 MLml6is7AjBuZABjfAEPAdpUniDy5gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-AVrlznyIPqu0wZoo9QZQaw-1; Fri, 03 Jul 2020 06:07:00 -0400
X-MC-Unique: AVrlznyIPqu0wZoo9QZQaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A873186A200;
 Fri,  3 Jul 2020 10:06:59 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1EE17923E;
 Fri,  3 Jul 2020 10:06:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/14] pc-bios: s390x: cio.c cleanup and compile fix
Date: Fri,  3 Jul 2020 12:06:37 +0200
Message-Id: <20200703100650.621212-2-cohuck@redhat.com>
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's initialize the structs at the beginning to ease reading and also
zeroing all other fields. This also makes the compiler stop
complaining about sense_id_ccw.flags being ored into when it's not
initialized.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200624075226.92728-2-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 339ec5fbe7a4..83ca27ab41d2 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -49,13 +49,13 @@ void enable_subchannel(SubChannelId schid)
 
 uint16_t cu_type(SubChannelId schid)
 {
-    Ccw1 sense_id_ccw;
     SenseId sense_data;
-
-    sense_id_ccw.cmd_code = CCW_CMD_SENSE_ID;
-    sense_id_ccw.cda = ptr2u32(&sense_data);
-    sense_id_ccw.count = sizeof(sense_data);
-    sense_id_ccw.flags |= CCW_FLAG_SLI;
+    Ccw1 sense_id_ccw = {
+        .cmd_code = CCW_CMD_SENSE_ID,
+        .flags = CCW_FLAG_SLI,
+        .count = sizeof(sense_data),
+        .cda = ptr2u32(&sense_data),
+    };
 
     if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
         panic("Failed to run SenseID CCw\n");
@@ -67,13 +67,13 @@ uint16_t cu_type(SubChannelId schid)
 int basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
                  uint16_t data_size)
 {
-    Ccw1 senseCcw;
+    Ccw1 senseCcw = {
+        .cmd_code = CCW_CMD_BASIC_SENSE,
+        .count = data_size,
+        .cda = ptr2u32(sense_data),
+    };
     Irb irb;
 
-    senseCcw.cmd_code = CCW_CMD_BASIC_SENSE;
-    senseCcw.cda = ptr2u32(sense_data);
-    senseCcw.count = data_size;
-
     return __do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1, &irb);
 }
 
@@ -314,7 +314,17 @@ static void print_irb_err(Irb *irb)
  */
 static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
 {
-    CmdOrb orb = {};
+    /*
+     * QEMU's CIO implementation requires prefetch and 64-bit idaws. We
+     * allow all paths.
+     */
+    CmdOrb orb = {
+        .fmt = fmt,
+        .pfch = 1,
+        .c64 = 1,
+        .lpm = 0xFF,
+        .cpa = ccw_addr,
+    };
     int rc;
 
     IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
@@ -324,12 +334,6 @@ static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
         IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
     }
 
-    orb.fmt = fmt;
-    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
-    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
-    orb.lpm = 0xFF; /* All paths allowed */
-    orb.cpa = ccw_addr;
-
     rc = ssch(schid, &orb);
     if (rc == 1 || rc == 2) {
         /* Subchannel status pending or busy. Eat status and ask for retry. */
-- 
2.25.4


