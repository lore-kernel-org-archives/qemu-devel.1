Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70297C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460A120673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460A120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfbL-00075y-R1
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iCfY8-0005G8-Ev
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iCfY6-00071G-Hb
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iCfY4-0006zL-Jf; Tue, 24 Sep 2019 03:47:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA4227E421;
 Tue, 24 Sep 2019 07:47:45 +0000 (UTC)
Received: from thuth.com (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14C566017E;
 Tue, 24 Sep 2019 07:47:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] target/i386/kvm: Silence warning from Valgrind about
 uninitialized bytes
Date: Tue, 24 Sep 2019 09:47:38 +0200
Message-Id: <20190924074738.13104-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 24 Sep 2019 07:47:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When I run QEMU with KVM under Valgrind, I currently get this warning:

 Syscall param ioctl(generic) points to uninitialised byte(s)
    at 0x95BA45B: ioctl (in /usr/lib64/libc-2.28.so)
    by 0x429DC3: kvm_ioctl (kvm-all.c:2365)
    by 0x51B249: kvm_arch_get_supported_msr_feature (kvm.c:469)
    by 0x4C2A49: x86_cpu_get_supported_feature_word (cpu.c:3765)
    by 0x4C4116: x86_cpu_expand_features (cpu.c:5065)
    by 0x4C7F8D: x86_cpu_realizefn (cpu.c:5242)
    by 0x5961F3: device_set_realized (qdev.c:835)
    by 0x7038F6: property_set_bool (object.c:2080)
    by 0x707EFE: object_property_set_qobject (qom-qobject.c:26)
    by 0x705814: object_property_set_bool (object.c:1338)
    by 0x498435: pc_new_cpu (pc.c:1549)
    by 0x49C67D: pc_cpus_init (pc.c:1681)
  Address 0x1ffeffee74 is on thread 1's stack
  in frame #2, created by kvm_arch_get_supported_msr_feature (kvm.c:445)

It's harmless, but a little bit annoying, so silence it by properly
initializing the whole structure with zeroes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 92069099ab..bd92dabea6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -447,7 +447,7 @@ uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
-    } msr_data;
+    } msr_data = {};
     uint32_t ret;
 
     if (kvm_feature_msrs == NULL) { /* Host doesn't support feature MSRs */
-- 
2.18.1


