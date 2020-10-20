Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBE322283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="NNKWmZyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBE322283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnfq-0002m0-3S
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kUneY-0002CA-BK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:09:58 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:59078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kUneV-00059s-RB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:09:57 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 8A8BCC60010;
 Tue, 20 Oct 2020 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1603184993;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=jURFI+Tv0JPAjk59xRlvE0DmZUKseh5TuVg3HINLb+0=;
 b=NNKWmZyTjz9W1cwCgBIDNTIynkl7spT3FCIMQWQvh+pWBbQ8JxJmuXbVWZliNv+LfeyUsW
 f3ZAwHl/W6kUVjDii49uuimKSGB92reQ6IUwjHFGMwYEuOPQ6dWfNu1D2Y3ndp+chJDUv/
 YilUf1RZU/+50nbLZ2WTj0I0Ntx869vk1Je71ee3LIs+casyK1MYuUbpJ4tOzvt9RLhzvl
 sU21BWJ8WAix4NepXQGrWv6WZM+IRXOxDXPK+b4JS20ovY6A1mZJ+p3GAGPxubHJvh0QvP
 iIl65+Wcz9/oBp3avuVsbOAjg6JwcNG0w24hZWhVGFOyDJqac5uP2+6D4H3Y+g==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/core/qdev-clock: add a reference on aliased clocks
Date: Tue, 20 Oct 2020 11:10:24 +0200
Message-Id: <20201020091024.320381-1-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1603184993;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=jURFI+Tv0JPAjk59xRlvE0DmZUKseh5TuVg3HINLb+0=;
 b=A5vRID4zUc8PxGe8US5eSkS3y1lmJqyCDhqjX1aMU9xgwappvpG3gMqsKJBl92HW0N9m/R
 sjMmF4rGdjKsftcpnc5JAEY5PmqRX/TLNogQJCJ/xOi/wgINtLw+ZvwlMFg4fLycJ/ycvD
 //qitjHbjUv0VzZS0kOU8gCiyeYevols21AsA5eFQNw5XgKFuMq6C3jGrxsV3t0cWihL2/
 eAvLHyEfEmibh48BA937Qo8y0zoUlaNGZ45msPrr5LpfCuV1Bv4oU4yjnwZjlLoA/09ONz
 Ve2qp0fjyH0qzhMnDQ7OQMIPEvMsQn+jWc2FM5CRYunp6IMiGKJOuV7XQ26Eew==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1603184993; a=rsa-sha256; cv=none;
 b=I5A6IEuXph7utHZn/mjZsgMTkhmyAVyFrt4ya4yU+8Oo8UD0QhyDj4GM6LtojJyv7zORJIvHa2bmXS5evZVzTkwAJn1w+cmmMurfgeWHOiVWgkzOLnsx4Kcaq4pI6TVYFGrs3JnBIs76uicN2pLSaXrVTROBumGQOOtszopxkx0qV3QEx2enaYtEu+9SLIROZWGXIDAa9mjZD85g6dWTbrjkBc+nTviLqDQurOj8M+wxeP2pO1m3WFgLc8epWugCsPBdASI0cpcbJWYTAuuRPs58aToZvkJS9ynvXrEw//wYpCs9qPBm6OWkqV/zPxUusB5E5GeVfAV6o26Sl1DTIA==
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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
to avoid a double-free memory error when the property gets deleted.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/core/qdev-clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6a9a340d0f..eb05f2a13c 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -59,10 +59,18 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
     } else {
         object_property_add_link(OBJECT(dev), name,
                                  object_get_typename(OBJECT(clk)),
                                  (Object **) &ncl->clock,
                                  NULL, OBJ_PROP_LINK_STRONG);
+        /*
+         * Since the link property has the OBJ_PROP_LINK_STRONG flag, the clk
+         * object reference count gets decremented on property deletion.
+         * However object_property_add_link does not increment it since it
+         * doesn't know the linked object. Increment it here to ensure the
+         * aliased clock stays alive during this device life-time.
+         */
+        object_ref(OBJECT(clk));
     }
 
     ncl->clock = clk;
 
     QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
-- 
2.28.0


