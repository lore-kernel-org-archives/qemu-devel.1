Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC81C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F3206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDF42zWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F3206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjXr-0003AM-Ao
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUw-0007ZJ-BY
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36332
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUt-0002Ds-DT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0969VGj5122999
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=syB6xU1sAclaOx/9Z+DIXVLQhMr2St/MEouHTWAoBkU=;
 b=EDF42zWVqflc+6JDCIoKqNJEPrORBPKgAUbEnIBocf9L0yo+yNI2NL16JJRX1riTGZC/
 wZnZgebiJAdJ6YK2wsrolDVfpd9JCTuopwWK+S2y8u1a1q+Wzc/cCgbujS9YxYL3GATF
 BvUxtS3aotqrvw6sBanmOCWKYKGnzbmVNb4xy7YU0e26kwjY+5ANrBYd6HPSEzVbcp6g
 wiu5XjDiNcrRq6zAbeo03hJq6jhdpU3veEsUZwr9+76W1DOzq9pXn+OSb1XOYGq1j3ki
 yH7263Z/gbaAwTjaEvX3qH5jEdCtEp+la21eWaXicj0JFsCTsPzMqUxA0tbnG7FYAf/o ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 340nct1nbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:43:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0969VK1K123348
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:00 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 340nct1nad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 05:43:00 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0969S9un000395;
 Tue, 6 Oct 2020 09:42:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03fra.de.ibm.com with ESMTP id 33xgx7sk6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 09:42:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0969guqq17498452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2020 09:42:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F18755204E;
 Tue,  6 Oct 2020 09:42:55 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 534AE5204F;
 Tue,  6 Oct 2020 09:42:55 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] pc-bios: s390x: Cleanup part 2
Date: Tue,  6 Oct 2020 05:42:45 -0400
Message-Id: <20201006094249.50640-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-06_03:2020-10-06,
 2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 05:43:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So, here are a few more cleanup patches mostly cleaning up ipl code
and some of the assembly.

The patches are available here:
https://github.com/frankjaa/qemu/pull/new/cleanup_bios2

CI:
https://gitlab.com/frankja/qemu/-/pipelines/198568601

v4:
	* Dropped ext/io new PSW patch to speed up review

v3:
	* Split PSW save rework again
	* Added noreturn annotation
	* Minor cleanup

v2:
	* Fixed psw saving in use reset psw patch (thanks Jason)
	* Dropped a lot of patches which weren't strictly necessary
	* Added disabled wait patch
	* Added RFC PSW save patch

Janosch Frank (4):
  pc-bios: s390x: Fix bootmap.c zipl component entry data handling
  pc-bios: s390x: Save PSW rework
  pc-bios: s390x: Use reset PSW if avaliable
  pc-bios: s390x: Go into disabled wait when encountering a PGM
    exception

 pc-bios/s390-ccw/bootmap.c  |  9 ++++---
 pc-bios/s390-ccw/bootmap.h  |  7 +++++-
 pc-bios/s390-ccw/jump2ipl.c | 47 ++++++++++++++++++++-----------------
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/start.S    |  5 +++-
 5 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.25.1


