Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsFDU-0001Sf-RR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsFDT-0001We-SX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:29:04 -0400
References: <20170913210343.19078-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15df0ccc-1745-6e2b-35f5-b473aaec1b7b@redhat.com>
Date: Wed, 13 Sep 2017 23:28:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170913210343.19078-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] osdep: Fix ROUND_UP(64-bit, 32-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 13/09/2017 23:03, Eric Blake wrote:
> When using bit-wise operations that exploit the power-of-two
> nature of the second argument of ROUND_UP(), we still need to
> ensure that the mask is as wide as the first argument (done
> by using addition of 0 to force proper arithmetic promotion).
> Unpatched, ROUND_UP(2ULL*1024*1024*1024*1024, 512) produces 0,
> instead of the intended 2TiB.
> 
> Broken since its introduction in commit 292c8e50 (v1.5.0).
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> I did not audit to see how many potential users of ROUND_UP
> are actually passing in different sized types where the first
> argument can be larger than UINT32_MAX; I stumbled across the
> problem when iotests 190 started failing on a patch where I
> added a new use.  We can either be conservative and put this
> on qemu-stable no matter what, or go through the effort of an
> audit to see what might be broken (many callers in the block
> layer, but not just there).
> ---
>  include/qemu/osdep.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94bbf..7a3000efc5 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -189,13 +189,13 @@ extern int daemon(int, int);
> 
>  /* Round number up to multiple. Requires that d be a power of 2 (see
>   * QEMU_ALIGN_UP for a safer but slower version on arbitrary
> - * numbers) */
> + * numbers); works even if d is a smaller type than n.  */
>  #ifndef ROUND_UP
> -#define ROUND_UP(n,d) (((n) + (d) - 1) & -(d))
> +#define ROUND_UP(n, d) (((n) + (d) - 1) & -((n) - (n) + (d)))
>  #endif
> 
>  #ifndef DIV_ROUND_UP
> -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> +#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  #endif
> 
>  /*
> 


Cc: qemu-stable@nongnu.org

Paolo
