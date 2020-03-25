Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8BBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FB12077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnJppTQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FB12077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5yJ-00066B-Ci
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5ts-0006hB-Fl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tr-00067D-8S
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5tr-00066I-3x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEQLTnESrCkmIYtvp45jrMRH1TdW1/P8cKhXdzg257k=;
 b=SnJppTQsoIFTv2pAkyT2S1fDHRj8esyayy9T3ghyw+Xk9TkUDzggO+mG8UX6lSJkh2/E4U
 UwkoIqHnybJs3CIur4egefTUszYz9xCZAbPVvOXlWDGsOVqTsS9idfCV6FbYI7lstPe6yN
 HOZgOwPJx8LTZBye6OmS5LVnUSzufa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ONgN0yWFN7yLdljVZ5jIEA-1; Wed, 25 Mar 2020 09:16:46 -0400
X-MC-Unique: ONgN0yWFN7yLdljVZ5jIEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6E6D1005509;
 Wed, 25 Mar 2020 13:16:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB3D5C241;
 Wed, 25 Mar 2020 13:16:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 3/9] tests/migration: Reduce autoconverge initial bandwidth
Date: Wed, 25 Mar 2020 13:16:26 +0000
Message-Id: <20200325131632.311034-4-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Message-Id: <20200323184015.11565-1-philmd@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.25.1


