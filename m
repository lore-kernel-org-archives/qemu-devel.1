Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3CC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B02C2376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBVorUaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B02C2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNBg-0006QM-Gl
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLN6Z-0001pO-LO; Thu, 24 Sep 2020 04:59:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kLN6U-0002fQ-TG; Thu, 24 Sep 2020 04:59:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08O8RuII177142; Thu, 24 Sep 2020 04:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Zvj8C4onBmEwqW8yzzE32mGeDza3Urhl1rCElcvmUgc=;
 b=nBVorUaSQTgJ0VZUmbdmOvSNBDhDPAe0XkypxG5oNV07GxBLaYTY8srqgVW6pPnWSHRS
 EjATPxcDkwNfvZymnzlboXUvZj8s5O2kAV+6HC7jqyQblrgv3q6EvnTXk76DRXELkDmd
 r4fCvXzc9wCR6Z/nPcsEublDyNyvTXVkg0QT2tsGyYk4dfFdt/1Q4WtTgIY925RedJ7C
 y/aaj9czlqr09BjNKFAtTMGKE0sCT0ZDmqRyr3p8UA51XueqQ+XTuz7rXsLc3p5ODEHc
 kIBEGnSGRk+Lz6V+l5swZKyksntqoVj1MGKrtJfR90hYd5b8x1FCnHlZdyZdW3FlDbWq Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rqyggt2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 04:59:46 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08O8Rrfk176784;
 Thu, 24 Sep 2020 04:59:46 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33rqyggt1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 04:59:45 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08O8wPiL020756;
 Thu, 24 Sep 2020 08:59:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 33n98gtmtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2020 08:59:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08O8xeG134603460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 08:59:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A31A64C040;
 Thu, 24 Sep 2020 08:59:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 431CB4C044;
 Thu, 24 Sep 2020 08:59:40 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.161.19])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2020 08:59:40 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/3] pc-bios: s390x: fix corner cases in booting from ECKD
Date: Thu, 24 Sep 2020 10:59:23 +0200
Message-Id: <20200924085926.21709-1-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-24_05:2020-09-24,
 2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=675 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 04:59:47
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first patch fixes the scan for the string "zIPL" (which is used to
detect the start of the boot menu banner) in
`find_zipl_boot_menu_banner`. The second patch fixes the bug of not
booting the default entry if no zipl boot menu data was found.

For everybody's convenience there is a branch:
https://gitlab.com/mhartmay/qemu/-/tree/bios_fixes

Marc Hartmayer (3):
  pc-bios/s390-ccw: fix off-by-one error
  pc-bios/s390-ccw: break loop if a null block number is reached
  pc-bios/s390-ccw: Update s390-ccw.img bios binary

 pc-bios/s390-ccw.img       | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/bootmap.c |   4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.4


