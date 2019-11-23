Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48458C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 17:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121FC20719
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121FC20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYYsX-0006fb-7r
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 12:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iYYl4-00085F-BX
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iYYl2-0002Dq-L6
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iYYl2-0002DZ-BU
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 11:59:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xANGvgvK135836
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 11:59:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wf1t1sag3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 11:59:39 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 23 Nov 2019 16:59:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 23 Nov 2019 16:59:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xANGxXdd51576840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 Nov 2019 16:59:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BCF65205F;
 Sat, 23 Nov 2019 16:59:33 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 08DC15204E;
 Sat, 23 Nov 2019 16:59:33 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-172-18.de.ibm.com [9.145.172.18])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 6F93E22008F;
 Sat, 23 Nov 2019 17:59:32 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] 9pfs: Fix divide by zero bug
Date: Sat, 23 Nov 2019 17:59:15 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191123165915.1077842-1-groug@kaod.org>
References: <20191123165915.1077842-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112316-0028-0000-0000-000003BE79DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112316-0029-0000-0000-00002481A950
Message-Id: <20191123165915.1077842-2-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_04:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=627
 suspectscore=4 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1034 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911230141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Dan Schatzberg <dschatzberg@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dan Schatzberg <dschatzberg@fb.com>

Some filesystems may return 0s in statfs (trivially, a FUSE filesystem
can do so). QEMU should handle this gracefully and just behave the
same as if statfs failed.

Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 37abcdb71ec0..520177f40c17 100644
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
2.21.0


