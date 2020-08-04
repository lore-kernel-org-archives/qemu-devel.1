Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7120781
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X175D01G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2qf9-0006S6-8E
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qda-0005Bz-KR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qdX-0004Gv-LC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596523282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=5h4QWMFzdBPj3Pi9JiWXOeR4PM6zpX0kyyH91PillLM=;
 b=X175D01GzfuanGnhxrHwl0TyS/E51kCwJYpI8SAVt/GvjcemYKLt24WvVryzVTiVzZQUBG
 E2BM1ivcY6k7YK7y32ZQir7xXwZMnrC7aLUsaKlMsiaIWXTYp9vhaWok1ycdulK2vha1zn
 tWadECU2VDRurVIjq6JNa9CoP1iSKP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-98-H-YmlOZGbpnvLIelOIw-1; Tue, 04 Aug 2020 02:41:20 -0400
X-MC-Unique: 98-H-YmlOZGbpnvLIelOIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83AA61005504;
 Tue,  4 Aug 2020 06:41:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-166.pek2.redhat.com
 [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC94960BF4;
 Tue,  4 Aug 2020 06:41:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 2/2] hw/net/net_tx_pkt: fix assertion failure in
 net_tx_pkt_add_raw_fragment()
Date: Tue,  4 Aug 2020 14:41:10 +0800
Message-Id: <1596523270-5492-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
References: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mauro Matteo Cascella <mcascell@redhat.com>

An assertion failure issue was found in the code that processes network packets
while adding data fragments into the packet context. It could be abused by a
malicious guest to abort the QEMU process on the host. This patch replaces the
affected assert() with a conditional statement, returning false if the current
data fragment exceeds max_raw_frags.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 9560e4a..da262ed 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -379,7 +379,10 @@ bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *pkt, hwaddr pa,
     hwaddr mapped_len = 0;
     struct iovec *ventry;
     assert(pkt);
-    assert(pkt->max_raw_frags > pkt->raw_frags);
+
+    if (pkt->raw_frags >= pkt->max_raw_frags) {
+        return false;
+    }
 
     if (!len) {
         return true;
-- 
2.7.4


