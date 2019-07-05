Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9914C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5B821670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5B821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUqF-00034E-Pa
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUeO-0005tl-SL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUeN-0007Qo-SS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUeL-0007NL-FO; Fri, 05 Jul 2019 16:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE3F03082A98;
 Fri,  5 Jul 2019 20:17:40 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58B48867E6;
 Fri,  5 Jul 2019 20:17:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:27 -0400
Message-Id: <20190705201631.26266-15-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 05 Jul 2019 20:17:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/18] iotests: teach run_job to cancel
 pending jobs
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

run_job can cancel pending jobs to simulate failure. This lets us use
the pending callback to issue test commands while the job is open, but
then still have the job fail in the end.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index fcad957d63..c544659ecb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -541,7 +541,22 @@ class VM(qtest.QEMUQtestMachine):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, wait=3D60.0):
+                pre_finalize=3DNone, cancel=3DFalse, wait=3D60.0):
+        """
+        run_job moves a job from creation through to dismissal.
+
+        :param job: String. ID of recently-launched job
+        :param auto_finalize: Bool. True if the job was launched with
+                              auto_finalize. Defaults to True.
+        :param auto_dismiss: Bool. True if the job was launched with
+                             auto_dismiss=3DTrue. Defaults to False.
+        :param pre_finalize: Callback. A callable that takes no argument=
s to be
+                             invoked prior to issuing job-finalize, if a=
ny.
+        :param cancel: Bool. When true, cancels the job after the pre_fi=
nalize
+                       callback.
+        :param wait: Float. Timeout value specifying how long to wait fo=
r any
+                     event, in seconds. Defaults to 60.0.
+        """
         match_device =3D {'data': {'device': job}}
         match_id =3D {'data': {'id': job}}
         events =3D [
@@ -568,7 +583,10 @@ class VM(qtest.QEMUQtestMachine):
             elif status =3D=3D 'pending' and not auto_finalize:
                 if pre_finalize:
                     pre_finalize()
-                self.qmp_log('job-finalize', id=3Djob)
+                if cancel:
+                    self.qmp_log('job-cancel', id=3Djob)
+                else:
+                    self.qmp_log('job-finalize', id=3Djob)
             elif status =3D=3D 'concluded' and not auto_dismiss:
                 self.qmp_log('job-dismiss', id=3Djob)
             elif status =3D=3D 'null':
--=20
2.21.0


