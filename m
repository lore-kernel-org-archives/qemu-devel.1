Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAC5207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUHNdkkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAC5207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluZc-0006Ae-Ur
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluV4-0005ah-OX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluV2-0005ks-JF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=446xKidgEVOQ/SPk+3o4/lsMihU0RVqhybpGPFUvV0I=;
 b=gUHNdkkGBuebazzlUlxCQ+RuOaeTm359bftcxe+Q0nH0fhifs3OgykFtklipGK4gvZ7JUP
 75SOcU4oeOyllzyWVMz/tNSZyGhdqk4GgtMPxzK9IV0ungHdArz4CXAsq5HUx3ts/+c40a
 xuZHhdzNFUk8DcWSoiwnfNPsjBxGtVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zMxJDc8vMlqgJUzn8bA2cA-1; Thu, 18 Jun 2020 09:22:29 -0400
X-MC-Unique: zMxJDc8vMlqgJUzn8bA2cA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D708106B216;
 Thu, 18 Jun 2020 13:22:27 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A11FB5BAC2;
 Thu, 18 Jun 2020 13:22:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 08/33] Fix tulip breakage
Date: Thu, 18 Jun 2020 21:21:23 +0800
Message-Id: <1592486508-6135-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
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
Cc: Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

The tulip network driver in a qemu-system-hppa emulation is broken in
the sense that bigger network packages aren't received any longer and
thus even running e.g. "apt update" inside the VM fails.

The breakage was introduced by commit 8ffb7265af ("check frame size and
r/w data length") which added checks to prevent accesses outside of the
rx/tx buffers.

But the new checks were implemented wrong. The variable rx_frame_len
counts backwards, from rx_frame_size down to zero, and the variable len
is never bigger than rx_frame_len, so accesses just can't happen and the
checks are unnecessary.
On the contrary the checks now prevented bigger packages to be moved
into the rx buffers.

This patch reverts the wrong checks and were sucessfully tested with a
qemu-system-hppa emulation.

Fixes: 8ffb7265af ("check frame size and r/w data length")
Buglink: https://bugs.launchpad.net/bugs/1874539
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/tulip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 6cefc0a..57ecbe2 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -171,9 +171,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
             len = s->rx_frame_len;
         }
 
-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -= len;
@@ -186,9 +183,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
             len = s->rx_frame_len;
         }
 
-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -= len;
-- 
2.5.0


