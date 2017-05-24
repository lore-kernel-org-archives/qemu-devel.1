Received: from eggs.gnu.org ([2001:4830:134:3::10]:41780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDfRf-0005G9-S7
	for qemu-devel@nongnu.org; Wed, 24 May 2017 19:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDfRe-0005Ns-Tv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 19:11:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDfRe-0005Nj-Nj
	for qemu-devel@nongnu.org; Wed, 24 May 2017 19:11:58 -0400
Received: by mail-qk0-x243.google.com with SMTP id k74so28405344qke.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 16:11:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-6-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <41056516-562a-4155-dc90-01e24e467c45@twiddle.net>
Date: Wed, 24 May 2017 16:11:55 -0700
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-6-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/sh4: fix RTE instruction delay
 slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 03:47 PM, Aurelien Jarno wrote:
> The ReTurn from Exception (RTE) instruction loads the system register
> (SR) with the saved system register (SSR). It has a delay slot, and
> behaves specially according to the SH4 manual:
> 
>    The SR value accessed by the instruction in the RTE delay slot is the
>    value restored from SSR by the RTE instruction. The SR and MD values
>    defined prior to RTE execution are used to fetch the instruction in
>    the RTE delay slot.
> 
> The instruction in the delay slot being often a NOP, it doesn't cause
> any issue most of the time except in some rare cases where the NOP is
> being splitted in a different TB (for example when the TCG op buffer
> is full). In that case the NOP is fetched with the user permissions
> and causes an instruction TLB protection violation exception.
> 
> This patches fixes that by introducing a new delay slot flag for the
> RTE instruction. Given it's a privileged instruction, the RTE delay
> slot instruction is always fetched in privileged mode. It is therefore
> enough to to check for this flag in cpu_mmu_index.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.h       | 13 ++++++++++---
>   target/sh4/translate.c |  8 ++++++--
>   2 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
