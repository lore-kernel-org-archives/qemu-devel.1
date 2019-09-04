Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E2C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4231221726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5QoSQQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4231221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Yst-0003Ee-JT
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqQ-0001IP-4J
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqP-0006yc-4O
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqO-0006yF-U7; Wed, 04 Sep 2019 13:13:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id r195so4717309wme.2;
 Wed, 04 Sep 2019 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=voiG7DWCSdFTStaEL19HrjsIseLBzBfq9/zOs+pAh+4=;
 b=F5QoSQQn9lWthvpWyrS2ePfhHwzA6EJHxfekKenJN0c18EnLqz3KAhcG3ZIBCf4E/q
 xE1skhSM/IMpFgWWUFs6xfJEiucb/V7b6gjmdxWvq7iTPq/XHo5HY40sx0s31zf3m/oh
 02Bb2Sj29VaQ288BVZ75cPJewS39PX3o2fSqNUE1ZVDDaJAnoDBKnQ5gtWJlDGI/x5GX
 DcaVwU+lRM2nnrDj/re8zdzLBXfgY46FkrqxRAXTZwbQwmvDRhnQk0GIrs4aUHd6Jp7Y
 PIBPD2F+nKER7Esxkn58oJH6ALphmkjExJ417wAsJrf66NJyaMpVmmbUypjpIh6kprfc
 Lywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=voiG7DWCSdFTStaEL19HrjsIseLBzBfq9/zOs+pAh+4=;
 b=OvS4Kxx+Q1skfZ+WPy+a1/ee1TAOxQ2pIV2aREpA0qepmha6SQ0ui5SltW6WorgeXe
 xcBbAeVgtOgVmEzsZJys9RT8l23SsQTHhltJ6l1WYgtd8I0kGkX2Kml+ww+jjPXri5Kc
 aiFlWYs8RvSXJQ3zhCg/kaOxBAVCXJDVeqiZtblmBhRSYq14GeXBQUOcGCosZOtkOsaB
 DXkYHcj85jT8v6IQi2D+GcS+X3+99B9hPbUKSSKxCX0/rlEyqrtITyW1DfxqzMe5mitl
 XE0rj9nC3PSYRFrbDoW9CaQpDRrbVQLTYiOZowljGfEsWZ4t+RV1dVHo34qrOdsJiA1B
 uDCg==
X-Gm-Message-State: APjAAAVTtczqZHj/5bpqqUJ51VZ4Vd+FpELB9sCIbrHIZDKl67Q4BwcR
 59OQOiJp9yInwJ0vgAzDC10=
X-Google-Smtp-Source: APXvYqzBwRWU4J7GwgmLjJBorifDNzYqwpTh/zahtmZ1lnkaaK3FcvFf1OQKRni6r+6xIZqi+Nl43A==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr5520752wmd.104.1567617199881; 
 Wed, 04 Sep 2019 10:13:19 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:02 +0200
Message-Id: <20190904171315.8354-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 01/14] hw/arm/raspi: Use the IEC binary prefix
 definitions
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 74c062d05e..615d755879 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
-- 
2.20.1


