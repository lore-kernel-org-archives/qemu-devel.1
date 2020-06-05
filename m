Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18502C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0F6206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VABW60r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F6206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGh6-0003xN-4A
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcK-0005PQ-Ev
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcJ-0000LM-HA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhooDoq31Iw0ds0BQEJhXV5JDDKysW0nQian/XkdMKs=;
 b=VABW60r937rqx6y/DhOzC0vz9HQfVEWSbaN9L1WfUi9HHwml30tfhTk0x/XiOVcPF+YisA
 LiXPgtQNajB+GANVrZmikrTiRHeKsm6vhGjzrIynT9YmbghDeUooX7L2Y/lPFDVCNYbfXH
 h+v2+Vp55IAnFOALuwG09ZvML/fq5rA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-AG2TvkrJMC6tVF1k5CPqpA-1; Fri, 05 Jun 2020 13:58:40 -0400
X-MC-Unique: AG2TvkrJMC6tVF1k5CPqpA-1
Received: by mail-wm1-f70.google.com with SMTP id s15so3239784wmc.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rhooDoq31Iw0ds0BQEJhXV5JDDKysW0nQian/XkdMKs=;
 b=PXmFT2SPaW6gjyF6ZJ7kD/Kx1lqendNo5on2Xp5B4sEPF00Lm1IFXo1QyuFKHD8+0d
 W6EK9GbRlHUuY5pRXc9ir6fgNTAGFPndgXnQiYrLGquou5dTN2yUzs/3Vu+C0CZHKmCs
 Fv3clDzW+QXhTZFCHgiDdUcOeApvy6HWFzfrz2SUS85vHfsJMdXimRL16pmcXmjs/WK8
 2X2eim+LO6In7HJJO2y7/x5Hjbqkux1+SAZ9v8hInTJjhE4D4BLMQzb4dmMlyRpYvWze
 7lu98QAbrFWiETrKBq7352a5SE+cyBPXTDZeKmQ4Tm1Je1tK6XYAuP6so2MJvjP0fO8I
 yl4Q==
X-Gm-Message-State: AOAM530C9WypHrAKE3ypwXWgHSaf2hzcTIlT4y5X90Gi7M+ogFtzpABg
 RD9N+TMb07++HmrxyIlJ3mqhKf3x5WcqDfarWAnJ89QMaOIsx6hq1Kn4c/vL0TOTDN4acWE2iow
 iOMs4w37WAKLgbBI=
X-Received: by 2002:a5d:4745:: with SMTP id o5mr10343014wrs.87.1591379919070; 
 Fri, 05 Jun 2020 10:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq6LvB99CRuX1fVGYHSKPHPB/4etyBd6KiVsKm0cPJswbHsl46MFkRyGii67lPdObDlYJAAw==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr10342996wrs.87.1591379918876; 
 Fri, 05 Jun 2020 10:58:38 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c5sm14049878wrb.72.2020.06.05.10.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Fri,  5 Jun 2020 19:58:13 +0200
Message-Id: <20200605175821.20926-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Palatin <vpalatin@chromium.org>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tao Wu <lepton@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nobody replied since the first time [*] that patch was
posted, so mark HAX as orphan.

[*] https://mid.mail-archive.com/20200316120049.11225-4-philmd@redhat.com

Cc: haxm-team@intel.com
Cc: Tao Wu <lepton@google.com>
Cc: Colin Xu <colin.xu@intel.com>
Cc: Wenchao Wang <wenchao.wang@intel.com>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f725c12161..05d7210204 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,6 +426,12 @@ F: accel/accel.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 
+HAX Accelerator
+S: Orphan
+F: accel/stubs/hax-stub.c
+F: target/i386/hax-all.c
+F: include/sysemu/hax.h
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


