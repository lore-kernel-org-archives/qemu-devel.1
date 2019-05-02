Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C731C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3729C206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9Y6nrS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3729C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCH0-0003Qk-DH
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:01:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCFF-0002N0-9S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCF7-0008Mc-8p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:59:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMCF0-0008F7-UK; Thu, 02 May 2019 09:59:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42DrlVf035774; Thu, 2 May 2019 13:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references;
	s=corp-2018-07-02; 
	bh=+GmqDTr4A0b+4arMEn7WVVZ2pJzJXgiEeewztayhFGY=;
	b=Z9Y6nrS2+q1acxCTrq+HcGGxrDctndroar4aE5grrQ1WNOEUWy7Qm2FKSgkxWLdSrZNE
	BTupRJTdW/Xo6Cm41+IHJSPLyPalSS4t7+/JQe3XC85bSvFnAx1XhBJMxGcckhtrvoCy
	nB1ba/U3Z5x3PoXWNToAylIjJ3zf+UAZZ6u6FHP2cX3K05Ge4Ko4QB/C0x80klysOORT
	JNYe278ERQZ7Q6zp3Dp013gGOB+iRRWoJag0oA1NHTwauIWyCXpnzCjyHWz6aikhkSut
	CiS4MqGLlxssP7NgCauROzwT2jLTwZRtsx84LBXDWOuk675yVIll3vgovTxclDDrYof1
	KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2s6xhygtn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42Dx5NF078452; Thu, 2 May 2019 13:59:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 2s6xhh2rhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 13:59:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x42Dx875030393;
	Thu, 2 May 2019 13:59:08 GMT
Received: from nexus.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 06:59:08 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:58:27 +0300
Message-Id: <20190502135828.42797-3-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190502135828.42797-1-shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
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
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-img: rebase: Reduce reads on
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502135827.aqeuz55TuRzK5CrUn6Wc59hPTZFyPs3bWhN7tHLH9X4@z>

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
index d9b609b3f0..7f20858cb9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3152,7 +3152,7 @@ static int img_rebase(int argc, char **argv)
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
-    BlockDriverState *bs = NULL;
+    BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3343,6 +3343,12 @@ static int img_rebase(int argc, char **argv)
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
@@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
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


