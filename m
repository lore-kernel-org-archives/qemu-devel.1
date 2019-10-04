Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94049C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691622084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691622084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJ7L-0005U5-KH
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iGJ6Y-0004u8-1G
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iGJ6W-000343-Ri
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:38:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34118
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iGJ6W-00030m-MQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:38:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x948cFDG194892
 for <qemu-devel@nongnu.org>; Fri, 4 Oct 2019 04:38:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ve0ey4x59-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:38:20 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 4 Oct 2019 09:37:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 4 Oct 2019 09:37:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x948bmFo48889936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Oct 2019 08:37:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C62C8AE04D;
 Fri,  4 Oct 2019 08:37:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1248CAE051;
 Fri,  4 Oct 2019 08:37:48 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Oct 2019 08:37:47 +0000 (GMT)
Subject: [PATCH] xics: Make some device types not user creatable
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 04 Oct 2019 10:37:47 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100408-0028-0000-0000-000003A5ECDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100408-0029-0000-0000-00002467F6BC
Message-Id: <157017826724.337875.14822177178282524024.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-04_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040081
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some device types of the XICS model are exposed to the QEMU command
line:

$ ppc64-softmmu/qemu-system-ppc64 -device help | grep ic[sp]
name "icp"
name "ics"
name "ics-spapr"
name "pnv-icp", desc "PowerNV ICP"

These are internal devices that shouldn't be instantiable by the
user. By the way, they can't be because their respective realize
functions expect link properties that can't be set from the command
line:

qemu-system-ppc64: -device icp: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device ics: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device ics-spapr: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device pnv-icp: required link 'xics' not found:
 Property '.xics' not found

Hide them by setting dc->user_creatable to false in the base class
"icp" and "ics" init functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index dfe7dbd254ab..8d41df3103f9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -369,6 +369,7 @@ static void icp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo icp_info = {
@@ -689,6 +690,7 @@ static void ics_class_init(ObjectClass *klass, void *data)
     dc->props = ics_properties;
     dc->reset = ics_reset;
     dc->vmsd = &vmstate_ics;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo ics_info = {


