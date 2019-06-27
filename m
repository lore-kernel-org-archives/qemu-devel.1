Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD26C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857D42084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857D42084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgd3T-0007U5-QF
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgcxS-0000Qg-VG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgcxQ-0004I7-Np
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgcxM-00046y-5i; Thu, 27 Jun 2019 18:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22A2A3082E6A;
 Thu, 27 Jun 2019 22:33:25 +0000 (UTC)
Received: from localhost (ovpn-204-47.brq.redhat.com [10.40.204.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 473905D719;
 Thu, 27 Jun 2019 22:33:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 00:32:54 +0200
Message-Id: <20190627223255.3789-5-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-1-mreitz@redhat.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 27 Jun 2019 22:33:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/5] iotests: Add @use_log to VM.run_job()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

unittest-style tests generally do not use the log file, but VM.run_job()
can still be useful to them.  Add a parameter to it that hides its
output from the log file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 3ecef5bc90..ce74177ab1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -542,7 +542,7 @@ class VM(qtest.QEMUQtestMachine):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, wait=3D60.0):
+                pre_finalize=3DNone, use_log=3DTrue, wait=3D60.0):
         match_device =3D {'data': {'device': job}}
         match_id =3D {'data': {'id': job}}
         events =3D [
@@ -557,7 +557,8 @@ class VM(qtest.QEMUQtestMachine):
         while True:
             ev =3D filter_qmp_event(self.events_wait(events))
             if ev['event'] !=3D 'JOB_STATUS_CHANGE':
-                log(ev)
+                if use_log:
+                    log(ev)
                 continue
             status =3D ev['data']['status']
             if status =3D=3D 'aborting':
@@ -565,13 +566,20 @@ class VM(qtest.QEMUQtestMachine):
                 for j in result['return']:
                     if j['id'] =3D=3D job:
                         error =3D j['error']
-                        log('Job failed: %s' % (j['error']))
+                        if use_log:
+                            log('Job failed: %s' % (j['error']))
             elif status =3D=3D 'pending' and not auto_finalize:
                 if pre_finalize:
                     pre_finalize()
-                self.qmp_log('job-finalize', id=3Djob)
+                if use_log:
+                    self.qmp_log('job-finalize', id=3Djob)
+                else:
+                    self.qmp('job-finalize', id=3Djob)
             elif status =3D=3D 'concluded' and not auto_dismiss:
-                self.qmp_log('job-dismiss', id=3Djob)
+                if use_log:
+                    self.qmp_log('job-dismiss', id=3Djob)
+                else:
+                    self.qmp('job-dismiss', id=3Djob)
             elif status =3D=3D 'null':
                 return error
=20
--=20
2.21.0


