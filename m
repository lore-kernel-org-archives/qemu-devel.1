Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D15C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5F820801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHonzAQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmEq-0006bx-Am
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmDv-0005L0-LQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmDs-00013P-Ec
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591978083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJ5QpuHxGC44PNW734u7oiMMHq6LfU6fDDTfKL7vXIs=;
 b=AHonzAQxeaYMa2OVJ30zhD44AcdOJnkMB+MIBSgHoGvravzap9/mTOvSfqz6UfH/YsBZ+A
 dzpTVhv7hoYlcMMK1f6sXrRLrkxwXyt9k2JhvfUu8fiIkawCDyIMHuuAPKf26LmfE4UJIF
 dxi0fujyFOBwAojwctPh7ELWOxyFFlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-RPGPZLbJMQSYOeqZAwo1Fg-1; Fri, 12 Jun 2020 12:08:01 -0400
X-MC-Unique: RPGPZLbJMQSYOeqZAwo1Fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718A1872FE0;
 Fri, 12 Jun 2020 16:08:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 052088FF91;
 Fri, 12 Jun 2020 16:07:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 098/116] i386: hvf: Move mmio_buf into CPUX86State
Date: Fri, 12 Jun 2020 12:07:55 -0400
Message-Id: <20200612160755.9597-5-pbonzini@redhat.com>
In-Reply-To: <20200612160755.9597-1-pbonzini@redhat.com>
References: <20200612160755.9597-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

There's no similar field in CPUX86State, but it's needed for MMIO traps.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-13-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h         |  1 +
 target/i386/hvf/hvf.c     |  5 +++++
 target/i386/hvf/x86.h     |  1 -
 target/i386/hvf/x86_emu.c | 12 ++++++------
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f742ba933f..25a2f4c0c3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1603,6 +1603,7 @@ typedef struct CPUX86State {
 #endif
 #if defined(CONFIG_HVF)
     HVFX86LazyFlags hvf_lflags;
+    void *hvf_mmio_buf;
     HVFX86EmulatorState *hvf_emul;
 #endif
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 4cee496d71..57696c46c7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -533,7 +533,11 @@ void hvf_reset_vcpu(CPUState *cpu) {
 
 void hvf_vcpu_destroy(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
+    g_free(env->hvf_mmio_buf);
     assert_hvf_ok(ret);
 }
 
@@ -563,6 +567,7 @@ int hvf_init_vcpu(CPUState *cpu)
     init_decoder();
 
     hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    env->hvf_mmio_buf = g_new(char, 4096);
     env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
 
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 2363616c07..483fcea762 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -230,7 +230,6 @@ typedef struct x68_segment_selector {
 
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
-    uint8_t mmio_buf[4096];
 };
 
 /* useful register access  macros */
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 1ad2c30e16..d3e289ed87 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -187,8 +187,8 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
 
 uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
-    return env->hvf_emul->mmio_buf;
+    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
+    return env->hvf_mmio_buf;
 }
 
 
@@ -489,9 +489,9 @@ static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
                   decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
+    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
                   decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -512,9 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
+    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
                  decode->operand_size);
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
                   decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.26.2


