Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2366ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC602064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC602064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUmI-0001ar-CF
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWw-0006Zi-FJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWv-0006vy-6O
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUWu-0006vV-US
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA28E30832E9;
 Tue, 15 Oct 2019 21:38:55 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC975D70D;
 Tue, 15 Oct 2019 21:38:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 16/18] i386: Fix legacy guest with xsave panic on host kvm
 without update cpuid.
Date: Tue, 15 Oct 2019 18:37:43 -0300
Message-Id: <20191015213745.22174-17-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 21:38:55 +0000 (UTC)
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
Cc: Bingsong Si <owen.si@ucloud.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bingsong Si <owen.si@ucloud.cn>

without kvm commit 412a3c41, CPUID(EAX=3D0xd,ECX=3D0).EBX always equal to=
 0 even
through guest update xcr0, this will crash legacy guest(e.g., CentOS 6).
Below is the call trace on the guest.

[    0.000000] kernel BUG at mm/bootmem.c:469!
[    0.000000] invalid opcode: 0000 [#1] SMP
[    0.000000] last sysfs file:
[    0.000000] CPU 0
[    0.000000] Modules linked in:
[    0.000000]
[    0.000000] Pid: 0, comm: swapper Tainted: G           ---------------=
 H  2.6.32-279#2 Red Hat KVM
[    0.000000] RIP: 0010:[<ffffffff81c4edc4>]  [<ffffffff81c4edc4>] alloc=
_bootmem_core+0x7b/0x29e
[    0.000000] RSP: 0018:ffffffff81a01cd8  EFLAGS: 00010046
[    0.000000] RAX: ffffffff81cb1748 RBX: ffffffff81cb1720 RCX: 000000000=
1000000
[    0.000000] RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffffffff8=
1cb1720
[    0.000000] RBP: ffffffff81a01d38 R08: 0000000000000000 R09: 000000000=
0001000
[    0.000000] R10: 02008921da802087 R11: 00000000ffff8800 R12: 000000000=
0000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
1000000
[    0.000000] FS:  0000000000000000(0000) GS:ffff880002200000(0000) knlG=
S:0000000000000000
[    0.000000] CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000000 CR3: 0000000001a85000 CR4: 000000000=
01406b0
[    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[    0.000000] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000=
0000400
[    0.000000] Process swapper (pid: 0, threadinfo ffffffff81a00000, task=
 ffffffff81a8d020)
[    0.000000] Stack:
[    0.000000]  0000000000000002 81a01dd881eaf060 000000007e5fe227 000000=
0000001001
[    0.000000] <d> 0000000000000040 0000000000000001 0000006cffffffff 000=
0000001000000
[    0.000000] <d> ffffffff81cb1720 0000000000000000 0000000000000000 000=
0000000000000
[    0.000000] Call Trace:
[    0.000000]  [<ffffffff81c4f074>] ___alloc_bootmem_nopanic+0x8d/0xca
[    0.000000]  [<ffffffff81c4f0cf>] ___alloc_bootmem+0x11/0x39
[    0.000000]  [<ffffffff81c4f172>] __alloc_bootmem+0xb/0xd
[    0.000000]  [<ffffffff814d42d9>] xsave_cntxt_init+0x249/0x2c0
[    0.000000]  [<ffffffff814e0689>] init_thread_xstate+0x17/0x25
[    0.000000]  [<ffffffff814e0710>] fpu_init+0x79/0xaa
[    0.000000]  [<ffffffff814e27e3>] cpu_init+0x301/0x344
[    0.000000]  [<ffffffff81276395>] ? sort+0x155/0x230
[    0.000000]  [<ffffffff81c30cf2>] trap_init+0x24e/0x25f
[    0.000000]  [<ffffffff81c2bd73>] start_kernel+0x21c/0x430
[    0.000000]  [<ffffffff81c2b33a>] x86_64_start_reservations+0x125/0x12=
9
[    0.000000]  [<ffffffff81c2b438>] x86_64_start_kernel+0xfa/0x109
[    0.000000] Code: 03 48 89 f1 49 c1 e8 0c 48 0f af d0 48 c7 c6 00 a6 6=
1 81 48 c7 c7 00 e5 79 81 31 c0 4c 89 74 24 08 e8 f2 d7 89 ff 4d 85 e4 75=
 04 <0f> 0b eb fe 48 8b 45 c0 48 83 e8 01 48 85 45
c0 74 04 0f 0b eb

Signed-off-by: Bingsong Si <owen.si@ucloud.cn>
Message-Id: <20190822042901.16858-1-owen.si@ucloud.cn>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index daece62c19..b821132b6a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4693,7 +4693,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
             *ecx =3D xsave_area_size(x86_cpu_xsave_components(cpu));
             *eax =3D env->features[FEAT_XSAVE_COMP_LO];
             *edx =3D env->features[FEAT_XSAVE_COMP_HI];
-            *ebx =3D xsave_area_size(env->xcr0);
+            /*
+             * The initial value of xcr0 and ebx =3D=3D 0, On host witho=
ut kvm
+             * commit 412a3c41(e.g., CentOS 6), the ebx's value always =3D=
=3D 0
+             * even through guest update xcr0, this will crash some lega=
cy guest
+             * (e.g., CentOS 6), So set ebx =3D=3D ecx to workaroud it.
+             */
+            *ebx =3D kvm_enabled() ? *ecx : xsave_area_size(env->xcr0);
         } else if (count =3D=3D 1) {
             *eax =3D env->features[FEAT_XSAVE];
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
--=20
2.21.0


