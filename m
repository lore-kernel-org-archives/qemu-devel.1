Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC22C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEF021741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPVjmunv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEF021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLWd-0003NA-JP
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVB-0001Jv-Oi
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVA-0003zP-MF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVA-0003v5-HD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5N3viiIpDvgmz5NQ3C0n0h5DAYjZJzdSGyqyhpF2Hg=;
 b=TPVjmunvALcso55hbhl5ErXYhLlXdXXMxFdjHE93T120q7FA4YepyJRnLaxr+HxxMZBD2O
 XGURr+aKcTOZVjHtDfz6kG2cD+6pdV9PMtIbwW1sUG124RS8b72GcEPyIzlnKjzVVft/0o
 WnhMTBCTAawelKc/OU7JgVYK1VEATtc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-48hf_5G-Otm8bQCOPFgzCg-1; Wed, 05 Feb 2020 09:17:58 -0500
Received: by mail-qv1-f70.google.com with SMTP id cn2so1577977qvb.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gXkPt6N6Af8+FqxhOe2WmGrZCOt+N/6RyewFCHsP9v8=;
 b=oGEY15sAswAnQ+q3ChZwjLwGPhAvbOFjAGMOcDqk7MfWZ4UgmjieloDvlNmEHxTLl5
 lTfYdCl77JAGkS/vZ4G4beNdG8DtxB5+Q4Q+7r1I46mol/kvKmaXNOnHXNFYdM4g3boZ
 BLQ6X6dss1vvQhpiUQeH3MbygDcEFqe2LR4fc5swDJIGDzMvv1IJ/z05SOysOVRu7/xp
 PvHD4+QOo/KeJ234QUP3vPYSSHCki1dEDIVK0RYpE4FzYvc6Wp0FNDcvcUC1+5JTbAgK
 NfMpCcrAHyBx2HaK3Y8MFpDLQ+4efLmPnCoCfHtNDyF4ucjZZEqcaw/3ZmLK4ay5Va+a
 tnlA==
X-Gm-Message-State: APjAAAV5i8uHMwhmFUDbva2ob58lGQdJ+seMy6Os5FbT3tG0m7/j5Qjt
 kajE+rdFIQP6gdXVJdeGbNVx0Lzf7v6/uKAlucrtXLkAfvca5U0bLreMjp4d4wIo1WD+sUANWWv
 MQ0iffdxjTmG/u3A=
X-Received: by 2002:a37:9e09:: with SMTP id h9mr32940195qke.289.1580912277657; 
 Wed, 05 Feb 2020 06:17:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTV29qcKFHl49Yf2MzK5ByW+swLFvny2QzaMu3Ejx6PF1SvGk1dyxb616O8LbulOY3tjzWCw==
X-Received: by 2002:a37:9e09:: with SMTP id h9mr32940177qke.289.1580912277419; 
 Wed, 05 Feb 2020 06:17:57 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:17:56 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 2/9] linux-headers: Update
Date: Wed,  5 Feb 2020 09:17:42 -0500
Message-Id: <20200205141749.378044-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 48hf_5G-Otm8bQCOPFgzCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 linux-headers/asm-x86/kvm.h |  1 +
 linux-headers/linux/kvm.h   | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 503d3f42da..b59bf356c4 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -12,6 +12,7 @@
=20
 #define KVM_PIO_PAGE_OFFSET 1
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 2
+#define KVM_DIRTY_LOG_PAGE_OFFSET 64
=20
 #define DE_VECTOR 0
 #define DB_VECTOR 1
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 9d647fad76..c5a6c6e0a6 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
=20
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -1009,6 +1010,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_DIRTY_LOG_RING 179
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1473,6 +1475,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE=09  _IOW(KVMIO,  0xc2, int)
=20
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 =09/* Guest initialization commands */
@@ -1623,4 +1628,43 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK=09=090x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN=09(1 << 0)
=20
+/*
+ * KVM dirty GFN flags, defined as:
+ *
+ * |---------------+---------------+--------------|
+ * | bit 1 (reset) | bit 0 (dirty) | Status       |
+ * |---------------+---------------+--------------|
+ * |             0 |             0 | Invalid GFN  |
+ * |             0 |             1 | Dirty GFN    |
+ * |             1 |             X | GFN to reset |
+ * |---------------+---------------+--------------|
+ *
+ * Lifecycle of a dirty GFN goes like:
+ *
+ *      dirtied         collected        reset
+ * 00 -----------> 01 -------------> 1X -------+
+ *  ^                                          |
+ *  |                                          |
+ *  +------------------------------------------+
+ *
+ * The userspace program is only responsible for the 01->1X state
+ * conversion (to collect dirty bits).  Also, it must not skip any
+ * dirty bits so that dirty bits are always collected in sequence.
+ */
+#define KVM_DIRTY_GFN_F_DIRTY           BIT(0)
+#define KVM_DIRTY_GFN_F_RESET           BIT(1)
+#define KVM_DIRTY_GFN_F_MASK            0x3
+
+/*
+ * KVM dirty rings should be mapped at KVM_DIRTY_LOG_PAGE_OFFSET of
+ * per-vcpu mmaped regions as an array of struct kvm_dirty_gfn.  The
+ * size of the gfn buffer is decided by the first argument when
+ * enabling KVM_CAP_DIRTY_LOG_RING.
+ */
+struct kvm_dirty_gfn {
+=09__u32 flags;
+=09__u32 slot;
+=09__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
--=20
2.24.1


