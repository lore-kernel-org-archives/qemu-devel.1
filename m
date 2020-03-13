Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E653120409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CXsHDqHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E653120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCld5-0005ZS-3y
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jClcG-0004EM-9K
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jClcF-0005nL-5l
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jClcE-0005ka-Tt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEmbrB058091;
 Fri, 13 Mar 2020 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ykRn0+RqCXA4m617GziSwqaMvQDkRJtuTYYXR559UBE=;
 b=CXsHDqHYIkpFndJmz9GfkbIinSZ3EGocQZNF2W+mbIc4BrAZjISGwven4jK3UiEtxU6i
 2TtMyvsebF8ZCozAztRZqlZd2R7XeFJZUunyrGp/0GQ1YPx96/oeT+MIIc27Cu/cU5vM
 bhramu5eqyaFEW/nc3Mz/RZBiR7sPkVRyMiWNsPh43v1poCk3cDcPcpcCSMRvxAXZ0Qo
 LkY0w24fPRnMBBP3HSE9CL4J4EsudQgiFWtaSULs4mp4sexvCXuSfVf55QaPdNIt1J6Z
 4Iufx/GjmbC+NuPV1BYDdr54ltOkcG0yLsZ97MvJmETSjzWdOyPcw0eM52oj4/K+/2fm Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yqtagc900-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEmKRc028746;
 Fri, 13 Mar 2020 14:48:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2yqtadaft7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DEmgXh020222;
 Fri, 13 Mar 2020 14:48:43 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 07:48:42 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] acpi: unit-test: Update WAET ACPI Table expected
 binaries
Date: Fri, 13 Mar 2020 16:50:09 +0200
Message-Id: <20200313145009.144820-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313145009.144820-1-liran.alon@oracle.com>
References: <20200313145009.144820-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=958 spamscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=1 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is done according to step (6) in the process described at
tests/qtest/bios-tables-test.c.

Expected WAET.dsl:

[000h 0000   4]                    Signature : "WAET"    [Windows ACPI Emulated Devices Table]
[004h 0004   4]                 Table Length : 00000028
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 88
[00Ah 0010   6]                       Oem ID : "BOCHS "
[010h 0016   8]                 Oem Table ID : "BXPCWAET"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "BXPC"
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   4]        Flags (decoded below) : 00000002
                        RTC needs no INT ack : 0
                     PM timer, one read only : 1

Raw Table Data: Length 40 (0x28)

  0000: 57 41 45 54 28 00 00 00 01 88 42 4F 43 48 53 20  // WAET(.....BOCHS
  0010: 42 58 50 43 57 41 45 54 01 00 00 00 42 58 50 43  // BXPCWAET....BXPC
  0020: 01 00 00 00 02 00 00 00                          // ........

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 tests/data/acpi/pc/WAET                     | Bin 0 -> 40 bytes
 tests/data/acpi/q35/WAET                    | Bin 0 -> 40 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/pc/WAET b/tests/data/acpi/pc/WAET
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c2240f58dff6b2f765386b5a2e506fda4800be3e 100644
GIT binary patch
literal 40
mcmWG{bPds9U|?YEaPoKd2v%^42yhMuiZKGkKx`1r1jGQWX$JuS

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/WAET b/tests/data/acpi/q35/WAET
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c2240f58dff6b2f765386b5a2e506fda4800be3e 100644
GIT binary patch
literal 40
mcmWG{bPds9U|?YEaPoKd2v%^42yhMuiZKGkKx`1r1jGQWX$JuS

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b269a1e3e583..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/WAET",
-"tests/data/acpi/q35/WAET",
-- 
2.20.1


