Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDBBC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1EF214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvaP5gIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1EF214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9t4N-0002iG-Jr
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCl-0006FP-4T
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCj-0007Ov-Lb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:33082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCj-0007OY-Bi
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id b9so5595624wrs.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YKW2Y+e7G2qkXzUR5XTC1dqXN0+JuqZwNXAZTTRmCi4=;
 b=IvaP5gIBmrC/4DUFcqOpdwesGChREks7RykTzhC9l+jNXTo4CmivPXNAR+UfQDGEx0
 QCAF7TAUaThkU/UFYsvCOJy7tmYJVxcb57iKFHiPeeupuXXRlauRS0g31LtqchHtCr5n
 znLuCZavB6zMklIe3ZCyFruG5MNTk4awBdF/KdIHssuwW42pA8tqMA1JtpZkx6uhdq9I
 ncKm5hiZ/5etsySPigPNxpBtPpdF17CZfIVycCKAkOMIQGekTHXTdIWDFVIzFG9mKTfd
 +PjApwLG/gmhzz3mtqrJZwWu0oudh7Z8cDP/cueONnWpEEy5Sq8bEEUJGJ7GYcXY3nDN
 NZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YKW2Y+e7G2qkXzUR5XTC1dqXN0+JuqZwNXAZTTRmCi4=;
 b=GDa11oNTooSQQqTh5+nNvlcraWzhLhwoT1tXHh5RyYKuEQfrnfLZDdUoTWS0GIDZuG
 sjIjW+Tk6VQyQW2nDurg87cPWQOtxstUbjYwv/+Ll8pfsvVaV4eVaW1XgVaZiivaa4Pq
 a3jakFuC76YMzuyCA664hP6c14SpYtbdPJU1ro66xz4i17PvE2RIfki2NRfE1keOSMco
 YNm7ISyHfTgCFEZwMAvWeTpvVuIRL7HCU3HRzcepMwL3/ER2VBtft+ik/PqugkCAmCJg
 c6//q58KaQ19qcMAFTA82pxiqvhIkaoafZpZfJVK1z2ISQaJVlLVj8b/qpoiD80gt6zN
 E8zA==
X-Gm-Message-State: APjAAAVPRgrMsm6TKMAmxNUtiMW5f5UAjqS3BEM3Gn687F10T2PnJWZn
 VMi4G9O3dAOh2gi0cPwQo8KZeb/P
X-Google-Smtp-Source: APXvYqxLViKlkJ/7umDpDDZxbvo9fHqk33ZdOSOfARXpU4JgZaygykS70v50qIbZbrp30ogf+dkZyQ==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr152206wrw.34.1568644931756;
 Mon, 16 Sep 2019 07:42:11 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:41 +0200
Message-Id: <1568644929-9124-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 01/29] i386/kvm: support guest access CORE cstate
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
Cc: Wanpeng Li <wanpengli@tencent.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

Allow guest reads CORE cstate when exposing host CPU power management capabilities
to the guest. PKG cstate is restricted to avoid a guest to get the whole package
information in multi-tenant scenario.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/linux/kvm.h | 4 +++-
 target/i386/kvm.c         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c8423e7..18892d6 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -696,9 +696,11 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
                                               KVM_X86_DISABLE_EXITS_HLT | \
-                                              KVM_X86_DISABLE_EXITS_PAUSE)
+                                              KVM_X86_DISABLE_EXITS_PAUSE | \
+                                              KVM_X86_DISABLE_EXITS_CSTATE)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8023c67..3435fc4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2076,7 +2076,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (disable_exits) {
             disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                               KVM_X86_DISABLE_EXITS_HLT |
-                              KVM_X86_DISABLE_EXITS_PAUSE);
+                              KVM_X86_DISABLE_EXITS_PAUSE |
+                              KVM_X86_DISABLE_EXITS_CSTATE);
         }
 
         ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-- 
1.8.3.1



