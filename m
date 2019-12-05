Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413B22245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt7FdAKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413B22245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icpj6-0005gj-BZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 06:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icphn-00054T-Bv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icphm-0000Wq-42
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:53:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icphl-0000S8-Rt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575546837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yN5TRwngZUjzSM2cHF6xCV4QA8APW69VbxVSBn6x9B4=;
 b=bt7FdAKy9s3r1v+cnjwdZhe44WaNxWKqIoCkCwmU3qCQ3mfRifhU/lAVDKNEWRfc6a/sl0
 SQS4P0NMg6FITp0AvOxb0HeUoEcPEBoCFDsrdMMOohp7qaVsOp7NPJpKMEUV8bDSNw/+Cb
 zYpqdMAymLsmxwUVCm4AgLZwgty1hIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-5Fb3ZdYjMoW5unGKAjf93Q-1; Thu, 05 Dec 2019 06:53:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05DF9107ACC4;
 Thu,  5 Dec 2019 11:53:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99AE35D6A5;
 Thu,  5 Dec 2019 11:53:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v3] qga: fence guest-set-time if hwclock not available
Date: Thu,  5 Dec 2019 12:53:50 +0100
Message-Id: <20191205115350.18713-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5Fb3ZdYjMoW5unGKAjf93Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Posix implementation of guest-set-time invokes hwclock to
set/retrieve the time to/from the hardware clock. If hwclock
is not available, the user is currently informed that "hwclock
failed to set hardware clock to system time", which is quite
misleading. This may happen e.g. on s390x, which has a different
timekeeping concept anyway.

Let's check for the availability of the hwclock command and
return QERR_UNSUPPORTED for guest-set-time if it is not available.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

v2->v3:
  - added 'static' keyword to hwclock_path

Not sure what tree this is going through; if there's no better place,
I can also take this through the s390 tree.

---
 qga/commands-posix.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1c1a165daed8..0be301a4ea77 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns=
, Error **errp)
     pid_t pid;
     Error *local_err =3D NULL;
     struct timeval tv;
+    static const char hwclock_path[] =3D "/sbin/hwclock";
+    static int hwclock_available =3D -1;
+
+    if (hwclock_available < 0) {
+        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
+    }
+
+    if (!hwclock_available) {
+        error_setg(errp, QERR_UNSUPPORTED);
+        return;
+    }
=20
     /* If user has passed a time, validate and set it. */
     if (has_time) {
@@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns,=
 Error **errp)
=20
         /* Use '/sbin/hwclock -w' to set RTC from the system time,
          * or '/sbin/hwclock -s' to set the system time from RTC. */
-        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
+        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
                NULL, environ);
         _exit(EXIT_FAILURE);
     } else if (pid < 0) {
--=20
2.21.0


