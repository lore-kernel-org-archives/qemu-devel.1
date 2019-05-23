Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D837C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E3E2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wfPQvqVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E3E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToFE-0004dT-GN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:58:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hToDv-0003ql-Iw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hToDu-0002D0-LF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:57:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTo92-0007Tu-8B; Thu, 23 May 2019 09:52:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NDhSf7155184; Thu, 23 May 2019 13:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=qe8PLR9/UiNEo6e1lHVkJVCotNDWuaHF+uQaPNfv3zg=;
	b=wfPQvqVqGAYiRoWVnvG9bzkoCp+8hK4AXM2VMGk52k0bJtC25DZ0eeaDORFZspMdQRSb
	cr2hi/+0VBhkB0POI3BloPhFCOE3jY3PFX/sc/HuMDnV9iBhK5ezf82dp9wUBfN3NE8N
	svnhTqL5OmIBieVf7funlUneUuWWSDMUTztbhcqTjYO8HdNXimq7IRmqJbR5jP/vpnvw
	61Le8K0OU+keaM1Vnjb40wVQjYBmf9tv+i8oI1YZPFna+R2MgEkPRons4v/QAja0aRMq
	KVXV5Fl+uOm7x9VtMXo7yXB3or+3/I3PjdbapRCTf35REm37WiqpvVmwEhXRebVPoZzz
	Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2smsk5jfbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 13:52:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NDqCqj101169; Thu, 23 May 2019 13:52:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2smsh28rgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 13:52:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4NDqTZb000431;
	Thu, 23 May 2019 13:52:29 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 13:52:29 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Thu, 23 May 2019 16:51:39 +0300
Message-Id: <20190523135139.2147-4-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190523135139.2147-1-shmuel.eiderman@oracle.com>
References: <20190523135139.2147-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230096
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v3 3/3] qemu-img: rebase: Reuse in-chain
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
index e6fd8e1a98..b3a1c76fb6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3358,16 +3358,29 @@ static int img_rebase(int argc, char **argv)
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


