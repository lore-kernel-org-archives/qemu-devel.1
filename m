Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F61C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E1D2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPjWu4vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E1D2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpvX-0001WG-4X
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:46:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTptx-0007wJ-GR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTptw-0006Iq-If
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:45:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTptu-0006Gj-8G; Thu, 23 May 2019 11:45:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NFi1Lw089869; Thu, 23 May 2019 15:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=VQn+8g7OVSHfojIXASPlc8b/d32RkbBUIb4er9L8jgw=;
	b=LPjWu4vwPHm1/vTXFRQL4+1wZ7JgmgZoW1NeaMJq+9+vG2n0VLY/nIf4u0ycfOTUrchd
	DQ8TRyu4Fk5njAhyJL3kuHpaFMr92Gse0QOYXZec35n6JlJ65mOB5sCQQEm87TdDzwh0
	11IbvPJsddyW7PK0Wf/GHNuZpueLVUzJrpK6JMRF9H3o9nYBfsfP5zO8adbjKOoeCIBa
	oQJO/yqUg99gkV8cbXGVU8Bhivjd7nP749pQnbYiwG1OTjwfIfH8Q46JkujAedTpie1F
	W1YmjA0TtPIfIBB4/7ha8AVs9BFxlWMRf20h88zXQWBFAD1Lj0t8b9hXdAo5VDr9ejbQ
	JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2smsk5k9pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 15:45:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NFha2V021741; Thu, 23 May 2019 15:45:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2smsgtat3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 15:45:00 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4NFj0ZC002481;
	Thu, 23 May 2019 15:45:00 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 15:45:00 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com
Date: Thu, 23 May 2019 18:44:43 +0300
Message-Id: <20190523154444.28783-3-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190523154444.28783-1-shmuel.eiderman@oracle.com>
References: <20190523154444.28783-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=997
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [PATCH v4 2/3] qemu-img: rebase: Reduce reads on
 in-chain rebase
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

In the following case:

(base) A <- B <- C (tip)

when running:

    qemu-img rebase -b A C

QEMU would read all sectors not allocated in the file being rebased (C)
and compare them to the new base image (A), regardless of whether they
were changed or even allocated anywhere along the chain between the new
base and the top image (B). This causes many unneeded reads when
rebasing an image which represents a small diff of a large disk, as it
would read most of the disk's sectors.

Instead, use bdrv_is_allocated_above() to reduce the number of
unnecessary reads.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9bd0bb1e47..e6fd8e1a98 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3164,7 +3164,7 @@ static int img_rebase(int argc, char **argv)
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
-    BlockDriverState *bs = NULL;
+    BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3353,6 +3353,12 @@ static int img_rebase(int argc, char **argv)
                 goto out;
             }
 
+            /*
+             * Find out whether we rebase an image on top of a previous image
+             * in its chain.
+             */
+            prefix_chain_bs = bdrv_find_backing_image(bs, out_real_path);
+
             blk_new_backing = blk_new_open(out_real_path, NULL,
                                            options, src_flags, &local_err);
             g_free(out_real_path);
@@ -3437,6 +3443,23 @@ static int img_rebase(int argc, char **argv)
                 continue;
             }
 
+            if (prefix_chain_bs) {
+                /*
+                 * If cluster wasn't changed since prefix_chain, we don't need
+                 * to take action
+                 */
+                ret = bdrv_is_allocated_above(bs, prefix_chain_bs,
+                                              offset, n, &n);
+                if (ret < 0) {
+                    error_report("error while reading image metadata: %s",
+                                 strerror(-ret));
+                    goto out;
+                }
+                if (!ret) {
+                    continue;
+                }
+            }
+
             /*
              * Read old and new backing file and take into consideration that
              * backing files may be smaller than the COW image.
-- 
2.13.3


