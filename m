Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A4C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC03B2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtgTPQDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC03B2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQk1-0000xQ-Km
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isQiI-0007mz-BO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isQiE-0005nm-G6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:26:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isQiE-0005nD-Cj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579264013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2pe5sS7swoOPETD5lpxZGfDZXAw5lMKY8nOUEtbu5XQ=;
 b=gtgTPQDNbY3OjaDUAJCk2ScGGrFuK4lcRlXtOIqZpjyr6tGVj/DH/hFgBNBUqrHjlPExer
 h2PeNxxQhF9z+ofeA1UPJox2aoWWJL+IPZdGKfL+Pxa7F7JTWet7ynmxdziybWdur/O0MI
 mHJ8itY/mxe/th1GH6VzPexpnKxKmdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-VYCFH_i6NRW8c8tJkWbvmQ-1; Fri, 17 Jan 2020 07:26:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE29106F8AD
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 12:26:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 796FC84BAC;
 Fri, 17 Jan 2020 12:26:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	thuth@redhat.com
Subject: [PATCH] tests/vhost-user-bridge: Fix build
Date: Fri, 17 Jan 2020 12:26:48 +0000
Message-Id: <20200117122648.137862-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VYCFH_i6NRW8c8tJkWbvmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

vhost-user-bridge isn't actually a test, it's just a helper
(that should probably move somewhere else) - but the build was
broken in the qtest move.

Fixes: 833884f37adc9f125fa2
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/Makefile.include       | 1 +
 tests/qtest/Makefile.include | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c6827ce8c2..7833684bac 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -585,6 +585,7 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
=20
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
+tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
=20
 SPEED =3D quick
=20
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index e6bb4ab28c..eb0f23b108 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -290,7 +290,6 @@ tests/qtest/test-filter-redirector$(EXESUF): tests/qtes=
t/test-filter-redirector.
 tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-com=
pat.o $(qtest-obj-y)
 tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivsh=
mem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o te=
sts/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-obj-y=
) $(libqos-spapr-obj-y)
-tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(=
test-util-obj-y) libvhost-user.a
 tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
 tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
 tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/=
boot-sector.o tests/qtest/acpi-utils.o
--=20
2.24.1


