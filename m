Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D738207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS2HkiVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D738207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluWw-0001Z0-Rq
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluUe-0004fD-Tm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluUd-0005ij-Bf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=JFwHMkHqVUvcQ2HM5U+pSmAGlyM+UoHgsvgwXwXIIns=;
 b=DS2HkiVcWUPTAqnTP/xH8ofxg2++Zb2g6u3tq3PBvO7zfU3tfM9Sjy3rqy54vU7JSsHsNW
 PfEiaAyfXWGF2Gsml0nlYCrdmSU9FVlBxB8YAeoi7v9fp/KmXjrTJAEkgO0Uaovy5RippT
 jYlpMzgROje2qT/PmCXECMXiBsSXeRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-PE-N5duVOOuNUweohpbMWA-1; Thu, 18 Jun 2020 09:22:08 -0400
X-MC-Unique: PE-N5duVOOuNUweohpbMWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778DB8035F8;
 Thu, 18 Jun 2020 13:22:07 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA8E5BAC2;
 Thu, 18 Jun 2020 13:22:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 03/33] tap: allow extended virtio header with hash info
Date: Thu, 18 Jun 2020 21:21:18 +0800
Message-Id: <1592486508-6135-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 6207f61..ca48f2a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -254,7 +254,8 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr));
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.5.0


