Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C2BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC067206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MtdXHJzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC067206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCH1-0003RF-2w
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:01:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0002Gi-FT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF6-0008MF-BN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMCF0-0008HT-Un; Thu, 02 May 2019 09:59:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42Drm6D035800; Thu, 2 May 2019 13:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=ziyXdHnH9IbZkZ8fEb7OALXrXP4qx5fOVQ/VMaT7tUw=;
	b=MtdXHJzCfhlakVnzFk5RHqlMMPzCE+ih7p0dWjBglCizCQgOLFt1Mc+x4jivsrJ4bgWg
	LzTInhczJbTG8yJP1NkOCTa/Z0nA4ScyGZaIqYG+xMbeboEb9irShNox6RvoqLtF8xnb
	JqTFZJVmlhO5iSNFHd5BQOZ23a4dx0wT/RlXkn3eNZ5XLDp7dkVurvfRlqDpV61Yapj4
	rjCC0EU3pZeYHFXnUXMzGRxQ9ayqo9kFgNTjmtjT++kirm+0Mf1zDnwKylu7wKbfYUzE
	yhf0QyL/COfHc+UJ4Ik02vbgR6g9Ln5yZ6dmJ2lZwev1Bn0J2YodlkoxZ+lkQqBwLpGv
	4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2s6xhygtne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42DvtkJ105620; Thu, 2 May 2019 13:59:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2s7p89sdmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:11 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x42DxBGq030467;
	Thu, 2 May 2019 13:59:11 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 06:59:10 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:58:28 +0300
Message-Id: <20190502135828.42797-4-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905020095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905020095
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-img: rebase: Reuse in-chain
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
Message-ID: <20190502135828.leX1JXOKEAvInen1MgFeDTcNY3jHVGpWhuDYsKYFxsU@z>

If a chain was detected, don't open a new BlockBackend from the target
backing file which will create a new BlockDriverState. Instead, create
an empty BlockBackend and attach the already open BlockDriverState.

Permissions for blk_new() were copied from blk_new_open() when
flags = 0.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Signed-off-by: Sagi Amit <sagi.amit@oracle.com>
Co-developed-by: Sagi Amit <sagi.amit@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 qemu-img.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7f20858cb9..b32884bfc5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3348,16 +3348,29 @@ static int img_rebase(int argc, char **argv)
              * in its chain.
              */
             prefix_chain_bs = bdrv_find_backing_image(bs, out_real_path);
-
-            blk_new_backing = blk_new_open(out_real_path, NULL,
-                                           options, src_flags, &local_err);
-            g_free(out_real_path);
-            if (!blk_new_backing) {
-                error_reportf_err(local_err,
-                                  "Could not open new backing file '%s': ",
-                                  out_baseimg);
-                ret = -1;
-                goto out;
+            if (prefix_chain_bs) {
+                g_free(out_real_path);
+                blk_new_backing = blk_new(BLK_PERM_CONSISTENT_READ,
+                                          BLK_PERM_ALL);
+                ret = blk_insert_bs(blk_new_backing, prefix_chain_bs,
+                                    &local_err);
+                if (ret < 0) {
+                    error_reportf_err(local_err,
+                                      "Could not reuse backing file '%s': ",
+                                      out_baseimg);
+                    goto out;
+                }
+            } else {
+                blk_new_backing = blk_new_open(out_real_path, NULL,
+                                               options, src_flags, &local_err);
+                g_free(out_real_path);
+                if (!blk_new_backing) {
+                    error_reportf_err(local_err,
+                                      "Could not open new backing file '%s': ",
+                                      out_baseimg);
+                    ret = -1;
+                    goto out;
+                }
             }
         }
     }
-- 
2.13.3


