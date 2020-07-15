Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0238C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB8620657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaelTgtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB8620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhrw-0004SV-Os
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqx-0002wt-Ew
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqv-0005LB-Io
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=pycJaOGH+mrtlDuxINiTiyF5nVH/YR0uKzGwEx3SrCg=;
 b=CaelTgtk56ZCoJRZXKcLzG6qxUOXmgEE1CSa6ygv264If2jnsH/vBmSGSwH67IJqj8oQ3v
 RQWH6IG79cG73IFvGpI/5vKNPnVbCdncA3iNl1r1XsRGQF6NE6bP794Tid+mE7fEn2qlDk
 Kn/bFNFW3LiPUIk3YC7k1IW+2LlVPjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-tGlrKLi_OzeBdZUfSO2KwA-1; Wed, 15 Jul 2020 09:53:38 -0400
X-MC-Unique: tGlrKLi_OzeBdZUfSO2KwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D828518C63C0;
 Wed, 15 Jul 2020 13:53:37 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 558B35C57D;
 Wed, 15 Jul 2020 13:53:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 3/7] net/colo-compare.c: Expose compare "max_queue_size" to
 users
Date: Wed, 15 Jul 2020 21:53:17 +0800
Message-Id: <1594821201-3708-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This patch allow users to set the "max_queue_size" according
to their environment.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx    |  5 +++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 398b754..cc15f23 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -59,6 +59,7 @@ static bool colo_compare_active;
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
 static int event_unhandled_count;
+static uint32_t max_queue_size;
 
 /*
  *  + CompareState ++
@@ -222,7 +223,7 @@ static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
  */
 static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)
 {
-    if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
+    if (g_queue_get_length(queue) <= max_queue_size) {
         if (pkt->ip->ip_p == IPPROTO_TCP) {
             fill_pkt_tcp_info(pkt, max_ack);
             g_queue_insert_sorted(queue,
@@ -1134,6 +1135,37 @@ static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
     s->expired_scan_cycle = value;
 }
 
+static void get_max_queue_size(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    uint32_t value = max_queue_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void set_max_queue_size(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    max_queue_size = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1251,6 +1283,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         s->expired_scan_cycle = REGULAR_PACKET_CHECK_MS;
     }
 
+    if (!max_queue_size) {
+        /* Set default queue size to 1024 */
+        max_queue_size = MAX_QUEUE_SIZE;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1370,6 +1407,10 @@ static void colo_compare_init(Object *obj)
                         compare_get_expired_scan_cycle,
                         compare_set_expired_scan_cycle, NULL, NULL);
 
+    object_property_add(obj, "max_queue_size", "uint32",
+                        get_max_queue_size,
+                        set_max_queue_size, NULL, NULL);
+
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
                              compare_set_vnet_hdr);
diff --git a/qemu-options.hx b/qemu-options.hx
index d2c1e95..310885c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4695,7 +4695,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}``
+    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}][,max_queue_size=@var{size}]``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4707,7 +4707,8 @@ SRST
         vnet\_hdr\_len. Then compare\_timeout=@var{ms} determines the
         maximum delay colo-compare wait for the packet.
         The expired\_scan\_cycle=@var{ms} to set the period of scanning
-        expired primary node network packets.
+        expired primary node network packets. The max\_queue\_size=@var{size}
+        is to set the max compare queue size depend on user environment.
         If you want to use Xen COLO, will need the notify\_dev to
         notify Xen colo-frame to do checkpoint.
 
-- 
2.5.0


