Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3640D20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a58+dNRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3640D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzUh-0005fF-B3
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRv-0001d2-Qq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRt-0002jC-DU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSfukc0geywNkqucbqnh5BnXZLygA+nz7IBN65XXjA4=;
 b=a58+dNRG4GzmSTFhgi4pmLvJMzA1hknOwE6MUR7dyQJv22RpF5c63Ee7+cn0dI4dEAY3Ku
 MDHb+X/+htLavMtipNRIRtr2ZpsRM6lFlhOUir9HvXTrBwnbpkJEX2Jwgf3oPBFW8DppfR
 qWo8IV7nrc2Vx/AoX8BxCXN3LLd+fNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-7RvxRFVOPvy-CEpM6oqIDQ-1; Tue, 03 Nov 2020 11:46:19 -0500
X-MC-Unique: 7RvxRFVOPvy-CEpM6oqIDQ-1
Received: by mail-wm1-f71.google.com with SMTP id 3so2353850wms.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GSfukc0geywNkqucbqnh5BnXZLygA+nz7IBN65XXjA4=;
 b=J+XEGA80q0I8y26e0+sf8/aAb2ZrsiUzL8itqyeNXCrbwPAEj9xtyaDWMufpal3D8K
 UcuH34EfXv27hjCavx1vcjW/KAk4zaCcwa8whtYt8W3ldAmbYN+k3Lfbi1jP5Le6P1U/
 JAxqzQidr/0Rl7q23W3A+wZjwvUOu3fLE+NK8SpC6ZhJsgq9ZH7zR1jSPnbdPFS79x1O
 szqwD0xh/Ey7TAVKV9VHIu19cp974kr5eHMuQaDPXiWGRD4dEWp7t3Pm/CMLhFygEMjV
 UWYJPOX48JFIHKHRW2zPqgPjZ3xNBrSRS8Jc/u16RdBGUUIMgYVZjYarJiKCHuDTWQD6
 QBCg==
X-Gm-Message-State: AOAM532EYaQEDrLT+RCTQYOSB9bRX8+u/4GzepqeI4St5g/vlfP/OA9D
 muQmqW3k7UHHAFEsvYLqvQfO5qti3N4xylEZDmGnv4HzEfTkb1WWk317MHHFDjGDxbZSd9kv/WD
 +/1qQsqKVmr0e/PA=
X-Received: by 2002:adf:bd86:: with SMTP id l6mr28038812wrh.205.1604421977581; 
 Tue, 03 Nov 2020 08:46:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPkY319mzWnh+5kjLkFCs/q7NcLnkCzxot5CVDqaQkEz2hlpQZVVaFpLgHucsUomMtZvvLCA==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr28038793wrh.205.1604421977447; 
 Tue, 03 Nov 2020 08:46:17 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c64sm167809wmd.41.2020.11.03.08.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:46:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
Date: Tue,  3 Nov 2020 17:46:03 +0100
Message-Id: <20201103164604.2692357-3-philmd@redhat.com>
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

We test './configure --without-default-devices' since commit
20885b5b169 (".travis.yml: test that no-default-device builds
do not regress") in Travis-CI.

As we prefer to use GitLab-CI, add the equivalent job there.

One minor difference: the GitLab Ubuntu docker image has the
Xen devel packages installed. As it is automatically selected,
we need to disable it with the --disable-xen option, else the
build fails:

  /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
  hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
  /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
  collect2: error: ld returned 1 exit status

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c302..6ee098ec53c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -262,6 +262,17 @@ build-user-plugins:
     MAKE_CHECK_ARGS: check-tcg
   timeout: 1h 30m
 
+build-system-ubuntu-without-default-devices:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-xen --disable-tools --disable-docs
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - build
+
 build-clang:
   <<: *native_build_job_definition
   variables:
-- 
2.26.2


