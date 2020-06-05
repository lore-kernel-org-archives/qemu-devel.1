Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8523A207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaBEnq2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8523A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8rQ-0005wO-S8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jY-00012r-T9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh8jY-0004bv-2k
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgLubjKz8VmCZqpELU1JLw/uHIcEFx15X1H+hmJK3kA=;
 b=JaBEnq2k4j6isJxgluZfkvyv3fDGFss281Aw/8pxHzAl8vqdxPCTvFzXm2VySKGEYQNxTJ
 UlF2aFR+nJJKH3KVRhFuW9NBq+JfxA3b7n9fRFH4drlhQ+XfHPGBHrXUgC2R5pMShBVTcX
 bwnECPTuIp7j2OrmUFJS/DKXZATILdY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-jvwNTn4jM5mF9gsg4yFLbg-1; Fri, 05 Jun 2020 05:33:49 -0400
X-MC-Unique: jvwNTn4jM5mF9gsg4yFLbg-1
Received: by mail-wm1-f70.google.com with SMTP id v23so2813717wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WgLubjKz8VmCZqpELU1JLw/uHIcEFx15X1H+hmJK3kA=;
 b=os+saMzxbmc866TfC+VrFoPyDYzWiVA6FZzm8XRsf8dZKNnBPur6SktrMZq0mitlc3
 G31F33CvgRs7lXl8vUYr4I9xn60XPUEE9pszWdVDMHu+vWc4ezNuxLuljSEwBSX5I2xz
 c66UuOwTrJw4ypu77K1WhoWH3Yma6c1daPqEC5Bo4vjFg0VWl8dmLx3I8ctAMz9rnl5l
 KYoyOJ7MvtSIR1rksCGknU6PnSN+aNiAcC7eiL6GWGmdB7CsCl74HzfKTTX5nQfai+Et
 nQ12zGqUYOHHTRFNITva88X+6PKSwpUqsjugddRDqV2Wed5wQHqPSw+hSFHZ7IpfALXs
 OM8Q==
X-Gm-Message-State: AOAM532tFtvUgmVWKSvrR1jGI2nSi2vSDp4DX/FYljxFCYO0kT2s9qsO
 BTLzSifuc4r98FdmkXGHqAUJuU5/U/TYD4fTPf9LEcanesCN2ZNMGzBbQAXXQgCyT0/94etkUdB
 JlfVqdXzthw11zI0=
X-Received: by 2002:a1c:a906:: with SMTP id s6mr1856536wme.171.1591349628448; 
 Fri, 05 Jun 2020 02:33:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8NToajb5p/dbh8mTE8uAeECQaMD6Q1yBArulcleGUFj0q3JxbGCpyyru6exvdesFrASiD3A==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr1856523wme.171.1591349628253; 
 Fri, 05 Jun 2020 02:33:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm11890215wrq.0.2020.06.05.02.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:33:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/11] Makefile: Allow target-specific optional Kconfig
Date: Fri,  5 Jun 2020 11:32:55 +0200
Message-Id: <20200605093256.30351-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605093256.30351-1-philmd@redhat.com>
References: <20200605093256.30351-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow use of target-specific Kconfig file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f8a45e1379..d5009cd304 100644
--- a/Makefile
+++ b/Makefile
@@ -423,11 +423,13 @@ MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host \
                    $(SRC_PATH)/accel/Kconfig \
                    $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) \
-                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
+                 $(wildcard $(SRC_PATH)/hw/*/Kconfig) \
+                 $(wildcard $(SRC_PATH)/target/*/Kconfig)
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
 
 $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_DEPS) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) \
+		$(wildcard $(SRC_PATH)/target/$(call base-arch, $(firstword $(subst -, ,$@)))/Kconfig) \
 		> $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
-- 
2.21.3


