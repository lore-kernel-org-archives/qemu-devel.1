Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BAC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B6E217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B6E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAuV-000551-JM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:10:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAni-0007aI-QJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAng-0005xB-Oy
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hPAnb-0005sM-0o; Fri, 10 May 2019 15:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44EA7308339A;
	Fri, 10 May 2019 19:03:14 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64FE75ED4B;
	Fri, 10 May 2019 19:03:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:03:06 -0400
Message-Id: <20190510190307.17647-4-jsnow@redhat.com>
In-Reply-To: <20190510190307.17647-1-jsnow@redhat.com>
References: <20190510190307.17647-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 10 May 2019 19:03:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/4] iotests.py: rewrite run_job to be
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't pull events out of the queue that don't belong to us;
be choosier so that we can use this method to drive jobs that
were launched by transactions that may have more jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 561f547a97..601c802476 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -536,23 +536,21 @@ class VM(qtest.QEMUQtestMachine):
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse, w=
ait=3D60.0):
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
-                        self.qmp_log('job-finalize', id=3Djob)
-                    elif status =3D=3D 'concluded' and not auto_dismiss:
-                        self.qmp_log('job-dismiss', id=3Djob)
-                    elif status =3D=3D 'null':
-                        return error
-                else:
-                    iotests.log(ev)
+            ev =3D self.event_wait(name=3D'JOB_STATUS_CHANGE',
+                                 match=3D{'data':{'id':job}})
+            status =3D ev['data']['status']
+            if status =3D=3D 'aborting':
+                result =3D self.qmp('query-jobs')
+                for j in result['return']:
+                    if j['id'] =3D=3D job:
+                        error =3D j['error']
+                        log('Job failed: %s' % (j['error']))
+            elif status =3D=3D 'pending' and not auto_finalize:
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


