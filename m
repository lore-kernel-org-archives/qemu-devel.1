Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4482236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ4VtcaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4482236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHSP-0001iC-4W
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPw-0006kP-6y
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPt-0005Wb-5x
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604491048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvfGSovFfbSbNaWRDvuyOO64aSfN6A/KmCqwAtM9GUA=;
 b=VZ4VtcaG3ucvE2Q6tV1Fqg3yghd90LgJb5SQX51L/gcEyoZU7INg31XSLmTbDpyhNW+0MG
 BJMgjJP7J7WL3v3PRB6KrEbY7VXZmT5Qw2q9/pWYHu4acj65DS1JD4Z9yTfdFDJMb6Mhp/
 oCkmlPHc3L4g8i6IowBFciaSH8VzqhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84--uyqoVk9O_aiMCaFfv-cqw-1; Wed, 04 Nov 2020 06:57:26 -0500
X-MC-Unique: -uyqoVk9O_aiMCaFfv-cqw-1
Received: by mail-wr1-f69.google.com with SMTP id p12so1661560wrx.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DvfGSovFfbSbNaWRDvuyOO64aSfN6A/KmCqwAtM9GUA=;
 b=d6m/bKXRUQ75sU62ky8P4RkEcHaUNsrugxdOoUC7cHyCNWCeSRxtolmNBL3HLRx5mx
 p4bc60wba1ysdqwNOgoQ1CtX7wHGyMobkkLFVhHmNKD2rBnSTxFZpoPI4JUqxQ+jzJ+B
 Xzw0Kx5/NMTsvG2NbbFzHpBnfjPVUUm+LbP5b6z0eQjxjveo7e5Ga4q6NgnxjsCD70h8
 uis6MB0hZb3U3dqLkn9tagVrV26qXxizLGtH4lAwQsAKw9FV2G7HcHxNF1jV+Mal2A+2
 jdbQ0sg75fXUpaFYq7+0ZmTrY3Z63aMuUcUG9J7Uuxx/sZmIEYlvI0XaxVNS+SXqtID3
 Mlxg==
X-Gm-Message-State: AOAM530b7c4LLk9cK4Jhqh4n+8vZmSYICT072IJ/J0cokL1NZ8Xb3fSz
 I3g3ypDxifOIdutyE0AEAfJx/tnacPJM0ZhcS8j2ia4vAGUmPsAwDQfHNpLvjdO5eHqKrejlioh
 fH4LSSFO39EdP5Ss=
X-Received: by 2002:a1c:6782:: with SMTP id b124mr4438075wmc.117.1604491045245; 
 Wed, 04 Nov 2020 03:57:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb4J1vsBP6Jcp72ana1MPrwkSkHvN43FY+n+E4Qa37eljdJRevcGBXmefauqPZqcdNkZIRHQ==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr4438041wmc.117.1604491045072; 
 Wed, 04 Nov 2020 03:57:25 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u3sm6109406wme.0.2020.11.04.03.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 03:57:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 3/4] gitlab-ci: Add a job to cover the
 --without-default-devices config
Date: Wed,  4 Nov 2020 12:57:05 +0100
Message-Id: <20201104115706.3101190-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104115706.3101190-1-philmd@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We test './configure --without-default-devices' since commit
20885b5b169 (".travis.yml: test that no-default-device builds
do not regress") in Travis-CI.

Since having a single CI to look at is easier, and GitLab-CI
is the preferred one, add the equivalent job there.

As smoke test, run the qtests on the AVR target. Since the
boards are simple SoC, there is not issue with unavailable
default devices there.
Also include the m68k target which works fine.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c302..e4eba96ff34 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -262,6 +262,13 @@ build-user-plugins:
     MAKE_CHECK_ARGS: check-tcg
   timeout: 1h 30m
 
+build-system-ubuntu-without-default-devices:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-tools --disable-docs
+    MAKE_CHECK_ARGS: check-qtest-avr check-qtest-m68k
+
 build-clang:
   <<: *native_build_job_definition
   variables:
-- 
2.26.2


