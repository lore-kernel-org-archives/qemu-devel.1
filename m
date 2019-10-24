Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619362054F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaAWcHzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619362054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNevo-0004E0-Tw
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdig-0006t7-Sy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdib-0007Zy-Hp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdib-0007Yq-2M
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id 3so2739415wmi.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QVjziJV/GbvmaoW+DHNw8wzHLwg9ajCUZw0RDTVnmHI=;
 b=PaAWcHzWrL/DTwDYUsib8LN+QztuGuY5I383DlPJsU1zVkdJZTn5bI47veQoEWeviA
 FYxScYSZTk/gxFSANkhe+wMAq9FEeYdIKj9p70SDlnUU3ui42SL5vo7EwihnTJqJVG8d
 V5U8dxpRRk20J/LfGKbYlXrXVXFegPaVjy3TEyIM7RQXkVClmeLmJD7HcheHi/xtZKC2
 Cf+KbvKU9N39RTjR5mLrn3lyYuWmzYc8dMHgDtJRGmL/OMpATcAYFSRH65uOrJ0cEJPw
 6gcwFayWtCWr6Y8qNt1yERn7KMzaqWxsP8C2lj0rBHNlp/Yh1USChWowuUPTXjmINfQ2
 GLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=QVjziJV/GbvmaoW+DHNw8wzHLwg9ajCUZw0RDTVnmHI=;
 b=Szy2pvAA2ILRG0uhbhv2RHHPttZsJIdE3PARoXaOpl3cSgteykN21VsOKKz8IEHrru
 +WylRPJeq7jKw/yCaFY9We/hskDoo6IPyvN+E8hiJ/bB4U9zpQ70ad7tOw+87PAVJLJm
 f2W760eBM+o/SyaQZiMzS8KsD3J0lZjOGWn+KiUXhJFIEFGK+t1eTAk8itN1596YCjdl
 e+J6p85vSqp6b88WuDSUe7lunDwcEfNqp7MmaBwqvnrETmKwoObQ/RAn00xfwC1YAhli
 xM528G4qqqrStdpGxXoLGoXpIPRD/hhtQ+VHzn+fJ0pLmWnVifPQIIdqB+rHmXTCiwzq
 Ctdg==
X-Gm-Message-State: APjAAAWuTsqha8QZpmr55KN3uWBCKVDXc9/7S/TCkOutjacFuFJuuQpL
 PIBA6QzKxcb9U4wwdB3DViAAS17U
X-Google-Smtp-Source: APXvYqyGMxkCzR4vc0Ce77FAvO57ZOR5L+mbXrzN2Rg/Fv90ESpNuBOKVawz8GfiWXYz53LWla0p1Q==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr5205677wmg.146.1571925838509; 
 Thu, 24 Oct 2019 07:03:58 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.03.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:03:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/39] target/i386: log MCE guest and host addresses
Date: Thu, 24 Oct 2019 16:03:17 +0200
Message-Id: <1571925835-31930-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Mario Smarduch <msmarduch@digitalocean.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mario Smarduch <msmarduch@digitalocean.com>

Patch logs MCE AO, AR messages injected to guest or taken by QEMU itself.
We print the QEMU address for guest MCEs, helps on hypervisors that have
another source of MCE logging like mce log, and when they go missing.

For example we found these QEMU logs:

September 26th 2019, 17:36:02.309        Droplet-153258224: Guest MCE Memory Error at qemu addr 0x7f8ce14f5000 and guest 3d6f5000 addr of type BUS_MCEERR_AR injected   qemu-system-x86_64      amsN    ams3nodeNNNN

September 27th 2019, 06:25:03.234        Droplet-153258224: Guest MCE Memory Error at qemu addr 0x7f8ce14f5000 and guest 3d6f5000 addr of type BUS_MCEERR_AR injected   qemu-system-x86_64      amsN    ams3nodeNNNN

The first log had a corresponding mce log entry, the second didnt (logging
thresholds) we can infer from second entry same PA and mce type.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
Message-Id: <20191009164459.8209-3-msmarduch@digitalocean.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8c73438..0e3da99 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -592,9 +592,9 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
                        (MCM_ADDR_PHYS << 6) | 0xc, flags);
 }
 
-static void hardware_memory_error(void)
+static void hardware_memory_error(void *host_addr)
 {
-    fprintf(stderr, "Hardware memory error!\n");
+    error_report("QEMU got Hardware memory error at addr %p", host_addr);
     exit(1);
 }
 
@@ -618,15 +618,34 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
             kvm_hwpoison_page_add(ram_addr);
             kvm_mce_inject(cpu, paddr, code);
+
+            /*
+             * Use different logging severity based on error type.
+             * If there is additional MCE reporting on the hypervisor, QEMU VA
+             * could be another source to identify the PA and MCE details.
+             */
+            if (code == BUS_MCEERR_AR) {
+                error_report("Guest MCE Memory Error at QEMU addr %p and "
+                    "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
+                    addr, paddr, "BUS_MCEERR_AR");
+            } else {
+                 warn_report("Guest MCE Memory Error at QEMU addr %p and "
+                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
+                     addr, paddr, "BUS_MCEERR_AO");
+            }
+
             return;
         }
 
-        fprintf(stderr, "Hardware memory error for memory used by "
-                "QEMU itself instead of guest system!\n");
+        if (code == BUS_MCEERR_AO) {
+            warn_report("Hardware memory error at addr %p of type %s "
+                "for memory used by QEMU itself instead of guest system!",
+                 addr, "BUS_MCEERR_AO");
+        }
     }
 
     if (code == BUS_MCEERR_AR) {
-        hardware_memory_error();
+        hardware_memory_error(addr);
     }
 
     /* Hope we are lucky for AO MCE */
-- 
1.8.3.1



