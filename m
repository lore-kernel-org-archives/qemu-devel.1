Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9ral-0002c5-MT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9rak-0007aI-I0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:58:27 -0400
Date: Tue, 9 Oct 2018 14:57:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181009125747.GS4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA8PHLZGfYpwU=zsG8eZ==hWu-b9CLJ_7Z+8+C5YvgZfuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8PHLZGfYpwU=zsG8eZ==hWu-b9CLJ_7Z+8+C5YvgZfuQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/12] arm: Add first models of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Mon, Oct 08, 2018 at 03:08:14PM +0100, Peter Maydell wrote:
> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > In QEMU we'd like to have a virtual developer board with the Versal SoC
> > and a selected set of peripherals under the control of QEMU.
> > We'd like to gradually extend this board as QEMU gains more support
> > for Versal hardware components. QEMU will generate a device-tree
> > describing only the components it supports and includes in the virtual
> > dev board.
> 
> So, the SoC implementation and the GEM and HVC bugfix patches
> here are straightforward. What I'm less sure about is the "virtual"
> nature of the board model. What do we gain doing this rather than
> just modelling some particular Versal dev board?
> 
> At the moment we have a fairly clear distinction:
>  * most machine models are models of real hardware, and the
>    real hardware is the litmus test for how things are supposed
>    to work (and, like real hardware, the user provides the DTB)
>  * the "virt" board is special, because it is purely virtual and
>    contains only a few specific devices, so it can run Linux guests
> 
> This would seem to be an odd hybrid, with an SoC that's a model
> of real hardware but also some virtual "QEMU controls what's
> present and creates the dtb" aspects.


Hi Peter,

This is a good question.

There're a few issues we see that we think this approach will help to solve
or at least mitigate.

The Versal architecture will be a family of chips (same as ZynqMP). Each
tapeout and board comes with a set of physical limitations. I.e due to
size/power/heat and other constraints not everything that the architecture
has can be available everywhere. For example a specific board may only
enable one GEM.

We'd like to have a QEMU board that doesn't get limited by these physical
constrains but instead, with time, can grow to the full potential even
though there may not be tapeouts nor boards at this given point in time
that have it all.

Another problem that we've seen with the ZynqMP is that users struggle
to run stuff on QEMU because we don't support the full set of devices
needed to run everything that you can run on a real board. So we need
to create "QEMU" device-trees that contain the subset that QEMU supports.
These dtbs then float around and mixing and matching versions becomes a problem.
If QEMU generates the a device tree on the fly, we hope to avoid that
problem. Note that this board still accepts a dtb on the command-line if
users really want to pass one.


At the moment, Versal only exists in FPGA based emulation boards.
These implementations are flexible in that different configurations can
be re-programmed onto the FPGAs at any time.
>From my perspective, the name of the board is not so important. We can
call it Xilinx Versal QEMU Developer board, Xilinx Versal Emulation Board,
or what ever but it would be nice to keep the characteristics of an
phsyically unconstrained board and the auto-generated device-tree.

I hope that clarifies the intent.

Thanks and Best regards,
Edgar
