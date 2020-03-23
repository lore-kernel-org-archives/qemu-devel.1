Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF60120409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5TFQhJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF60120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGS0b-0002Hd-Qp
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGRzr-0001Pu-10
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGRzp-0001Pj-Og
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:40:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGRzp-0001PP-K9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584988821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qCI/dTFk5DEWc5+LPb7u2aAwCbTQetFcUeWTOS9UCxU=;
 b=C5TFQhJgY2crEXaHeO6XZoCx1HUFT2InNeYqTnWLaldy5gIjPLjAMHqC4aNbkuyguh/tU3
 IX90msOpRBEsnplPxmg2K1CoORBh5A1+sQKnGkohs0vbXZVYYqvALn3mNS4q2ah93eMDNP
 sjmWmpBn3i+hy3ImBEaEwoOUME7oqac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-CoSGmkvVMRm-Ew1NFTec7w-1; Mon, 23 Mar 2020 14:40:19 -0400
X-MC-Unique: CoSGmkvVMRm-Ew1NFTec7w-1
Received: by mail-wr1-f70.google.com with SMTP id u18so7738451wrn.11
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+pI9aTTzpnzdd+Wanh7es/tKJpfzcT++K3VtiCEn5J4=;
 b=bAtIkk/Pv6UOi4rgXFdzUIBjGE0/kN2rywn44glLRvsFG8ZtJnfc5pvCzkYHD1zMrd
 RMlk+5DjKS5nzpQaq/CFtWoWhn8uuX8+sJ85biPfVSg4hXdpl83M3luwlHR+hnAUvoXa
 AohnjU3bE8eu+RSFJOXxlhJmiKN07JV77L3/phVzOwsZjtNfDtwqmFNTpg1TCvsa0Hpc
 iLFTcmKuzXQDj36f+R7UXbfGZlycrpOZMFRzyKafvJrt3XHMXZSNLOTpPlgqFhlqcRyf
 2p7Iyj5BbX4OxhUht5n7VeEpSSTERoCEC8YLB2mku6yun8idmXhQp/R9oZR6eGeLKHEv
 u4QQ==
X-Gm-Message-State: ANhLgQ0ID9Ys9iXR3muA0S0Ug1MITAryxRK6Gzv42x06fn8m+2qBtoyM
 JjaKNw1zB6wP6huSEGVpclkBjTaybOprkxPqePe3VG9ZGhJQ3yNLfnIsNmtBv69BlUyFladCmsO
 204PAtckhmsR7IXk=
X-Received: by 2002:a1c:3d5:: with SMTP id 204mr752524wmd.188.1584988818047;
 Mon, 23 Mar 2020 11:40:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs9iuq318XSytBFHKCl0Y14mn0Jw7cn8IX2KykMc5BZPw86J0I9X66xthdLUcVfdpALlwSgOA==
X-Received: by 2002:a1c:3d5:: with SMTP id 204mr752489wmd.188.1584988817708;
 Mon, 23 Mar 2020 11:40:17 -0700 (PDT)
Received: from x1w.redhat.com (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id p16sm547881wmi.40.2020.03.23.11.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 11:40:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH-for-5.0 v3] tests/migration: Reduce autoconverge initial
 bandwidth
Date: Mon, 23 Mar 2020 19:40:15 +0100
Message-Id: <20200323184015.11565-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
v3: really reduce =3D)
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3d6cc83b88..2568c9529c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
      * without throttling.
      */
     migrate_set_parameter_int(from, "downtime-limit", 1);
-    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb=
/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s *=
/
=20
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
--=20
2.21.1


