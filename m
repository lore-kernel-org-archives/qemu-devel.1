Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9177C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0187206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xj0OhjB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0187206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdrT-0004Rq-Qe
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdp0-0007ZO-Rj
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdp0-0002vi-5J
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuX27WNv6Kn8UhBL2AA1RqIUWcivIj63B6OZkuFogSI=;
 b=Xj0OhjB3fM8Jwx2X0MGDWIo0IB1mdpfiKJFVa+20vpFpRqE/siTG52DHERg9WLPTX2SjO8
 +SBjUL5OoOp4yr/WrDnSRNen8Ec8jj9NhUt6U/fIkttYzMfo9/8XkaH2/C/H1XYMh8aei5
 axvIWDuFOk/6lb+oH6+U3Mw+x137Xok=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-LUWexmLRNRyzKsMYiLUbwA-1; Fri, 15 May 2020 13:08:25 -0400
X-MC-Unique: LUWexmLRNRyzKsMYiLUbwA-1
Received: by mail-wm1-f69.google.com with SMTP id n124so1265829wma.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WuX27WNv6Kn8UhBL2AA1RqIUWcivIj63B6OZkuFogSI=;
 b=j+1DzDnwUbVNgXzu7CuVx6eX4mG5m09Ry6h2IRsteLnRK01JqLH1J7Ab4NHDaDEjMD
 J5xweLu2W2z62bCn0rZZxeKT7cFiPBqkR1nqq0OT7LEUgpMZs6F20zXDT0pigpsaEsrS
 lpdm4aEcAxcLoB+UgBAHa6oANe/nHd8bYqPoYakUaWeVys5gSzB9mbxK5lfKCF4HLrTK
 AUnlJmxwD6siYAGED7aIA+CxyCyxYnxJbyYU5wYiYt7Fuk4va2h6iz4aEirX6EPQ+p70
 H8w86AeYJvCjbIPdRVn87TKCJjAKF1Bph/SEqf3ABBagvwU4jIGT67hSRt8/nl6LQoMk
 UpLQ==
X-Gm-Message-State: AOAM5304vUdQRkrotYet3DqMoTPypqznjy9d2+1q+zUz6wD8zxsyk9ZL
 L8iVGgnx+mu0+Gfb7BBndknMks8Sa/PPe8a2RG8P9ovyocHL9x4oyqLQi8+rNdmQ1PcbMJU3I2B
 lSGEAF4g1U2eV7Is=
X-Received: by 2002:a05:600c:2041:: with SMTP id
 p1mr5373996wmg.152.1589562504035; 
 Fri, 15 May 2020 10:08:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9VffLWNGOL/oI/tLQbfVUADB9+49+0dkca4XV5cjM4nxFEkeGTcSn85uECbfY2blt2s7vFA==
X-Received: by 2002:a05:600c:2041:: with SMTP id
 p1mr5373962wmg.152.1589562503876; 
 Fri, 15 May 2020 10:08:23 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 5sm4554811wmd.19.2020.05.15.10.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:08:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/10] MAINTAINERS: Add an entry for the HAX accelerator
Date: Fri, 15 May 2020 19:07:57 +0200
Message-Id: <20200515170804.5707-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515170804.5707-1-philmd@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Colin Xu <colin.xu@intel.com>,
 Yu Ning <yu.ning@intel.com>, Tao Wu <lepton@google.com>,
 Marek Vasut <marex@denx.de>, Vincent Palatin <vpalatin@chromium.org>,
 David Chou <david.j.chou@intel.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, haxm-team@intel.com,
 Hang Yuan <hang.yuan@intel.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@intel.com>
Cc: Tao Wu <lepton@google.com>
Cc: haxm-team@intel.com
Cc: Colin Xu <colin.xu@intel.com>
Cc: Hang Yuan <hang.yuan@intel.com>
Cc: David Chou <david.j.chou@intel.com>
Cc: Wenchao Wang <wenchao.wang@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 659092eb43..5172e9a734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -424,6 +424,12 @@ S: Maintained
 F: include/sysemu/accel.h
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


