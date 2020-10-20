Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8843C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6058B2224F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="PEREai9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058B2224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmJw-0004C0-BP
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kUmJ2-0003Ns-Ph
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:43:40 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:56086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kUmJ0-0008MW-O5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:43:40 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 1F895C60010;
 Tue, 20 Oct 2020 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1603179814;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=mlIRwhaHDHPVIU5gr1CK/VGLAMYhpYmFtsI2zoTsscE=;
 b=PEREai9yOngZf1GqKDJOEWjrdJaeX99Uer+pHaXjHCDv2TaPk5UmbUmA/O4tGsXF5pPzTC
 NHqqmlEHzKQLrG5N4fJqjSKE91WuOWluBpnuRLogbkqU2TnuJKWYhOT+vWzkLIna5gewM7
 rcbej0puib9BcQJdid/wjf672RAc9+lqHz7XEO7RpAxorZ9s2hUlywQNo5VG4jkAKVQAkt
 gh9dSNlRchzltwiEgULN/BIEMsZHnE/DZp/3TIFCdgczXo5y08u7yTpDhR+p3Mf6uNLSfF
 1fQ0Z/mFx7kUIr86HAl3WQl2Ez4zUq9U1wbofs+VZCrYS4LwXgOs5MH96TJiUA==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/core/qdev-clock: add a reference on aliased clocks
Date: Tue, 20 Oct 2020 09:44:26 +0200
Message-Id: <20201020074426.105878-1-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1603179814;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=mlIRwhaHDHPVIU5gr1CK/VGLAMYhpYmFtsI2zoTsscE=;
 b=Yarvetic0tbpnqTec95tfzSiysB7MwOlSiiGYESqICGoxtPWHTwdKr7PX/5zfwrv9q40U6
 wtIfbvo+ach0MvciQvXwWlIA2mLmaQvF3ESjTg/ZpLfr0l7py8F3UIFsrSO7tWPpGdDIJb
 kISD56myzRwAoLsVxbhNx+L646+QSlONy2nErc+/zCPBVza7xkVZGOErKLZIau6ECZXw+U
 du4KXrvCNeVEQkH5uCQvg6crzPsJ8B+yrUZJhn1IPnxrMaodhNYrZFJr6VRozl30RXLz7e
 y6WbnABAOjGRw+m77QuGCRTEVYDHTylZO+dq4Mq/kVFX2Ml5Sn6m6+5Ug1A7kg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1603179814; a=rsa-sha256; cv=none;
 b=Gv2fTUD+di0dzPaEeafCOf2PettbxhyZhNUnZ85FH5ChIR04b2hqk6U+9a6IvEl1f7v1+SY97ePgHyK5DNcJQbmZAiZ3MI/zQPzojfeO+SmHtSLye4pWNY4lwqzKS6IUNm8T/KUbopW2+S6n3KC5M9HzLfSLBDdHGe8u8eQhh3c39qmOheyJrLxlwbgNpuEu0FfmiatpGxZ3xqlk+wq5vcVd3zL9ceHAwvMkMpVgALxHA6YbvlD7uUKHJdv0haSC5SbKCPRjWm4L/YAJD4qb3/Wa8L1JZ4BULAKp6zuwJnluQ6SjbJmg1R3G//Tt4J9gKyfEOxl96HVcvCd2ZjNjkQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 03:43:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When aliasing a clock with the qdev_alias_clock() function, a new link
property is created on the device aliasing the clock. The link points
to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
property is read only since it does not provide a check callback for
modifications.

The object_property_add_link() documentation stats that with
OBJ_PROP_LINK_STRONG properties, the linked object reference count get
decremented when the property is deleted. But it is _not_ incremented on
creation (object_property_add_link() does not actually know the link).

This commit increments the reference count on the aliased clock to
ensure the aliased clock stays alive during the property lifetime, and
to avoid a double-free memory error when the property get deleted.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/core/qdev-clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6a9a340d0f..5f5e143702 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -59,10 +59,11 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
     } else {
         object_property_add_link(OBJECT(dev), name,
                                  object_get_typename(OBJECT(clk)),
                                  (Object **) &ncl->clock,
                                  NULL, OBJ_PROP_LINK_STRONG);
+        object_ref(OBJECT(clk));
     }
 
     ncl->clock = clk;
 
     QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
-- 
2.28.0


