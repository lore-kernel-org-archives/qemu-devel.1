Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3rdpeWAMKCqYJPKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--dje.bounces.google.com>)
	id 1cKswi-0001ms-3z
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 15:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3rdpeWAMKCqYJPKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--dje.bounces.google.com>)
	id 1cKswh-00024b-AV
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 15:29:36 -0500
Received: from mail-pg0-x24a.google.com ([2607:f8b0:400e:c05::24a]:34899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3rdpeWAMKCqYJPKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--dje.bounces.google.com>)
	id 1cKswh-000233-4q
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 15:29:35 -0500
Received: by mail-pg0-x24a.google.com with SMTP id u5so5493190pgi.2
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 12:29:34 -0800 (PST)
MIME-Version: 1.0
Message-ID: <f403045cde4049058c05446d5c04@google.com>
Date: Sat, 24 Dec 2016 20:29:33 +0000
From: Doug Evans <dje@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Subject: [Qemu-devel] [PATCH] target/i386: Fix bad patch application to
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com

In commit c52ab08aee6f7d4717fc6b517174043126bd302f,
the patch snippet for the "syscall" insn got applied to "iret".

Signed-off-by: Doug Evans <dje@google.com>
---
  target/i386/translate.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 59e11fc..7e9d073 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6435,10 +6435,7 @@ static target_ulong disas_insn(CPUX86State *env,  
DisasContext *s,
                                        tcg_const_i32(s->pc - s->cs_base));
              set_cc_op(s, CC_OP_EFLAGS);
          }
-        /* TF handling for the syscall insn is different. The TF bit is  
checked
-           after the syscall insn completes. This allows #DB to not be
-           generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob(s);
          break;
      case 0xe8: /* call im */
          {
@@ -7119,7 +7116,10 @@ static target_ulong disas_insn(CPUX86State *env,  
DisasContext *s,
          gen_update_cc_op(s);
          gen_jmp_im(pc_start - s->cs_base);
          gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
-        gen_eob(s);
+        /* TF handling for the syscall insn is different. The TF bit is  
checked
+           after the syscall insn completes. This allows #DB to not be
+           generated after one has entered CPL0 if TF is set in FMASK.  */
+        gen_eob_worker(s, false, true);
          break;
      case 0x107: /* sysret */
          if (!s->pe) {
-- 
2.8.0.rc3.226.g39d4020
