Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1B220720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjsONlli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1B220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIcK-00059D-Ot
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbC-0003Mv-DJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbA-0005X7-LX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXcLYdyAsOR9Mteeheh8+N7Y20u/vLKQhDl19KIwhTU=;
 b=DjsONlliAUcqtJYohrtAU6HczwooZEFkITH+S/y6rsEFyA3xhc4e7wL91UMtJPNBvga53q
 2Bf8R02gaHFCwTDz/BPW7uUgZp3N5N1OJD1CZBJ3MPOcaN5AeXIx0ZZ+S2rV8GtEbemkF7
 KhCPA5oB0iYBo1r9puOn4YBelwLwnyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-bk50CHWRNFONyPWL90zUnA-1; Fri, 03 Jul 2020 06:07:09 -0400
X-MC-Unique: bk50CHWRNFONyPWL90zUnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CA4800C64;
 Fri,  3 Jul 2020 10:07:08 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 873CF1053B1B;
 Fri,  3 Jul 2020 10:07:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/14] pc-bios: s390x: Get rid of magic offsets into the lowcore
Date: Fri,  3 Jul 2020 12:06:40 +0200
Message-Id: <20200703100650.621212-5-cohuck@redhat.com>
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

If we have a lowcore struct that has members for offsets that we want
to touch, why not use it?

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200624075226.92728-5-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
 pc-bios/s390-ccw/main.c |  8 +++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index aaa432deddb9..1e5d4e92e12c 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -122,12 +122,17 @@ typedef struct schib {
 } __attribute__ ((packed, aligned(4))) Schib;
 
 typedef struct subchannel_id {
-        __u32 cssid:8;
-        __u32:4;
-        __u32 m:1;
-        __u32 ssid:2;
-        __u32 one:1;
-        __u32 sch_no:16;
+    union {
+        struct {
+            __u16 cssid:8;
+            __u16 reserved:4;
+            __u16 m:1;
+            __u16 ssid:2;
+            __u16 one:1;
+        };
+        __u16 sch_id;
+    };
+    __u16 sch_no;
 } __attribute__ ((packed, aligned(4))) SubChannelId;
 
 struct chsc_header {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 4e65b411e1d8..8b912454c940 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -36,11 +36,9 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
  */
 void write_subsystem_identification(void)
 {
-    SubChannelId *schid = (SubChannelId *) 184;
-    uint32_t *zeroes = (uint32_t *) 188;
-
-    *schid = blk_schid;
-    *zeroes = 0;
+    lowcore->subchannel_id = blk_schid.sch_id;
+    lowcore->subchannel_nr = blk_schid.sch_no;
+    lowcore->io_int_parm = 0;
 }
 
 void write_iplb_location(void)
-- 
2.25.4


