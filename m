Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90272C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2F320715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKfj18Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2F320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouFy-00088a-Vq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iouEC-0005rv-S9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iouEA-0008Ui-UM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iouDi-0008B5-Sv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iW8QCganWiQPCWzq9gqTjCp7BHPrxSgiqh4/l8mLKQQ=;
 b=DKfj18Vlaq/skK30v+Dwues/wTXc5pPssOdweOjGRpADd9+vYBUd55S0v20Lpm83ZoPLZF
 rxacbXmwlY5v5nPsdtc38Za8ee0mZjE162mjMa8qPJCn8PKo4+M2X4A/1gY8Mpb7NHtxt7
 U3V/k9lWqWa0l/afQR2vYhYESkLh+mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-MtU_V-AMMUaZScAkrXpTUQ-1; Tue, 07 Jan 2020 14:08:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D388130194;
 Tue,  7 Jan 2020 19:08:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-83.ams2.redhat.com [10.36.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8009619DB;
 Tue,  7 Jan 2020 19:08:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/8] tests/Makefile: Separate unit test dependencies from qtest
 dependencies
Date: Tue,  7 Jan 2020 20:07:58 +0100
Message-Id: <20200107190802.2257-5-thuth@redhat.com>
In-Reply-To: <20200107190802.2257-1-thuth@redhat.com>
References: <20200107190802.2257-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MtU_V-AMMUaZScAkrXpTUQ-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the unit test dependencies are declared right in the block of
the qtest dependencies. Let's move them to the other unit tests instead.

Message-Id: <20191218103059.11729-5-thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 134d269add..93aea88bdc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -589,6 +589,11 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
 tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o =
hw/core/ptimer.o
+tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
+tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-=
qapi-obj-y)
+tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-b=
lock-obj-y)
+tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
+tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
=20
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
=20
@@ -830,18 +835,13 @@ tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-=
test.o $(libqos-usb-obj-y)
 tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o
-tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
-tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-=
qapi-obj-y)
-tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-b=
lock-obj-y)
 tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
 tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-=
y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qt=
est-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtes=
t-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/i=
vshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
-tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
-tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o test=
s/acpi-utils.o
 tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos=
-obj-y)
--=20
2.18.1


