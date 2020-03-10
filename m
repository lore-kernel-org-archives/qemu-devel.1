Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056B724655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHvgrfvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056B724655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58493 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdGX-0007aS-5r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDm-0003I2-ME
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDl-0008Qf-98
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDj-0008Lu-B5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWmFsTqSPEH50eOtsc4mu7xbbfJh9pJRysylAo4hCak=;
 b=RHvgrfvqSQPid1G0ANxqBgNPX6E0uDuoki8EMm7z2Pyceiw37vcY+MB9Geu7yANmv4HrE4
 Uk/GiYCpTWOmXJFjGwupolZ1pzbkL+Fr1QTuxgHHl+GEUck3OXs1mOUa106wIhT+oTbFat
 gCSwCO1kNd8hNGSTjO/ErJpRQpITJE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154--oWC9KkBPFu4n9eZm0n9rg-1; Tue, 10 Mar 2020 07:38:44 -0400
X-MC-Unique: -oWC9KkBPFu4n9eZm0n9rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284B2800D50;
 Tue, 10 Mar 2020 11:38:43 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08E5690A0E;
 Tue, 10 Mar 2020 11:38:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/7] iotests: Fix run_job() with use_log=False
Date: Tue, 10 Mar 2020 12:38:27 +0100
Message-Id: <20200310113831.27293-4-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'job-complete' QMP command should be run with qmp() rather than
qmp_log() if use_log=3DFalse is passed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8815052eb5..23043baa26 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -624,7 +624,10 @@ class VM(qtest.QEMUQtestMachine):
                         if use_log:
                             log('Job failed: %s' % (j['error']))
             elif status =3D=3D 'ready':
-                self.qmp_log('job-complete', id=3Djob)
+                if use_log:
+                    self.qmp_log('job-complete', id=3Djob)
+                else:
+                    self.qmp('job-complete', id=3Djob)
             elif status =3D=3D 'pending' and not auto_finalize:
                 if pre_finalize:
                     pre_finalize()
--=20
2.20.1


