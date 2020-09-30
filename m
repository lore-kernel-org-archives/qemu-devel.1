Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9EC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A11206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S1f5E97A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A11206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeZw-00020k-A7
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeW0-0007QV-9Z; Wed, 30 Sep 2020 11:59:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeVm-00020T-H4; Wed, 30 Sep 2020 11:59:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08UFnG8P052456; Wed, 30 Sep 2020 11:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=wiicjQIMdALL4f3XaB02g4q83zY3RjiA3GiRnoP6IHI=;
 b=S1f5E97AbEwRtiGHGdTlaix57XaZngIylZcNNrfvxv5u5+OR88sRa4S9kw2hiwR8XgH9
 x4uEGn3OJNOiLHS1FUyY4OfmWjE4HB1yUUhZ3wblh7xzKIVFsK4bVDQkC88G9UE7H7vZ
 kUddga8UhTgewiqiBtpzLdq7uhBpbIl38OE7OWfvGMYhn/xGuQL4hqxayzqTNIXSEENQ
 +GlRmtjI468KSFPKxxIvrTH8o9NMRdEuiEA07bm2j+7LmB4gxl1CggPssz+cMSRRk/0F
 zmeWRafZsH+dHairdtF5mHYQGMvbWnkvFUWeVa5qs3KWMbLAn9wrqos+H2/Hh3D5IlPX Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33vw0eg7cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:07 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UFpddg058838;
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33vw0eg7am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UFwMmG020400;
 Wed, 30 Sep 2020 15:59:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma01fra.de.ibm.com with ESMTP id 33sw98admf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 15:59:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08UFx15i30867752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 15:59:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B90B45204E;
 Wed, 30 Sep 2020 15:59:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A73EC5204F;
 Wed, 30 Sep 2020 15:59:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 5448BE1FB0; Wed, 30 Sep 2020 17:59:01 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] nbd: silence maybe-uninitialized warnings
Date: Wed, 30 Sep 2020 17:58:57 +0200
Message-Id: <20200930155859.303148-3-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930155859.303148-1-borntraeger@de.ibm.com>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-30_08:2020-09-30,
 2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 suspectscore=1 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:59:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gcc 10 from Fedora 32 gives me:

Compiling C object libblock.fa.p/nbd_server.c.o
../nbd/server.c: In function ‘nbd_co_client_start’:
../nbd/server.c:625:14: error: ‘namelen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  625 |         rc = nbd_negotiate_send_info(client, NBD_INFO_NAME, namelen, name,
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  626 |                                      errp);
      |                                      ~~~~~
../nbd/server.c:564:14: note: ‘namelen’ was declared here
  564 |     uint32_t namelen;
      |              ^~~~~~~
cc1: all warnings being treated as errors

As I cannot see how this can happen, let uns silence the warning.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 982de67816a7..2ff04ee7533d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -561,7 +561,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     NBDExport *exp;
     uint16_t requests;
     uint16_t request;
-    uint32_t namelen;
+    uint32_t namelen = 0;
     bool sendname = false;
     bool blocksize = false;
     uint32_t sizes[3];
-- 
2.26.2


