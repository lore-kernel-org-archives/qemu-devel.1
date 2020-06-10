Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3963C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBCC2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO2fmstC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBCC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisQR-00077o-V3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKE-0006xK-Lv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKD-0008D8-S4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yihp2yFMcguSy9jFeXkGeBwz3LCEihh+GUUxuBuxjO0=;
 b=ZO2fmstCxfuiUtRK8h9O9Bd7XdZEY1N9qBYZ0JqVBiRRrCG4Rw5WcJCKWN4yHCSiRBUtNV
 nt4YAu1aC7gxvuUhinrHE8+sfYsb5cmHl3eYmgwN+GW0XN07/KEz2JsxnDWiFy9mdWaZaP
 +sVNyvygFVfNsWAtzXgPdzWPL07povI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-s9YHzycFPYuZMr3sg48FTw-1; Wed, 10 Jun 2020 00:26:51 -0400
X-MC-Unique: s9YHzycFPYuZMr3sg48FTw-1
Received: by mail-wr1-f70.google.com with SMTP id r5so510380wrt.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Yihp2yFMcguSy9jFeXkGeBwz3LCEihh+GUUxuBuxjO0=;
 b=UsoNoXW+lTRcER/pYw4mAg4Juu5DqR/Kd20fUQfQ8YOg9C9Gl3uk/SYv/NGGnm3uGV
 bbhrifEcgpEs3jJEavsmIL2oA5UgaHtjh0EHw+++9ehCMJFT7QgRFf5xm2e5OLVfii+b
 GCrH8IdjkSZgspd5CW9R+j5FbojRKI+5HBKOj7bBGazmBO2dPY1KXXok6fI0lErU74tl
 EPvpEO22v9UKQceA9TCvELoydeRK8oBfQaEnzDMkskvQLddUJuau9UXvyqQdPe0RJu7y
 uCh1n49jPl2QTZkSEnrnb5G76v9Blzfk0Dw7hzeJtkESJtUFy3KO5vJCwnZy2IW9tfKQ
 qCuw==
X-Gm-Message-State: AOAM530nYkG8v4VOzw7RneUzdgS+Q6hvy+8+HUnqSCpMRec0U/VZGRH+
 EUlN2idOLLtsg1VUf3/6gmRFdeDXdSMJE/rpjf4tsAk5SvaQeTCe3l6ngEmpECAzh6iS6lsFrTH
 or3b5tJBSGxKXm+w=
X-Received: by 2002:adf:a396:: with SMTP id l22mr1315948wrb.24.1591763209810; 
 Tue, 09 Jun 2020 21:26:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrY3G5RRCWNnv+J8jSeRY7r0/ZNO2JyEpuF/iFjRLg8h/qJof7fs66Hw1yvJTf3EDkMObltA==
X-Received: by 2002:adf:a396:: with SMTP id l22mr1315931wrb.24.1591763209605; 
 Tue, 09 Jun 2020 21:26:49 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id p7sm6081118wro.26.2020.06.09.21.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:49 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/56] acpi: rtc: use a single crs range
Message-ID: <20200610042613.1459309-8-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use a single io range for _CRS instead of two,
following what real hardware does.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200515150421.25479-4-kraxel@redhat.com>
---
 hw/rtc/mc146818rtc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index fe05a4488e..1e9fa0f33f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1013,12 +1013,14 @@ static void rtc_build_aml(ISADevice *isadev, Aml *scope)
     Aml *dev;
     Aml *crs;
 
+    /*
+     * Reserving 8 io ports here, following what physical hardware
+     * does, even though qemu only responds to the first two ports.
+     */
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
-                           0x10, 0x02));
+                           0x01, 0x08));
     aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
-    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE + 2,
-                           0x02, 0x06));
 
     dev = aml_device("RTC");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
-- 
MST


