Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE74207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgNUlX7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE74207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluls-0004c3-VH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluWA-0000Th-8B
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVu-0005tS-QB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elivO27Qf/JSTlTnpF6OqVy6SM5yMeRd8r5vrxQeoxI=;
 b=dgNUlX7cPuTxbc1bv40yn0C+J+QWDpgaJoofOa3Y1AW6PLeBfzKkfy4y1IdhC41UcCsMYz
 pcLksl9rOaFcMEIoNgRxRtQTzUfCE8nBy8n1oIj7/ZKkQLZWWKSYpnC9quSdyfHwNpFjFY
 bI2EuVoWTYd8ZrY9B74U772j6Wx3dKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Tbokr5ldMZWVpSeTRIqeXQ-1; Thu, 18 Jun 2020 09:23:28 -0400
X-MC-Unique: Tbokr5ldMZWVpSeTRIqeXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1189C107ACF6;
 Thu, 18 Jun 2020 13:23:27 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 258665BAC2;
 Thu, 18 Jun 2020 13:23:24 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 30/33] colo-compare: Fix memory leak in packet_enqueue()
Date: Thu, 18 Jun 2020 21:21:45 +0800
Message-Id: <1592486508-6135-31-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Derek Su <dereksu@qnap.com>, Zhang Chen <chen.zhang@intel.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Derek Su <dereksu@qnap.com>

The patch is to fix the "pkt" memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big.

Replace the error_report of full queue with a trace event.

Signed-off-by: Derek Su <dereksu@qnap.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 23 +++++++++++++++--------
 net/trace-events   |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ed1f3d0..f15779d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -146,6 +146,10 @@ enum {
     SECONDARY_IN,
 };
 
+static const char *colo_mode[] = {
+    [PRIMARY_IN] = "primary",
+    [SECONDARY_IN] = "secondary",
+};
 
 static int compare_chr_send(CompareState *s,
                             uint8_t *buf,
@@ -242,6 +246,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     ConnectionKey key;
     Packet *pkt = NULL;
     Connection *conn;
+    int ret;
 
     if (mode == PRIMARY_IN) {
         pkt = packet_new(s->pri_rs.buf,
@@ -270,16 +275,18 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     }
 
     if (mode == PRIMARY_IN) {
-        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
-            error_report("colo compare primary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->primary_list, pkt, &conn->pack);
     } else {
-        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
-            error_report("colo compare secondary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->secondary_list, pkt, &conn->sack);
     }
+
+    if (!ret) {
+        trace_colo_compare_drop_packet(colo_mode[mode],
+            "queue size too big, drop packet");
+        packet_destroy(pkt, NULL);
+        pkt = NULL;
+    }
+
     *con = conn;
 
     return 0;
diff --git a/net/trace-events b/net/trace-events
index 02c13fd..fa49c71 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
 
 # colo-compare.c
 colo_compare_main(const char *chr) ": %s"
+colo_compare_drop_packet(const char *queue, const char *chr) ": %s: %s"
 colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
-- 
2.5.0


