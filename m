Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFD52083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3vaolFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFD52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOYE-0002SL-Uv
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMn-0006UD-22
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMh-0004dZ-3r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HavTR5jlyYY+4DgutSw3BluUcAU3B5yxPF0wWIdw1vM=;
 b=B3vaolFATMUgiN6x4OmWtIzi0Q1ltMBGFSnW73IW8hn8KOPjLR3145Spc6SJRJzo4kua2d
 7Z+UjR2yPXB36rvyKQJ4afFRsQm1qDB+khtS0ZKURRJm76fYLpzdoy224heAuG5cFhnNKW
 nJ42VBYy1dVLiN4YXMEiXgBBrG9+UqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565--R2Wd9FxN_6L0vuCZ0uLzg-1; Tue, 29 Sep 2020 18:44:50 -0400
X-MC-Unique: -R2Wd9FxN_6L0vuCZ0uLzg-1
Received: by mail-wr1-f72.google.com with SMTP id 33so2342102wrk.12
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HavTR5jlyYY+4DgutSw3BluUcAU3B5yxPF0wWIdw1vM=;
 b=KI5JMUzeBl7GRTgMkbgOIRy1wR/JnStUBxmyYsxvLljhO8v9o//Tf/G3lCJN46siQY
 6B3DzjlAgp9cE/45bJeggA7k28VkNtcZYQyY7KvzorSr3XtHxlLE4hoYgzq/XUjnu+xr
 ZbrreFblUM6KupIOBaoSqs5o/WUZsPMwhd7ExlNnNN1hoGSSYPbBd1v85YxCNGli0pRE
 gGJjKPcs27vICL7P0SYfqKcVbkKJjKaEDdyFR3ov30v1FQNqrzcKP+IvBi4Gc2B8P8nc
 6uwq/oF9jlDJcfk74foujbuPub+bv4sqMbqMDtNKcjq0q0bnEL05ItXUzI8fE1RKYDF7
 0vVQ==
X-Gm-Message-State: AOAM530RjcWzEEHwX+faiI8e2U7MbL07atdXT6yupiKJ+uVVBA/i+kyr
 rxdcYNd2u7FmEtFbfFPzHuwuoNGqjUtHkByc4T68o8sz0YngA3ob5DX/9yPOrp4xpGhgFuAtstV
 oAl4Tbv8efOLSd0E=
X-Received: by 2002:adf:f552:: with SMTP id j18mr7126144wrp.128.1601419489040; 
 Tue, 29 Sep 2020 15:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8PSYX9/XyNa0d4ovucJYi4QupKVwuKDBSqVqoLbQhr626hwpDLMGmdduFj20kYY9OEgIMog==
X-Received: by 2002:adf:f552:: with SMTP id j18mr7126125wrp.128.1601419488887; 
 Tue, 29 Sep 2020 15:44:48 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t4sm8074682wrr.26.2020.09.29.15.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/12] target/arm: Do not build TCG objects when TCG is off
Date: Wed, 30 Sep 2020 00:43:53 +0200
Message-Id: <20200929224355.1224017-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

We can now safely turn all TCG dependent build off when CONFIG_TCG is
off. This allows building ARM binaries with --disable-tcg.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
[PMD: Heavily rebased during almost 2 years then finally rewritten =) ]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/meson.build | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index f6a88297a8..9b7727d4bb 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,24 +16,29 @@ arm_ss = ss.source_set()
 arm_ss.add(gen)
 arm_ss.add(files(
   'cpu.c',
-  'crypto_helper.c',
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
+  'vfp_helper.c',
+))
+
+arm_tcg_ss = ss.source_set()
+arm_tcg_ss.add(files(
+  'arm-semi.c',
+  'cpu_tcg.c',
+  'crypto_helper.c',
+  'debug_helper.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'translate.c',
   'vec_helper.c',
-  'vfp_helper.c',
-  'cpu_tcg.c',
 ))
-arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('m_helper.c'), if_false: files('m_helper-stub.c'))
+
+arm_tcg_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('m_helper.c'), if_false: files('m_helper-stub.c'))
 
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
 arm_ss.add(when: 'CONFIG_TCG', if_false: files('m_helper-stub.c'))
 
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
@@ -41,6 +46,9 @@ arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: fil
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c',
+))
+
+arm_tcg_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'helper-a64.c',
   'mte_helper.c',
   'pauth_helper.c',
@@ -49,14 +57,16 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'translate-sve.c',
 ))
 
+arm_ss.add_all(when: 'CONFIG_TCG', if_true: arm_tcg_ss)
+
 arm_softmmu_ss = ss.source_set()
 arm_softmmu_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
   'machine.c',
   'monitor.c',
-  'psci.c',
 ))
+arm_softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('psci.c'))
 
 target_arch += {'arm': arm_ss}
 target_softmmu_arch += {'arm': arm_softmmu_ss}
-- 
2.26.2


