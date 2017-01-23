Received: from eggs.gnu.org ([2001:4830:134:3::10]:56596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk1x-0000q3-Hn
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk1w-0005WW-P8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:11:53 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVk1w-0005WP-Ku
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:11:52 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so19427117qtc.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:11:52 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-17-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <119e5de6-388c-3b02-8797-fa8eb07ca8ad@twiddle.net>
Date: Mon, 23 Jan 2017 11:11:48 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 16/27] cputlb: add tlb_flush_by_mmuidx
 async routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> +/* Helper function to slurp va_args list into a bitmap
> + */
> +static inline unsigned long make_mmu_index_bitmap(va_list args)
> +{
> +    unsigned long bitmap = 0;
> +    int mmu_index = va_arg(args, int);
> +
> +    /* An empty va_list would be a bad call */
> +    g_assert(mmu_index > 0);
> +
> +    do {
> +        set_bit(mmu_index, &bitmap);
> +        mmu_index = va_arg(args, int);
> +    } while (mmu_index >= 0);
> +
> +    return bitmap;
> +}
> +

Why don't we just pass in this bitmap in the first place?  It's much better
than having to use varargs in tlb_flush_by_mmuidx...


r~
