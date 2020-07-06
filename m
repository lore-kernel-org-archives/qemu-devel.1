Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF35EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FFC206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIfvQKOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FFC206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUFB-0008U5-MX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC7-0003Jj-DR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC5-000350-J0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivYHD2g3Jxw1934ZPVIeMU+0jTpdt7CUCeoEcyeUUFU=;
 b=iIfvQKOktwk5S3YT8z1k/V/lmnStUBJy1XuGmm+i8bA8SD39IWHVLUBgeOzZO4JkS25sjD
 vGud2Ty7vNgNZkA7QZzdDGcYpXshlJV+CdPn8giUSR6OYF/EXiUdc0ERS1CiWJqVTsGgjd
 x+wPvPnY8YwsfWYO5SenZut9lmOcmsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-zYfbo6IRNAK44MlSGdqn1g-1; Mon, 06 Jul 2020 12:42:10 -0400
X-MC-Unique: zYfbo6IRNAK44MlSGdqn1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62E01937FDD;
 Mon,  6 Jul 2020 16:42:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F12ACF94F;
 Mon,  6 Jul 2020 16:42:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/53] i386: hvf: Set env->eip in macvm_set_rip()
Date: Mon,  6 Jul 2020 12:41:14 -0400
Message-Id: <20200706164155.24696-13-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

cpu_synchronize_state() is currently no-op for hvf but BIOS will hang in
vAPIC option ROM when cpu_synchronize_state() is wired to
hvf_cpu_synchronize_state().

cpu_synchronize_state() state is called from vapic_write() during option
ROM initialization. It sets dirty flag on the cpu. macvm_set_rip() is
then invoked to advance IP after the I/O write to vAPIC port.

macvm_set_rip() only modifies VMCS, it doesn't change env->eip.
Therefore on the next iteration of vCPU loop, vcpu_dirty flag is checked
and hvf_put_registers() overwrites correct RIP in VMCS with the value of
env->eip that points to the I/O write instruction. Execution of the CPU
gets stuck on the instruction.

The issue can be avoided if eip doesn't contain stale value when dirty
flag is set on cpu.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200630102824.77604-2-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index ce2a1532d5..1e8b29bf7d 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -173,6 +173,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
 
     /* BUG, should take considering overlap.. */
     wreg(cpu->hvf_fd, HV_X86_RIP, rip);
+    env->eip = rip;
 
     /* after moving forward in rip, we need to clean INTERRUPTABILITY */
    val = rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
-- 
2.26.2



