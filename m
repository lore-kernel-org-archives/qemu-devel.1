Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A6C205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gurmdCO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A6C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMBTb-0005AI-2n
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 09:10:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSO-0004YS-OX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMBSN-0006IQ-Mm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:09:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMBSD-0005xn-TS; Thu, 02 May 2019 09:08:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42D3YLj182956; Thu, 2 May 2019 13:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=sErMukjrtGgSh3mHJoEGKWH+RlxHAVP8rjvTiiBwq5I=;
	b=gurmdCO80754jWAZLKo/hJREscSi5oV6sno4/YiaeLuRir9IpzS1DlIy6jQL7BFDnl3v
	tsUR+BPk3hMnHZfPeW58Zw3+5clCNsuipWVYu3Gz9EFjkIILoUbIkT7I1S19ZC8JE6Ie
	ULpPhNi8mtl+UUjHum60rIcpHeClPz0Zyq54iUg4Pg/wFg8QYdSFe0O7Gb/oUuoZuRPF
	HsJTKMtTaln97OK7TAkj1dwQEJfS0zfgBNrag+vDnMzfovpVcKOTmoe/MUQgDYh+b2XY
	d5ObdNR6VfooqV+/zdH7yE7xMM9S0qZX3pGLO4hOzilE7x2Rbc3iJSffegWWptiBqPJC
	mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2s6xhygeyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:08:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42D7eCR160126; Thu, 2 May 2019 13:08:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2s7p89rg2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:08:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x42D8cNB024451;
	Thu, 2 May 2019 13:08:38 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 06:08:37 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, thuth@redhat.com, fam@euphon.net, eblake@redhat.com
Date: Thu,  2 May 2019 16:08:22 +0300
Message-Id: <20190502130822.46858-2-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190502130822.46858-1-shmuel.eiderman@oracle.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905020091
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905020091
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to vmdk
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
Cc: shmuel.eiderman@oracle.com, arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502130822.5x-c9f_bZIEmOaWIWabmt9YXlagjkDTfZ1IYxYNLgEU@z>

Commit b69864e ("vmdk: Support version=3 in VMDK descriptor files")
fixed the probe function to correctly guess vmdk descriptors with
version=3.

This solves the issue where vmdk snapshot with parent vmdk descriptor
containing "version=3" would be treated as raw instead vmdk.

In the future case where a new vmdk version is introduced, we will again
experience this issue, even if the user will provide "-f vmdk" it will
only apply to the tip image and not to the underlying "misprobed" parent
image.

The code in vmdk.c already assumes that the backing file of vmdk must be
vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
vmdk).

So let's make it official by supplying the backing_format as vmdk.

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-By: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
---
 block/vmdk.c           | 2 ++
 tests/qemu-iotests/110 | 6 +++---
 tests/qemu-iotests/126 | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8dec6ef767..de8cb859f8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
                 bs->auto_backing_file);
+        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
+                "vmdk");
     }
 
 out:
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..982569dbc5 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
 # qemu should be able to reconstruct the filename, so relative backing names
 # should work
 TEST_IMG="json:{'driver':'$IMGFMT','file':{'driver':'file','filename':'$TEST_IMG'}}" \
-    _img_info | _filter_img_info
+    _img_info | _filter_img_info | grep -v "backing file format"
 
 echo
 echo '=== Non-reconstructable filename ==='
@@ -78,7 +78,7 @@ TEST_IMG="json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v "backing file format"
 
 echo
 echo '=== Backing name is always relative to the backed image ==='
@@ -110,7 +110,7 @@ TEST_IMG="json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v "backing file format"
 
 
 # success, all done
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..1f7618c8a5 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -63,7 +63,7 @@ TEST_IMG=$BASE_IMG _make_test_img 64M
 TEST_IMG=$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
 
 # The default cluster size depends on the image format
-TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
 
 _rm_test_img "$BASE_IMG"
 _rm_test_img "$TOP_IMG"
@@ -79,7 +79,7 @@ TOP_IMG="file:image:top.$IMGFMT"
 TEST_IMG=$BASE_IMG _make_test_img 64M
 TEST_IMG=$TOP_IMG _make_test_img -b "$BASE_IMG"
 
-TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=$TOP_IMG _img_info | grep -v 'cluster_size\|backing file format'
 
 _rm_test_img "$BASE_IMG"
 _rm_test_img "image:top.$IMGFMT"
-- 
2.13.3


