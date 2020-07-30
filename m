Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75270C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0E02082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0ZuMsycl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0E02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ahh-0004IL-Fu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af9-0001Gg-0U
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af6-0002UV-JE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXoQC008019;
 Thu, 30 Jul 2020 15:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Q6iOoNWsJ7EJZ/SrWzpci9KqugByM0dkae4gvLigMYc=;
 b=0ZuMsyclxLoMaOJsBoTuEX47Rbk4rqe/Sf42FnCb55kX3MJDI7mFIC/mfQ46UScl4vFy
 jdzniQunw7hLOpIhK29xhzDFYe8W3Zz/VUWB0fA8fL0pAaCAwHVc2md9q91HWmIDsvch
 P7QE2dd8JbHtG2NsvDR3rAmA4MRWRG/mm3MFDAmWKu+00oJuvJ1AwUp1rVIpv2srp/3J
 vwyiSlQqyrMApoJD4T7oYmT15LyNfMosKMQbn6TS9iHckl2mtFrcnlSz2pEpoOG0lpww
 9Mh2TiCcE3p5hIy889/ihUmXeFRepKlj6cj/vylASixogMHGGi0mTGOMswN+uXfTPeS1 UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32hu1jmftp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:40:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXToC130863;
 Thu, 30 Jul 2020 15:38:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 32hu5wwgqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFc0rN020352;
 Thu, 30 Jul 2020 15:38:00 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:59 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 09/32] savevm: prevent cprsave if memory is volatile
Date: Thu, 30 Jul 2020 08:14:13 -0700
Message-Id: <1596122076-341293-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cprsave and cprload require that guest ram be backed by an externally
visible shared file.  Check that in cprsave.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 exec.c                | 32 ++++++++++++++++++++++++++++++++
 include/exec/memory.h |  2 ++
 migration/savevm.c    |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/exec.c b/exec.c
index 6f381f9..02160e0 100644
--- a/exec.c
+++ b/exec.c
@@ -2726,6 +2726,38 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
     return block->offset + offset;
 }
 
+/*
+ * Return true if any memory regions are writable and not backed by shared
+ * memory.  Exclude x86 option rom shadow "pc.rom" by name, even though it is
+ * writable.
+ */
+bool qemu_ram_volatile(Error **errp)
+{
+    RAMBlock *block;
+    MemoryRegion *mr;
+    bool ret = false;
+
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        mr = block->mr;
+        if (mr &&
+            memory_region_is_ram(mr) &&
+            !memory_region_is_ram_device(mr) &&
+            !memory_region_is_rom(mr) &&
+            (!mr->name || strcmp(mr->name, "pc.rom")) &&
+            (block->fd == -1 || !qemu_ram_is_shared(block))) {
+
+            error_setg(errp, "Memory region %s is volatile",
+                       memory_region_name(mr));
+            ret = true;
+            break;
+        }
+    }
+
+    rcu_read_unlock();
+    return ret;
+}
+
 /* Generate a debug exception if a watchpoint has been hit.  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527..6aafbb0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2519,6 +2519,8 @@ bool ram_block_discard_is_disabled(void);
  */
 bool ram_block_discard_is_required(void);
 
+bool qemu_ram_volatile(Error **errp);
+
 #endif
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 1509173..f101039 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2713,6 +2713,10 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
         return;
     }
 
+    if (op == VMS_REBOOT && qemu_ram_volatile(errp)) {
+        return;
+    }
+
     f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
     if (!f) {
         return;
-- 
1.8.3.1


