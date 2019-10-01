Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF5CECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A0420842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTXd-0004Sm-7n
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsx-0002K0-4N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsu-00039x-S1
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsg-0002Gz-8i; Tue, 01 Oct 2019 19:48:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlO0j053445; Tue, 1 Oct 2019 19:48:05 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcg1716gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:05 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njk6S029377;
 Tue, 1 Oct 2019 23:48:04 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 2v9y59fam2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:48:04 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nm3ET38535672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:48:03 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CBAF2805A;
 Tue,  1 Oct 2019 23:48:03 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 707DE28058;
 Tue,  1 Oct 2019 23:48:03 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:48:03 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 94/97] slirp: ip_reass: Fix use after free
Date: Tue,  1 Oct 2019 18:46:13 -0500
Message-Id: <20191001234616.7825-95-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using ip_deq after m_free might read pointers from an allocation reuse.

This would be difficult to exploit, but that is still related with
CVE-2019-14378 which generates fragmented IP packets that would trigger this
issue and at least produce a DoS.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
(from libslirp.git commit c59279437eda91841b9d26079c70b8a540d41204)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 slirp/src/ip_input.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/slirp/src/ip_input.c b/slirp/src/ip_input.c
index 68a99de5b5..89ae04e0c1 100644
--- a/slirp/src/ip_input.c
+++ b/slirp/src/ip_input.c
@@ -297,6 +297,7 @@ ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp)
 	 */
 	while (q != (struct ipasfrag*)&fp->frag_link &&
             ip->ip_off + ip->ip_len > q->ipf_off) {
+        struct ipasfrag *prev;
 		i = (ip->ip_off + ip->ip_len) - q->ipf_off;
 		if (i < q->ipf_len) {
 			q->ipf_len -= i;
@@ -304,9 +305,10 @@ ip_reass(Slirp *slirp, struct ip *ip, struct ipq *fp)
 			m_adj(dtom(slirp, q), i);
 			break;
 		}
+        prev = q;
 		q = q->ipf_next;
-		m_free(dtom(slirp, q->ipf_prev));
-		ip_deq(q->ipf_prev);
+		ip_deq(prev);
+		m_free(dtom(slirp, prev));
 	}
 
 insert:
-- 
2.17.1


