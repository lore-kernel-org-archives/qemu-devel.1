Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033DC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9FD2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUvaUasK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9FD2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIXf-00046q-Nj
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEITT-0008G3-Lg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEITS-0004Em-AE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEITR-0004BM-Uh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PyD7+RJ4/A5gy2wbJ6MziohBvoadqKSq3w75LWrEVU=;
 b=RUvaUasK30DuvXgXBB03dWeEidSBvR99zpCj/D1daAKGUt13CTdigzjhSF7MzFIgZdHXgK
 X2RqYsCFoBz/ePMgN4R8W1wDu/6vaTR/dP4mfqIFDI5ttKdBlm2J3dwbdJlekTeUuz4c6Q
 bxkIFUDvGbOM6PFqKyGRZLoQ9HRBPOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-FLzqcabtOayDF5AXmw38eg-1; Tue, 17 Mar 2020 16:05:59 -0400
X-MC-Unique: FLzqcabtOayDF5AXmw38eg-1
Received: by mail-wm1-f71.google.com with SMTP id a13so183150wme.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VFYerVqML5WLPQvDawZvTMww1bUZUEqxoUBIS/19Nu8=;
 b=DdCKl+hp6xLGW5VhTthXEfyUSDUsxA1H1Wj2U0PRm0S61HCsJQ4LLMJUp0GKg1vFQL
 iNyrq+HEGWNOevI4DgfLse9hw3HGfcMktuK/q7RuAl2Ao+s7AFYCZbwFT1awx1usvDnb
 6RKk/w5UOKJ1kcwVraFcR7OdEXxMToho9UOY192EOfHTZPqG3ryJYPLvP5YgRPhwX3kQ
 qeysup/fXWyuz4pACLhWxPWZjma3/5CAeGDebUIFBqO+hGVjS2GB54PEUr6BlcXP1GeV
 oT2dx5nL6ydxQpUw3afEfgDGzR7NkHoenvNFsEcOBK3ImApriVWB1tqPdkU6Z8prKCUt
 Z7oA==
X-Gm-Message-State: ANhLgQ1VlklJR8PuYQ120O7JSj4oeaWkmjqni1T2ZIEhDS1FJAhERZ5I
 yQUmjs+poK+/Td+6zLL309QNZic7WynmQa4NcDn8Mjw7rySNz37xDRxHtooc1itIXWGpDwtl+by
 qS10Pp5aY0aSFTts=
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr726429wmu.185.1584475558360;
 Tue, 17 Mar 2020 13:05:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtlQ78HgeeGpUQpz0ATirjsLdrPNru8oNgbR+P282DUF/jhkumWLYytv93+bl1+JAwL4Q9cpA==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr726394wmu.185.1584475558084;
 Tue, 17 Mar 2020 13:05:58 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id o23sm6146519wro.23.2020.03.17.13.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:05:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tests/migration: Disable autoconverge test on Travis-CI
 s390x
Date: Tue, 17 Mar 2020 21:05:40 +0100
Message-Id: <20200317200541.6246-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317200541.6246-1-philmd@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test fails on Travis-CI s390x when configured with --disable-tcg:

  $ make check-qtest
    TEST    check-qtest-s390x: tests/qtest/boot-serial-test
  qemu-system-s390x: -accel tcg: invalid accelerator tcg
  qemu-system-s390x: falling back to KVM
    TEST    check-qtest-s390x: tests/qtest/pxe-test
    TEST    check-qtest-s390x: tests/qtest/test-netfilter
    TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
    TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
    TEST    check-qtest-s390x: tests/qtest/drive_del-test
    TEST    check-qtest-s390x: tests/qtest/device-plug-test
    TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
    TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
    TEST    check-qtest-s390x: tests/qtest/migration-test
  **
  ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_=
stop' should be FALSE
  ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_au=
to_converge: 'got_stop' should be FALSE
  make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1

Per David Gilbert, it might be a threshold requiring tuning:
"it could just be the writing is slow on s390 and the migration
thread fast; in which case the autocomplete wouldn't be needed.
Perhaps we just need to reduce the bandwidth limit."

Disable the autoconverge test for now.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3d6cc83b88..878399666e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1181,6 +1181,16 @@ static void test_migrate_auto_converge(void)
     MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
     int64_t remaining, percentage;
+    char *travis_arch;
+
+    /*
+     * This test does not work reliably on Travis s390x.
+     */
+    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
+    if (travis_arch && g_str_equal(travis_arch, "s390x")) {
+        g_test_skip("Test does not work reliably on s390x Travis container=
s.");
+        return;
+    }
=20
     /*
      * We want the test to be stable and as fast as possible.
--=20
2.21.1


