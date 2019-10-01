Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F010C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D291E20842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D291E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFThY-0007H7-Oz
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsw-0002JP-Oq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRss-00037r-RV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51988
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsg-0002D1-PW; Tue, 01 Oct 2019 19:48:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlX3d146488; Tue, 1 Oct 2019 19:48:04 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcfcp26q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:04 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkEb027150;
 Tue, 1 Oct 2019 23:48:03 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:48:03 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nm3As38535662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:48:03 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 104CA28059;
 Tue,  1 Oct 2019 23:48:03 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E88B12805C;
 Tue,  1 Oct 2019 23:48:02 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:48:02 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 93/97] slirp: Fix heap overflow in ip_reass on big packet input
Date: Tue,  1 Oct 2019 18:46:12 -0500
Message-Id: <20191001234616.7825-94-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the first fragment does not fit in the preallocated buffer, q will
already be pointing to the ext buffer, so we mustn't try to update it.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
(from libslirp.git commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210)
(from libslirp.git commit e0be80430c390bce181ea04dfcdd6ea3dfa97de1)
*squash in e0be80 (clarifying comments)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 slirp/src/ip_input.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/slirp/src/ip_input.c b/slirp/src/ip_input.c
index a714fecd58..68a99de5b5 100644
--- a/slirp/src/ip_input.c
+++ b/slirp/src/ip_input.c
@@ -331,6 +331,8 @@ insert:
     q = fp->frag_link.next;
 	m = dtom(slirp, q);
 
+	int was_ext = m->m_flags & M_EXT;
+
 	q = (struct ipasfrag *) q->ipf_next;
 	while (q != (struct ipasfrag*)&fp->frag_link) {
 	  struct mbuf *t = dtom(slirp, q);
@@ -347,13 +349,12 @@ insert:
 	q = fp->frag_link.next;
 
 	/*
-	 * If the fragments concatenated to an mbuf that's
-	 * bigger than the total size of the fragment, then and
-	 * m_ext buffer was alloced. But fp->ipq_next points to
-	 * the old buffer (in the mbuf), so we must point ip
-	 * into the new buffer.
+	 * If the fragments concatenated to an mbuf that's bigger than the total
+	 * size of the fragment and the mbuf was not already using an m_ext buffer,
+	 * then an m_ext buffer was alloced. But fp->ipq_next points to the old
+	 * buffer (in the mbuf), so we must point ip into the new buffer.
 	 */
-	if (m->m_flags & M_EXT) {
+	if (!was_ext && m->m_flags & M_EXT) {
 	  int delta = (char *)q - m->m_dat;
 	  q = (struct ipasfrag *)(m->m_ext + delta);
 	}
-- 
2.17.1


