Received: from eggs.gnu.org ([209.51.188.92]:46086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQ77-00069q-2b
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQ76-0004Wv-1A
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:55:29 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQ75-0004W8-Nn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:55:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so17351199otl.6
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 01:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-5-richard.henderson@linaro.org>
	<CAFEAcA9Yz53O1OiG-eN=0eCdnO=Lz+yJPUtqVxfFSb3rrG4TEg@mail.gmail.com>
	<ae0d3ea5-e7e1-da8e-9b10-4534a1ff9162@linaro.org>
In-Reply-To: <ae0d3ea5-e7e1-da8e-9b10-4534a1ff9162@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 09:55:14 +0000
Message-ID: <CAFEAcA9OuF=rdRBRpoXFG3r4_rntc-fRa2m2g=+w+cpfC1Vg1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/11] target/arm: Record the GP bit for a
 page in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 28 Jan 2019 at 21:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/22/19 5:26 AM, Peter Maydell wrote:
> >> +        guarded |= extract64(descriptor, 50, 1);  /* GP */
> >
> > Do we need to do the logical-OR here? Since this is a
> > block/page entry bit with no similar bit in the table
> > descriptors, there's no merging to be done (ie we
> > only execute this code once and 'guarded' will always
> > be 'false' before execution of the |=.)
>
> The document that I have has exactly one sentence about this, and does not
> specify whether the bit is akin to the page table attributes (which appear at
> every table level) or not.

Translation table descriptor formats come in four flavours:
 * Invalid
 * Table (which gives the address of the next level table)
 * Block (which gives the address of a large lump of memory)
 * Page (which gives the address of a page)

The GP bit documented to be in Block and Page entries, not
Table (which is how you've coded it).

> As written above, this will execute more than once.

I don't see how -- all the code paths forward from
"guarded |= extract64(descriptor, 50, 1);" reach a
"break" statement that terminates the loop, don't they?

thanks
-- PMM
