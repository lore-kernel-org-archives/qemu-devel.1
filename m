Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF7BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0659C20836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PktqJYCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0659C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHpJ-0001wZ-98
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcr-0000YX-8w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37318
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcp-0004WM-GX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J87y6/ALZV5j2hxcU6iv08lRd5sVzb2p1LKaAZ1dyww=;
 b=PktqJYCFDRVdf16AcozFUD05+JoA3j5QkHjEqV8UakyoNCX1KaDzWU+f+mRKy4xUOip80Y
 EUbCLLjIgMMcJ5xHJIAcBCSnTEfX+9dpaDQcUBn6XtLuRiEuEpCEJKRB8fiKFUVgA6gykZ
 9MVWoLg8gPuicUf4RZ5S8oUg4jk/BCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Yh3HwYPuN9ezq8KJMRgMlg-1; Fri, 03 Jul 2020 05:04:49 -0400
X-MC-Unique: Yh3HwYPuN9ezq8KJMRgMlg-1
Received: by mail-wr1-f70.google.com with SMTP id 89so7685945wrr.15
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J87y6/ALZV5j2hxcU6iv08lRd5sVzb2p1LKaAZ1dyww=;
 b=rmO7/UF4yxVyAENMHlKpVfitutcWNSCsmNcFWyZD4J2A7KW7qiSSHhYA7rwm1IJZ8g
 VwUBKub83cR3d8mdu6bQK4zeE9GLJMltI4uQMTlDIW8SiCJpnIlcj66ApyiCe6t30Sfw
 7PQ/cb0nPInYpE3o5WOeOaZLZofotamn1E2+hVpFYZ+Dw4Q4s6LLV/tGFtkIG7eisuBh
 OibZQeP4fkStbsmQbGod9pI0XYX6PSd+z+80itX0eKZnsInHfUabNWeKwBLdh60+Tk81
 b6LQso3V3/4Xs+zGdPBC2TqmtLlniBPmDj/9cW27rr5ihfBWltu+/rqcomZNN9Ekp781
 wl2A==
X-Gm-Message-State: AOAM533WAjrVPn/qtWqSOTK4vFUsOdgAfXuQJLbta4n6VlwZ3QOUvAmP
 1k4Zw0tBtsr1mg8xAYksXYeTYdabIUY6TMc5Vl0cqalHpvW2OS/A1X3rPNkGIYX0Y3iYLjWIfWW
 ON0o/ciNnlEpmmr8=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr38010490wro.124.1593767087724; 
 Fri, 03 Jul 2020 02:04:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSYSfj3xYoukHI0nOCXK7dVWXT/4kzB734/IOwzyT6AJ8eKiFl1wqTUJigyr1s6tJp2eFNgg==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr38010467wro.124.1593767087490; 
 Fri, 03 Jul 2020 02:04:47 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r12sm13030188wrc.22.2020.07.03.02.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:46 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] net: introduce qemu_get_peer
Message-ID: <20200703090252.368694-29-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

This is a small function that can get the peer
from given NetClientState and queue_index

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-2-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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
MST


