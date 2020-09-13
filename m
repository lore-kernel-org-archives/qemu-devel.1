Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D706C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C965F221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtWqPkIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C965F221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUa2-0004cN-Pq
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTk-0003II-Qs
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTi-0001RJ-PC
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600013025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5U6NpADpwbz6hmsrwp+fNTljpdFoEsRxAFNUR7QhDM=;
 b=FtWqPkIpPSBjs56qhp/lLKDHerpKhYeQgm7e7/hr6Arpd84yhPT+udX3+tVja6uWFuuUZQ
 CjxxbJ0EZgMo9zoVI+o4Dk4qNpDu1WGldrixn7sVMquBHSfdImgGQ+4CeZ8rR6U9AKbbWL
 dcS5ROumZ5GLh1lkH6lfJrwAftZJkqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-9KgSBD1sM4ultvOg8vzbPg-1; Sun, 13 Sep 2020 12:03:42 -0400
X-MC-Unique: 9KgSBD1sM4ultvOg8vzbPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F1551005E63;
 Sun, 13 Sep 2020 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E56D919C4F;
 Sun, 13 Sep 2020 16:03:38 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 9/9] scsi/scsi_bus: fix races in REPORT LUNS
Date: Sun, 13 Sep 2020 19:02:59 +0300
Message-Id: <20200913160259.32145-10-mlevitsk@redhat.com>
In-Reply-To: <20200913160259.32145-1-mlevitsk@redhat.com>
References: <20200913160259.32145-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:28:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently scsi_target_emulate_report_luns iterates over the child device list
twice, and there is no guarantee that this list is the same in both iterations.

The reason for iterating twise is that the first iteration calculates
how much memory to allocate.

However if we use a dynamic array we can avoid iterating twice, and therefore
we avoid this race.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1866707

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-bus.c | 65 ++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index dfd503f7ef..84c145c724 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -439,19 +439,23 @@ struct SCSITargetReq {
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
@@ -459,48 +463,41 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
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
 
-    rcu_read_lock();
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
-            }
-            n += 8;
-        }
-    }
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
+    rcu_read_lock();
     QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
-        if (dev->channel == channel && dev->id == id) {
-            store_lun(&r->buf[i], dev->lun);
-            i += 8;
+        if (dev->channel == channel && dev->id == id && dev->lun != 0) {
+            store_lun(tmp, dev->lun);
+            g_byte_array_append(buf, tmp, 8);
+            len += 8;
         }
     }
-
     rcu_read_unlock();
 
-    assert(i == n + 8);
-    r->len = len;
+    r->buf_len = len;
+    r->buf = g_byte_array_free(buf, FALSE);
+    r->len = MIN(len, r->req.cmd.xfer & ~7);
+
+    /* store the LUN list length */
+    stl_be_p(&r->buf[0], len - 8);
+
     return true;
 }
 
-- 
2.26.2


