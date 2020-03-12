Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02AC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6320F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="veFlrIfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6320F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRKQ-00069o-I2
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4Z-0002BT-Gu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4Y-00009w-7S
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4X-00006Q-S2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnLH1189366;
 Thu, 12 Mar 2020 16:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=qeA3YpdxH20QfpDq2fOKHn3gJRxt2aAnQvizqY+vGl0=;
 b=veFlrIfEfVj3aX4T08+6roVxdyQWzO1n9c0dPMrLW85h2MP9SZa9Ar40v/bDRCZGg1y0
 ymzQs0bymyIZjQxECx4lG/loaZipg0bTKqyA1IrWdzKBcmApsdsmN8vpKzIl9xjHpwwI
 Q8o8tJWeQJH7UbWiJ/BL4ZmU5GbVA97tx5J8Z8QPReDDu6/d+uCbmPb0JUhifrCGhfo5
 dwKTfBzM6AwkdlzoAdIt5QgesrGU3gHxB7sa5a7t8e+etZrtlFE9tQpefJynHQepCSci
 mvo+7Uvc8upYxJL8MxrjtD+sEHZwdw0zl63T4JG/6WxhxOM7LOY6wTGh4WeZt+cbe9px FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yqkg8a02j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoKeG122501;
 Thu, 12 Mar 2020 16:52:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yp8r0snfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqXCI000794;
 Thu, 12 Mar 2020 16:52:33 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:32 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/16] hw/i386/vmport: Set EAX to -1 on failed and
 unsupported commands
Date: Thu, 12 Mar 2020 18:54:19 +0200
Message-Id: <20200312165431.82118-5-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

This is used as a signal for VMware Tools to know if a command it
attempted to invoke, failed or is unsupported. As a result, VMware Tools
will either report failure to user or fallback to another backdoor command
in attempt to perform some operation.

A few examples:
* open-vm-tools TimeSyncReadHost() function fallbacks to
CMD_GETTIMEFULL command when CMD_GETTIMEFULL_WITH_LAG
fails/unsupported.
* open-vm-tools Hostinfo_NestingSupported() function verifies
EAX != -1 to check for success.
* open-vm-tools Hostinfo_VCPUInfoBackdoor() functions checks
if reserved-bit is set to indicate command is unimplemented.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0496112b741c..2595a13e5650 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
     { "vmport", "x-read-set-eax", "off" },
+    { "vmport", "x-signal-unsupported-cmd", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 72f09ef5cba3..e67c7bb2afea 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -44,9 +44,12 @@
 #define VMPORT_MAGIC   0x564D5868
 
 /* Compatibility flags for migration */
-#define VMPORT_COMPAT_READ_SET_EAX_BIT      0
-#define VMPORT_COMPAT_READ_SET_EAX          \
+#define VMPORT_COMPAT_READ_SET_EAX_BIT              0
+#define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
+#define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
+#define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
+    (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -87,17 +90,23 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
     eax = env->regs[R_EAX];
     if (eax != VMPORT_MAGIC) {
-        goto out;
+        goto err;
     }
 
     command = env->regs[R_ECX];
     trace_vmport_command(command);
     if (command >= VMPORT_ENTRIES || !s->func[command]) {
         qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
-        goto out;
+        goto err;
     }
 
     eax = s->func[command](s->opaque[command], addr);
+    goto out;
+
+err:
+    if (s->compat_flags & VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD) {
+        eax = UINT32_MAX;
+    }
 
 out:
     /*
@@ -189,6 +198,8 @@ static Property vmport_properties[] = {
     /* Used to enforce compatibility for migration */
     DEFINE_PROP_BIT("x-read-set-eax", VMPortState, compat_flags,
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
+    DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
+                    VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


