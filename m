Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB3C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4039624655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsqjprsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4039624655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSEl-0000bS-DO
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCT-0005SH-Po
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCS-0006hw-SA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSCS-0006hF-Kc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqePi147313;
 Mon, 9 Mar 2020 23:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2wjVYVusXqahreDVrx8ai5a0+xGSxKRX3/lG+CE5nvI=;
 b=fsqjprscASjLhyXo3a9TUJunT0kQXmlQCVBrlfs4loanP/OFntIdCkpQfBXkSdKDfEuG
 UD+0Nt/8+5R59lEgh158R5Ett/+Tw/fv6egmMI5zS9GLEJbQD+1jQJAYylBvp3CKPPi7
 mALiPcBPvhaqhTgkIZ9Ol687hK/plqBxbF4GtxIqVHKfNjLLeJWleOxd6My4IWp7cOxv
 17mBJHcCTkw725GiqNfhI9RYS3x1gorTOuqC0QKjTu+PrTSE99nPXdeb2fhX6xfruVuu
 lFL380oCALLpyre9asCVPtKZHhIYQ31FncLGb3jEf3SpLRtpitsDT4iRutocL8AWy7Sk 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2ym31ua65s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Npi2f101380;
 Mon, 9 Mar 2020 23:52:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ymun81dcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029Nqffb027463;
 Mon, 9 Mar 2020 23:52:41 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:41 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/14] hw/i386/vmport: Allow x2apic without IR
Date: Tue, 10 Mar 2020 01:54:08 +0200
Message-Id: <20200309235411.76587-12-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=799 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=863 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
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
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signal to guest that hypervisor supports x2apic without VT-d/IOMMU
Interrupt-Remapping support. This allows guest to use x2apic in
case all APIC IDs fits in 8-bit (i.e. Max APIC ID < 255).

See Linux kernel commit 4cca6ea04d31 ("x86/apic: Allow x2apic
without IR on VMware platform") and Linux try_to_enable_x2apic()
function.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index b33ef9c01d65..2b0a623f19c1 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -182,7 +182,14 @@ static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
 
 static uint32_t vmport_cmd_get_vcpu_info(void *opaque, uint32_t addr)
 {
-    return (1 << VCPU_INFO_RESERVED_BIT);
+    X86CPU *cpu = X86_CPU(current_cpu);
+    uint32_t ret = 0;
+
+    if (cpu->env.features[FEAT_1_ECX] & CPUID_EXT_X2APIC) {
+        ret |= 1 << VCPU_INFO_LEGACY_X2APIC_BIT;
+    }
+
+    return ret;
 }
 
 /* vmmouse helpers */
-- 
2.20.1


