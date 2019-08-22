Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A4C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4523A2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4523A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucloud.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0eu3-0002lT-Sk
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <owen.si@ucloud.cn>) id 1i0etD-0001yZ-N0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0etC-0001vN-4a
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:39:59 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:36084)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0etB-0001qw-ID
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:39:58 -0400
Received: from localhost.localdomain (unknown [120.132.1.230])
 by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 68AAD5C167D;
 Thu, 22 Aug 2019 12:39:43 +0800 (CST)
From: Bingsong Si <owen.si@ucloud.cn>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 12:29:01 +0800
Message-Id: <20190822042901.16858-1-owen.si@ucloud.cn>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVOTk5CQkJMTk5DTkJIQ1lXWShZQU
 lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6MCo4Szg4Fz4VLREqQiow
 IUkwFEtVSlVKTk1NT09DTENITElMVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSklL
 VUpISVVKVUlIS1lXWQgBWUFPTU1INwY+
X-HM-Tid: 0a6cb79f90842087kuqy68aad5c167d
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.97.85
Subject: [Qemu-devel] [PATCH] i386: Fix legacy guest with xsave panic on
 host kvm without update cpuid.
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff65e11008..77510cdacd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4416,7 +4416,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
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
2.22.0


