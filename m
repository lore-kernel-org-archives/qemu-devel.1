Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227A021537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227A021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmiH-0006si-EN
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRh-0001dw-Go
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRg-0005sf-2o
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRW-0005jg-Id; Fri, 14 Jun 2019 09:40:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A43F259466;
 Fri, 14 Jun 2019 13:40:33 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE5E5B68A;
 Fri, 14 Jun 2019 13:40:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:05 +0200
Message-Id: <20190614134021.32486-5-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 14 Jun 2019 13:40:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/20] iotests.py: rewrite run_job to be pickier
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Don't pull events out of the queue that don't belong to us;
be choosier so that we can use this method to drive jobs that
were launched by transactions that may have more jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-5-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 48 +++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 6a3703e6ee..3ecef5bc90 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -543,27 +543,37 @@ class VM(qtest.QEMUQtestMachine):
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
                 pre_finalize=3DNone, wait=3D60.0):
+        match_device =3D {'data': {'device': job}}
+        match_id =3D {'data': {'id': job}}
+        events =3D [
+            ('BLOCK_JOB_COMPLETED', match_device),
+            ('BLOCK_JOB_CANCELLED', match_device),
+            ('BLOCK_JOB_ERROR', match_device),
+            ('BLOCK_JOB_READY', match_device),
+            ('BLOCK_JOB_PENDING', match_id),
+            ('JOB_STATUS_CHANGE', match_id)
+        ]
         error =3D None
         while True:
-            for ev in self.get_qmp_events_filtered(wait=3Dwait):
-                if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
-                    status =3D ev['data']['status']
-                    if status =3D=3D 'aborting':
-                        result =3D self.qmp('query-jobs')
-                        for j in result['return']:
-                            if j['id'] =3D=3D job:
-                                error =3D j['error']
-                                log('Job failed: %s' % (j['error']))
-                    elif status =3D=3D 'pending' and not auto_finalize:
-                        if pre_finalize:
-                            pre_finalize()
-                        self.qmp_log('job-finalize', id=3Djob)
-                    elif status =3D=3D 'concluded' and not auto_dismiss:
-                        self.qmp_log('job-dismiss', id=3Djob)
-                    elif status =3D=3D 'null':
-                        return error
-                else:
-                    log(ev)
+            ev =3D filter_qmp_event(self.events_wait(events))
+            if ev['event'] !=3D 'JOB_STATUS_CHANGE':
+                log(ev)
+                continue
+            status =3D ev['data']['status']
+            if status =3D=3D 'aborting':
+                result =3D self.qmp('query-jobs')
+                for j in result['return']:
+                    if j['id'] =3D=3D job:
+                        error =3D j['error']
+                        log('Job failed: %s' % (j['error']))
+            elif status =3D=3D 'pending' and not auto_finalize:
+                if pre_finalize:
+                    pre_finalize()
+                self.qmp_log('job-finalize', id=3Djob)
+            elif status =3D=3D 'concluded' and not auto_dismiss:
+                self.qmp_log('job-dismiss', id=3Djob)
+            elif status =3D=3D 'null':
+                return error
=20
     def node_info(self, node_name):
         nodes =3D self.qmp('query-named-block-nodes')
--=20
2.21.0


