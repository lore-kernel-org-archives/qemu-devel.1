Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7EC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BF72146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uMcIIEXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BF72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSD4-00068T-LW
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSC9-00051e-VZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSC8-0006IT-LX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSC8-0006AI-Ep
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:52:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NgJxw103195;
 Mon, 9 Mar 2020 23:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=i/ARnzowR8/1MtquPdbmvNaw9Dc/8NFz48hU5VEL98c=;
 b=uMcIIEXSchY1PrjanWozt/Dky82fjwT7vNGlils6PEemAqWcFObaIobR826YpQZF0ttV
 OVrfL/ekOk85jmx+J4PyRkuObB/6ZEQ5Gs4mYoQXca/yUbYbHI6cY20CDOV2zVPELhHX
 qLJSyMJA1niSG802DqJ2lBolfQheo20f+yqE9z8Ew7ddDtxSlZ3QKbCBfiWdSVJAaPcz
 xnxO68FVRyMjo9kkUHWQgCblclU/hkoQVLm5KqzjIzvLVRS0wwki9iLyH8cX8hsG3EMJ
 MXGN5uy5H+m+tlqLq0FGAU3Nhi6T3i6A6SZ/GOs0ZMzr/sbZv4kGIFl25lWZeSGkIY3l Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ym3jqj5kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqF8B102211;
 Mon, 9 Mar 2020 23:52:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ymun81bqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:14 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqDLC008416;
 Mon, 9 Mar 2020 23:52:13 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:13 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/14] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
Date: Tue, 10 Mar 2020 01:53:58 +0200
Message-Id: <20200309235411.76587-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090143
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
 hw/i386/vmport.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8aa4..9319720e8204 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -72,25 +72,36 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
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
+    cpu->env.regs[R_EAX] = eax;
+    return eax;
 }
 
 static void vmport_ioport_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
-    X86CPU *cpu = X86_CPU(current_cpu);
-
-    cpu->env.regs[R_EAX] = vmport_ioport_read(opaque, addr, 4);
+    vmport_ioport_read(opaque, addr, 4);
 }
 
 static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
-- 
2.20.1


