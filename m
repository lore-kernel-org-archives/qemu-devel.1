Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3EC4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B4420754
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzJpBzXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B4420754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhC8-0007hb-UX
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEhA7-0004UD-7H
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEhA6-0003S2-1x
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48475)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEhA5-0003Ps-Un
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwxtQ7zuGBVcBWcd2rbFm5bTPUBxVpiD64+XcdrrEXg=;
 b=VzJpBzXYWlFSR5II3bEtRJMwLt91H9+MOZthX62xXFL53zPIefqR5wh8S44ut7OiIO0U7T
 zKKjItQ7YCa5/FUjjhrG3bmzxnn9QtkArLsjpcduouSJyVXEPQ2TlEjJPqhg6ailStDHt/
 NnIn5jUWpAd1LypAJhbH8zeB4zWXNM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-EynRQR8TNaKvYvGyYhNHqQ-1; Wed, 18 Mar 2020 18:27:39 -0400
X-MC-Unique: EynRQR8TNaKvYvGyYhNHqQ-1
Received: by mail-wr1-f69.google.com with SMTP id o9so19195wrw.14
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7OSNvlMb1+ur10heC42trbpeHDe8h1Jj2J4/F3bymOI=;
 b=ZlhdnHfRg5uJ2KJaE1ydDl7jB9c/rD9he3NvLdE3Ko+SJA+F2eCA/cs1d+Jycpa/WD
 pcHnCybcRhw1VzyhPmIgq0yVVGwZ9bT/fhAfdHYZlAXs/EbEt3Yp8xJYYWg1QbxnzSp6
 2oaO1F+FpSDyPUIlhTKsexN/Pbj2chacw3It8LdqDMf6fGeRGDbe1vIRvNJg7krECGSu
 VITZxMCHXBzEWAoEmzYRhhj1gwXpIQQ2Gq98lYW5NhHaaD5dF6Ho/Vp0/9qMlxup9+rf
 EDnKs74mo2x4z9Kc+pbijEJ6ddcaZNjEgjUsGqP1lu6H97TpTXTNjop7wkPajJen/jvs
 7S8w==
X-Gm-Message-State: ANhLgQ2y3oc+G+2FZnrhFx4WCfUz/exMCGAjBzCO/S8WcYcHBlKl46pW
 V1VKbOOKER/C00oo3/8G9yRj9fEklYarDwZZQLbzmWLWCUGYyBUVWbGjaDeCIZ7IYmc0udO/Kky
 JRSdxqHBn9HJprmM=
X-Received: by 2002:adf:ec88:: with SMTP id z8mr109328wrn.61.1584570458461;
 Wed, 18 Mar 2020 15:27:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtxzLN3FJ0ECx2+E7D2MRpi+az4A9Bk80j8Zacjt8sR7f9m+9lHXXREXktieQzluQlHxKwe4g==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr109301wrn.61.1584570458239;
 Wed, 18 Mar 2020 15:27:38 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e6sm358282wrn.29.2020.03.18.15.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:27:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 3/4] tests/migration: Reduce autoconverge initial
 bandwidth
Date: Wed, 18 Mar 2020 23:27:16 +0100
Message-Id: <20200318222717.24676-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318222717.24676-1-philmd@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
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

When using max-bandwidth=3D~100Mb/s, this test fails on Travis-CI
s390x when configured with --disable-tcg:

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

Per David Gilbert, "it could just be the writing is slow on s390
and the migration thread fast; in which case the autocomplete
wouldn't be needed. Perhaps we just need to reduce the bandwidth
limit."

Tuning the threshold by reducing the initial bandwidth makes the
autoconverge test pass.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3d6cc83b88..727a97cf87 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
      * without throttling.
      */
     migrate_set_parameter_int(from, "downtime-limit", 1);
-    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb=
/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 10000000000); /* ~10G=
b/s */
=20
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
--=20
2.21.1


