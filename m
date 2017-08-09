Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfOOH-0007qK-6w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfOOD-0006HK-0L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:39:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfOOC-0006Gm-Qy
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:39:00 -0400
References: <alpine.DEB.2.20.1708082350340.23380@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbc3e188-4831-0bab-6ada-606f99a3a83c@redhat.com>
Date: Wed, 9 Aug 2017 12:38:55 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1708082350340.23380@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: set rip_offset for further
 SSE instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com

On 09/08/2017 01:51, Joseph Myers wrote:
> It turns out that my recent fix to set rip_offset when emulating some
> SSE4.1 instructions needs generalizing to cover a wider class of
> instructions.  Specifically, every instruction in the sse_op_table7
> table, coming from various instruction set extensions, has an 8-bit
> immediate operand that comes after any memory operand, and so needs
> rip_offset set for correctness if there is a memory operand that is
> rip-relative, and my patch only set it for a subset of those
> instructions.  This patch moves the rip_offset setting to cover the
> wider class of instructions, so fixing 9 further gcc testsuite
> failures in my GCC 6-based testing.  (I do not know whether there
> might be still further classes of instructions missing this setting.)
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> 
> ---
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 5fdadf9..95f7261 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4077,10 +4077,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>              if (!(s->cpuid_ext_features & sse_op_table7[b].ext_mask))
>                  goto illegal_op;
>  
> +            s->rip_offset = 1;
> +
>              if (sse_fn_eppi == SSE_SPECIAL) {
>                  ot = mo_64_32(s->dflag);
>                  rm = (modrm & 7) | REX_B(s);
> -                s->rip_offset = 1;
>                  if (mod != 3)
>                      gen_lea_modrm(env, s, modrm);
>                  reg = ((modrm >> 3) & 7) | rex_r;
> 


Queued, thanks.

Paolo
