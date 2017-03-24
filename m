Received: from eggs.gnu.org ([2001:4830:134:3::10]:50770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crM7I-0001iY-73
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crM7H-0000pu-Ad
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:06:44 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crM7H-0000pk-45
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:06:43 -0400
Received: by mail-wr0-x231.google.com with SMTP id u1so6060761wra.2
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:06:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C94A741879221447B4FC9B607EB4FFCD79EA7BA3@DGGEMA504-MBX.china.huawei.com>
References: <1459777195-7907-1-git-send-email-vijayak@caviumnetworks.com>
	<1459777195-7907-3-git-send-email-vijayak@caviumnetworks.com>
	<CAFEAcA_755uEOZoGj0SCtmT-5PyLMntkK3wZeuHvZ_kPG9A1aQ@mail.gmail.com>
	<5703D7EE.2000005@redhat.com>
	<CAFEAcA8G_-jQOtnVag2Ef++RbfbEJ-XzNnyYM=o9Sh8c6ohecA@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EA34F4@DGGEMA504-MBX.china.huawei.com>
	<CAJhHMCDDu_kEJichH=60N=np+ZKbU1e9bWK-pP9Z-9=Fn4w1_w@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EA7BA3@DGGEMA504-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 10:06:21 +0000
Message-ID: <CAFEAcA_0UA1hnP9XVBn8w0B66eyR12GnnUoCOxjirPSDgHcHvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [patch 1/1]about armv8's prefetch decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wangjintang <wangjintang@huawei.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, "Shlomo Pongratz (A)" <shlomo.pongratz@huawei.com>, "Wanghaibin (Benjamin)" <benjamin.wanghaibin@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, "Ori Chalak (A)" <Ori.Chalak@huawei.com>

On 24 March 2017 at 06:14, Wangjintang <wangjintang@huawei.com> wrote:
> Hi Pranith,
>
>         Thanks for your reply. patch as below, new added code default is off, please review.
> The major thinking is about translate Armv8's prefetch instruction into intermediate code, at the same time don't effect the rm/rn register.
>
>
> diff --git a/translate-a64.c b/translate-a64.c
> index 814f30f..86da8ee 100644
> --- a/translate-a64.c
> +++ b/translate-a64.c
> @@ -2061,7 +2061,11 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
>      } else {
>          if (opc == 3) {
>              /* PRFM (literal) : prefetch */
> +            #ifdef TCG_AARCH64_PREFETCH_TRANSLATE
> +            ;
> +            #else
>              return;
> +            #endif
>          }

No, these changes look wrong. PRFM instructions do not need to
do anything and should definitely not be emitting any intermediate
code. In particular if you let execution fall through and try
do_gpr_ld() then it will really do a load, which might cause
an exception -- this is specifically forbidden for PRFM.
Architecturally the ARM ARM says "it is valid for the PE to
treat any or all prefetch instructions as a NOP", which is
what QEMU does.

The existing code is correct. In general you should not
expect to be able to deduce the guest instructions from
the intermediate code representation.

thanks
-- PMM
