Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5E52067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeN0Eb+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5E52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEQ9-0003Li-A3
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihEPO-0002l8-Qh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihEPM-0005DJ-QQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:05:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihEPM-0005Av-Mm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576595107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FDRYRtssVQ4XYVOKoVpIB3ytBicvhpCOFhfrDHzyyY=;
 b=TeN0Eb+HV0Vzg3Cn9z195dUfrX8uyGX5eDc+Zsl/vemBmdE7ozOASdmUW9KnUN4gqv0nm0
 cUthTM4rum8WiDtnM0r2Lr4QrnnuqZmmi55JJoztBRvTU13vXfvfUC8Cmf9adSJeYwuEBM
 l2xX4OJXxaItwWQYXIv7UkMNILXqmzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-X9LJY1mmPcykMVj-G2nQ_g-1; Tue, 17 Dec 2019 10:05:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6758E818B;
 Tue, 17 Dec 2019 15:05:03 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 095207C856;
 Tue, 17 Dec 2019 15:05:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2] blockjob: Fix error message for negative speed
Date: Tue, 17 Dec 2019 16:04:58 +0100
Message-Id: <20191217150458.10288-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: X9LJY1mmPcykMVj-G2nQ_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error message for a negative speed uses QERR_INVALID_PARAMETER,
which implies that the 'speed' option doesn't even exist:

    {"error": {"class": "GenericError", "desc": "Invalid parameter 'speed'"=
}}

Make it use QERR_INVALID_PARAMETER_VALUE instead:

    {"error": {"class": "GenericError", "desc": "Parameter 'speed' expects =
a non-negative value"}}

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---

v2:
- Update reference output for 030 [Max]

 blockjob.c             | 3 ++-
 tests/qemu-iotests/030 | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index c6e20e2fcd..5d63b1e89d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -261,7 +261,8 @@ void block_job_set_speed(BlockJob *job, int64_t speed, =
Error **errp)
         return;
     }
     if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative value");
         return;
     }
=20
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index f3766f2a81..be35bde06f 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -943,7 +943,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('block-stream', device=3D'drive0', speed=3D=
-1)
-        self.assert_qmp(result, 'error/desc', "Invalid parameter 'speed'")
+        self.assert_qmp(result, 'error/desc', "Parameter 'speed' expects a=
 non-negative value")
=20
         self.assert_no_active_block_jobs()
=20
@@ -952,7 +952,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
         result =3D self.vm.qmp('block-job-set-speed', device=3D'drive0', s=
peed=3D-1)
-        self.assert_qmp(result, 'error/desc', "Invalid parameter 'speed'")
+        self.assert_qmp(result, 'error/desc', "Parameter 'speed' expects a=
 non-negative value")
=20
         self.cancel_and_wait(resume=3DTrue)
=20
--=20
2.20.1


