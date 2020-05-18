Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49617C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F5920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke6g/adP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaY3c-0005Jw-9p
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwo-0008NJ-Ad
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwm-0004K5-1w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtEvIlWbqhqGbHRVosFJQi8OcMstNLV0Zi3H/Us5Ry8=;
 b=Ke6g/adP2gg6WIimXku7L5IOYsatLe2ZiHASqpkRD2Rv/Jdow7nW61/g+++lbPA8XfwQGR
 LiI8zVq5sji7VdmfyJkBuQwkMZDEJvxEiaWi7377bYMEdj+aW3k1PvhtrZ9mrE51KXHzR1
 dEShmEPec2SJroMZCFr9d+qFI3gn89w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-13nZ3pErMKGs6GVwgP5fjw-1; Mon, 18 May 2020 01:04:13 -0400
X-MC-Unique: 13nZ3pErMKGs6GVwgP5fjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B4C80058A;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 217EF2E05F;
 Mon, 18 May 2020 05:04:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EE9411358C4; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/24] mac_via: Fix to realize "mos6522-q800-via*" devices
Date: Mon, 18 May 2020 07:03:52 +0200
Message-Id: <20200518050408.4579-9-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mac_via_realize() creates a "mos6522-q800-via1" and a
"mos6522-q800-via2" device, but neglects to realize them.  Affects
machine q800.

I wonder how this ever worked.  If the "device becomes real only on
realize" thing actually works, then we've always been missing these
two devices, yet nobody noticed.

Fix by realizing them right away.

Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/mac_via.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index e05623d730..ee32f72d75 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -890,6 +890,9 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
                               SYSBUS_DEVICE_GPIO_IRQ "[0]");
 
+    qdev_init_nofail(DEVICE(&m->mos6522_via1));
+    qdev_init_nofail(DEVICE(&m->mos6522_via2));
+
     /* Pass through mos6522 input IRQs */
     qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
     qdev_pass_gpios(DEVICE(&m->mos6522_via2), dev, "via2-irq");
-- 
2.21.1


