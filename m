Received: from eggs.gnu.org ([2001:4830:134:3::10]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f47C4-0007l4-5y
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f47C1-00044J-4v
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f47C0-000439-Pt
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:53 -0400
References: <20180405134702.5020-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6b21a387-7ebd-c738-e1c4-b65645f11fed@vivier.eu>
Date: Thu, 5 Apr 2018 17:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180405134702.5020-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

Le 05/04/2018 à 15:47, Max Filippov a écrit :
> preadv/pwritev accept low and high parts of file offset in two separate
> parameters. When host bitness doesn't match guest bitness these parts
> must be appropriately recombined.
> Introduce target_to_host_low_high that does this recombination and use
> it in preadv/pwritev syscalls.
> 
> This fixes glibc testsuite test misc/tst-preadvwritev64.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - rename helper to target_to_host_low_high;
> - handle cases TARGET_LONG_BITS * 2 > HOST_LONG_BITS and
>   TARGET_LONG_BITS < 2 * HOST_LONG_BITS correctly.
> 
> Changes v1->v2:
> - fix host high computation in TARGET_LONG_BITS > HOST_LONG_BITS case
> 
>  linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5ef517613577..13ad572e0d3b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3386,6 +3386,30 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>      return ret;
>  }
>  
> +static void target_to_host_low_high(abi_ulong tlow,
> +                                    abi_ulong thigh,
> +                                    unsigned long *hlow,
> +                                    unsigned long *hhigh)
> +{
> +#if TARGET_LONG_BITS == HOST_LONG_BITS
> +        *hlow = tlow;
> +        *hhigh = thigh;
> +#elif TARGET_LONG_BITS < HOST_LONG_BITS
> +        *hlow = tlow | (unsigned long)thigh << TARGET_LONG_BITS;
> +#if TARGET_LONG_BITS * 2 <= HOST_LONG_BITS
> +        *hhigh = 0;
> +#else
> +        *hhigh = (unsigned long)thigh >> (HOST_LONG_BITS - TARGET_LONG_BITS);
> +#endif
> +#else
> +        *hlow = (unsigned long)tlow;
> +        *hhigh = (unsigned long)(tlow >> HOST_LONG_BITS);
> +#if TARGET_LONG_BITS < 2 * HOST_LONG_BITS
> +        *hhigh |= (unsigned long)thigh << (TARGET_LONG_BITS - HOST_LONG_BITS);
> +#endif
> +#endif
> +}

Why don't you try to de-construct then re-construct the offset?

Kernel commit
  601cc11d054a "Make non-compat preadv/pwritev use native register size"
is interesting.

static inline abi_llong target_pos_from_hilo(abi_ulong high,
                                             abi_ulong low)
{
#define TARGET_HALF_LONG_BITS (TARGET_LONG_BITS / 2)
   return (((abi_llong)high << TARGET_HALF_LONG_BITS) <<
                             TARGET_HALF_LONG_BITS) | low;
}

#define HOST_HALF_LONG_BITS (HOST_LONG_BITS / 2)

 abi_llong pos = target_pos_from_hilo(arg4, arg5);
 ret = get_errno(safe_preadv(arg1, vec, arg3,
          pos,
          (pos >> HOST_HALF_LONG_BITS) >> HOST_HALF_LONG_BITS));

It looks simpler, but perhaps I miss something
(it's just cut&paste, I don't pretend to understand that code...)?

Richard?

Thanks,
Laurent
