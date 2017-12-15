Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePufb-0005hR-O2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePufa-0004sg-OL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:25:15 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:39417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePufa-0004rk-IV
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:25:14 -0500
Received: by mail-ot0-x234.google.com with SMTP id v21so8548183oth.6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:25:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513355076-5075-1-git-send-email-peter.maydell@linaro.org>
References: <1513355076-5075-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 18:24:53 +0000
Message-ID: <CAFEAcA-0AxnDEnr6YcRGPMkNE5smgU3Rt+V5_jex9Z_vkFuWPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Handle page table
 walk load failures correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 15 December 2017 at 16:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> Instead of ignoring the response from address_space_ld*()
> (indicating an attempt to read a page table descriptor from
> an invalid physical address), use it to report the failure
> correctly.
>
> Since this is another couple of locations where we need to
> decide the value of the ARMMMUFaultInfo ea bit based on a
> MemTxResult, we factor out that operation into a helper
> function.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Now we've fixed the get-phys-addr functions to always report
> errors via the ARMMMUFaultInfo struct, it's pretty easy to
> detect and report external aborts on translation table walks.

Reading through the Arm ARM for an unrelated reason, I discovered
that this patch is necessary but not sufficient, because
external aborts on translation table walks for ATS instructions
are supposed to be reported as Data Aborts (unlike other
kinds of translation fault) -- see DDI0487B.a section D4.2.11.
So this patch is OK (reporting the abort in the PAR is no
worse than ignoring it completely and using a zero descriptor
value) but we should add another one after it that makes
do_ats_write() special-case fi->type == ARMFault_SyncExternal
and generate an exception.

I won't get to that until next year, though. (Need to
look up the various architecture versions to check whether
they all behave the same here.)

thanks
-- PMM
