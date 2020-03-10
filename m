Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F5720873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBsk2csZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F5720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi9G-0002q5-UH
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6Y-0006Vk-Kz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6X-000617-Ht
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6X-0005wf-9k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcLqe010615;
 Tue, 10 Mar 2020 16:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VlJbFXph1o3QpRz6r1wPDq062qzt3UTQfdX2PanQWGY=;
 b=DBsk2csZdrrwHc5JwovVme3G5Cjdia4aqJANEr8Pzix+B2eacHLEf/ToU4F7PbuCg+pa
 8RlnXauhyFm4VCokDTOxMGJNGYOxrUWMCgKgGUh1mmctqYcPFEM6WAhG7Wyzcc2mcuEW
 0VtOvlhPAnVSwGTIszY/igDufS0djtjWqo24YqBfiS0ZCbsMmzFeKugZD0CEpo1WgFVa
 f1J5mhDI5DkRUJnGBPNep1f0CO7/DmbXaJpTs/0/h6htf48T64ZMwTzc2htN0sZ63O+1
 LWRDg5pF9lkqmv0shl21M+/Q6KwSQ6O0hH/PHg+sUVFg1QZmUJOSDi9uhchVtzu6NU4k RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcOu0053103;
 Tue, 10 Mar 2020 16:51:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yp8nu255n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:39 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AGpbM3011502;
 Tue, 10 Mar 2020 16:51:38 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:37 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/16] hw/i386/vmport: Introduce vmx-version property
Date: Tue, 10 Mar 2020 18:53:21 +0200
Message-Id: <20200310165332.140774-6-liran.alon@oracle.com>
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

In VMware terminology, VMX is the name of VMware VMM. Short for Virtual
Machine eXecutable. (Do not confuse with Intel VT-x which is also often
named VMX).

vmx-version is a number returned from CMD_GETVERSION which specifies to
guest VMware Tools the the host VMX version. If the host reports a number
that is different than what the guest VMware Tools expects, it may force
guest to upgrade VMware Tools. (See comment above VERSION_MAGIC and
VmCheck_IsVirtualWorld() function in open-vm-tools open-source code).

For better readability and allow maintaining compatability for guests
which may expect different vmx-version, make vmx-version a VMPort object
property. This would allow user to control it's value via
"-global vmport.vmx-version=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 8115852720c8..0d3f19b0bb71 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -45,6 +45,8 @@ typedef struct VMPortState {
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
 
+    uint32_t vmx_version;
+
     uint8_t version;
 } VMPortState;
 
@@ -123,7 +125,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
-    return 6;
+    return port_state->vmx_version;
 }
 
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
@@ -186,6 +188,10 @@ static Property vmport_properties[] = {
      * version and define proper version for previous machine-types.
      */
     DEFINE_PROP_UINT8("version", VMPortState, version, 2),
+
+    /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
+    DEFINE_PROP_UINT32("vmx-version", VMPortState, vmx_version, 6),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


