Received: from eggs.gnu.org ([2001:4830:134:3::10]:44535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fC2UG-0006t0-OR
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fC2UF-0004tO-T1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:28:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fC2UF-0004t8-OE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:28:27 -0400
References: <20180427121723.3543-1-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a14b1299-318d-7cff-899a-4ae6d9273491@redhat.com>
Date: Fri, 27 Apr 2018 14:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180427121723.3543-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] tcg: workaround branch instruction overflow
 in tcg_out_qemu_ld/st
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 27/04/2018 14:17, Laurent Vivier wrote:
> ppc64 uses a BC instruction to call the tcg_out_qemu_ld/st
> slow path. BC instruction uses a relative address encoded
> on 14 bits.
> 
> The slow path functions are added at the end of the generated
> instructions buffer, in the reverse order of the callers.
> So more we have slow path functions more the distance between
> the caller (BC) and the function increases.
> 
> This patch changes the behavior to generate the functions in
> the same order of the callers.
> 
> Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     This is an RFC for several reasons:
>     - it doens't really fix the overflow problem
>       only avoids the case
>     - it uses a recursive function to revert the slow path
>       functions order (and we can have a stack overflow...),

I think the number of slow path functions cannot be greater than
TCG_MAX_INSNS (i.e. 512): is it enough to overflow the stack?

Thanks,
Laurent
