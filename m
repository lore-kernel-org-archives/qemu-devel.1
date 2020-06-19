Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C633B20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COyqoN8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C633B20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJNB-00014D-UU
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jmJMJ-0008Ff-IL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:55:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jmJMH-0007wt-TI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592582112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONVIMPFVgNlQCWartogeNcXUxw3XoJkJEtWznEeVhjk=;
 b=COyqoN8VhOkGQxSbCY60yzjM7sjnX1NTzXT1cTxFDEb3onBV+1kbVANWoR61QnxzU9z7hU
 ZanvQ7vRie+47pD5HvO9yNVyRa10m4y8Ad7UN8bC5GjXteBuF5uuC17VBOzjYvKoOz+d1+
 nAOaYuiU7LApxQDJdzy2YtPbSSzQ+n4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-an-RjqUnOU2a1z51WD2Ghw-1; Fri, 19 Jun 2020 11:54:03 -0400
X-MC-Unique: an-RjqUnOU2a1z51WD2Ghw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79C6C18C6EEA;
 Fri, 19 Jun 2020 15:53:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-254.ams2.redhat.com
 [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1DD95BAD3;
 Fri, 19 Jun 2020 15:53:52 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: [PATCH 1/2] kvm: Add support for KVM_CAP_HAS_SMALLER_MAXPHYADDR
Date: Fri, 19 Jun 2020 17:53:43 +0200
Message-Id: <20200619155344.79579-2-mgamal@redhat.com>
In-Reply-To: <20200619155344.79579-1-mgamal@redhat.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mgamal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
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
Cc: mtosatti@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the KVM_CAP_HAS_SMALLER_MAXPHYADDR capability
and a helper function to check for this capability.
This will allow QEMU to decide to what to do if the host
CPU can't handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR properly.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 linux-headers/linux/kvm.h | 1 +
 target/i386/kvm.c         | 5 +++++
 target/i386/kvm_i386.h    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 9804495a46..9eb61a303f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1017,6 +1017,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_VCPU_RESETS 179
 #define KVM_CAP_S390_PROTECTED 180
 #define KVM_CAP_PPC_SECURE_GUEST 181
+#define KVM_CAP_SMALLER_MAXPHYADDR 184
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b3c13cb898..01100dbf20 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -136,6 +136,11 @@ bool kvm_has_smm(void)
     return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
 }
 
+bool kvm_has_smaller_maxphyaddr(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_SMALLER_MAXPHYADDR);
+}
+
 bool kvm_has_adjust_clock_stable(void)
 {
     int ret = kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 00bde7acaf..513f8eebbb 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -34,6 +34,7 @@
 
 bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
+bool kvm_has_smaller_maxphyaddr(void);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
-- 
2.26.2


