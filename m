Received: from eggs.gnu.org ([2001:4830:134:3::10]:55656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKiH5-0004EN-Hn
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKiH4-0000tl-Rn
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:14:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKiH4-0000tY-Lj
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:14:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id 192-v6so15817902oii.6
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 03:14:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541674784-25936-4-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-4-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 11:14:37 +0000
Message-ID: <CAFEAcA_sQOcDm8kyfRE7p4p7gdpGHf0HNhKY8K+npiOByG2ErQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] change int len to uin32_t len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> In order to support >= 2G initrd, we need to change len type from int to
> uin32_t.
>
> Below is the flow sample to show how qemu copy initrd from qemu
> side to VM when using optionroms bootlinux_dma.bin:
> dma_memory_read(uint32_t len)
>   -> dma_memory_rw(uint32_t len)
>     -> dma_memory_rw_relaxed(uint32_t len)
>       -> address_space_rw(int len) # len overflow
>         -> address_space_read_full(int len)
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Philip Li <philip.li@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

If we change this, then "uint32_t" is not the right type. If we
want to allow writes of large chunks of memory through this API
then the right type for the length of a chunk of guest memory
is "hwaddr".

The other way to approach this would be to say that devices
doing DMA mustn't try to do it in enormous chunks like this,
but need to split it up. If we had a coherent story for how
to avoid dma-engine device emulations from sitting in a loop
forever doing guest-requested DMA this would probably tie in
with that, as part of saying "don't do more than X amount of
work at a time without yielding control back to QEMU".

thanks
-- PMM
