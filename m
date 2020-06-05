Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B23C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E838D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IayJJ0n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E838D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9aP-0005De-6R
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9WX-0007HX-BI
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:24:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9WW-0006ia-K2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/743Z1QyCRowFD2sBc8yC4KQi0Lmbj/XYRlJsfWAxhE=;
 b=IayJJ0n/luS5Sq2w1vWMSBHF9FI3IeunXnyRkCWbZIcQXWDdgWTy8cwokhrwG4a8bsFhqy
 zv/nB+XlgAItPLolyDxfolNYbGcAtZyKpfLfdtNQRD0+d7jFgDdNGpCcgDM78a5fHm72eb
 H/ovLTsYtGlnHQbfpbPie2EVToqGQOE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-3gbEtARkP0-fNPjxZYTYdA-1; Fri, 05 Jun 2020 06:24:26 -0400
X-MC-Unique: 3gbEtARkP0-fNPjxZYTYdA-1
Received: by mail-wm1-f70.google.com with SMTP id u11so2843583wmc.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/743Z1QyCRowFD2sBc8yC4KQi0Lmbj/XYRlJsfWAxhE=;
 b=tYokkK6ZF8OinUdpN062vJi3Gi2LIU9o6YMJzbXwEe3f/XaLMYtHHGiQnfCdDF9nJ0
 EvSeVH2/LBKbN8S/dCOF+oEjY7iCMXfnBwCTna+FjqMyNYDf/Scs6vLa67q13QkNtV+x
 Vs+nF4+iXb0JE/WMxmGL6tmSuG1IrL0zEKYMKzXuUoh+gU8aL01N2HPW8e5JjLLvIfSY
 WXuefyRqX6P8PUy/8846VHCRfpn6Ug8B3i8A58Kwv1BqS93cRo62Gusumo42EonhRbmX
 i2MCQtu6VCm9Pea8/ozKH8qpSrU+doWxeOiGvoPJN2eJ1QmL8XOn6Zy1+71TORjPerxR
 1cng==
X-Gm-Message-State: AOAM530TXt9z73AYoY/eg4VI5ulaIvEx1B1e9jUHKPQP2LBMkVRjwafu
 eQeE5m9Nz8Lz7IUEmpDQuYS1h+B64a2CNC1yM8gvVgK4RvQFYlyN1nX1cNEXMZmoLXza8QahK9z
 MtCbQVrC9E1VdpeI=
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr372867wmj.144.1591352605071; 
 Fri, 05 Jun 2020 03:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAovcUB3nYBZFOQy3cP29FUa8Tar7jITLsTOdjGHAtir/ecZFqj56zF0bezkJyYqEZGsQ0GQ==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr372848wmj.144.1591352604869; 
 Fri, 05 Jun 2020 03:23:24 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y17sm11833422wrn.12.2020.06.05.03.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/11] hw/sd/sdcard: Simplify realize() a bit
Date: Fri,  5 Jun 2020 12:22:30 +0200
Message-Id: <20200605102230.21493-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We don't need to check if sd->blk is set twice.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a1b25ed36f..060ca9d993 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2123,12 +2123,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sd->blk && blk_is_read_only(sd->blk)) {
-        error_setg(errp, "Cannot use read-only drive as SD card");
-        return;
-    }
-
     if (sd->blk) {
+        if (blk_is_read_only(sd->blk)) {
+            error_setg(errp, "Cannot use read-only drive as SD card");
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3


