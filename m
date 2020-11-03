Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6796BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54CC20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJzECGZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54CC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzTH-0003aB-Mo
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzS2-0001qu-Qh
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzS0-0002lS-PE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CroNXPd2gZDwwm/Aroq093pym2LY55n4rUoIP5cgYXI=;
 b=aJzECGZn0Zizd0HmihfidsSRCU6x6xqeIzll2ztKV4Amr7IRUYVS/kK3tbINlWBwFTN8zF
 HvBowytlwVZ3EGFUs1qB4x/MpdbWI2NdU+M4yj6yhGJpbcMiztH91RqXg+EvcU46AU1OSf
 ovFwHUCxxR85kLoyAR0kVmRK4MeWir0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-VdAbGIPUOPWrvvJkGtMAQw-1; Tue, 03 Nov 2020 11:46:25 -0500
X-MC-Unique: VdAbGIPUOPWrvvJkGtMAQw-1
Received: by mail-wm1-f72.google.com with SMTP id t21so2822112wmt.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CroNXPd2gZDwwm/Aroq093pym2LY55n4rUoIP5cgYXI=;
 b=hzA9Uv9saQYzNnFjQgS7RC6CgGXCBkad+o1VgmABTpHtZyeXXLCYQAbQmekS6Y3Bg6
 tD7/vjbyakwpAkHd92wjc+3vkXoeNk8aShfKQz08mKvfGYNmfCzQU3Nt7PMZorffaJ4i
 Y+9nIU5BHrLU8wWsQhdzUpBlgDr7Kg4GarAxmzFwpOAeTIgMSzErcJ4xmR9OemoTxhn5
 56slunG+eeEyxbqG6TTvtlYqRC3E2zpuFoJ+8c2cpkeQHDkGlMltJ1/r5b+5rC/I/OZD
 4QTyWUOoxL3mz4XkdNCpIPzuiFB/h7xDyIq3DL1nJyY5JphubBwsUav42RSmjs9y9IvX
 Nkcg==
X-Gm-Message-State: AOAM5321HWR1sfWHTWBUn+9Q9vfONi98i+7DtAhw18e4U+8V/7ztonLI
 enZjdFz6dHNrzH7mZIu+m/P2oe2sk7X6x1FoKSeB+UGFAF2YdG/NtRuX5eSW7LLZ3tse6+svWBw
 1Imh9W0oSx0ayd3w=
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr28767680wrn.247.1604421982841; 
 Tue, 03 Nov 2020 08:46:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2ZlS+BkjSa7zJ+xfr2nDukbgPkksfGuXINcmoJLEcuQsYKoz8xWpxskJWCFCT9eJhzPwZ3w==
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr28767654wrn.247.1604421982696; 
 Tue, 03 Nov 2020 08:46:22 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z10sm19185941wrp.2.2020.11.03.08.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:46:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/3] travis-ci: Remove the --without-default-devices
 job
Date: Tue,  3 Nov 2020 17:46:04 +0100
Message-Id: <20201103164604.2692357-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103164604.2692357-1-philmd@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We replicated the --without-default-devices job on GitLab-CI
in the previous commit. We can now remove it from Travis-CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a3d78171cab..15d92291358 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -224,14 +224,6 @@ jobs:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
 
-    # We manually include builds which we disable "make check" for
-    - name: "GCC without-default-devices (softmmu)"
-      env:
-        - CONFIG="--without-default-devices --disable-user"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-        - TEST_CMD=""
-
-
     # We don't need to exercise every backend with every front-end
     - name: "GCC trace log,simple,syslog (user)"
       env:
-- 
2.26.2


