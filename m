Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B565206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B565206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVe6T-00088x-Bz
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVe4p-0006IB-TF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVe4o-0007jH-Ku
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:04:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVe4o-0007it-D1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:04:02 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFvjD3047850
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 11:03:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsjwpge-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 11:03:58 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 15 Nov 2019 16:03:55 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 16:03:52 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAFG3F7813304122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 16:03:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAAD3AE056;
 Fri, 15 Nov 2019 16:03:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A1B4AE04D;
 Fri, 15 Nov 2019 16:03:51 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 16:03:51 +0000 (GMT)
Subject: [PATCH] ppc/pnv: Drop "chip" link from POWER9 PSI object
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 15 Nov 2019 17:03:51 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111516-0028-0000-0000-000003B74461
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111516-0029-0000-0000-0000247A56A1
Message-Id: <157383383118.166856.2588933416368211047.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1034 adultscore=0 impostorscore=0
 mlxlogscore=861 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150143
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It has no apparent user.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d7130c3304f0..24bc3d5ab32b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1091,8 +1091,6 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi),
                             TYPE_PNV9_PSI, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj,
-                                   &error_abort);
 
     object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc),
                             TYPE_PNV9_LPC, &error_abort, NULL);


