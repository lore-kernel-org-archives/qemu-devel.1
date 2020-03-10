Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDFE20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="isddHPJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDFE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi9E-0002ix-Kg
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6T-0006M6-96
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6R-0005Qa-94
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6R-0005F0-00
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcP8L010681;
 Tue, 10 Mar 2020 16:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mpcf7favVlwULOZ6B5KpaVIfHziy38c68GzKP0xzj8s=;
 b=isddHPJJUihlysdwj0NY1FG+X7Ffbg6msGJSgrSB3EwB4/k/2um9fFgB93PK5IaNHtdi
 22nxq4C3uvnnJwKXIPN8tMOSLKuFrOr9UioWlFDGcaTMUn0fR67RJ0tRi7GqcXvMgkZM
 SEkMAjQ7WWP4uYcSh54WhThr4L2i6jVwhBADjGMHaItM2ZEogqGxKSNFu1sc5puKQjnR
 XQww0aL0RGH24thMPBbzy/ys82SPawHjuQ8qu84RMRDG+9iSjRBoEZjVgHpZ1I4MZukw
 vlS884Lx4FnmyogdjNyIp0QK6IfV2ZlUGRsFWXkgdtsPtbxzVoUXhL9QCcgrpI/0AgWb 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbHDn102146;
 Tue, 10 Mar 2020 16:51:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yp8qp6cn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AGpURI011357;
 Tue, 10 Mar 2020 16:51:30 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:29 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] hw/i386/vmport: Add compatability version field
Date: Tue, 10 Mar 2020 18:53:18 +0200
Message-Id: <20200310165332.140774-3-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 nikita.leshchenko@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change.

This is done as a preparation for the following patches which will change
guest-visible behavior. Adding this version field will allow us to
maintain migration compatability from new QEMU version to old QEMU
version (Given machine-type is the compatabile).

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 8d7513e2a23c..ca4d95fc017f 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -44,6 +44,8 @@ typedef struct VMPortState {
     MemoryRegion io;
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
+
+    uint8_t version;
 } VMPortState;
 
 static VMPortState *port_state;
@@ -156,6 +158,12 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
 }
 
 static Property vmport_properties[] = {
+    /*
+     * Used to enforce compatibility for migration.
+     * On every guest-visible change, should make changes conditioned on
+     * version and define proper version for previous machine-types.
+     */
+    DEFINE_PROP_UINT8("version", VMPortState, version, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


