Received: from eggs.gnu.org ([2001:4830:134:3::10]:58920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crMn9-0006IT-5g
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crMn6-0007EZ-4R
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1crMn5-0007EJ-VA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:49:56 -0400
References: <20170323175851.14342-1-bobby.prani@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3dd9c1d8-bc6d-0b6e-14c2-b37bfd40d852@redhat.com>
Date: Fri, 24 Mar 2017 11:49:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170323175851.14342-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Check the size of instruction
 being translated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Queued, thanks.

Paolo

On 23/03/2017 18:58, Pranith Kumar wrote:
> Sending again since I messed by pbonzini's email.
> 
> This fixes the bug: 'user-to-root privesc inside VM via bad translation
> caching' reported by Jann Horn here:
> https://bugs.chromium.org/p/project-zero/issues/detail?id=1122
> 
> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  target/i386/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 72c1b03a2a..1d1372fb43 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4418,6 +4418,13 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
>      s->vex_l = 0;
>      s->vex_v = 0;
>   next_byte:
> +    /* x86 has an upper limit of 15 bytes for an instruction. Since we
> +     * do not want to decode and generate IR for an illegal
> +     * instruction, the following check limits the instruction size to
> +     * 25 bytes: 14 prefix + 1 opc + 6 (modrm+sib+ofs) + 4 imm */
> +    if (s->pc - pc_start > 14) {
> +        goto illegal_op;
> +    }
>      b = cpu_ldub_code(env, s->pc);
>      s->pc++;
>      /* Collect prefixes.  */
> 
