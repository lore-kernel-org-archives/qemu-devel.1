Received: from eggs.gnu.org ([2001:4830:134:3::10]:54899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBeh5-0004fk-DZ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBeh4-0006Aw-HG
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBeh4-0006Ar-7B
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:59:34 -0400
References: <ffb376034ff184f2fcbe93d5317d9e76@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be98ada5-2a3b-f1c2-e477-7232f735b296@redhat.com>
Date: Fri, 19 May 2017 11:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <ffb376034ff184f2fcbe93d5317d9e76@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: fix read/write cr with icount option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, Qemu Devel <qemu-devel@nongnu.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 19/05/2017 11:36, Mihail Abakumov wrote:
> Running Windows with icount causes a crash in instruction of write cr.
> This patch fixes it.
> 
> Reading and writing cr cause an icount read because there are called
> cpu_get_apic_tpr and cpu_set_apic_tpr functions. So, there is need
> gen_io_start()/gen_io_end() calls.

The patch looks good, but lacks a signoff.  Please read the Developer 
Certificate of Origin[1] and reply to this email with "Signed-off-by: 
Mihail Abakumov <mikhail.abakumov@ispras.ru>".


[1]     Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

Thanks,

Paolo
> ---
>  target/i386/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 06d8833..3b009bd 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -7907,14 +7907,26 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>                  gen_update_cc_op(s);
>                  gen_jmp_im(pc_start - s->cs_base);
>                  if (b & 2) {
> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
> +                        gen_io_start();
> +                    }
>                      gen_op_mov_v_reg(ot, cpu_T0, rm);
>                      gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
>                                           cpu_T0);
> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
> +                        gen_io_end();
> +                    }
>                      gen_jmp_im(s->pc - s->cs_base);
>                      gen_eob(s);
>                  } else {
> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
> +                        gen_io_start();
> +                    }
>                      gen_helper_read_crN(cpu_T0, cpu_env,
> tcg_const_i32(reg));
>                      gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                    if (s->tb->cflags & CF_USE_ICOUNT) {
> +                        gen_io_end();
> +                    }
>                  }
>                  break;
>              default:
