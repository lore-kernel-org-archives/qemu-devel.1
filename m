Received: from eggs.gnu.org ([209.51.188.92]:51163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghc5Y-0003eH-T9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghc5S-0007uA-NA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:17:44 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghc5M-0007or-0f
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:17:34 -0500
References: <20181219042113.7364-1-richard.henderson@linaro.org>
	<20181219042113.7364-5-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4e89a2dd-47fb-29ac-aff2-5d506e3deebb@vivier.eu>
Date: Thu, 10 Jan 2019 16:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181219042113.7364-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/8] linux-user: Split out preadv,
 pwritev, readv, writev, pread64, pwrite64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 19/12/2018 05:21, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall-defs.h     |  14 ++++
>  linux-user/syscall-file.inc.c | 124 ++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c          |  93 -------------------------
>  linux-user/strace.list        |  18 -----
>  4 files changed, 138 insertions(+), 111 deletions(-)
> 
...
> diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
> index 11e75044c1..410a763eee 100644
> --- a/linux-user/syscall-file.inc.c
> +++ b/linux-user/syscall-file.inc.c
> @@ -315,6 +315,104 @@ SYSCALL_IMPL(openat)
...
> +
> +/*
> + * Both preadv and pwritev merge args 4/5 into a 64-bit offset.
> + * Moreover, the parts are *always* in little-endian order.
> + */
> +#if TARGET_ABI_BITS == 32
> +SYSCALL_ARGS(preadv_pwritev)
> +{
> +    /* We have already assigned out[0-2].  */
> +    abi_ulong lo = in[3], hi = in[4];
> +    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
> +    return def;
> +}
> +#else
> +#define args_preadv_pwritev NULL
> +#endif
> +
> +/* Perform the inverse operation for the host.  */
> +static inline void host_offset64_low_high(unsigned long *l, unsigned long *h,
> +                                          uint64_t off)
> +{
> +    *l = off;
> +    *h = (off >> (HOST_LONG_BITS - 1)) >> 1;
> +}


I have an error with preadv() on a 32bit target (powerpc, LTP test preadv02).

It works if I use:

static inline void host_offset64_low_high(unsigned long *hlow,
                                          unsigned long *hhigh,
                                          abi_ulong tlow,
                                          abi_ulong thigh)
{
    uint64_t off = tlow |
                   ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
                   TARGET_LONG_BITS / 2;
    
    *hlow = off;
    *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
}



> +
> +SYSCALL_IMPL(preadv)
> +{
> +    struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
> +    unsigned long lo, hi;
> +    abi_long ret;
> +
> +    if (vec == NULL) {
> +        return -host_to_target_errno(errno);
> +    }
> +
> +    host_offset64_low_high(&lo, &hi, arg4);
> +    ret = get_errno(safe_preadv(arg1, vec, arg3, lo, hi));
> +    unlock_iovec(vec, arg2, arg3, 1);
> +    return ret;
> +}
> +
> +SYSCALL_IMPL(pwritev)
> +{
> +    struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
> +    unsigned long lo, hi;
> +    abi_long ret;
> +
> +    if (vec == NULL) {
> +        ret = -host_to_target_errno(errno);

           return -host_to_target_errno(errno);

> +    }
> +
> +    host_offset64_low_high(&lo, &hi, arg4);
> +    ret = get_errno(safe_pwritev(arg1, vec, arg3, lo, hi));
> +    unlock_iovec(vec, arg2, arg3, 0);
> +    return ret;
> +}
> +
>  SYSCALL_IMPL(read)
>  {
>      abi_long ret;
