Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D6ECE59D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540522064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540522064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUlI-0008IY-A8
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWy-0006de-7x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWw-0006wg-Uu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:39:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUWw-0006wP-OR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 032D2C05FF87;
 Tue, 15 Oct 2019 21:38:58 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9474E1001947;
 Tue, 15 Oct 2019 21:38:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 17/18] i386: Omit all-zeroes entries from KVM CPUID table
Date: Tue, 15 Oct 2019 18:37:44 -0300
Message-Id: <20191015213745.22174-18-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 15 Oct 2019 21:38:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Yumei Huang <yuhuang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM has a 80-entry limit at KVM_SET_CPUID2.  With the
introduction of CPUID[0x1F], it is now possible to hit this limit
with unusual CPU configurations, e.g.:

  $ ./x86_64-softmmu/qemu-system-x86_64 \
    -smp 1,dies=3D2,maxcpus=3D2 \
    -cpu EPYC,check=3Doff,enforce=3Doff \
    -machine accel=3Dkvm
  qemu-system-x86_64: kvm_init_vcpu failed: Argument list too long

This happens because QEMU adds a lot of all-zeroes CPUID entries
for unused CPUID leaves.  In the example above, we end up
creating 48 all-zeroes CPUID entries.

KVM already returns all-zeroes when emulating the CPUID
instruction if an entry is missing, so the all-zeroes entries are
redundant.  Skip those entries.  This reduces the CPUID table
size by half while keeping CPUID output unchanged.

Reported-by: Yumei Huang <yuhuang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1741508
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190822225210.32541-1-ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 11b9c854b5..8c73438c67 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1567,6 +1567,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->function =3D i;
             c->flags =3D 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx)=
;
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is mi=
ssing,
+                 * so we can omit it and avoid hitting KVM's 80-entry li=
mit.
+                 */
+                cpuid_i--;
+            }
             break;
         }
     }
@@ -1631,6 +1638,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->function =3D i;
             c->flags =3D 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx)=
;
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is mi=
ssing,
+                 * so we can omit it and avoid hitting KVM's 80-entry li=
mit.
+                 */
+                cpuid_i--;
+            }
             break;
         }
     }
--=20
2.21.0


