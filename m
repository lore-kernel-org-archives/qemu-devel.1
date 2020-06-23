Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3180A20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXQg9MpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3180A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngZr-0004cX-EO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWS-0005p6-Oa
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWP-0007Wn-WE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7T6k8rDooEOp5R0yTFBiO/Qp4O8fYn54pnxO67whtxE=;
 b=VXQg9MpX4HycWOgVXIa1x7+c5KMbs4GrIQivyJ5xG+/LBgq9WgSTn8dxWl76DmPaJtFBQ/
 lVkg06mWzH1XVYoaJY9BTqmM24DIYxELPtLlYxBx68tuSmDB3G+7nEDzWFqGn0bw58dBdO
 DAPoLdbzNRDvohr4D/gznJA/SKMaoa4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-hUtzkeniPrKmxaDnSYmXog-1; Tue, 23 Jun 2020 06:51:19 -0400
X-MC-Unique: hUtzkeniPrKmxaDnSYmXog-1
Received: by mail-wm1-f69.google.com with SMTP id o13so3589573wmh.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7T6k8rDooEOp5R0yTFBiO/Qp4O8fYn54pnxO67whtxE=;
 b=oeFGugF9I5WzhACW2BU2XrMDtQoM+V9psPA5EVpSkr9F63CXBFcBwx/UvwPsIEk8rk
 k/h3MYBWoiEgZ6SG+3+MrV9b8tc4h1OlWTSfvdUUYCzslYk9TLN7ib0JUKs0ZHvpWJEG
 NtFCMYxzj2Ui8rqgmCH2l2lIMZ3o8/Tq4FoB/0MvNCQNFFrdAtbQlxsgRr3ZRQXvt6S2
 NVOvGL2vle83e9iLVk20VIwaiyAf5aQCGgVCbWX5MCO76pBVuELHQLwZ3KnWNzFqJfy2
 8qMOfmbvE3A9RvNjSuSPaRTfXTTD7QgRKPlvzyJ9qQ4YBcqoO6aplxRfd6QQt7JgO6C5
 1cqQ==
X-Gm-Message-State: AOAM530HvX6DUe/HwqjRzqJ83FRQWCzE0v5qv8nC0/flwKVu/AXjORvA
 ZgosBll+IMCQQ0vX8oRi9UbH1K+R4cCO5Ghw/BwsWLsm3CM7jY+8yVjzrrDIbIwxqa0Qw2iU5Iw
 Z7F48iytg1tp6ZkU=
X-Received: by 2002:a1c:49c1:: with SMTP id w184mr22722088wma.46.1592909478437; 
 Tue, 23 Jun 2020 03:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKlUNG19p2ou+jCN0MXVN7uyCXrtT3qGTGAn5SMFlQPMWCuwgEDnxemEGRDjqST39js2Ao/w==
X-Received: by 2002:a1c:49c1:: with SMTP id w184mr22722054wma.46.1592909478207; 
 Tue, 23 Jun 2020 03:51:18 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s18sm24085181wra.85.2020.06.23.03.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/7] accel/kvm: Simplify kvm_set_sigmask_len()
Date: Tue, 23 Jun 2020 12:50:49 +0200
Message-Id: <20200623105052.1700-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sigmask_len is a property of the accelerator, not the VM.
Simplify by directly using the global kvm_state, remove the
unnecessary KVMState* argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/kvm.h | 2 +-
 accel/kvm/kvm-all.c  | 4 ++--
 target/mips/kvm.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3662641c99..44c1767a7f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -469,7 +469,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
 uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 
-void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
+void kvm_set_sigmask_len(unsigned int sigmask_len);
 
 #if !defined(CONFIG_USER_ONLY)
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index afd14492a0..7b3f76f23d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2240,9 +2240,9 @@ err:
     return ret;
 }
 
-void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len)
+void kvm_set_sigmask_len(unsigned int sigmask_len)
 {
-    s->sigmask_len = sigmask_len;
+    kvm_state->sigmask_len = sigmask_len;
 }
 
 static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direction,
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 0adfa70210..cc3e09bdef 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -48,7 +48,7 @@ unsigned long kvm_arch_vcpu_id(CPUState *cs)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* MIPS has 128 signals */
-    kvm_set_sigmask_len(s, 16);
+    kvm_set_sigmask_len(16);
 
     kvm_mips_fpu_cap = kvm_check_extension(KVM_CAP_MIPS_FPU);
     kvm_mips_msa_cap = kvm_check_extension(KVM_CAP_MIPS_MSA);
-- 
2.21.3


