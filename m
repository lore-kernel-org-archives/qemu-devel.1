Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54704C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5E92074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZKUo+Ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5E92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw9Wj-0002v4-E3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 15:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw9Vv-0002GZ-7Z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:25:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw9Vs-0008B3-8f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594927546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ILiSAWPYTAj500OLNEREcWbB1f5alUvLXGyo4Skrp8k=;
 b=DZKUo+AeCrzJiXS6lWAfmuYOOgbmwVBIxfKegh7AIMP8gejXyFiN8hE0ye0jkJd0kRZYQ+
 OcVVOn38M0Xxln+JObv4jrSTDidzZGSoikgo2o59dljtZ0U+ebjbAN1qqO/Irzz/erBtC/
 iEGIV15gTACmCEJcUR37kN/7H1Q0N+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-fRJXseWGM0ecwVTwxHIwzw-1; Thu, 16 Jul 2020 15:25:44 -0400
X-MC-Unique: fRJXseWGM0ecwVTwxHIwzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865BA803059;
 Thu, 16 Jul 2020 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5BB378479;
 Thu, 16 Jul 2020 19:25:39 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] net: check payload length limit for all frames
Date: Fri, 17 Jul 2020 00:53:35 +0530
Message-Id: <20200716192335.1212638-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 13:59:43
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While sending packets, the check that packet 'payload_len'
is within 64kB limit, seems to happen only for GSO frames.
It may lead to use-after-free or out-of-bounds access like
issues when sending non-GSO frames. Check the 'payload_len'
limit for all packets, irrespective of the gso type.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/net_tx_pkt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802dd7..e66998a8f9 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
      * Since underlying infrastructure does not support IP datagrams longer
      * than 64K we should drop such packets and don't even try to send
      */
-    if (VIRTIO_NET_HDR_GSO_NONE != pkt->virt_hdr.gso_type) {
-        if (pkt->payload_len >
-            ETH_MAX_IP_DGRAM_LEN -
-            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
-            return false;
-        }
+    if (pkt->payload_len >
+        ETH_MAX_IP_DGRAM_LEN -
+        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
+        return false;
     }
 
     if (pkt->has_virt_hdr ||
-- 
2.26.2


