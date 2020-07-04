Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0196C20771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AObpbMYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0196C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnCZ-00038K-5Z
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw1-0004SD-D5
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvz-0001ZW-If
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J87y6/ALZV5j2hxcU6iv08lRd5sVzb2p1LKaAZ1dyww=;
 b=AObpbMYK9w23uBXh5hkHDf8+Br5CubFu1BgE2C5bFB/lOnPsAbQA79WERoE2R7XNfnGYl8
 rvC2t8WOobkIf9Zc6WnYxnabdOElT4bW4HGdpZJArv11i5ZPCbLuGBMx0l7C8BRLDlXdNr
 9fLQ99bSS5deUEpzhlbK/Ajy2fp3mCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-AyTozNeVMruuGKquHZNywA-1; Sat, 04 Jul 2020 14:30:40 -0400
X-MC-Unique: AyTozNeVMruuGKquHZNywA-1
Received: by mail-wr1-f71.google.com with SMTP id o12so36257246wrj.23
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J87y6/ALZV5j2hxcU6iv08lRd5sVzb2p1LKaAZ1dyww=;
 b=GSmyXOXsADFlUcdT8EPOOYeZ/SpQx89t9Pt1ACfomy1z5ylPA2g/ZIKu3rVlnYLFJJ
 xvhgsDlXwpQ+8uhL8JzG910/hRQLj5Px7afUTBhbrzbzYknf3joBeHYLKW9GO2pDGCqJ
 /WYi/z3YMCvipHISTCkRWtegVXVjTkXjwoPLktl6Zv3v3v47jUJ77coLk+I8cRrkojdf
 JVOiHved2gruRRhxjyvvvsX03WWP4KtpHI9eOMXlzOwqd3XeXA7byW9Wrh8KX/mbKfX6
 mm0WWaN1Zo3lZCyelhuFYOP8vzq4D/t4feoljGZeqqPAjKGDXifv3FfgbqfQPz5QOX8J
 UgSw==
X-Gm-Message-State: AOAM533CHY+CK3wa2kV5QuOEwN6RTmGJagT9rsPiJN9OeEi8qAT81VlX
 hVcTQHckxeYPVHnNuNzri/KKDFf2RAr2xRsZDwGS/CPy9IrPGinD2RCTfjGqXSaWO3cg3+nkAbT
 fjcW5xGiedFMyUnQ=
X-Received: by 2002:a5d:650e:: with SMTP id x14mr43960653wru.187.1593887439019; 
 Sat, 04 Jul 2020 11:30:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz3RWqFKTy2s8oJKuCMlVvqwFDWvlkuJXUzDI5CtWR4SB6EfithsyyitDICz3+tQY78T651A==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr43960644wru.187.1593887438879; 
 Sat, 04 Jul 2020 11:30:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 n5sm17021025wmi.34.2020.07.04.11.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:38 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/41] net: introduce qemu_get_peer
Message-ID: <20200704182750.1088103-29-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
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


