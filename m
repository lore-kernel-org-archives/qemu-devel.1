Received: from eggs.gnu.org ([2001:4830:134:3::10]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MqK-0000kU-CO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MqG-0002TZ-BF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:56:20 -0400
References: <20181003180711.19335-1-richard.henderson@linaro.org>
	<20181003180711.19335-4-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c71e6c84-538f-4697-dccc-871047df0ff7@redhat.com>
Date: Fri, 5 Oct 2018 11:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181003180711.19335-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] softfloat: Specialize udiv_qrnnd
 for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

On 03/10/2018 20:07, Richard Henderson wrote:
> The ISA has a 128/64-bit division instruction.
> 
> Cc: qemu-s390x@nongnu.org
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat-macros.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index 6d58615709..e702607b43 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -626,6 +626,12 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      uint64_t q;
>      asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
>      return q;
> +#elif defined(__s390x__)
> +    /* Need to use a TImode type to get an even register pair for DLGR.  */
> +    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
> +    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
> +    *r = n >> 64;
> +    return n;
>  #else
>      uint64_t d0, d1, q0, q1, r1, r0, m;
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
