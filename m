Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D485C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21ABC206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+VJ+Vhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ABC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBRY-0006oz-9s
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQL-00044F-Mk
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQJ-0001tc-3G
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzIXUjmQFMXKkBqElREelsSBtwnLlPTjL7FgZWSFFRo=;
 b=b+VJ+Vhpaqltx7qQLy8TkBH1NR9dIuXvnIEJmnhVQ4XbgoQFTIh/YGuoiQR56VIko0rBww
 ZuckFjirCF89aleCClQFhUzf4in4YAPD9eupB3oZINvEHXell7DUKOizLDZ8CBsFmzCe2c
 xxNJULB8nd+jCiKTE4wnLCtupY5sNLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-RmGrtnTeOCWl4_MkQK6knQ-1; Fri, 22 May 2020 13:25:29 -0400
X-MC-Unique: RmGrtnTeOCWl4_MkQK6knQ-1
Received: by mail-wm1-f70.google.com with SMTP id l2so4412920wmi.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pzIXUjmQFMXKkBqElREelsSBtwnLlPTjL7FgZWSFFRo=;
 b=ZGUPLFllLEMirQxPqtadsgmn3ENr7prSEgKZifAuapt6L+86JOEsFWBCn6H6X0eU02
 CyanGoaexXdkPvwA6duKAYxysMHKIWMGUCwUN11vnWV/d/fHjVPYke/hK/aBJnwDTkYY
 nm0kOVdxyM77aA8eYKlKy3owb7NaVAx0RWkyGj8/BVfuEaAsrwPGHSPYKaHpXYkeFdgp
 baYhed8Hlag7o9P6x6Oud7yIozQ517SLet0nGCfud9Qc2aYuOJavsU7bo0zzYu94NK0O
 dclCDbShjgHwxuGo7S3kYkfI7kIHtrpMn5w77zNZh5o+0dpKklJMBHgq+JSr5OfmcgCG
 ms0A==
X-Gm-Message-State: AOAM531nbbHJUczql1ma+yrXp9hAw5yFFnK1YQydeOolmjDny+khQltl
 cCcqSZz5fIBNjlHniwbUwZR5stYpMJLM9ev5cRrexcihmPpN+BlyzcJE3A84STAj+G49FBs5420
 Tlv3rikVd18c2xQY=
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr15191563wmi.65.1590168327640; 
 Fri, 22 May 2020 10:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFUMOXMRJNi03qmgZVgVUBNZc61FlTSbPs4N95RyygaMEs2jp8mbjr97TSoPRdKs+JzJXZLA==
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr15191544wmi.65.1590168327492; 
 Fri, 22 May 2020 10:25:27 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m3sm9950762wrn.96.2020.05.22.10.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/13] tests/Makefile: Only display TCG-related tests when
 TCG is available
Date: Fri, 22 May 2020 19:25:00 +0200
Message-Id: <20200522172510.25784-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6..6bc3d1096b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,8 +12,10 @@ check-help:
 	@echo " $(MAKE) check-speed          Run qobject speed tests"
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
+ifeq ($(CONFIG_TCG),y)
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
+endif
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
 	@echo
 	@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test report"
-- 
2.21.3


