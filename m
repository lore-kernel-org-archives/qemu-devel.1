Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BDD206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAhNO+iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BDD206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8le-0005AN-Rv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j9-0000Qm-T2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8j8-0004aW-QH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNsloOXx+ZPFLkxXkn6jKW9LNpB7+wkZVTwvjxmYgbY=;
 b=TAhNO+iWTWJofIK+FTRhd/8SEIpwmfv+ns7bd/PVaMjJPQRUsxzdUrMUqdmWwbBJR9QR3r
 VS+7XsFGIBPgn2uCeSNG451iLMLbIBCW4agngI2PfDbqpIY6mJouQ37mp33hdi3U8AIv1O
 7adHwhrwqbxjkeo6yHJ5V7qCTwr2hx4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-T1iz8TeoPhmh0TNetZS-nA-1; Fri, 05 Jun 2020 05:33:24 -0400
X-MC-Unique: T1iz8TeoPhmh0TNetZS-nA-1
Received: by mail-wr1-f72.google.com with SMTP id p10so3549642wrn.19
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RNsloOXx+ZPFLkxXkn6jKW9LNpB7+wkZVTwvjxmYgbY=;
 b=Idjr+zmxop7RflDo4Z/GWB6/TqiigRV/g83tuQ6KAnPlKv37vjW7CUFRgTFoMEaUkB
 T4+9xsgu6cQ908FI/L9ysjWozp2kuxH6GElXLjLfmhlyLqeyabu6xdffxIDwuFUtUqVT
 DEFFNe0hMyC/rexhP/ZL703iwrWJrkZgI1/GXACaVG1chlS1pxrPrqAgoGBT5Mz0yRKn
 nDFz0ShsR0nJqiqLzoDxBIVkN1rnus+EHxOPG4Jl8rd9+RdBuBmYXNipzkY9PTAdaB+D
 ehLhJk2t4DxZZ/Ap4bu97aob7YjWNRpWjtaEHcood7xJMFFZwW18rDxfR1UtEeKKl1oE
 FvUg==
X-Gm-Message-State: AOAM531/oPbyFNCi5YnVPmTaVBlMA1V46B4C5B/NouXDzdQIRMMDjKY9
 Julad34zEqb3zhacaRsgxwJBU3H4kgj6WoZZF8Q5K+Ao4bpLAdulwN2J0dgNiQ689aXe+M0u6MM
 cm+8o1ty2537O/eI=
X-Received: by 2002:a5d:6944:: with SMTP id r4mr8486413wrw.169.1591349603233; 
 Fri, 05 Jun 2020 02:33:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjsPk+rlqQW/VnXkeauOZFbxWxwVuEYACRvUPsj6B/watwjDI+Zc3M4ChYQbDuCgy6AMLbvA==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr8486396wrw.169.1591349602985; 
 Fri, 05 Jun 2020 02:33:22 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm10724745wmi.16.2020.06.05.02.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/11] rules.mak: Add base-arch() rule
Date: Fri,  5 Jun 2020 11:32:50 +0200
Message-Id: <20200605093256.30351-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
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
index ccc1c49604..907f9aca91 100644
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
+		$(if $(call startwith,aarch64,$1),arm,\
+		  $(if $(call startwith,arm,$1),arm,\
+		    $(if $(call startwith,microblaze,$1),microblaze,\
+		      $(if $(call startwith,mips,$1),mips,\
+		        $(if $(call startwith,ppc,$1),ppc,\
+		          $(if $(call startwith,riscv,$1),riscv,\
+		            $(if $(call startwith,sh4,$1),sh4,\
+		              $(if $(call startwith,sparc,$1),sparc,\
+		                $(if $(call startwith,xtensa,$1),xtensa,\
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


