Received: from eggs.gnu.org ([2001:4830:134:3::10]:41075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiiB-00088W-3R
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqii7-0003yy-Rs
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqiht-0001VY-VJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:38:44 -0400
References: <20180816011903.39816-1-andrew@andrewoates.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
Date: Fri, 17 Aug 2018 19:38:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180816011903.39816-1-andrew@andrewoates.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: andrew@andrewoates.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

On 16/08/2018 03:19, andrew@andrewoates.com wrote:
> From: Andrew Oates <aoates@google.com>
> 
> The current implementation has three bugs,
>  * segment limits are not enforced in protected mode if the L bit is set
>    in the target segment descriptor[1]
>  * segment limits are not enforced in compatability mode (ljmp to 32-bit
>    code segment in long mode)
>  * #GP(new_cs) is generated rather than #GP(0)
> 
> Now the segment limits are enforced if we're not in long mode OR the
> target code segment doesn't have the L bit set.
> 
> [1] this is an invalid configuration (in protected mode the L bit is
> reserved and should be set to zero), but qemu doesn't enforce that.

Stupid question, why not fix that instead at least for this case?

> Signed-off-by: Andrew Oates <aoates@google.com>
> ---
> The limit check is still incorrect for ljmp-through-call-gate in 64-bit
> mode.  That's a larger fix I'm still working on.

Can you resend the call-gate for both ljmp and lcall when you're done
(there's plenty of time until 3.1)?

Thanks,

Paolo

>  target/i386/seg_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> index 00301a0c04..975365fd30 100644
> --- a/target/i386/seg_helper.c
> +++ b/target/i386/seg_helper.c
> @@ -1628,8 +1628,8 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
>          }
>          limit = get_seg_limit(e1, e2);
>          if (new_eip > limit &&
> -            !(env->hflags & HF_LMA_MASK) && !(e2 & DESC_L_MASK)) {
> -            raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
> +            (!(env->hflags & HF_LMA_MASK) || !(e2 & DESC_L_MASK))) {
> +            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
>          }
>          cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
>                         get_seg_base(e1, e2), limit, e2);
> 
