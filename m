Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB0C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B8021926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B8021926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqH5q-0008QJ-Qd
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqH51-0005Jf-S2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqH50-0007vj-Tv
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:13:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqH50-0007vI-OQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:13:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F36E3300D1CA;
 Wed, 24 Jul 2019 13:13:13 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-43.ams2.redhat.com
 [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1A315C225;
 Wed, 24 Jul 2019 13:13:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 15:13:08 +0200
Message-Id: <20190724131309.1378-3-pbonzini@redhat.com>
In-Reply-To: <20190724131309.1378-1-pbonzini@redhat.com>
References: <20190724131309.1378-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 24 Jul 2019 13:13:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] i386/kvm: Do not sync nested state during
 runtime
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Writing the nested state e.g. after a vmport access can invalidate
important parts of the kernel-internal state, and it is not needed as
well. So leave this out from KVM_PUT_RUNTIME_STATE.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ada89d27cc..dbbb13772a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3563,12 +3563,12 @@ int kvm_arch_put_registers(CPUState *cpu, int lev=
el)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
-    ret =3D kvm_put_nested_state(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
-
     if (level >=3D KVM_PUT_RESET_STATE) {
+        ret =3D kvm_put_nested_state(x86_cpu);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret =3D kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
             return ret;
--=20
2.21.0



