Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27CC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9535A20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9535A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6FGX-0002cW-NA
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 10:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j6FFf-0001p1-I7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j6FFa-0002X8-Bx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:02:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38476
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j6FFa-0002We-6v
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:02:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01OErhPB127163
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:02:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb161ves0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:02:24 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 24 Feb 2020 15:02:23 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 24 Feb 2020 15:02:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01OF2IAc45089054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 15:02:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B88452052;
 Mon, 24 Feb 2020 15:02:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BAAA552051;
 Mon, 24 Feb 2020 15:02:17 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/1] s390/ipl: sync back loadparm
Date: Mon, 24 Feb 2020 16:02:13 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20022415-0020-0000-0000-000003AD23CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022415-0021-0000-0000-0000220535B4
Message-Id: <20200224150213.21253-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_04:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We expose loadparm as a r/w machine property, but if loadparm is set by
the guest via DIAG 308, we don't update the property. Having a
disconnect between the guest view and the QEMU property is not nice in
itself, but things get even worse for SCSI, where under certain
circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
expected" for details) we call s390_gen_initial_iplb() on resets
effectively overwriting the guest/user supplied loadparm with the stale
value.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 7104bae9de "hw/s390x: provide loadparm property for the machine"
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 hw/s390x/ipl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499d7f..97a279c1a5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -538,6 +538,26 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
     return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
 }
 
+static void update_machine_ipl_properties(IplParameterBlock *iplb)
+{
+    Object *mo = qdev_get_machine();
+
+    /* Sync loadparm */
+    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
+        char ascii_loadparm[8];
+        uint8_t *ebcdic_loadparm = iplb->loadparm;
+        int i;
+
+        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
+            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
+        }
+        ascii_loadparm[i] = 0;
+        object_property_set_str(mo, ascii_loadparm, "loadparm", NULL);
+    } else {
+        object_property_set_str(mo, "", "loadparm", NULL);
+    }
+}
+
 void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -545,6 +565,7 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
     ipl->iplb = *iplb;
     ipl->iplb_valid = true;
     ipl->netboot = is_virtio_net_device(iplb);
+    update_machine_ipl_properties(iplb);
 }
 
 IplParameterBlock *s390_ipl_get_iplb(void)

base-commit: c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f
-- 
2.17.1


