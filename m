Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B392065F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiEpbcew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B392065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAjW-0003GN-NQ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgm-0006et-LS
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgl-0002U2-SY
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPKsbRJt9+h1QZ5ZVV7cawQ2hLkDBzrcL810MECGIUM=;
 b=RiEpbcewkKMs1J7IK9JY8RNSeO97WmQvvjtFfF+3joxWZ7rHvKrm/QrjBOoiEqg5O5ObT7
 /66V0FBgaybQmer3lqdqWX6Jfpa6dJEozoP/ODePmHZ4yPcXB8E5bSC5Envu12ze8mJGfa
 hoOr/zzkH8jZuNUT6Also/eeygKhpm0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-c97WLPUFMdiQYe-VvVoM_w-1; Fri, 22 May 2020 12:38:25 -0400
X-MC-Unique: c97WLPUFMdiQYe-VvVoM_w-1
Received: by mail-wr1-f71.google.com with SMTP id n9so4574983wru.20
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zPKsbRJt9+h1QZ5ZVV7cawQ2hLkDBzrcL810MECGIUM=;
 b=p71N2GYLxfO2d9qhfnqp8aPmdnHKnGmx4jtupDVcYljsiZ1P6T9fAfhwNmoGIOabxt
 E8H99uQEqPZp9c/AtMtvj1Fzk/FiBbrNs6NTxFHQ2EqtSJUwYn9mB0qX3KY17MpHIbml
 IwJCLekwq0x1u4peCqbwYUbACevOKC/R8e0YSNTW+ekNshX1mOYcYr0rFPwRJOsNkXjb
 5wOLgWMJRo2xaSG0+UpdAkusj/yqwuBL/3WyKAGuVGIBqVt9522nZYUAYxnWq5WK27D6
 SKar+iokL+99vdTQ5ceaC1Cpm5bmqU3O8Xy+C4NPflfY8NzVTm8CRGVesSADiRMS/myY
 CKIQ==
X-Gm-Message-State: AOAM531P7Lk1u2HGZnqa6cnnb25sJwjSym7Kb8Y6Yxf04dtibzrVUgt4
 3mC2NvSFmYR7NGnWL/zK6zBlSaTrWKL/lOX6dWbA0dzvuRkKTSOoqNA8u3N/b+zju46nlkb7sH3
 dZjybCdxRMf9+uyY=
X-Received: by 2002:a5d:6283:: with SMTP id k3mr4010275wru.62.1590165503978;
 Fri, 22 May 2020 09:38:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvccAQCLsXlZohF7IaPbmy9JYZk5H7N32zMfVsg9ojJLunE2SZwNXo210t2UtcjKLfYmiF0w==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr4010264wru.62.1590165503762;
 Fri, 22 May 2020 09:38:23 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m13sm9707946wmi.42.2020.05.22.09.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/11] rules.mak: Add base-arch() rule
Date: Fri, 22 May 2020 18:37:53 +0200
Message-Id: <20200522163759.11480-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
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
      print-base-arch-aarch64 \
      print-base-arch-x86_64 \
      print-base-arch-mips64el \
      print-base-arch-ppc64
  openrisc=openrisc
  aarch64=arm
  x86_64=i386
  mips64el=mips
  ppc64=ppc

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v4:
- use startwith()
- fix openrisc (rth)
---
 rules.mak | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rules.mak b/rules.mak
index e39bee93d5..2ce527e885 100644
--- a/rules.mak
+++ b/rules.mak
@@ -445,3 +445,30 @@ atomic = $(eval $1: $(call sentinel,$1) ; @:) \
 
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
+		$(if $(call startwith,mips,$1),mips,\
+		  $(if $(call startwith,ppc,$1),ppc,\
+		    $(if $(call startwith,sparc,$1),sparc,\
+		      $(if $(call startwith,risc,$1),risc,\
+		        $(if $(call startwith,aarch64,$1),arm,\
+		          $(if $(call startwith,x86_64,$1),i386,\
+		            $1\
+		           )\
+		         )\
+		       )\
+		     )\
+		   )\
+		 )\
+		)
+
+print-base-arch-%:
+	@echo '$*=$(call base-arch, $*)'
-- 
2.21.3


