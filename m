Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8BBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5608020651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZlWXildd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5608020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7VI-0004yO-Ij
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:55:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R5-0000WS-RV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hM7R4-0000ZJ-HX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:51:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hM7R1-0000Ao-GA; Thu, 02 May 2019 04:51:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x428nmlX190140; Thu, 2 May 2019 08:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=9ccw3z6s2hPMEok4793CteM3gasxj/Ia2H+u0wiDWIc=;
	b=ZlWXilddp5nYadHxRHXjtvDEaSN2eTD/wEuMzZQBg0+i/W+nvOsQiHJ8yTYMKWr8KKl0
	P0b3pueeVGl+u/tfMEHmAk1A9V1nTV8i2JA6cLDjIeJ9kq6szXxqm50lTmwh+5qKcwfI
	lbc40kgklq5Wapzg7nB3w9OyVz6NlsAOmPEXAyJbwegPED97z8vITkFrC0kTWC6Ovk3x
	EgBOzNBymZtd7u7h72DRr+HLcVKOzYjKCVFJ4BB4KImXugMrw3t7uEIT6aek4oq0bHTJ
	/USQMUL22k3raPytHYXEM3+moIYTHmw2CMLZj1JzyDmpYZmrfCcZXz+isxJVh7BoYgc4
	5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2s6xhyq56y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 08:50:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x428okYN186684; Thu, 2 May 2019 08:50:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2s7rtbksfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 08:50:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x428ovtc006722;
	Thu, 2 May 2019 08:50:57 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 01:50:56 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:50:27 +0300
Message-Id: <20190502085029.30776-2-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905020067
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=983
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905020067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH 1/3] qemu-img: rebase: Reuse parent
 BlockDriverState
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
Cc: eyal.moscovici@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com,
	shmuel.eiderman@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502085027.Xl-MIhxhxNSg7c0n5w_6U4KnhGFtrnVHsZdOe9VB2TA@z>

In safe mode we open the entire chain, including the parent backing
file of the rebased file.
Do not open a new BlockBackend for the parent backing file, which
saves opening the rest of the chain twice, which for long chains
saves many "pricy" bdrv_open() calls.

Permissions for blk_new() were copied from blk_new_open() when
flags = 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 qemu-img.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 8ee63daeae..d9b609b3f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3297,28 +3297,23 @@ static int img_rebase(int argc, char **argv)
 
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
-        char backing_name[PATH_MAX];
         QDict *options = NULL;
+        BlockDriverState *base_bs = backing_bs(bs);
 
-        if (bs->backing_format[0] != '\0') {
-            options = qdict_new();
-            qdict_put_str(options, "driver", bs->backing_format);
+        if (!base_bs) {
+            error_setg(&local_err, "Image does not have a backing file");
+            ret = -1;
+            goto out;
         }
 
-        if (force_share) {
-            if (!options) {
-                options = qdict_new();
-            }
-            qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
-        }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
-        blk_old_backing = blk_new_open(backing_name, NULL,
-                                       options, src_flags, &local_err);
-        if (!blk_old_backing) {
+        blk_old_backing = blk_new(BLK_PERM_CONSISTENT_READ,
+                                  BLK_PERM_ALL);
+        ret = blk_insert_bs(blk_old_backing, base_bs,
+                            &local_err);
+        if (ret < 0) {
             error_reportf_err(local_err,
-                              "Could not open old backing file '%s': ",
-                              backing_name);
-            ret = -1;
+                              "Could not reuse old backing file '%s': ",
+                              base_bs->filename);
             goto out;
         }
 
-- 
2.13.3


