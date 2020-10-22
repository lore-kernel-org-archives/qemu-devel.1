Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55781C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87175223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGVex5Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87175223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZny-0001Md-CZ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVZmN-0008OT-NG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVZmK-0004f6-Pj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603369990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o9amAo9g3qKT3NV9q0c+haOCUEoSL/xJJp7IYZVV08s=;
 b=LGVex5Bne6QT7uL60T6iDUDf1h7r492uptbdmwfiAZaCdmSouDI0VpIUbJxOpskxvDvCL/
 qMZRbrsvMed8v97ia32PDhDlSUgLdTchacYRggVqpI0CEPP7bcSDD4g5MKZ79dagn0EgxP
 kiG/d74kvnko65Tr5S4LFDMSeDFbP8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-V2KDNV-3NCGPWkOPcHG6XQ-1; Thu, 22 Oct 2020 08:33:09 -0400
X-MC-Unique: V2KDNV-3NCGPWkOPcHG6XQ-1
Received: by mail-wm1-f71.google.com with SMTP id y13so301041wmj.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o9amAo9g3qKT3NV9q0c+haOCUEoSL/xJJp7IYZVV08s=;
 b=VR1n6h0nzVAiKbh1pdzsOjI5/kVFBqYHlAlPzoOAS8qsWz3hAZK9Ag5vqcqvhLDTtn
 Kfioo8Tahr1wbXFNZ4p+8yZkDxeuqvtprFFb9jKXoUeOWHqP2XkdiNOphy3R+qtW7VAR
 oLyiutGw5wjyfKKuO//fAHCIwWaOWpbRK9KTlClOKHWKELw7SCUdA+SUh+r6ehvyzPIa
 GSsnxT8YMLCAfi1WmnJ7mkjlXTSprjjJorOlKwjHnAd2+0C4wXD66HDAQoF81/wa1o1j
 3tL9z304ohcqmK1e/KO3iaS5usfQJT/BxYBAwn4DuxIqbalVIMCIL4Nk7OBufQXEA0R6
 Im5Q==
X-Gm-Message-State: AOAM530zgzRPD56bH/qRXr6WVSld6pyXds/VtvPdBc9ESoWMTPnA+FEm
 uLV/Nnr4umqL2Hpea+ozjBCkWdz61nA518UzqIStujcKHyY13RTR6Ww0IkuIPeTkpgztMbij2mc
 DhwcWZdyyH8mWKSQ=
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr2329359wmd.188.1603369985029; 
 Thu, 22 Oct 2020 05:33:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFKcWgGUs/0q33hGSYSnb8iuzizdWa7/ZWr4RGb8cfTNAtjljauOkGGckjrDwcdS38IMODJA==
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr2329339wmd.188.1603369984843; 
 Thu, 22 Oct 2020 05:33:04 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g5sm3326411wmi.4.2020.10.22.05.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 05:33:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci: Clone from GitLab itself
Date: Thu, 22 Oct 2020 14:33:02 +0200
Message-Id: <20201022123302.2884788-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let GitLab runners use GitLab repository directly.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 66ad7aa5c22..ba77af51f2f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,6 +24,7 @@ include:
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   before_script:
     - JOBS=$(expr $(nproc) + 1)
+    - sed -i s,git.qemu.org/git,gitlab.com/qemu-project, .gitmodules
   script:
     - mkdir build
     - cd build
-- 
2.26.2


