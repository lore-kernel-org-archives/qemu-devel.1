Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE8C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B158C2183E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPtSkI++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158C2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwqj-0002X7-2L
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmh-0000Wm-L4
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmf-0004ID-Nd
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmd-0004AS-Oj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id p11so4215310wre.7
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3B/bfXURZHaVjJAIBJ0jUA1Z41SYUF9H91mCqN9VRIY=;
 b=vPtSkI++evlUCPvTkjuIHRSyGK1jxL0NWT/PY3lTrb51hETdV2pNFBErF1J08KZUtV
 Rmet41kRpC+/LEn+gQDDHsh0EudT57EUZFkVsfJPeL+oQwvx6jvKDc7HHFPzgdEVcrCA
 Q7xx9LolLDiH0+4dEaCsoEoVHveP7wd4ZkJhgy/XzdKoLArTCsdaF8Chc3v+rtDVgn4s
 lGuMv9BeKxInqrS2kR7rJiL7Td776lut0+nrbktJaRN/mCpPMOoQ9rnLjFwswgs8F69V
 SgYDproCZfl70RUdS8UBoKTAPhhPEueapLUdZq9ZNgehJ8+H6RLrHvLDJCMzqcKqkxEQ
 7z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3B/bfXURZHaVjJAIBJ0jUA1Z41SYUF9H91mCqN9VRIY=;
 b=OHHt3a9cwTsDvrvr4gl15KEh4iLKyPX+3geqyxE5f8rdvXX19LI7ii3NNQx15RYiDf
 yyW/UF/IwyuKnfFuUgDXImFA1S5Ka+HehmM91sTJ/xVZKDNrcrDjckuOjlVG6EQr4F7g
 29AInQnsgQgYigq8dHYGk0QdX8mvt0HBAch71Na7Gs5S9lAkYBTG8OYl28ZS+3KuOg7u
 Rf177RFtvcuI1raiQEyqQN6NAuiFrxI2Q2ENRN4tBClm0yBvhTmC8/rN43z6p0jGxROW
 g5/JLDPhSb7jHySGHYyd+n1j/Jp9UDgPzV7i1PdtwE5CzyFbXeV3OkpgKWLb+/TNElhM
 VRuw==
X-Gm-Message-State: APjAAAUc6dK+JwpE5/BOmUe2xTZ0wYPFgvJJoDnjFhcy8DES8vIsPznv
 I6lWT28gYy/HmsOAyFWyWfLIvlvr
X-Google-Smtp-Source: APXvYqwW87LgiSWNqqIhdgWANSe8mA/vzRL0BHQ+eI20z1LFZIjKmb8ia+yWS2BxGhTMcMEIaMhXxw==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr5032965wrn.281.1560559379627; 
 Fri, 14 Jun 2019 17:42:59 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.42.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:42:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:53 +0200
Message-Id: <20190615004256.16367-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 4/7] linux-headers: import improved definition
 of KVM_GET/SET_NESTED_STATE structs
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch improves the KVM_GET/SET_NESTED_STATE structs by detailing
the format of VMX nested state in a struct.  The VMX nested state is
accessible through struct kvm_vmx_nested_state though, to avoid
changing the size of the structs, it has to be accessed as "vmx.data[0]"
rather than just "vmx.data".

Also, the values of the "format" field are defined as macros.  This
patch should be sent to Linus very shortly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-x86/kvm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 7a0e64ccd6..06b8727a3b 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -383,6 +383,9 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
+#define KVM_STATE_NESTED_FORMAT_VMX	0
+#define KVM_STATE_NESTED_FORMAT_SVM	1
+
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
@@ -390,6 +393,11 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
 
+struct kvm_vmx_nested_state_data {
+	__u8 vmcs12[0x1000];
+	__u8 shadow_vmcs12[0x1000];
+};
+
 struct kvm_vmx_nested_state {
 	__u64 vmxon_pa;
 	__u64 vmcs_pa;
@@ -397,6 +405,9 @@ struct kvm_vmx_nested_state {
 	struct {
 		__u16 flags;
 	} smm;
+
+	__u8 pad[120 - 18];
+	struct kvm_vmx_nested_state_data data[0];
 };
 
 /* for KVM_CAP_NESTED_STATE */
-- 
2.21.0



