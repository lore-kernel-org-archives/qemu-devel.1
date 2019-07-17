Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CEC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F27721743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QPUTRFkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F27721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnl2j-0006H3-2z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.kanda@oracle.com>) id 1hnl2Y-0005si-Kf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.kanda@oracle.com>) id 1hnl2X-00011X-8g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:36:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
 id 1hnl2W-0000yj-Ul
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:36:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEO63F079441;
 Wed, 17 Jul 2019 14:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=SsVkzdT38+dvqH1VLUtF1VxRmmdfMH4pKSAeWnPgriA=;
 b=QPUTRFkXe1qu+q5fyGid/SZkMpXr0j/icxXNZcQDk6aSde/7vTTAXcartcO960oRra9z
 4dhe/dJ53JN4zu/0WdWqLakBw8nSTfziEi444UwIs+guuqDXbmZx7aWkSXhVVTjTAPIh
 mKPeFKDkOu6HDF+IXphlaGO1J9gYTnsPCksC5eofeO9GgaJI2idmh5AxK9vC2eRbCTNC
 /7Q1wGlljQKDkVLOiJdE1V9hjUl23E0f1AeDN3CMYyf8Gpe3nQ3m2u99YvZBxvwPdFZI
 GHz1pwd4YPufyqRLdUnZWOvuL10RZIgrqwpSaUGrbLAL1D100YoSrN7x3skBLanFc6EO 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2tq6qtub7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 14:36:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEN0lg187574;
 Wed, 17 Jul 2019 14:36:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2tsctx6wta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 14:36:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HEaC0s008608;
 Wed, 17 Jul 2019 14:36:12 GMT
Received: from mhkanda-aus-1.us.oracle.com (/10.135.188.192)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 17 Jul 2019 14:36:12 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 09:38:18 -0500
Message-Id: <1563374298-17323-1-git-send-email-mark.kanda@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=932 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170171
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH-for-4.2 v2] Only enable the halt poll control
 MSR if it is supported by the host
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The halt poll control MSR should only be enabled on hosts which
support it.

Fixes: ("kvm: i386: halt poll control MSR support")

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>

---
v2: Remove unnecessary hunks which break migration with older hosts (Paolo)
---
 target/i386/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a8bafdb8b9..543bc25f64 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] = {
     { "kvm-asyncpf", "on" },
     { "kvm-steal-time", "on" },
     { "kvm-pv-eoi", "on" },
-    { "kvm-poll-control", "on" },
     { "kvmclock-stable-bit", "on" },
     { "x2apic", "on" },
     { "acpi", "off" },
-- 
2.21.0


