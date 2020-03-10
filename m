Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C525C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEA021D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OmhoJ0Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEA021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiB3-0005O1-Kg
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6a-0006YD-J2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6Z-0006GA-Io
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6Z-00066e-87
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcLo8010592;
 Tue, 10 Mar 2020 16:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=UQjy1VwWA2VcbtHOtRUI+1J6Ijx9B1l+DyoKZk7XItI=;
 b=OmhoJ0RpWL/ZcDxZjFoedbPkGT9uIbQYIJ1Iu5flnQUqcv/I4lmhQYCrgSjG5Hi/prJM
 2FwO4ysKTFJjdzzGC2e6gBrpFV4Wu6gvQyKEFo+/pQmoEVP8Q6m4PExkvNA/rPrHMNJZ
 LMLnq0zFP4CVrxzxvRoVxqg3DBmVGTcqOPi+99g7meq+JDqW0gMevE5T+ywTO6v6h2Yc
 czD5W/Ycd9tqurm8LGfMEyrfAO2osBMEF+SxDskWIXo+zEOmAknaBcw4pY06n985tZed
 dQI9JUBpkYmPPiPBvW4J47rxFw+okHvy6kLl4C3GLmALckewO0vem+PSkpZofCBmF9u6 aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcOsm053102;
 Tue, 10 Mar 2020 16:51:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8nu25af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpenU030680;
 Tue, 10 Mar 2020 16:51:40 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:39 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/16] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Date: Tue, 10 Mar 2020 18:53:22 +0200
Message-Id: <20200310165332.140774-7-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
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

As can be seen from VmCheck_GetVersion() in open-vm-tools code,
CMD_GETVERSION should return VMX type in ECX register.

Default is to fake host as VMware ESX server. But user can control
this value by "-global vmport.vmx-type=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 0d3f19b0bb71..973f3f6448e9 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -36,6 +36,16 @@
 #define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
+/* Enum taken from open-vm-tools lib/include/vm_vmx_type.h */
+typedef enum {
+   VMX_TYPE_UNSET = 0,
+   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Express */
+   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
+   VMX_TYPE_WGS,        /* Deprecated type used for VMware Server */
+   VMX_TYPE_WORKSTATION,
+   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for ACE 1.x */
+} VMXType;
+
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
 typedef struct VMPortState {
@@ -46,6 +56,7 @@ typedef struct VMPortState {
     void *opaque[VMPORT_ENTRIES];
 
     uint32_t vmx_version;
+    uint8_t vmx_type;
 
     uint8_t version;
 } VMPortState;
@@ -125,6 +136,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
+    if (port_state->version > 1) {
+        cpu->env.regs[R_ECX] = port_state->vmx_type;
+    }
     return port_state->vmx_version;
 }
 
@@ -191,6 +205,8 @@ static Property vmport_properties[] = {
 
     /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
     DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
+    DEFINE_PROP_UINT8("vmx-type", VMPortState, vmx_type,
+                      VMX_TYPE_SCALABLE_SERVER),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.20.1


