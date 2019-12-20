Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A892C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44D720866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44D720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLWU-0006t5-Mq
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iiLVH-0005Zr-0n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iiLVF-0005Ls-V8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63328
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iiLVF-0005L7-Nc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKGRgV2069204
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:51:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x0xcdrmpj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:51:49 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 20 Dec 2019 16:51:47 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 20 Dec 2019 16:51:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBKGphLs45547956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2019 16:51:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 269C65204E;
 Fri, 20 Dec 2019 16:51:43 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.169.241])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E938C52051;
 Fri, 20 Dec 2019 16:51:42 +0000 (GMT)
Subject: [PATCH 1/2] ppc/pnv: Exit gracefully if CPU topology doesn't match
 the machine capacities
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 20 Dec 2019 17:51:42 +0100
In-Reply-To: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
References: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19122016-0008-0000-0000-00000342FD0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122016-0009-0000-0000-00004A631B52
Message-Id: <157686070223.97184.882725559353545017.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_04:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1034 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912200127
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU crashes when started with:

   -machine powernv,num-chips=2 -smp cores=2 -accel tcg,thread=multi

ERROR:
tcg/tcg.c:789:tcg_register_thread: assertion failed: (n < ms->smp.max_cpus)
Aborted (core dumped)

This happens because the powernv machine creates num-chips * smp.cores
CPUs, which might exceed the maximum number of CPUs of the CPU topology
as computed by smp_parse().

Check the CPU topology in pnv_set_num_chips().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f77e7ca84ede..f8cf2b6d760f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1706,7 +1706,8 @@ static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
-    uint32_t num_chips;
+    MachineState *ms = MACHINE(pnv);
+    uint32_t num_chips, num_cpus;
     Error *local_err = NULL;
 
     visit_type_uint32(v, name, &num_chips, &local_err);
@@ -1724,6 +1725,13 @@ static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    num_cpus = num_chips * ms->smp.cores * ms->smp.threads;
+    if (num_cpus > ms->smp.max_cpus) {
+        error_setg(errp, "%d chips don't fit in the CPU topology", num_chips);
+        error_append_hint(errp, "Try -smp sockets=%d.\n", num_chips);
+        return;
+    }
+
     pnv->num_chips = num_chips;
 }
 


