Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D15EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9D821721
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9D821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmXP-00050u-5H
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRr-0001jQ-Sx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRp-0005zS-9R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRj-0005uT-Qp; Fri, 14 Jun 2019 09:40:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2557D302454F;
 Fri, 14 Jun 2019 13:40:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3AFA19C58;
 Fri, 14 Jun 2019 13:40:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:09 +0200
Message-Id: <20190614134021.32486-9-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 13:40:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/20] iotests: Fix intermittent failure in 219
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

In 219, we wait for the job to make progress before we emit its status.
This makes the output reliable.  We do not wait for any more progress if
the job's current-progress already matches its total-progress.

Unfortunately, there is a bug: Right after the job has been started,
it's possible that total-progress is still 0.  In that case, we may skip
the first progress-making step and keep ending up 64 kB short.

To fix that bug, we can simply wait for total-progress to reach 4 MB
(the image size) after starting the job.

Reported-by: Karen Mezick <kmezick@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1686651
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190516161114.27596-1-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
[mreitz: Adjusted commit message as per John's proposal]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/219 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index c03bbdb294..e0c51662c0 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -23,6 +23,8 @@ import iotests
=20
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
=20
+img_size =3D 4 * 1024 * 1024
+
 def pause_wait(vm, job_id):
     with iotests.Timeout(3, "Timeout waiting for job to pause"):
         while True:
@@ -62,6 +64,8 @@ def test_pause_resume(vm):
                 iotests.log(vm.qmp('query-jobs'))
=20
 def test_job_lifecycle(vm, job, job_args, has_ready=3DFalse):
+    global img_size
+
     iotests.log('')
     iotests.log('')
     iotests.log('Starting block job: %s (auto-finalize: %s; auto-dismiss=
: %s)' %
@@ -84,6 +88,10 @@ def test_job_lifecycle(vm, job, job_args, has_ready=3D=
False):
     iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANG=
E')))
     iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANG=
E')))
=20
+    # Wait for total-progress to stabilize
+    while vm.qmp('query-jobs')['return'][0]['total-progress'] < img_size=
:
+        pass
+
     # RUNNING state:
     # pause/resume should work, complete/finalize/dismiss should error o=
ut
     iotests.log('')
@@ -173,9 +181,8 @@ with iotests.FilePath('disk.img') as disk_path, \
      iotests.FilePath('copy.img') as copy_path, \
      iotests.VM() as vm:
=20
-    img_size =3D '4M'
-    iotests.qemu_img_create('-f', iotests.imgfmt, disk_path, img_size)
-    iotests.qemu_io('-c', 'write 0 %s' % (img_size),
+    iotests.qemu_img_create('-f', iotests.imgfmt, disk_path, str(img_siz=
e))
+    iotests.qemu_io('-c', 'write 0 %i' % (img_size),
                     '-f', iotests.imgfmt, disk_path)
=20
     iotests.log('Launching VM...')
--=20
2.21.0


