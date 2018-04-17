Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8YWL-0001HU-9V
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8YWK-00062E-G5
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:52:13 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8YWK-0005z0-B3
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:52:12 -0400
Received: by mail-ot0-x243.google.com with SMTP id h55-v6so23082971ote.9
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:52:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOuPqTFJABMcDHmQcNoNZioBBJ8RcreeevsRfh5b46ZgKZLetw@mail.gmail.com>
References: <CAOuPqTFJABMcDHmQcNoNZioBBJ8RcreeevsRfh5b46ZgKZLetw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 22:51:51 +0100
Message-ID: <CAFEAcA8cWYPjN8sxCwzCXhNBucXyhCBMFDA-AJ2zUCr-FKLT1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] ARM memory barrier patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Henry Wertz <hwertz10@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 17 April 2018 at 22:32, Henry Wertz <hwertz10@gmail.com> wrote:
> Please find submitted a patch for ARM memory barriers.  This patch is
> against qemu-2.12-rc2 but I do believe it should apply for anything from
> 2.11.x to current. (the code being patched was added in for 2.11 series.)
>
>
> I found with qemu 2.11.x or newer that I would get an illegal instruction
> error running some Intel binaries on my ARM chromebook.  On investigation,
> I found it was quitting on memory barriers.
> qemu instruction:
> mb $0x31
> was translating as:
> 0x604050cc:  5bf07ff5  blpl     #0x600250a8
>
> After patch it gives:
> 0x604050cc:  f57ff05b  dmb      ish
>
> In short, I found INSN_DMB_ISH (memory barrier for ARMv7) appeared to be
> correct based on online docs, but due to some endian-related shenanigans it
> had to be byte-swapped to suit qemu; it appears INSN_DMB_MCR (memory barrier
> for ARMv6) also should be byte swapped  (and this patch does so).
> I have not checked for correctness of aarch64's barrier instruction.
>
> Signed-off-by: Henry Wertz <hwertz10@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Richard, did you want to take this via the tcg tree?

thanks
-- PMM
