Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ABC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5E7207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpYAvYZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5E7207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8la-0004zn-1m
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j2-0000HS-QX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j1-0004ZW-MG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhooDoq31Iw0ds0BQEJhXV5JDDKysW0nQian/XkdMKs=;
 b=KpYAvYZ3xLN0E/2HXpeziT1idAOZCkX7RD7LfctiC3Nv2NHau5SsRHCBsY6gRYb1A3DIPa
 97Tqsts3S6ynxyW+Cd7uaxud2nb3DSKIFimN5Yp23IOT3ooOrB6edbH8GLNymQZCvpvlqv
 Zz2RVlVBVWM0j48Jp5PkAlq15uVRuZ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-QkhnKTg0MxiuQbuYBI6xJw-1; Fri, 05 Jun 2020 05:33:15 -0400
X-MC-Unique: QkhnKTg0MxiuQbuYBI6xJw-1
Received: by mail-wm1-f71.google.com with SMTP id l26so2809753wmh.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rhooDoq31Iw0ds0BQEJhXV5JDDKysW0nQian/XkdMKs=;
 b=LMB9V58xv55SnukjPBOPPQMd6IeIA3PLd9Ybi5wP3HtrqFlyplmjFdtwv5eJkchNFl
 bfiEtAaQ0+dWaScPdfQ2Y5BVhNaMqDxQagzltY/Ky+g0QSAjt8737yWWz3UG9fRn6nQ6
 BcXiHYPGZBIR7k0VtwTH1l0tQMLlG6RhdJDcWm6TYn0DuOThf8iu6Ig67wYDuAIvgdsr
 LRIor4oFaYfFM2zZepoZkmVQT+LauoGq/i0A8E2aX9gkBCt/KPPj8zyPNLr28AcMUVOD
 KW/JX70IcjzGdJRHi8MiSaXTwZt7k8aem8ZAa+xBR0EHhr5pRrCltIbttQoF5e7U1uhm
 390w==
X-Gm-Message-State: AOAM5328NaIaHriZ7jp1v5cNCTIPfu3QaM6uDi2tAVkGbI2Ff2Us/RXY
 Ht/kE2p0w+WNXXmye6j8xfzYnaSXXda7VqIgaf4XO9toGu5yV9kXeBOC6pPgTB4j3h98PfWw6tq
 VzxODgH8NMh2fGkI=
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr1770630wma.87.1591349593752; 
 Fri, 05 Jun 2020 02:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhkQHGbrs7h59u9rayg1cXlgrdCtllSBGRA9jrX9r2l6Bcneb8lbo3JB0Rsvs7sPhfTWb93w==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr1770609wma.87.1591349593552; 
 Fri, 05 Jun 2020 02:33:13 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c5sm7019115wma.20.2020.06.05.02.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Fri,  5 Jun 2020 11:32:48 +0200
Message-Id: <20200605093256.30351-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
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


