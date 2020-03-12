Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E08C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF612206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tAeKQReQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF612206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRJw-00050a-NR
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4v-0003MM-Vy
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4u-0000nb-VN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4u-0000mY-Og
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGn1I8177998;
 Thu, 12 Mar 2020 16:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=g6qY4i4vgHefsZSdoW4iuGQifGKkSLq71edUG4ox0Vk=;
 b=tAeKQReQzOnJXrcp9gL8dxdPtFUk/MhJ9+WLTMPfveiH2M2tAoH0PXVbmUD4wKDn6iDt
 b/uihJCv01PGM2sRn6AMjT2s8QELuF7wOmLFLz0ht+o+68yPeDbqsrnyjc7TOJPFXGOt
 d4W9fHetSAltU+P+HR8pQ16eoWeEjFhzaLwTR/cem4wk3c3vHThSi2kqqYUG0ysIIyAg
 AyR0URSfvMDpgMgl1+58UjXz6LeHHSFk8r1a/N27fHtLf0Ik14v8lZqfHNNbgd0HDU3S
 NZXMHse7xdA5HJUKswf4yb+tyd2zQ95JIFKYSAKx/V64VfvxdDEP8w12BjAKHEkjy/EA 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoHv4122238;
 Thu, 12 Mar 2020 16:52:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2yp8r0snxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:57 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGquRS032444;
 Thu, 12 Mar 2020 16:52:56 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:55 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/16] hw/i386/vmport: Allow x2apic without IR
Date: Thu, 12 Mar 2020 18:54:28 +0200
Message-Id: <20200312165431.82118-14-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=784
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=848
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
index 2ce78aaf7b4c..1664a6b97332 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -208,7 +208,14 @@ static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
 
 static uint32_t vmport_cmd_get_vcpu_info(void *opaque, uint32_t addr)
 {
-    return 1 << VCPU_INFO_RESERVED_BIT;
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


