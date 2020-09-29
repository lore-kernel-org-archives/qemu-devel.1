Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1652C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B55F2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5Jwe8wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B55F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOZt-0004EQ-Vb
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMt-0006gP-Cu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOMq-0004gj-Sr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:45:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDAC3FC/MEaPD4LUvl2bkbirLPCAiqLo/YtDEMBCclM=;
 b=R5Jwe8wix09pVIeYCw+Jtdse4VcVJmmF9cw4E+SJX+F0bWR6wQQdZChe0K5knG54Yg2Nxo
 jyaybuhtCBRKXg1HO19DuFYD/LCbVA0HiZhWtSCBl8YsDHWOWUV4MqXFoUJJ5vHhxmEPks
 JU8Fh0nxWNAAk5pkuMsKessdg42gptQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-xmtR7E0UNbO2yWjc0OCAAw-1; Tue, 29 Sep 2020 18:45:00 -0400
X-MC-Unique: xmtR7E0UNbO2yWjc0OCAAw-1
Received: by mail-wr1-f70.google.com with SMTP id v5so2326292wrs.17
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LDAC3FC/MEaPD4LUvl2bkbirLPCAiqLo/YtDEMBCclM=;
 b=Xcg6wliLArvw9SzekdtWBlTYiiHYO4uWqEy3xrreBe90LafLVedwnCpNLNzzmPVY4l
 SCFoDIIBGiQtLlm3ChnD/USEypJI8kJGZg2z6AxJ9r9mHVTvUSlI4b+dqycCEwpSlI66
 fE6dmv0hoIaYBy7MrMoJxqhCiMecCFGhWlPIAKcZJGB/tWroGXi/BpxvYcavLkJ3cL7d
 +ghDRaDNeaiJKw904Pw5j8bxaSD5uUTz0dLna1KXoq80Yud68jh3KftwwS1dtJikxO/K
 7ozMtl4z/F51AE9K32L88YnFU1CvVx2Rs5sXC7LypXEanqsIh2rEs2LQLE31byoKWnq3
 RGig==
X-Gm-Message-State: AOAM531W8W8S4r14KaPyVR+EhGQ5dRly99tPGx0b8J29k0uBtv2MLN3N
 GjXyrfEWtM4DDNAB1/wtJTUf2TLpBgEMID/EJvjgECsHmb0PW4/E4D3vzFwJjdTR+ZA20HIthiq
 9ccdLQMKEKchDrpU=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr6808328wrr.269.1601419499107; 
 Tue, 29 Sep 2020 15:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH+Rg1xe9gd9DlTZs7Ar3VzsQvPodRcCF6Ci4iIpufBqC6fONYRBje8t5F8NeD4ocLB3USiA==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr6808303wrr.269.1601419498855; 
 Tue, 29 Sep 2020 15:44:58 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 76sm7666468wma.42.2020.09.29.15.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/12] .travis.yml: Add a KVM-only Aarch64 job
Date: Wed, 30 Sep 2020 00:43:55 +0200
Message-Id: <20200929224355.1224017-13-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to build QEMU on Aarch64 with TCG disabled, so
this configuration won't bitrot over time.

We explicitly modify default-configs/aarch64-softmmu.mak to
only select the 'virt' and 'SBSA-REF' machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Job ran for 7 min 30 sec
https://travis-ci.org/github/philmd/qemu/jobs/731428859
---
 .travis.yml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index c75221dca3..cad65cf181 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -402,6 +402,41 @@ jobs:
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
         - UNRELIABLE=true
 
+    - name: "[aarch64] GCC (disable-tcg)"
+      arch: arm64
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
+        - TEST_CMD="make check-unit"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-aarch64"
+      before_script:
+        # Only use the 'virt' and 'sbsa-ref' machine which don't need TCG.
+        - echo CONFIG_ARM_VIRT=y > default-configs/aarch64-softmmu.mak
+        - echo CONFIG_SBSA_REF=y >> default-configs/aarch64-softmmu.mak
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
       dist: xenial
-- 
2.26.2


