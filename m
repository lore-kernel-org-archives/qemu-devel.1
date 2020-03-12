Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7B9206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="umXJN7iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7B9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRM3-0001Bf-FG
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4c-0002OA-Jc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4b-0000GI-8z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4a-0000Ek-W1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmUY1177850;
 Thu, 12 Mar 2020 16:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eATNqa3TJsdfh32i+c0A75GsokzcqwGsLguU2ouPfs0=;
 b=umXJN7iBu96o3tBX6YswVV9Ep4WZf5yC690IjVfipcR/RgFvAclPA/dbKUw4ibrNP264
 DkvnQk1+Db5jiSLzDbxq7pDu/jukrPoDxazc4QI+ly3u8ZoreNLba64ePna/6DoxmRRo
 DlAwTRRzsQDi0r8oDMYWSe4DqO6Djh0e9Efe4yEtjw9PYJnvBSVV+gT83fJP75KInPQD
 NgZaMxEbf8JKk3557ixBTytqN+r5NpVR/wxLCPZhyQAW8urIdLyMxgbd+5JU+nAf3f2u
 jHreZKm9KuOZe9Ywl7+Y5048arxg0W9qTUXGSwZ4ityzJPHCO3tSWkR2u6/BokRYgeqn vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnWIT003829;
 Thu, 12 Mar 2020 16:52:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yp8p7yq2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CGqcqi030503;
 Thu, 12 Mar 2020 16:52:38 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:37 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] hw/i386/vmport: Report vmware-vmx-type in
 CMD_GETVERSION
Date: Thu, 12 Mar 2020 18:54:21 +0200
Message-Id: <20200312165431.82118-7-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=999
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

As can be seen from VmCheck_GetVersion() in open-vm-tools code,
CMD_GETVERSION should return vmware-vmx-type in ECX register.

Default is to fake host as VMware ESX server. But user can control
this value by "-global vmport.vmware-vmx-type=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2595a13e5650..0e2f37420360 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "qxl-vga", "revision", "4" },
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
+    { "vmport", "x-report-vmx-type", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 8e662303d5d3..ead2f2d5326f 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -46,10 +46,13 @@
 /* Compatibility flags for migration */
 #define VMPORT_COMPAT_READ_SET_EAX_BIT              0
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
+#define VMPORT_COMPAT_REPORT_VMX_TYPE_BIT           2
 #define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
     (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
+#define VMPORT_COMPAT_REPORT_VMX_TYPE           \
+    (1 << VMPORT_COMPAT_REPORT_VMX_TYPE_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -61,6 +64,7 @@ typedef struct VMPortState {
     void *opaque[VMPORT_ENTRIES];
 
     uint32_t vmware_vmx_version;
+    uint8_t vmware_vmx_type;
 
     uint32_t compat_flags;
 } VMPortState;
@@ -140,6 +144,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
+    if (port_state->compat_flags & VMPORT_COMPAT_REPORT_VMX_TYPE) {
+        cpu->env.regs[R_ECX] = port_state->vmware_vmx_type;
+    }
     return port_state->vmware_vmx_version;
 }
 
@@ -202,10 +209,30 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
+    DEFINE_PROP_BIT("x-report-vmx-type", VMPortState, compat_flags,
+                    VMPORT_COMPAT_REPORT_VMX_TYPE_BIT, true),
 
     /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
     DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
                        vmware_vmx_version, 6),
+    /*
+     * Value determines which VMware product type host report itself to guest.
+     *
+     * Most guests are fine with exposing host as VMware ESX server.
+     * Some legacy/proprietary guests hard-code a given type.
+     *
+     * For a complete list of values, refer to enum VMXType at open-vm-tools
+     * project (Defined at lib/include/vm_vmx_type.h).
+     *
+     * Reasonable options:
+     * 0 - Unset
+     * 1 - VMware Express (deprecated)
+     * 2 - VMware ESX Server
+     * 3 - VMware Server (Deprecated)
+     * 4 - VMware Workstation
+     * 5 - ACE 1.x (Deprecated)
+     */
+    DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.20.1


