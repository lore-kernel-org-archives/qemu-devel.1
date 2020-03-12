Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F629C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC01B206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UUWTIaie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC01B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRKV-0006KL-0V
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4V-00025h-AR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4T-0008Vk-TH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4T-0008V3-Km
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmrS8012063;
 Thu, 12 Mar 2020 16:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jarRDdGyUEFzZbIrAkQVmM0Aonew4+OkRAXfo84g+Fg=;
 b=UUWTIaiejOGN6PvlaltR4TNpT9xDa5vA2VlQyKSMEUMXfVVNhVc/y4oPkmpBMdIxJtop
 4mLqFynoinN7pkI4ioz16NPNtgEPbiH0M+WPSgMUklmAZYKH8VFA9/IpSebY4fwuGvl6
 cdXRx1UxXJbG19y9lCzr+OA7Mi/ZV4SMhMUBgiQaLU+KEwtbJadsyDBp/JHQPWbzPDO6
 a5LslrRKnw7ex0DLtDMecVxoUqzPLdJ5hk57b/BcXyUEKkePlChajOHVNL332W77oS7k
 jTRGp3tTGn95ny7tij7jPwzN0caOzeo5CjL57rpHrDCOc+BDCDoqiL2V/fpqQfDYc0wx 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ym31utt2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnSaT003724;
 Thu, 12 Mar 2020 16:52:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8p7ypnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqUVo000768;
 Thu, 12 Mar 2020 16:52:30 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:30 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/16] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
Date: Thu, 12 Mar 2020 18:54:18 +0200
Message-Id: <20200312165431.82118-4-liran.alon@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
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

vmport_ioport_read() returns the value that should propagate to vCPU EAX
register when guest reads VMPort IOPort (i.e. By x86 IN instruction).

However, because vmport_ioport_read() calls cpu_synchronize_state(), the
returned value gets overridden by the value in QEMU vCPU EAX register.
i.e. cpu->env.regs[R_EAX].

To fix this issue, change vmport_ioport_read() to explicitly override
cpu->env.regs[R_EAX] with the value it wish to propagate to vCPU EAX
register.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036faf..0496112b741c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
+    { "vmport", "x-read-set-eax", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 6ed110ef71a6..72f09ef5cba3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -43,6 +43,11 @@
 #define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
+/* Compatibility flags for migration */
+#define VMPORT_COMPAT_READ_SET_EAX_BIT      0
+#define VMPORT_COMPAT_READ_SET_EAX          \
+    (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
+
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
 typedef struct VMPortState {
@@ -51,6 +56,8 @@ typedef struct VMPortState {
     MemoryRegion io;
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
+
+    uint32_t compat_flags;
 } VMPortState;
 
 static VMPortState *port_state;
@@ -80,17 +87,33 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
     eax = env->regs[R_EAX];
     if (eax != VMPORT_MAGIC) {
-        return eax;
+        goto out;
     }
 
     command = env->regs[R_ECX];
     trace_vmport_command(command);
     if (command >= VMPORT_ENTRIES || !s->func[command]) {
         qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
-        return eax;
+        goto out;
     }
 
-    return s->func[command](s->opaque[command], addr);
+    eax = s->func[command](s->opaque[command], addr);
+
+out:
+    /*
+     * The call above to cpu_synchronize_state() gets vCPU registers values
+     * to QEMU but also cause QEMU to write QEMU vCPU registers values to
+     * vCPU implementation (e.g. Accelerator such as KVM) just before
+     * resuming guest.
+     *
+     * Therefore, in order to make IOPort return value propagate to
+     * guest EAX, we need to explicitly update QEMU EAX register value.
+     */
+    if (s->compat_flags & VMPORT_COMPAT_READ_SET_EAX) {
+        cpu->env.regs[R_EAX] = eax;
+    }
+
+    return eax;
 }
 
 static void vmport_ioport_write(void *opaque, hwaddr addr,
@@ -163,6 +186,9 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
 }
 
 static Property vmport_properties[] = {
+    /* Used to enforce compatibility for migration */
+    DEFINE_PROP_BIT("x-read-set-eax", VMPortState, compat_flags,
+                    VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


