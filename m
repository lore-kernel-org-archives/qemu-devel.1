Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC8DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4D120722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IivBVm/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4D120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZ1Y-0001T2-Bj
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqYzx-0007qJ-4R
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:25:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqYzv-0004w6-GJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwDzVv8vVIGdgufhvskvFm88w8TifsKMZGwYpyVL/sY=;
 b=IivBVm/8GtCRNbrNRj1x7iZKB/gPdwKXduw51NFYJ8gvSi3QjSbbx4sHu3v8d3GATNNmYj
 2LGtPFPvSTcoEndgGr3l+N4I+KpxYgchHSFkblR/oufXVfGOWh883dHxIdK8rB2NXklwSR
 Jqc5n/2Y/iBd+gEOL+cMNJsmINkKmZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-mZcG_0VdOXSu3icakKpuwQ-1; Wed, 01 Jul 2020 05:25:41 -0400
X-MC-Unique: mZcG_0VdOXSu3icakKpuwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D921083E8A;
 Wed,  1 Jul 2020 09:25:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13C0210640E2;
 Wed,  1 Jul 2020 09:25:17 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v3 01/13] net: introduce qemu_get_peer
Date: Wed,  1 Jul 2020 17:24:37 +0800
Message-Id: <20200701092449.17451-2-lulu@redhat.com>
In-Reply-To: <20200701092449.17451-1-lulu@redhat.com>
References: <20200701092449.17451-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a small function that can get the peer
from given NetClientState and queue_index

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h | 1 +
 net/net.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 39085d9444..e7ef42d62b 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -176,6 +176,7 @@ void hmp_info_network(Monitor *mon, const QDict *qdict);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
                         bool vnet_hdr);
+NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
 
 /* NIC info */
 
diff --git a/net/net.c b/net/net.c
index d1130296e1..9099a327dd 100644
--- a/net/net.c
+++ b/net/net.c
@@ -325,6 +325,13 @@ void *qemu_get_nic_opaque(NetClientState *nc)
     return nic->opaque;
 }
 
+NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
+{
+    assert(nc != NULL);
+    NetClientState *ncs = nc + queue_index;
+    return ncs->peer;
+}
+
 static void qemu_cleanup_net_client(NetClientState *nc)
 {
     QTAILQ_REMOVE(&net_clients, nc, next);
-- 
2.21.1


