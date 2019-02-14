Received: from eggs.gnu.org ([209.51.188.92]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLPF-0001Mm-Qt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLES-0008P2-4C
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:55:33 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:39892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLEO-0008G1-2j
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:55:29 -0500
Received: by mail-ot1-x335.google.com with SMTP id n8so11995838otl.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20190128181047.20781-1-peter.maydell@linaro.org>
	<20190128181047.20781-10-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-10-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:55:08 +0000
Message-ID: <CAFEAcA8tinUgkBxmUe0-WNcaYStu0=6HsXwejQdOZ=L8ZSygXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 09/26] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Aaron Lindsay <Aaron@os.amperecomputing.com>

On Mon, 28 Jan 2019 at 18:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
>
> A bug was introduced during a respin of:
>
>         commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
>         target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0



> @@ -1113,13 +1115,16 @@ uint64_t get_pmceid(CPUARMState *env, unsigned which)
>          /* We do not currently support events in the 0x40xx range */
>          assert(cnt->number <= 0x3f);
>
> -        if ((cnt->number & 0x20) == (which << 6) &&
> -                cnt->supported(env)) {
> -            pmceid |= (1 << (cnt->number & 0x1f));
> +        if (cnt->supported(&cpu->env)) {
>              supported_event_map[cnt->number] = i;
> +            uint64_t event_mask = 1 << (cnt->number & 0x1f);

Coverity complains about this line (CID 1398645). The
RHS is evaluated using 32-bit signed arithmetic (because
cnt->number is uint16_t and so integer promotion means it
ends up working with the 'int' type. If cnt->number is
31 then this means that the assignment will do an
unintended sign-extension that sets the top 32 bits
of event_mask.

Fix is probably just to use "1ULL" instead of "1" on the LHS of <<.


> +            if (cnt->number & 0x20) {
> +                cpu->pmceid1 |= event_mask;
> +            } else {
> +                cpu->pmceid0 |= event_mask;
> +            }
>          }
>      }
> -    return pmceid;
>  }

thanks
-- PMM
