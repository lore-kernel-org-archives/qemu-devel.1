Received: from eggs.gnu.org ([209.51.188.92]:54183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1guucU-0003mb-Ke
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 02:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1guucL-00065I-So
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 02:42:35 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:40001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1guucI-0005ft-8E
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 02:42:31 -0500
Received: by mail-lf1-x12f.google.com with SMTP id t14so8847282lfk.7
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 23:42:26 -0800 (PST)
Date: Sat, 16 Feb 2019 10:42:19 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-ID: <20190216104219.46069dd0@phystech.edu>
In-Reply-To: <CAFEAcA_WNz+=mxvyekHN0u9kSzw6QrmmF9Lz8LzjJaL125zanw@mail.gmail.com>
References: <CAFEAcA_WNz+=mxvyekHN0u9kSzw6QrmmF9Lz8LzjJaL125zanw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] coverity detected issue in contrib/elf2dmp/main.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 14 Feb 2019 18:58:46 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

Hi

> Hi; Coverity detected an issue in contrib/elf2dmp/main.c (CID
> 1398641). In this loop:
> 
>     for (; KernBase >= 0xfffff78000000000; KernBase -= PAGE_SIZE) {
>         nt_start_addr = va_space_resolve(&vs, KernBase);
>         if (!nt_start_addr) {
>             continue;
>         }
> 
>         if (*(uint16_t *)nt_start_addr == 0x5a4d) { /* MZ */
>             break;
>         }
>     }
> 
> we might end exiting with nt_start_addr == NULL, if we go all
> the way through the address range without finding anything
> and the loop terminates via the "KernBase >= 0xfffff78000000000"
> condition.
> 
> However, we don't check for this, so we will then segfault
> in pe_get_pdb_symstore_hash(), which assumes it's passed a non-NULL
> address.
> 
> I guess we should be checking for nt_start_addr == NULL at the
> end of the loop and treating it as a fatal error?

You're right. I will make a fix.

> 
> thanks
> -- PMM



-- 
Viktor Prutyanov
