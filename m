Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D122C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5366A20675
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5366A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrD3-0004tR-GV
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:08:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBK-0003jn-89
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBF-0001fi-4s
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hTrB7-0001Zh-JW; Thu, 23 May 2019 13:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F363002F44;
	Thu, 23 May 2019 17:06:52 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D46251001DEF;
	Thu, 23 May 2019 17:06:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 13:06:42 -0400
Message-Id: <20190523170643.20794-5-jsnow@redhat.com>
In-Reply-To: <20190523170643.20794-1-jsnow@redhat.com>
References: <20190523170643.20794-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 23 May 2019 17:06:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/5] iotests.py: rewrite run_job to be
 pickier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't pull events out of the queue that don't belong to us;
be choosier so that we can use this method to drive jobs that
were launched by transactions that may have more jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 48 +++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 6e17c040dc..dc77d3fba0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -540,27 +540,37 @@ class VM(qtest.QEMUQtestMachine):
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
2.20.1


