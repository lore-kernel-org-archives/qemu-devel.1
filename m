Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E3F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGL2FhrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E3F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCIO-0007s4-Ck
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBW-0002kO-IG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBN-0002v9-8Q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iDl2ElwkXpRbcCCv6gyWEk3cW3jpGvA4tnLbRXMjV8=;
 b=XGL2FhrTVTwTGHfcC6a6dh4307YI2WXddZ3cttt6mReGglEbIvjbltqeXFTUArLYkTBKyM
 J2+bFCNJ3pZb7p1iX7Jl8ZuOvnsw02qPCq8nVYsb1QQNeqt54pFvj1l1vvMURY47wqR0HM
 uURbr7OYQ2ae2EModyGbPTmTggN/4tA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-9AApus3qOS-X4OtGSbH69A-1; Tue, 30 Jun 2020 05:03:58 -0400
X-MC-Unique: 9AApus3qOS-X4OtGSbH69A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F06018A0731;
 Tue, 30 Jun 2020 09:03:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C983471669;
 Tue, 30 Jun 2020 09:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AED8113847D; Tue, 30 Jun 2020 11:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/26] riscv/sifive_u: Fix sifive_u_soc_realize() error API
 violations
Date: Tue, 30 Jun 2020 11:03:42 +0200
Message-Id: <20200630090351.1247703-18-armbru@redhat.com>
In-Reply-To: <20200630090351.1247703-1-armbru@redhat.com>
References: <20200630090351.1247703-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

sifive_u_soc_realize() is wrong that way: it passes &err to
sysbus_realize() four times before checking it.  Harmless, because the
first three can't actually fail (I think).

Fix by checking for failure right away.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-riscv@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7d051e7c92..a1d2edfe13 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -677,11 +677,15 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->prci), &err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
     qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_GPIO].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
@@ -695,7 +699,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
-    sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
     if (nd->used) {
-- 
2.26.2


