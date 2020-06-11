Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF51720720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIhJADPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF51720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTs9-00078s-1q
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9p-0000j8-8y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9n-0001JJ-7i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Gb5f4ZV3aI2a6P7aJxN28ce8kll/n1k7O4VqaZKICc=;
 b=AIhJADPrnVm2vZNEj9pWc2o03KkvKIjrZChe65SVvtPb0zLYFaEcCOr09V5bHbyVK7Uu1Q
 wb/cz1MOWKnmnB7qjgi8TtalOse4zBpNSEx0BuobrLjIz4NsjhsePY9NfUmSMRDwjy7NUX
 0d+vBzUP56c8YraebLGICejAhH9zgz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-xg4uoLfMN2-bqW3D0h2ByQ-1; Thu, 11 Jun 2020 15:45:37 -0400
X-MC-Unique: xg4uoLfMN2-bqW3D0h2ByQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A104DEC1AE;
 Thu, 11 Jun 2020 19:45:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 484CB8FF96;
 Thu, 11 Jun 2020 19:45:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 057/115] exec: Propagate cpu_memory_rw_debug() error
Date: Thu, 11 Jun 2020 15:43:51 -0400
Message-Id: <20200611194449.31468-58-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Do not ignore the MemTxResult error type returned by
the address_space_rw() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                 | 12 ++++++++----
 include/exec/cpu-all.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 0e197e53c2..9cbde85d8c 100644
--- a/exec.c
+++ b/exec.c
@@ -3771,6 +3771,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
     while (len > 0) {
         int asidx;
         MemTxAttrs attrs;
+        MemTxResult res;
 
         page = addr & TARGET_PAGE_MASK;
         phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
@@ -3783,11 +3784,14 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                    attrs, buf, l);
+            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
+                                          attrs, buf, l);
         } else {
-            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
-                               l);
+            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
+                                     attrs, buf, l);
+        }
+        if (res != MEMTX_OK) {
+            return -1;
         }
         len -= l;
         buf += l;
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d14374bdd4..fb4e8a8e29 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -413,6 +413,7 @@ void dump_exec_info(void);
 void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
+/* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         void *ptr, target_ulong len, bool is_write);
 
-- 
2.26.2



