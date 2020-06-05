Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C23C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45E4207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLEyhzRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45E4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh71L-0001Qs-Tu
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xn-0002Mk-Tc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xn-00056F-0D
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFGkz0p8Ozik1u5VT2fQxUZYeytpG6hcbiN9ZEF3zxA=;
 b=WLEyhzRMeLGDfqXXzaqaY5USTyPgUs9N1GxMk1tPwM+5BefD8HFEFLszi8HVyo5342L4ZO
 vWJCH9g8PEG2JDRmkU10CANIV1gMIwUnk/gagPNB3j844KIAe1NTGGhJ1ibYsOQNTBIa+8
 CluF+3QS2f8M9AX3TNqGS4sZW/kAIsE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-5werW9iVPiGc5zPQt0IUEA-1; Fri, 05 Jun 2020 03:40:22 -0400
X-MC-Unique: 5werW9iVPiGc5zPQt0IUEA-1
Received: by mail-wr1-f69.google.com with SMTP id l1so3408857wrc.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VFGkz0p8Ozik1u5VT2fQxUZYeytpG6hcbiN9ZEF3zxA=;
 b=UrbxV8YP+V9omW56qWAfb6vB1Jdn4qFLjfXnwoeZQ9WaTWTDgP+xrWnWJokykHcHzN
 JN246MS8U50pi0YZ5vViYMKgSsoQGibmDqSZsTcEFNYyl6ZFKVAAxaSl2JML1qgtUsvA
 3fr9wkoZ5oxJ5i6ypqhYKQXdysagd+xANEIdMzQRBbD2JlReybtCz9bvRbmh8XsoLVFQ
 FNCRdupQnWOCYq4lDW7ztrvLKcQ1GCdSEDZaRUuz2b9mE70PZj+1ZtOdgK6HLFWhFMe8
 E4y4zSXpc20DRlfmvvxxrJZYWtt50GEJ1MXIe1hKRQSjtSpwJXcJK18a57DXybreI63r
 sQUw==
X-Gm-Message-State: AOAM533L4xBjtvR4/0Sk7W5+f36Vi0sZDqgvRaKaAD6rJo7qm0gUsbHF
 VbMASltsH3nhCyBGQQENTcRibNjwR+ofiPZbs+OynO3bINevkKwb9nx6Ie6u4fG+4w6l8cYwCGa
 r+31AVDgOXh4fiGg=
X-Received: by 2002:adf:8b55:: with SMTP id v21mr8608978wra.187.1591342820778; 
 Fri, 05 Jun 2020 00:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN19mIF1iE06AjpBLrNf8TYxvvfAjsvWZfF2+UGLaRVmFFmTavxzcT1AozrLBvY7ca1KvWHg==
X-Received: by 2002:adf:8b55:: with SMTP id v21mr8608965wra.187.1591342820560; 
 Fri, 05 Jun 2020 00:40:20 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y80sm11319660wmc.34.2020.06.05.00.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/11] rules.mak: Add base-arch() rule
Date: Fri,  5 Jun 2020 09:39:47 +0200
Message-Id: <20200605073953.19268-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
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
v5:
- risc -> riscv (rth)
- use strequal (rth)
- add microblaze/sh4/xtensa
v4:
- use startwith()
- fix openrisc (rth)
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


