Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BAC47409
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BEB2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHI89j9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb0e-0005nl-KJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazh-0004AZ-DQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazf-0005so-CU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazf-0005sN-4n
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJilRfYtd3vzWt3fBnOtG6fsCC0tEIP3/zOTdycco0k=;
 b=WHI89j9+ewVzrVNGoWDUtUYuHnM5/nii1TU1wsMLWVDRh5ZdhGzDoy+2IX1TZ5TbQlGhOz
 YhtCYB7BI6CauNuE9f9fvNfao5RqzCFMCzHrygod/cXbL67ChqOqqJFqbKhPsWwalSM6VT
 WijQaze2VsmaOuBUN5eLXuo/mAonVwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-n4YD75-JNpGM16zN78PqIw-1; Mon, 03 Feb 2020 07:38:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615A4107ACC7;
 Mon,  3 Feb 2020 12:38:19 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5542561070;
 Mon,  3 Feb 2020 12:38:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/13] tests/vhost-user-bridge: Fix build
Date: Mon,  3 Feb 2020 13:38:00 +0100
Message-Id: <20200203123811.8651-3-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: n4YD75-JNpGM16zN78PqIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

vhost-user-bridge isn't actually a test, it's just a helper
(that should probably move somewhere else) - but the build was
broken in the qtest move.

Fixes: 833884f37adc9f125fa2
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200117122648.137862-1-dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include       | 1 +
 tests/qtest/Makefile.include | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a1bff5dcce..fe63fec5f1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -586,6 +586,7 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
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
2.18.1


