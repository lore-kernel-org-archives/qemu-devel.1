Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24685C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29562074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5xVBU9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29562074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGdX-0006nh-6M
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcI-0005Lu-OI
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGcG-0000IE-Gs
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSOCEBN9BjVMOixsoI8rbZYG9y/X6ScSulzjzqLLaGk=;
 b=B5xVBU9fluI3TFIqO4un3pFv/hIvYfG5SWnX7gppUdDsQP4b9IM2BegXcSPWDsLWVrdh+4
 70dtuvog30h8poNCj47k+6jD7I0IXCDyZ4G5K1UI9IWGai7hznjFlljU0XhApMWbn+mD3r
 CvjsL1nRrJpgAFt9aVciIrT1dhqpKMc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-nApHhCwUPjCc7dYyw1FmYA-1; Fri, 05 Jun 2020 13:58:50 -0400
X-MC-Unique: nApHhCwUPjCc7dYyw1FmYA-1
Received: by mail-wm1-f71.google.com with SMTP id u11so3239619wmc.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TSOCEBN9BjVMOixsoI8rbZYG9y/X6ScSulzjzqLLaGk=;
 b=hkL9o8G4f3G0TkiXRoKxJlXQTPgrgMiAY74rKoBiS+xKuECObpT1/4cfZ47zYO0EtL
 iI7z26PrLLn0zP4Di/tMQSMaV9VF5+LDqdwCBDHKDT0lzIT4A5nhLZ79kZGwRlALZmoW
 SNKYDuh0KrAwdqtwRuTr4fy1SEwXjLt0d1WHt8092u/C4+zAtVssSKy3JrHj1ZY+PWhd
 fbhbVYziwttTfw90DpojDykhfY+/UrdkT18Y/Jfen7cId4kU56Yw+ehLeKEVmdzjq1dB
 LEZJ2bCiBGro/gz5OWPljF6HoMFfwqfxmfmBVzLqq4XrTX1zlxHgK6Bqh7NEwopQo56G
 sJgg==
X-Gm-Message-State: AOAM533PFl+KmgpvFbOJFM+DTMVzAhctD1akAawSFWYmP5ipn8tv0vBT
 Yp3qG7vakLYfARlBMSUEnvxmpJGygribFiyk26wQ1Xn4ry8rgJRw/q602EKUZgPoXh3HX78oWuD
 K6YxGAPUtlEmwVIE=
X-Received: by 2002:adf:a507:: with SMTP id i7mr11867031wrb.0.1591379929023;
 Fri, 05 Jun 2020 10:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf17Orc713wgG4cQIcdn7Ut6kLKdGwjZcozhnUr3qQcMaVEwsjDzILsEbBJhZECZomwEZaCg==
X-Received: by 2002:adf:a507:: with SMTP id i7mr11867018wrb.0.1591379928850;
 Fri, 05 Jun 2020 10:58:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y14sm1850296wma.25.2020.06.05.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/11] rules.mak: Add base-arch() rule
Date: Fri,  5 Jun 2020 19:58:15 +0200
Message-Id: <20200605175821.20926-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a rule to return the base architecture for a QEMU target.

The current list of TARGET_BASE_ARCH is:

  $ git grep  TARGET_BASE_ARCH configure
  configure:7785:TARGET_BASE_ARCH=""
  configure:7795:    TARGET_BASE_ARCH=i386
  configure:7813:    TARGET_BASE_ARCH=arm
  configure:7846:    TARGET_BASE_ARCH=mips
  configure:7854:    TARGET_BASE_ARCH=mips
  configure:7864:    TARGET_BASE_ARCH=openrisc
  configure:7871:    TARGET_BASE_ARCH=ppc
  configure:7879:    TARGET_BASE_ARCH=ppc
  configure:7887:    TARGET_BASE_ARCH=ppc
  configure:7894:    TARGET_BASE_ARCH=riscv
  configure:7900:    TARGET_BASE_ARCH=riscv
  configure:7920:    TARGET_BASE_ARCH=sparc
  configure:7925:    TARGET_BASE_ARCH=sparc

The rule can be tested calling 'print-base-arch-$TARGET':

  $ make \
      print-base-arch-openrisc \
      print-base-arch-aarch64_be \
      print-base-arch-x86_64 \
      print-base-arch-mips64el \
      print-base-arch-ppc64 \
      print-base-arch-riscv64
  openrisc=openrisc
  aarch64_be=arm
  x86_64=i386
  mips64el=mips
  ppc64=ppc
  riscv64=riscv

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 rules.mak | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rules.mak b/rules.mak
index 7b58a6b8c5..c4f2f35754 100644
--- a/rules.mak
+++ b/rules.mak
@@ -452,3 +452,38 @@ atomic = $(eval $1: $(call sentinel,$1) ; @:) \
 
 print-%:
 	@echo '$*=$($*)'
+
+# base-arch
+# Usage: $(call base-arch, target)
+#
+# @target: the target architecture.
+#
+# This macro will return the base architecture for a target.
+#
+# As example, $(call base-arch, aarch64) returns 'arm'.
+base-arch = $(strip \
+		$(if $(call startswith,aarch64,$1),arm,\
+		  $(if $(call startswith,arm,$1),arm,\
+		    $(if $(call startswith,microblaze,$1),microblaze,\
+		      $(if $(call startswith,mips,$1),mips,\
+		        $(if $(call startswith,ppc,$1),ppc,\
+		          $(if $(call startswith,riscv,$1),riscv,\
+		            $(if $(call startswith,sh4,$1),sh4,\
+		              $(if $(call startswith,sparc,$1),sparc,\
+		                $(if $(call startswith,xtensa,$1),xtensa,\
+		                  $(if $(call strequal,x86_64,$1),i386,\
+		                    $1\
+		                   )\
+		                 )\
+		               )\
+		             )\
+		           )\
+		         )\
+		       )\
+		     )\
+		   )\
+		 )\
+		)
+
+print-base-arch-%:
+	@echo '$*=$(call base-arch,$*)'
-- 
2.21.3


