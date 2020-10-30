Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD11C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E3D2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DLR6RiKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E3D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTZt-0003YM-K4
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kYTWF-00027u-Gw; Fri, 30 Oct 2020 08:28:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kYTWD-00030C-Ha; Fri, 30 Oct 2020 08:28:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09UC2Vfp013847; Fri, 30 Oct 2020 08:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fAilbE+DOMC+LSljOWLvPLtXdUGINSrGsFpNxtrU184=;
 b=DLR6RiKKDxegSz5icBMtY13OfD8xYFoW/eghGi6+M2t0fQQvm892PYa3dzZ0hmmsiG62
 MoaxabmTGrs7gZ/ezi7jUbI6BvvabkVdozlwy4/o2+HwYq45d1vBlgRsPItycnAf13av
 SA5A3OpG1h5Zatd6/MVvFxAHjrvyaJ0tQtW/9URw95SeNDNCIrpAs6jrWG3LYrWN9kTJ
 6ssEQw66OLZDlzLdt+UFm3xrxRBjQu+YXqK7itnf6oK1mNu6xpfwPnrO/EVTsyolKpqW
 T57KWjL4G7vKEeDeEaaux/HX0NGsPMXD5Bc9nIM6Rc1f0+xgv4L3Rt2wXXmCeqH1CrrI 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34ge51159p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 08:28:29 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09UC2VkS013878;
 Fri, 30 Oct 2020 08:28:29 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34ge51158s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 08:28:29 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09UCQv91029795;
 Fri, 30 Oct 2020 12:28:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma05fra.de.ibm.com with ESMTP id 34fv15rkvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 12:28:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09UCSNwx28770762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 12:28:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C25D05205A;
 Fri, 30 Oct 2020 12:28:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AE7C552054;
 Fri, 30 Oct 2020 12:28:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 5DAD4E24D3; Fri, 30 Oct 2020 13:28:23 +0100 (CET)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] s390-bios: Skip writing iplb location to low core for ccw ipl
Date: Fri, 30 Oct 2020 13:28:23 +0100
Message-Id: <20201030122823.347140-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-30_04:2020-10-30,
 2020-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=651 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 08:28:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

The architecture states that the iplb location is only written to low
core for list directed ipl and not for traditional ccw ipl. If we don't
skip this then operating systems that load by reading into low core
memory may fail to start.

We should also not write the iplb pointer for network boot as it might
overwrite content that we got via network.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 43c792cf9509..fc4bfaa45529 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -43,7 +43,9 @@ void write_subsystem_identification(void)
 
 void write_iplb_location(void)
 {
-    lowcore->ptr_iplb = ptr2u32(&iplb);
+    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
+        lowcore->ptr_iplb = ptr2u32(&iplb);
+    }
 }
 
 unsigned int get_loadparm_index(void)
-- 
2.26.2


