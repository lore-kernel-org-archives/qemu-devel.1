Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5614C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C151722267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J3yDUSwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C151722267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVXui-00059u-P7
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 06:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVXsw-0004AB-1y; Thu, 22 Oct 2020 06:31:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kVXso-00021O-4r; Thu, 22 Oct 2020 06:31:53 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09MA3ejF052765; Thu, 22 Oct 2020 06:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rrNFBG2DlRgGpO3rffrw7ArFcwYlaWuKcXvagTGLC5Y=;
 b=J3yDUSwoGrYvbBOJdF2j6JhWhRg0zi0FrwB6EAp0hCpYh8EsvUw6POOKTvR1JLI/lnPZ
 xeUtKSueCUABY0mOCQMv8COa5v7gS2aE6zqvWMv7MtoWpgJf1fJqIknh1LcTodiKi53+
 bh7DFtdgFOAe465cpT9zkJR52+MdOBRQIEeMe8qns3g6eLyCAlT8/wVG4RXK5niA3QII
 mcqjc4EDK8Bct0L9obLm5FYfgcNppz7WHk/+v5n33GFmvKpDLtKn6mDp01rLxgUglV9b
 0Z0wJSWQEd53vUH6yy5O++Nv+Q26hDH81VMnpae6Bdq7Y6FeGUGxb99mTF/I8ko4xpj4 nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0ekk5qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 06:31:44 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MA4PhJ055454;
 Thu, 22 Oct 2020 06:31:44 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0ekk5pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 06:31:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MARVph023725;
 Thu, 22 Oct 2020 10:31:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 347r87ts5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 10:31:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09MAVdoP28377382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 10:31:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E218B52063;
 Thu, 22 Oct 2020 10:31:38 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 151345204F;
 Thu, 22 Oct 2020 10:31:38 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] s390x: pv: Remove sclp boundary checks
Date: Thu, 22 Oct 2020 06:31:34 -0400
Message-Id: <20201022103135.126033-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022103135.126033-1-frankja@linux.ibm.com>
References: <20201022103135.126033-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_02:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=1 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:31:44
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 walling@linux.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SCLP boundary cross check is done by the Ultravisor for a
protected guest, hence we don't need to do it. As QEMU doesn't get a
valid SCCB address in protected mode this is even problematic and can
lead to QEMU reporting a false boundary cross error.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: db13387ca0 ("s390/sclp: rework sclp boundary checks")
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 hw/s390x/sclp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 00f1e4648d..0cf2290826 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -285,11 +285,6 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length), code)) {
-        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
-        goto out_write;
-    }
-
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
-- 
2.25.1


