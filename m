Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C290B20823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj3+ZJ4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C290B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrQ3-0004wO-UG
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMO-0006BY-A5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMN-0008Qy-Di
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCqDKoDbHDQzikos0o2LjEgWBMdVhgQLRqeJNp7F0OE=;
 b=Sj3+ZJ4aRqoCC7tDeN/Vw2V4UtZfMBZiDPXKpGZYGADY0u9Jfy/vrAIZFcJzmc9ZDGEXng
 bRFV0cUGoCu96WPUnj8GeI+DMApHDP0JoM+OjMZZeeGgUmTbRY82h80cIKZy3xEPnvWQDa
 /WZUIcFxiA+rK6+yZ3r17SqRzO5/g8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-I3WwgFsDOlW1rVj0BuqbCA-1; Thu, 21 May 2020 16:00:05 -0400
X-MC-Unique: I3WwgFsDOlW1rVj0BuqbCA-1
Received: by mail-wr1-f72.google.com with SMTP id h12so3352114wrr.19
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uCqDKoDbHDQzikos0o2LjEgWBMdVhgQLRqeJNp7F0OE=;
 b=qLV9r87/miZ7VYFlALIDg8XAalZnCooocfvaZYtIeaIjMSY9JO6Q8O7oel3vDvcb0M
 GfrdE0nYRIvryktwnoNeLTgb6sWYKOa5N7tWaAz50z6I9vhlm+K54BU0sVig+RNrED+N
 FPWRbnZej0VjIvD1ooLJ7vy/+0puyShIfGpG4iV5evwIoIBYOCW2Xn+QY9/sCuTgBafr
 LSBenpzhNRC+FkpbDiZVg+KmF0sbldCQGmSYpenI1eVLzrSgf3xoaQ8g8BXyaFfZkPVj
 tMn14/qUNIUcdHO8kUWTcIJQClMIRXOhT5hOm+wBtM397aTzpzthVx0c9pO7DPwkT4+6
 xs2g==
X-Gm-Message-State: AOAM531+q8aYk6NBF2/H6Pcpbu6QD/zIzgqJLVeIxGP8mJ65nXqtsZsb
 X/hFpBhuX9vsSA+yAzlHWZ4Xeco3SkkJBaO+SCMFSuqtO6Ca49tkrFHmtbYqy9xgro94XSEnnMr
 lvyIh1X9nXK0WZHQ=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr10741402wmi.135.1590091203068; 
 Thu, 21 May 2020 13:00:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywHyPjca5Ebm/EgFfbvzqRAjli9WmO/+OLcUYJ6EuqdTuNua26itFRVzTeXh8ZYdVwl7Jebg==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr10741378wmi.135.1590091202739; 
 Thu, 21 May 2020 13:00:02 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h27sm8466721wrc.46.2020.05.21.13.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:00:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/11] rules.mak: Add base-arch() rule
Date: Thu, 21 May 2020 21:59:09 +0200
Message-Id: <20200521195911.19685-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:32:18
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 rules.mak | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rules.mak b/rules.mak
index 694865b63e..55810d0cd6 100644
--- a/rules.mak
+++ b/rules.mak
@@ -438,3 +438,19 @@ atomic = $(eval $1: $(call sentinel,$1) ; @:) \
 
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
+base-arch = $(subst $(SPACE),,\
+		$(if $(findstring mips,$1),mips,\
+		$(if $(findstring ppc,$1),ppc,\
+		$(if $(findstring risc,$1),risc,\
+		$(if $(findstring sparc,$1),sparc,\
+		$(if $(findstring x86,$1),i386,\
+		$(if $(findstring aarch64,$1),arm,$1)))))))
-- 
2.21.3


