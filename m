Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FC120663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FC120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdY7t-0002i8-6J
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6u-0001Ro-Eq
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6t-0004pr-K4
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04QBXIKo010741; Tue, 26 May 2020 07:50:32 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3170b81g2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 07:50:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QBbSNs001051;
 Tue, 26 May 2020 11:50:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 316uf8wusx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 11:50:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04QBoRGJ45154512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2020 11:50:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C265A52057;
 Tue, 26 May 2020 11:50:27 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 9177E52051;
 Tue, 26 May 2020 11:50:27 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 02DFB22003E;
 Tue, 26 May 2020 13:50:26 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] 9p: Lock directory streams with a CoMutex
Date: Tue, 26 May 2020 13:49:29 +0200
Message-Id: <20200526114931.391049-3-groug@kaod.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526114931.391049-1-groug@kaod.org>
References: <20200526114931.391049-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-26_02:2020-05-26,
 2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 priorityscore=1501 clxscore=1034
 impostorscore=0 mlxlogscore=969 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260087
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:50:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Locking was introduced in QEMU 2.7 to address the deprecation of
readdir_r(3) in glibc 2.24. It turns out that the frontend code is
the worst place to handle a critical section with a pthread mutex:
the code runs in a coroutine on behalf of the QEMU mainloop and then
yields control, waiting for the fsdev backend to process the request
in a worker thread. If the client resends another readdir request for
the same fid before the previous one finally unlocked the mutex, we're
deadlocked.

This never bit us because the linux client serializes readdir requests
for the same fid, but it is quite easy to demonstrate with a custom
client.

A good solution could be to narrow the critical section in the worker
thread code and to return a copy of the dirent to the frontend, but
this causes quite some changes in both 9p.c and codir.c. So, instead
of that, in order for people to easily backport the fix to older QEMU
versions, let's simply use a CoMutex since all the users for this
sit in coroutines.

Fixes: 7cde47d4a89d ("9p: add locking to V9fsDir")
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index dd1c6cb8d2f4..3ab580764cf8 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -197,22 +197,22 @@ typedef struct V9fsXattr
=20
 typedef struct V9fsDir {
     DIR *stream;
-    QemuMutex readdir_mutex;
+    CoMutex readdir_mutex;
 } V9fsDir;
=20
 static inline void v9fs_readdir_lock(V9fsDir *dir)
 {
-    qemu_mutex_lock(&dir->readdir_mutex);
+    qemu_co_mutex_lock(&dir->readdir_mutex);
 }
=20
 static inline void v9fs_readdir_unlock(V9fsDir *dir)
 {
-    qemu_mutex_unlock(&dir->readdir_mutex);
+    qemu_co_mutex_unlock(&dir->readdir_mutex);
 }
=20
 static inline void v9fs_readdir_init(V9fsDir *dir)
 {
-    qemu_mutex_init(&dir->readdir_mutex);
+    qemu_co_mutex_init(&dir->readdir_mutex);
 }
=20
 /*
--=20
2.21.3


