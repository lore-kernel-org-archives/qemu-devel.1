Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61A920637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvm2LW5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61A920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiFM-0003A0-Ub
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6w-00078Z-OU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6u-0007vA-Nf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6u-0007td-G9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:52:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcZLB010742;
 Tue, 10 Mar 2020 16:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+kvXlSEdwyDTv0x+1fs7lkw2MU30gmREkPVpt94ognk=;
 b=nvm2LW5Z0BCmLaFNbNJBKi8sttlYmXvXAawr8f8XDXJFjKjyLEtYhvksO/pnR091WaJX
 bGQxVUl441ai1DEWYK4oZ3ah3YVgcJkcLNUU/8IJvx8SHBuP7/T4RxSkAr/dfs+YrQES
 Hzf39A65llrV2VjYH2qEXV9rBrc6m3TM7Ady/AT6CbXJNGXdAX2ef5GQr67KmxkpbHB4
 nhUyJa0DZagloRrMlH90jXodZyFc3VCxGca9KuxX+nzKoQQXxeHjDObdQrCpEb0UI0PS
 ojEm9colyaniuv8yXDAZcjtNr8NCntv1sRhm31J/6wMR85DpiTIMXaAZFn8i5DR8FNuJ 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbj3l031071;
 Tue, 10 Mar 2020 16:52:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yp8rjyje8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:52:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGq0vD031817;
 Tue, 10 Mar 2020 16:52:01 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:52:00 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] hw/i386/vmport: Allow x2apic without IR
Date: Tue, 10 Mar 2020 18:53:29 +0200
Message-Id: <20200310165332.140774-14-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=848
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=911
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
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
 nikita.leshchenko@oracle.com, rth@twiddle.net
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
index 30641d3ffb20..6ca03273066e 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -197,7 +197,14 @@ static uint32_t vmport_cmd_time_full(void *opaque, uint32_t addr)
 
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


