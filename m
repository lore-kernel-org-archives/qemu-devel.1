Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D10AECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A6E20B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A6E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTcS-0001t8-Dx
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtI-0002fE-2l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtG-0003cS-Gx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRtD-00034r-FJ; Tue, 01 Oct 2019 19:49:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmY9E144416; Tue, 1 Oct 2019 19:48:34 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccr3f2e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:33 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkFE006374;
 Tue, 1 Oct 2019 23:47:17 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04wdc.us.ibm.com with ESMTP id 2v9y57ye6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:17 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlGwA36897024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E7C828066;
 Tue,  1 Oct 2019 23:47:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61C0328058;
 Tue,  1 Oct 2019 23:47:16 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:16 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/97] spapr/xive: fix EQ page addresses above 64GB
Date: Tue,  1 Oct 2019 18:44:49 -0500
Message-Id: <20191001234616.7825-11-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x91NmY9E144416
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The high order bits of the address of the OS event queue is stored in
bits [4-31] of word2 of the XIVE END internal structures and the low
order bits in word3. This structure is using Big Endian ordering and
computing the value requires some simple arithmetic which happens to
be wrong. The mask removing bits [0-3] of word2 is applied to the
wrong value and the resulting address is bogus when above 64GB.

Guests with more than 64GB of RAM will allocate pages for the OS event
queues which will reside above the 64GB limit. In this case, the XIVE
device model will wake up the CPUs in case of a notification, such as
IPIs, but the update of the event queue will be written at the wrong
place in memory. The result is uncertain as the guest memory is
trashed and IPI are not delivered.

Introduce a helper xive_end_qaddr() to compute this value correctly in
all places where it is used.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190508171946.657-3-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 13df93244efbd4bb8b4cf4e26104a26033178674)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/spapr_xive.c       | 3 +--
 hw/intc/xive.c             | 9 +++------
 include/hw/ppc/xive_regs.h | 6 ++++++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 097f88d460..db75f5d608 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1144,8 +1144,7 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
     }
=20
     if (xive_end_is_enqueue(end)) {
-        args[1] =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) << 32
-            | be32_to_cpu(end->w3);
+        args[1] =3D xive_end_qaddr(end);
         args[2] =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
     } else {
         args[1] =3D 0;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a0b87001da..dcf2fcd108 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1042,8 +1042,7 @@ static const TypeInfo xive_source_info =3D {
=20
 void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qentries =3D 1 << (qsize + 10);
@@ -1072,8 +1071,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, ui=
nt32_t width, Monitor *mon)
=20
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
@@ -1101,8 +1099,7 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t=
 end_idx, Monitor *mon)
=20
 static void xive_end_enqueue(XiveEND *end, uint32_t data)
 {
-    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
-        | be32_to_cpu(end->w3);
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index bf36678a24..1a8c5b5e64 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -208,6 +208,12 @@ typedef struct XiveEND {
 #define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
=20
+static inline uint64_t xive_end_qaddr(XiveEND *end)
+{
+    return ((uint64_t) be32_to_cpu(end->w2) & 0x0fffffff) << 32 |
+        be32_to_cpu(end->w3);
+}
+
 /* Notification Virtual Target (NVT) */
 typedef struct XiveNVT {
         uint32_t        w0;
--=20
2.17.1


