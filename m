Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxC1-0000aV-DR
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxC0-00019Z-Ka
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:36:45 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-3-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <20e22e8b-c4ea-8e4c-b8d2-09f4af1f6ab2@twiddle.net>
Date: Mon, 5 Dec 2016 09:36:40 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] target-ppc: add mask_u128 routine
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

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> +#if defined(CONFIG_INT128)
> +FUNC_MASK(mask_u128, Int128, 128, Int128, ~((__uint128_t)0));
> +#else
> +static inline Int128 mask_u128(int start, int end)
> +{
> +    Int128 r = {0};
> +    if (start > 63) {
> +        r.hi = 0;
> +        r.lo = mask_u64(start - 64, end - 64);
> +    } else if (end < 64) {
> +        r.hi = mask_u64(start, end);
> +        r.lo = 0;
> +    } else {
> +        r.hi = mask_u64(start, 63);
> +        r.lo = mask_u64(0, end - 64);
> +    }
> +    return r;
> +}
>  #endif

First, I would really really like you to stop adding *any* ifdefs on
CONFIG_INT128.  All that's going to do is make sure that there's code that is
almost never tested, since x86_64 (and other 64-bit hosts) does support int128.

Second, you're not using the Int128 interface correctly.  Better would be

static inline Int128 mask_u128(int start, int end)
{
    uint64_t hi, lo;
    if (start > 63) {
        hi = 0;
        lo = mask_u64(start - 64, end - 64);
    } else if (end < 64) {
        hi = mask_u64(start, end);
        lo = 0;
    } else {
        hi = mask_u64(start, 63);
        lo = mask_u64(0, end - 64);
    }
    return make_int128(lo, hi);
}


r~
