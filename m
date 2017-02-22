Received: from eggs.gnu.org ([2001:4830:134:3::10]:40674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUDA-0006UQ-Cg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUD7-0008Sa-9h
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:31:52 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-4-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6ab5f39d-af42-8f03-01fe-002fdd04d51d@twiddle.net>
Date: Wed, 22 Feb 2017 21:31:40 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/11] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
>  target_ulong cpu_read_xer(CPUPPCState *env)
>  {
> -    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
> +    target_ulong xer;
> +
> +    xer = env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
>          (env->ca << XER_CA);
> +
> +    if (is_isa300(env)) {
> +        xer |= (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
> +    }
> +    return xer;
>  }
>
>  void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> @@ -32,5 +39,13 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>      env->so = (xer >> XER_SO) & 1;
>      env->ov = (xer >> XER_OV) & 1;
>      env->ca = (xer >> XER_CA) & 1;
> -    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
> +    if (is_isa300(env)) {
> +        env->ov32 = (xer >> XER_OV32) & 1;
> +        env->ca32 = (xer >> XER_CA32) & 1;
> +        env->xer = xer & ~((1ul << XER_SO) |
> +                           (1ul << XER_OV) | (1ul << XER_CA) |
> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
> +    } else {
> +        env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
> +    }
>  }

Do cpus before power9 really save all of the bits you write to it?
I.e. if you write -1 to XER, do you read -1 back?

If so, then I suppose I'll have to revise my previous advice; there's no point 
in NOT storing bit 19 in env->ov32, because we can always read it back out.


r~
