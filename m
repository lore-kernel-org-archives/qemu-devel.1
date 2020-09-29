Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3C0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E22520756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkkc6MuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E22520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOVS-00087U-5e
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMn-0006UF-5c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMj-0004dn-Ll
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:45:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwQAv7GT5EoZ2YwHLMCVUEVsXLr1pwlweOoW7BxG2J0=;
 b=gkkc6MuVVkg8IntSrsYZxzjw2QpnvUv3rVhqunb2QZb9FzwDamE7fG9aYmSacamT52d1bk
 kTWR4VO1Dj67bEOkLAPvHZnWhFeWI39XJ08mVcdhrhHKTvhRQRKSb4u1i39Ad/DH+DfPFu
 XvJfWUmthmuTHz2ILOBiNOiC3hOzkgo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-ScTBRYe9MQmxcsKtTC0o7A-1; Tue, 29 Sep 2020 18:44:55 -0400
X-MC-Unique: ScTBRYe9MQmxcsKtTC0o7A-1
Received: by mail-wr1-f71.google.com with SMTP id v12so2362207wrm.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mwQAv7GT5EoZ2YwHLMCVUEVsXLr1pwlweOoW7BxG2J0=;
 b=aMHL56yWgeE/1uhSizV5GxCSv3p+K0lxl1WJ/E0TGt90/xl/sMBl/pBaBHMPZDJDHb
 X3BtdppVsog3Ymnmj+KfxJmdrUT6sP++ssEYC5sWYaLOrX8Xm2laoJrrAA9jCd8Nsa/F
 OE4pCtTk3IK1ZWmzJlbSEs0VLq0ko28K5ofqJ0lywSdzuULx7qd2gL9UyugsToVGGmmt
 LF2/duZ7lLdbQN0GCpom9uid0dgZeUYEs3sOmjzF8RizT1ySOrf7e4sUJWIzC0a26q5E
 EO8ZOnH3iWD25t1Z9YLKB77fJ1009zbHQTbPZ3KDvNVaFk/BkDxawMpBVYGwZaN3NOBN
 NcKg==
X-Gm-Message-State: AOAM530gMsMzhEQo3ALljlbCS3twopxhUiaOFphj781HNXCfuwzCkZ+g
 UJQHbc41ykM2PjCAndS2l58XdzCRaOXUmkHQfMzlGXOO1sXc84YZnoHVA0Fn9zrWC25zXCxqwRn
 3p5tiFHpg7EbhCgA=
X-Received: by 2002:a5d:680b:: with SMTP id w11mr7120263wru.73.1601419494004; 
 Tue, 29 Sep 2020 15:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaezhlYa4iLWEZHwZ0kS7XLDzMCgEOlneNy29+EtQChDtpMkw2+jc9ZW303waN+0a4Rlb8Xw==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr7120247wru.73.1601419493850; 
 Tue, 29 Sep 2020 15:44:53 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u66sm15214592wme.1.2020.09.29.15.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/12] target/arm: Reorder meson.build rules
Date: Wed, 30 Sep 2020 00:43:54 +0200
Message-Id: <20200929224355.1224017-12-philmd@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reorder the rules to make this file easier to modify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
I prefer to not squash that with the previous patch,
as it makes it harder to review.
---
 target/arm/meson.build | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 9b7727d4bb..341af8f2ca 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -14,6 +14,7 @@ gen = [
 
 arm_ss = ss.source_set()
 arm_ss.add(gen)
+arm_ss.add(zlib)
 arm_ss.add(files(
   'cpu.c',
   'gdbstub.c',
@@ -21,6 +22,13 @@ arm_ss.add(files(
   'vfp_helper.c',
 ))
 
+arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
+
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c',
+))
+
 arm_tcg_ss = ss.source_set()
 arm_tcg_ss.add(files(
   'arm-semi.c',
@@ -35,26 +43,16 @@ arm_tcg_ss.add(files(
   'vec_helper.c',
 ))
 
-arm_tcg_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('m_helper.c'), if_false: files('m_helper-stub.c'))
-
-arm_ss.add(zlib)
-
 arm_ss.add(when: 'CONFIG_TCG', if_false: files('m_helper-stub.c'))
-
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
-
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_tcg_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('m_helper.c'), if_false: files('m_helper-stub.c'))
 
 arm_tcg_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'helper-a64.c',
   'mte_helper.c',
   'pauth_helper.c',
-  'sve_helper.c',
   'translate-a64.c',
   'translate-sve.c',
+  'sve_helper.c',
 ))
 
 arm_ss.add_all(when: 'CONFIG_TCG', if_true: arm_tcg_ss)
-- 
2.26.2


