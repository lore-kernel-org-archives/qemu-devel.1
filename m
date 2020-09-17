Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2CAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3862322470
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPD6puQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3862322470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwTz-0007hJ-7h
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kIwLq-0005vP-JS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kIwLk-000449-LS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600358491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8HbX5QjLUvwJ9BsUeae3ntLOMJglZce6F9CqEC3w8E=;
 b=cPD6puQgqUIFZkTha7H2zGW2RKkP5dlSzah9xFZMDkEzVncubnTCz87DO84cWJf8vf9i5t
 WC+22L2CmFTkBx+He/llNBvIn872XSZ/VXvrtlxxoOrzxTKmMjzl4+z92HWI01Cbdvua4f
 NAIdYcNgHJqGdv2YvuBf9EH7M5zlTcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8--jpPsrIjPV6OESixscLCbA-1; Thu, 17 Sep 2020 12:00:16 -0400
X-MC-Unique: -jpPsrIjPV6OESixscLCbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B191017DDC;
 Thu, 17 Sep 2020 16:00:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1362061176;
 Thu, 17 Sep 2020 16:00:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
Date: Thu, 17 Sep 2020 23:58:50 +0800
Message-Id: <20200917155851.20636-2-lulu@redhat.com>
In-Reply-To: <20200917155851.20636-1-lulu@redhat.com>
References: <20200917155851.20636-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fix the bug that fd will still open after the cleanup

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35..0480b92102 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -144,6 +144,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+     if (s->vhost_vdpa.device_fd >= 0) {
+        qemu_close(s->vhost_vdpa.device_fd);
+        s->vhost_vdpa.device_fd = -1;
+    }
 }
 
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
-- 
2.21.3


