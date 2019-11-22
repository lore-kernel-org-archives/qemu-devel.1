Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB20DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831B520706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RRyF6ZoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831B520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYFvy-0005zs-KM
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 15:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=6229b31cd3=dschatzberg@fb.com>)
 id 1iYF6s-0006Du-Do
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=6229b31cd3=dschatzberg@fb.com>)
 id 1iYF6r-00046q-5u
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:00:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61498
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=6229b31cd3=dschatzberg@fb.com>)
 id 1iYF6r-000460-05
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:00:53 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xAMJnmmW023724
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 12:00:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=sA+96+x1RojqSYjwLRec8/JmCqDAG5Z+lIbmXLfrUhQ=;
 b=RRyF6ZoJFvF2LQdyIXbKoP/76JL5GrGKjVyHKuxuvbB9t4QEUoVt94odj2tjqoxv/opa
 L+GKO+Ne2/z8LFTHfIqv5AphYjKCwPYy4chYg5eEho7y7GOtC+EtKpYl6hznDlcNmTjD
 sZgIYlUrcgAQX4bVj9er7oF2iJAe+IqW17A= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
 by m0089730.ppops.net with ESMTP id 2wdv587m5e-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 12:00:48 -0800
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 22 Nov 2019 12:00:47 -0800
Received: by devvm2927.frc2.facebook.com (Postfix, from userid 119756)
 id AA40853F59D1; Fri, 22 Nov 2019 12:00:43 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From: Dan Schatzberg <dschatzberg@fb.com>
Smtp-Origin-Hostname: devvm2927.frc2.facebook.com
To: <qemu-devel@nongnu.org>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH] 9pfs: Fix divide by zero bug
Date: Fri, 22 Nov 2019 12:00:34 -0800
Message-ID: <20191122200034.122564-1-dschatzberg@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_04:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 mlxlogscore=616
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=1 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220163
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 67.231.153.30
X-Mailman-Approved-At: Fri, 22 Nov 2019 15:50:56 -0500
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
Cc: Dan Schatzberg <dschatzberg@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some filesystems may return 0s in statfs (trivially, a FUSE filesystem
can do so). QEMU should handle this gracefully and just behave the
same as if statfs failed.

Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
---
 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 37abcdb71e..520177f40c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1834,8 +1834,10 @@ static int32_t coroutine_fn get_iounit(V9fsPDU *pdu, V9fsPath *path)
      * and as well as less than (client msize - P9_IOHDRSZ))
      */
     if (!v9fs_co_statfs(pdu, path, &stbuf)) {
-        iounit = stbuf.f_bsize;
-        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
+        if (stbuf.f_bsize) {
+            iounit = stbuf.f_bsize;
+            iounit *= (s->msize - P9_IOHDRSZ) / stbuf.f_bsize;
+        }
     }
     if (!iounit) {
         iounit = s->msize - P9_IOHDRSZ;
-- 
2.17.1


