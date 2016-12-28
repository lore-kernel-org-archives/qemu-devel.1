Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMHTt-0006YX-Ia
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMHTq-0005Hp-HZ
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:53:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cMHTq-0005Hk-9b
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:53:34 -0500
Date: Wed, 28 Dec 2016 14:53:30 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161228165330.GA23551@thinpad.lan.raisama.net>
References: <f403045cde4049058c05446d5c04@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f403045cde4049058c05446d5c04@google.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix bad patch application to
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Evans <dje@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Sat, Dec 24, 2016 at 08:29:33PM +0000, Doug Evans wrote:
> In commit c52ab08aee6f7d4717fc6b517174043126bd302f,
> the patch snippet for the "syscall" insn got applied to "iret".
> 
> Signed-off-by: Doug Evans <dje@google.com>

Patch was corrupt, I have fixed line wrapping by hand and had to
use git-am --ignore-whitespace to apply it.

I suggest using git-send-email, as e-mail clients often break
patch contents when copying&pasting.

Fixed patch below, for reference:

---
 target/i386/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 59e11fc..7adfff0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6435,10 +6435,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(s->pc - s->cs_base));
             set_cc_op(s, CC_OP_EFLAGS);
         }
-        /* TF handling for the syscall insn is different. The TF bit is checked
-           after the syscall insn completes. This allows #DB to not be
-           generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob(s);
         break;
     case 0xe8: /* call im */
         {
@@ -7119,7 +7116,10 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
         gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
-        gen_eob(s);
+        /* TF handling for the syscall insn is different. The TF bit is  checked
+           after the syscall insn completes. This allows #DB to not be
+           generated after one has entered CPL0 if TF is set in FMASK.  */
+        gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
-- 
2.7.4


> ---
>  target/i386/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 59e11fc..7e9d073 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -6435,10 +6435,7 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>                                        tcg_const_i32(s->pc - s->cs_base));
>              set_cc_op(s, CC_OP_EFLAGS);
>          }
> -        /* TF handling for the syscall insn is different. The TF bit is
> checked
> -           after the syscall insn completes. This allows #DB to not be
> -           generated after one has entered CPL0 if TF is set in FMASK.  */
> -        gen_eob_worker(s, false, true);
> +        gen_eob(s);
>          break;
>      case 0xe8: /* call im */
>          {
> @@ -7119,7 +7116,10 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>          gen_update_cc_op(s);
>          gen_jmp_im(pc_start - s->cs_base);
>          gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
> -        gen_eob(s);
> +        /* TF handling for the syscall insn is different. The TF bit is
> checked
> +           after the syscall insn completes. This allows #DB to not be
> +           generated after one has entered CPL0 if TF is set in FMASK.  */
> +        gen_eob_worker(s, false, true);
>          break;
>      case 0x107: /* sysret */
>          if (!s->pe) {
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> 

-- 
Eduardo
