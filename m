Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1F4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479EC2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B27vyC5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479EC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5So-0001rC-H2
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MM-0001bh-Eq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MK-0005aS-On
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=0bs/XqiKZ782G7HswOHdTr6cBBXiTONRsQ1okp2l69o=;
 b=B27vyC5nPBiSTHffwttKId34v3QJnz1U6E+NrtGvGsQjFEu9xFm/0aB5pQ9lwjAI3/1/0H
 bxdxKNlhbWvyLWSf7ZtfZgGyAn/mW+CiyMp4jY61fRgj1e5g8SYn7pMYPmhKZ5A49TWSew
 Yugl1qxR7/KGoF1N0KTVl0LPw2+zus4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-73_qaVLwPEOXNLBo_qOUnQ-1; Tue, 16 Jun 2020 02:46:09 -0400
X-MC-Unique: 73_qaVLwPEOXNLBo_qOUnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63682835B5A;
 Tue, 16 Jun 2020 06:46:08 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFBAF8202D;
 Tue, 16 Jun 2020 06:46:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 07/33] virtio-net: align RSC fields with updated virtio-net
 header
Date: Tue, 16 Jun 2020 14:45:18 +0800
Message-Id: <1592289944-13727-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Removal of duplicated RSC definitions. Changing names of the
fields to ones defined in the Linux header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5da29..aff67a9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -88,26 +88,6 @@
                                          VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
 
-/* temporary until standard header include it */
-#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
-
-#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       61
-
-#endif
-
-static inline __virtio16 *virtio_net_rsc_ext_num_packets(
-    struct virtio_net_hdr *hdr)
-{
-    return &hdr->csum_start;
-}
-
-static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
-    struct virtio_net_hdr *hdr)
-{
-    return &hdr->csum_offset;
-}
-
 static VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -1821,15 +1801,15 @@ static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
                                        VirtioNetRscSeg *seg)
 {
     int ret;
-    struct virtio_net_hdr *h;
+    struct virtio_net_hdr_v1 *h;
 
-    h = (struct virtio_net_hdr *)seg->buf;
+    h = (struct virtio_net_hdr_v1 *)seg->buf;
     h->flags = 0;
     h->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 
     if (seg->is_coalesced) {
-        *virtio_net_rsc_ext_num_packets(h) = seg->packets;
-        *virtio_net_rsc_ext_num_dupacks(h) = seg->dup_ack;
+        h->rsc.segments = seg->packets;
+        h->rsc.dup_acks = seg->dup_ack;
         h->flags = VIRTIO_NET_HDR_F_RSC_INFO;
         if (chain->proto == ETH_P_IP) {
             h->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-- 
2.5.0


