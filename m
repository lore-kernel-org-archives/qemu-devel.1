Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7DC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD32F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k69VpdgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRM2-00018u-26
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4e-0002WS-N5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4Z-0000CR-M6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4Z-0000AH-DO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmdhQ177900;
 Thu, 12 Mar 2020 16:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=F6pSVjJWrH940ok2XrCsxQ8yDu0HAMFFP5APdFtKLOw=;
 b=k69VpdgV+NxFEutr/Aavdjcmb7D1SC7AaIrYSlo4nYlvHHoMukuNamTEwWZ5QVP8l/dG
 ZiwPia4pN2lQF/xyWfrOXfi3tVUZAFJQQ9Wba2CaTDJZoNPFfA2kOiNUsJjmeUa4rSf9
 AvG7FY0z4gDiV0k6K99Od6J5S5Uv9ENcxkezrDDn5O4F4GO+ah308mgL8Rw7CHSlANKr
 2NTSsXsiQpH5PNArpteGC5x1d9EG/7sQx0a5+1UU+6yK8WjoCitx/28IfWPbBKp32t8r
 DiiVIpXTl6SEaVL8h7TWkjmdMqG+ElEW/9Zh2xl7AyGSKYJIOvMv9oJvcLBtOGaaB7SX 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoGoV054396;
 Thu, 12 Mar 2020 16:52:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yqgvdb0ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:36 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqZC9000817;
 Thu, 12 Mar 2020 16:52:35 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:35 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/16] hw/i386/vmport: Introduce vmware-vmx-version property
Date: Thu, 12 Mar 2020 18:54:20 +0200
Message-Id: <20200312165431.82118-6-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
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

vmware-vmx-version is a number returned from CMD_GETVERSION which specifies
to guest VMware Tools the the host VMX version. If the host reports a number
that is different than what the guest VMware Tools expects, it may force
guest to upgrade VMware Tools. (See comment above VERSION_MAGIC and
VmCheck_IsVirtualWorld() function in open-vm-tools open-source code).

For better readability and allow maintaining compatability for guests
which may expect different vmware-vmx-version, make vmware-vmx-version a
VMPort object property. This would allow user to control it's value via
"-global vmport.vmware-vmx-version=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index e67c7bb2afea..8e662303d5d3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -60,6 +60,8 @@ typedef struct VMPortState {
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
 
+    uint32_t vmware_vmx_version;
+
     uint32_t compat_flags;
 } VMPortState;
 
@@ -138,7 +140,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
-    return 6;
+    return port_state->vmware_vmx_version;
 }
 
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
@@ -200,6 +202,11 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
+
+    /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
+    DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
+                       vmware_vmx_version, 6),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


