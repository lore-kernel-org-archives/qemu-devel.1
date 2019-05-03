Received: from eggs.gnu.org ([209.51.188.92]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYzH-0005U7-8h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYzF-0003dB-LP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:31 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYzF-0003ch-FY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id o39so5408308ota.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<3afc2ab8-c6b6-7157-e744-e742b384b0da@vivier.eu>
In-Reply-To: <3afc2ab8-c6b6-7157-e744-e742b384b0da@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:16:16 +0100
Message-ID: <CAFEAcA_RCS0=1057PDeSfDtsiPK6V4HYKmZYDo0jJ_nokWDo_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "patches@linaro.org" <patches@linaro.org>

On Wed, 12 Dec 2018 at 20:43, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 10/12/2018 17:56, Peter Maydell wrote:
> > This patchset converts the m68k target from the deprecated
> > unassigned_access hook to the new transaction_failed hook.
> > It's RFC for a couple of reasons:
> >  * it's untested, since I don't have an m68k test image
> >  * the second patch just makes "bus error while trying to
> >    read page tables" be treated as a page fault, when it
> >    should probably cause a fault reporting it as a bus error
> >    of some kind
> >  * I don't understand why the old unassigned_access hook
> >    set the ATC bit in the MMU SSW, since the docs I have say
> >    this should be set if the fault happened during a table
> >    search, but cleared if it's just an ordinary bus-errored
> >    data or insn access. Probably this is a pre-existing bug?
> >
> > Anyway, I send it out as a skeleton for comments, because
> > it would be nice to get rid of the old unassigned_access
> > hook, which is fundamentally broken (it's still used by m68k,
> > microblaze, mips and sparc).
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (3):
> >   target/m68k: In dump_address_map() check for memory access failures
> >   target/m68k: In get_physical_address() check for memory access
> >     failures
> >   target/m68k: Switch to transaction_failed hook
> >
> >  target/m68k/cpu.h       |  7 ++--
> >  target/m68k/cpu.c       |  2 +-
> >  target/m68k/helper.c    | 84 ++++++++++++++++++++++++++++++++---------
> >  target/m68k/op_helper.c | 20 ++++------
> >  4 files changed, 80 insertions(+), 33 deletions(-)
> >
>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
>
> I'll try to review this later...

Ping! Are we at "later" yet ? :-)

I checked with the mbox of the series from
https://patchew.org/QEMU/20181210165636.28366-1-peter.maydell@linaro.org/
and it still applies cleanly to master.

thanks
-- PMM
