Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C64C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007C220842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSzx-0004Cz-Uc
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tS-AJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0002No-49
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29302
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsJ-0001pc-DT; Tue, 01 Oct 2019 19:48:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlOtP146257; Tue, 1 Oct 2019 19:47:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfcp26j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:48 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nlamr146538;
 Tue, 1 Oct 2019 19:47:48 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfcp26hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlPF031629;
 Tue, 1 Oct 2019 23:47:47 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:47 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NllEk47382866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1BDD2805A;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D584128058;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:46 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/97] iotests: Test backup job with two guest writes
Date: Tue,  1 Oct 2019 18:45:43 -0500
Message-Id: <20191001234616.7825-65-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Perform two guest writes to not yet backed up areas of an image, where
the former touches an inner area of the latter.

Before HEAD^, copy offloading broke this in two ways:
(1) The target image differs from the reference image (what the source
    was when the backup started).
(2) But you will not see that in the failing output, because the job
    offset is reported as being greater than the job length.  This is
    because one cluster is copied twice, and thus accounted for twice,
    but of course the job length does not increase.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190801173900.23851-3-mreitz@redhat.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 5f594a2e99f19ca0f7744d333bcd556f5976b78f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/056     | 39 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out |  4 ++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 3df323984d..e5ac25127b 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -133,6 +133,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm = iotests.VM()
         self.test_img = img_create('test')
         self.dest_img = img_create('dest')
+        self.ref_img = img_create('ref')
         self.vm.add_drive(self.test_img)
         self.vm.launch()
 
@@ -140,6 +141,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm.shutdown()
         try_remove(self.test_img)
         try_remove(self.dest_img)
+        try_remove(self.ref_img)
 
     def hmp_io_writes(self, drive, patterns):
         for pattern in patterns:
@@ -177,6 +179,43 @@ class BackupTest(iotests.QMPTestCase):
             self.assert_qmp(event, 'data/error', qerror)
             return False
 
+    def test_overlapping_writes(self):
+        # Write something to back up
+        self.hmp_io_writes('drive0', [('42', '0M', '2M')])
+
+        # Create a reference backup
+        self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
+                                 sync='full', target=self.ref_img,
+                                 auto_dismiss=False)
+        res = self.vm.qmp('block-job-dismiss', id='drive0')
+        self.assert_qmp(res, 'return', {})
+
+        # Now to the test backup: We simulate the following guest
+        # writes:
+        # (1) [1M + 64k, 1M + 128k): Afterwards, everything in that
+        #     area should be in the target image, and we must not copy
+        #     it again (because the source image has changed now)
+        #     (64k is the job's cluster size)
+        # (2) [1M, 2M): The backup job must not get overeager.  It
+        #     must copy [1M, 1M + 64k) and [1M + 128k, 2M) separately,
+        #     but not the area in between.
+
+        self.qmp_backup(device='drive0', format=iotests.imgfmt, sync='full',
+                        target=self.dest_img, speed=1, auto_dismiss=False)
+
+        self.hmp_io_writes('drive0', [('23', '%ik' % (1024 + 64), '64k'),
+                                      ('66', '1M', '1M')])
+
+        # Let the job complete
+        res = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
+        self.assert_qmp(res, 'return', {})
+        self.qmp_backup_wait('drive0')
+        res = self.vm.qmp('block-job-dismiss', id='drive0')
+        self.assert_qmp(res, 'return', {})
+
+        self.assertTrue(iotests.compare_images(self.ref_img, self.dest_img),
+                        'target image does not match reference image')
+
     def test_dismiss_false(self):
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
diff --git a/tests/qemu-iotests/056.out b/tests/qemu-iotests/056.out
index dae404e278..36376bed87 100644
--- a/tests/qemu-iotests/056.out
+++ b/tests/qemu-iotests/056.out
@@ -1,5 +1,5 @@
-.........
+..........
 ----------------------------------------------------------------------
-Ran 9 tests
+Ran 10 tests
 
 OK
-- 
2.17.1


