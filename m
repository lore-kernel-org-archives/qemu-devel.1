Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C269C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7520719
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/JsoQbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kancs-0008JB-NA
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbE-0006pU-L2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbC-0003zs-JV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M2mpS058692
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LNfIoY0vneDqIjZ/y7lK3irytyGGxH/3+M4yMt/zypg=;
 b=O/JsoQbPdgCLIp26LoqU/g1I2+QkJxp6yHoJl4yVjRQaTIWPvI1zq3aqOVwErCBmNQ4Y
 SAhJj0Gz8IoGgzg4nzl5b4lRpgp9HOLCTNCiGVo6GCqdttNREeN4IDn4MOvlMbqPrFgv
 1pJc+VtNdm5+hLnh0/PDytKHsDUPwoiTVCdRXqq7kQlKPMyZDp8Yr7K51yVo2tvk46Ie
 XZ6cm0sbaEADbyiEnRTMGKT4SOdX65xMg0bealzbNMnjERVcAy4DGrnTsc7cmf5PyObE
 XjyaUQaoI3b4epgttzoFInQyMF7Way75OJ5o3yaVd3xp+Rsv23oanemQjYiV8DTXSSNP XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mhxjtntp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 17:19:15 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M325a063624
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:15 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mhxjtnt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:14 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MCkoq007790;
 Thu, 5 Nov 2020 22:19:13 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 34h09nke68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:13 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJDRf12321492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:13 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 191CF6A04F;
 Thu,  5 Nov 2020 22:19:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A66D96A04D;
 Thu,  5 Nov 2020 22:19:12 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:12 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] Add support for Control-Flow Integrity
Date: Thu,  5 Nov 2020 17:18:56 -0500
Message-Id: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds supports for Control-Flow Integrity checks
on indirect function calls.

Requires the use of clang, and link-time optimizations

Changes in v3:

- clang 11+ warnings are now handled directly at the source,
instead of disabling specific warnings for the whole code.
Some more work may be needed here to polish the patch, I
would kindly ask for a review from the corresponding
maintainers
- Remove configure-time checks for toolchain compatibility
with LTO.
- the decorator to disable cfi checks on functions has
been renamed and moved to include/qemu/compiler.h
- configure-time checks for cfi support and dependencies
has been moved from configure to meson

Link to v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg753675.html
Link to v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg718786.html

Daniele Buono (9):
  fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
  s390x: fix clang 11 warnings in cpu_models.c
  hw/usb: reorder fields in UASStatus
  s390x: Avoid variable size warning in ipl.h
  scsi: fix overflow in scsi_disk_new_request_dump
  configure,meson: add option to enable LTO
  cfi: Initial support for cfi-icall in QEMU
  check-block: enable iotests with cfi-icall
  configure/meson: support Control-Flow Integrity

 accel/tcg/cpu-exec.c          | 11 +++++++++
 configure                     | 26 ++++++++++++++++++++
 hw/s390x/ipl.h                |  4 +--
 hw/scsi/scsi-disk.c           |  4 +++
 hw/usb/dev-uas.c              |  2 +-
 include/qemu/compiler.h       | 12 +++++++++
 meson.build                   | 46 +++++++++++++++++++++++++++++++++++
 meson_options.txt             |  4 +++
 plugins/core.c                | 37 ++++++++++++++++++++++++++++
 plugins/loader.c              |  7 ++++++
 target/s390x/cpu_models.c     |  8 +++---
 tcg/tci.c                     |  7 ++++++
 tests/check-block.sh          | 18 ++++++++------
 tests/qtest/fuzz/fork_fuzz.ld | 12 ++++++++-
 util/main-loop.c              | 11 +++++++++
 util/oslib-posix.c            | 11 +++++++++
 16 files changed, 205 insertions(+), 15 deletions(-)

-- 
2.17.1


