Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93DFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F11F2065C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGfT2y4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F11F2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4xY-0005cu-1k
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WW-0002xk-Vz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WO-0002jF-Ad
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0UUOtrq1fQ0NSBTSHvIDAywl8g3kvLSProVYS7MmD4=;
 b=gGfT2y4jBbrDMj/S73q5OPhFlGSIfjt7SaC5fj2SEzWmXet2Hg03JJYvIaJZfdN7OozLSS
 E2ULrL4emqfg2PyIuM4Jih4gaAcyWYOfp3xc2maeHrBmBQkFKCocaEppVeJoEMv0yMTsBI
 jymjN9Dss0ZRfiyk7VCAqvUAwtgcEgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-FvfBYzduOb-UUsAdC_mDiw-1; Mon, 12 Oct 2020 16:34:12 -0400
X-MC-Unique: FvfBYzduOb-UUsAdC_mDiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5CA685B686
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:34:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 643476EF59;
 Mon, 12 Oct 2020 20:34:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] scsi/scsi_bus: fix races in REPORT LUNS
Date: Mon, 12 Oct 2020 16:33:42 -0400
Message-Id: <20201012203343.1105018-38-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently scsi_target_emulate_report_luns iterates over the child device list
twice, and there is no guarantee that this list is the same in both iterations.

The reason for iterating twice is that the first iteration calculates
how much memory to allocate.  However if we use a dynamic array we can
avoid iterating twice, and therefore we avoid this race.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1866707

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-10-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201006123904.610658-14-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 68 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index eda8cb7e70..b901e701f0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -438,19 +438,23 @@ struct SCSITargetReq {
 static void store_lun(uint8_t *outbuf, int lun)
 {
     if (lun < 256) {
+        /* Simple logical unit addressing method*/
+        outbuf[0] = 0;
         outbuf[1] = lun;
-        return;
+    } else {
+        /* Flat space addressing method */
+        outbuf[0] = 0x40 | (lun >> 8);
+        outbuf[1] = (lun & 255);
     }
-    outbuf[1] = (lun & 255);
-    outbuf[0] = (lun >> 8) | 0x40;
 }
 
 static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
 {
     BusChild *kid;
-    int i, len, n;
     int channel, id;
-    bool found_lun0;
+    uint8_t tmp[8] = {0};
+    int len = 0;
+    GByteArray *buf;
 
     if (r->req.cmd.xfer < 16) {
         return false;
@@ -458,46 +462,40 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     if (r->req.cmd.buf[2] > 2) {
         return false;
     }
+
+    /* reserve space for 63 LUNs*/
+    buf = g_byte_array_sized_new(512);
+
     channel = r->req.dev->channel;
     id = r->req.dev->id;
-    found_lun0 = false;
-    n = 0;
 
-    RCU_READ_LOCK_GUARD();
+    /* add size (will be updated later to correct value */
+    g_byte_array_append(buf, tmp, 8);
+    len += 8;
 
-    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
+    /* add LUN0 */
+    g_byte_array_append(buf, tmp, 8);
+    len += 8;
 
-        if (dev->channel == channel && dev->id == id) {
-            if (dev->lun == 0) {
-                found_lun0 = true;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
+            DeviceState *qdev = kid->child;
+            SCSIDevice *dev = SCSI_DEVICE(qdev);
+
+            if (dev->channel == channel && dev->id == id && dev->lun != 0) {
+                store_lun(tmp, dev->lun);
+                g_byte_array_append(buf, tmp, 8);
+                len += 8;
             }
-            n += 8;
         }
     }
-    if (!found_lun0) {
-        n += 8;
-    }
-
-    scsi_target_alloc_buf(&r->req, n + 8);
-
-    len = MIN(n + 8, r->req.cmd.xfer & ~7);
-    memset(r->buf, 0, len);
-    stl_be_p(&r->buf[0], n);
-    i = found_lun0 ? 8 : 16;
-    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
 
-        if (dev->channel == channel && dev->id == id) {
-            store_lun(&r->buf[i], dev->lun);
-            i += 8;
-        }
-    }
+    r->buf_len = len;
+    r->buf = g_byte_array_free(buf, FALSE);
+    r->len = MIN(len, r->req.cmd.xfer & ~7);
 
-    assert(i == n + 8);
-    r->len = len;
+    /* store the LUN list length */
+    stl_be_p(&r->buf[0], len - 8);
     return true;
 }
 
-- 
2.26.2



