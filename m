Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F884C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2420873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CwpQ+pl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi7g-0008Dz-I3
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6T-0006M8-CA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6S-0005WS-8i
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6S-0005Re-0Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGdJge103990;
 Tue, 10 Mar 2020 16:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=HZDCswLkofKqT1CocQZaTBU9Ra3S3FQjSz77kMT5qfA=;
 b=CwpQ+pl79x/dDIeL4LAnAwscBkf3c4/qf2+hHL8DECC21B5bPm0yqqkpf97wX6Ge3IRK
 5RX4Hn7SZ34jBamY8hpbRLKGIiEBAZlQVqbrhniaK3RtD+Ch1YxTq0mLDwV5ZJdDBk0g
 8SlFs8o97OufwtoVcuRnFEgK/2D0LAaQuHlz6zaCwNPTVo2tmc8oGv+mLSAJSjLvWETj
 mo+CfGa2ch5APfuZhmI90kRt5JwnuaLNlNmXyY9rNnp1kKLtCo9/GlUgtkEHQgZQvjlk
 6h3BsM8g5G91tPBW+7o89Bn4vP1jvJH6ERa/rQLjgGYHJXWLrl4YViada2uuu63VXAHR fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm35ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcJCW054662;
 Tue, 10 Mar 2020 16:51:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yp8psg44c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpWSR030590;
 Tue, 10 Mar 2020 16:51:32 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:32 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
Date: Tue, 10 Mar 2020 18:53:19 +0200
Message-Id: <20200310165332.140774-4-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
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
 nikita.leshchenko@oracle.com, rth@twiddle.net
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
 hw/i386/vmport.c  | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036faf..b9da40460d52 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
+    { "vmport", "version", "1" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index ca4d95fc017f..736d78263889 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -75,17 +75,33 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
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
+    if (s->version > 1) {
+        cpu->env.regs[R_EAX] = eax;
+    }
+
+    return eax;
 }
 
 static void vmport_ioport_write(void *opaque, hwaddr addr,
@@ -163,7 +179,7 @@ static Property vmport_properties[] = {
      * On every guest-visible change, should make changes conditioned on
      * version and define proper version for previous machine-types.
      */
-    DEFINE_PROP_UINT8("version", VMPortState, version, 1),
+    DEFINE_PROP_UINT8("version", VMPortState, version, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


