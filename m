Received: from eggs.gnu.org ([2001:4830:134:3::10]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3IHl-0006xq-AR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3IHk-0004nn-FE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:26:53 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-8-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8f8d1cf3-ba97-1663-3327-2b8857af2dc8@twiddle.net>
Date: Wed, 26 Apr 2017 10:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <1493187803-4510-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] target/i386: introduce gen_jr
 helper to generate lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> +gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
>   {
>       gen_update_cc_op(s);
>   
> @@ -2530,6 +2532,13 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
>           tcg_gen_exit_tb(0);
>       } else if (s->tf) {
>           gen_helper_single_step(cpu_env);
> +    } else if (jr) {
...
> -        gen_eob_worker(s, false, true);
> +        gen_eob_worker(s, false, true, NULL);

You cannot use NULL.  While we abuse a pointer type for TCGv, that's because C 
doesn't have type verification for different integral types.

You need to use

     TCGv unused;
     TCGV_UNUSED(unused);

and

     if (TCGV_IS_UNUSED(foo))

(As it happens, I do have a branch that tries to clean this up, so that this 
kind of thing is less unwieldy.  Perhaps I'll get to it this cycle...)

> +        tcg_gen_ld_tl(vaddr, cpu_env, offsetof(CPUX86State, segs[R_CS].base));
> +        tcg_gen_add_tl(vaddr, vaddr, jr);

tcg_gen_add_tl(vaddr, jr, cpu_seg_base[R_CS]);


r~
