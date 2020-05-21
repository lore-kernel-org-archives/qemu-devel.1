Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65319C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7DD20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+WC6zyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7DD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrOy-0003B7-Bu
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLr-0004Uf-MN
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLq-0008K4-LL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8n0YFO+GkTAJ70YrDyCWQHFcQ3B2rpDJ3HMzik7tebk=;
 b=Y+WC6zykAzUM9R+t/77YPnjxMvDaI+AJgb3zaldr0C5OXfskvplLuDfcpVLPZ+sO/ziDsD
 OViZOv5weqFbI2ZtjPSvgQNF2G7ZqgdgH3FgNl/Y9AN+WV30pQFbmxGBMpZM70qd7Fwm+y
 s5QqD5qS8+QS0+axjMtkrGTFRjfJO8Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-dVWcV3g0MlurdQlGZhGcfQ-1; Thu, 21 May 2020 15:59:32 -0400
X-MC-Unique: dVWcV3g0MlurdQlGZhGcfQ-1
Received: by mail-wr1-f70.google.com with SMTP id r14so3353802wrw.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8n0YFO+GkTAJ70YrDyCWQHFcQ3B2rpDJ3HMzik7tebk=;
 b=f0efkjIDgGrtwEysNMwwZeSmt8jzsr8oodQvpTcn2yfwZwsRjBSLSgZ31s4ocyVZjd
 dg5nh7Jf1pdH0qplf54tJ62HQku+xhWDoy+931W3pwRc8Mgm16hgUx3zRfNzYmxDY7Er
 7b6b/ERQjil2yu/FkFiEvsD5TMf2Vy7JwgbL29xqWznypsFZwUZ5ZjlBkibHr6/VmVDU
 NOX93RecUdeQ/E1CSWGrqVqxadiz30OhSj88Xsas8c01qUmdOFyWF6QDZ//h+Xkj6bXb
 5XoxE6/IcFqbryxMv/qhWNMIF7AXVKgaZ1+69ACTeN3SiqYKtpOnDkOVkHn3faesLj/0
 gy+w==
X-Gm-Message-State: AOAM531omuerBe1tMSbwcDzwRMVNil5mP5LZxOMHfOqghXtqIm2hpwuZ
 4ZlrXe7EnfgQhY0+BrXbB0o+KzVZTTMZLaKhyJLMS8d7j2gssjImvhV/s1R/rMez5nbQj67Z6Gz
 6SnneBdaoGjklVfc=
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr9536021wmj.146.1590091170780; 
 Thu, 21 May 2020 12:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlgGWH+n9W9cr3XjZ4gqfAZL0L5kC2xGoZnWi5HocvmVMMsWNDdtckiCifIUneNXcnwu3Eog==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr9535989wmj.146.1590091170602; 
 Thu, 21 May 2020 12:59:30 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m3sm7370853wrn.96.2020.05.21.12.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:59:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Thu, 21 May 2020 21:59:03 +0200
Message-Id: <20200521195911.19685-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d7b98f9878..0f76dc330b 100644
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


