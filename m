Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb48r-0005hw-Pn
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb48q-0006ES-P6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:41:01 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb48q-0006Ci-HQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:41:00 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so150665611wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:41:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170121084600.5860-1-ale+qemu@clearmind.me>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 11:40:38 +0000
Message-ID: <CAFEAcA_RLBgpOg2eBGujSGOduAOp8VpaaE6EfM6D+j05AMxquw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Preparing the build system for
 libtcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 January 2017 at 08:45, Alessandro Di Federico
<ale+qemu@clearmind.me> wrote:
> This series of patches introduce a set of changes, mainly to the QEMU
> build system, to open the way to implementing "libtcg", i.e., using
> QEMU's tiny code generator frontends as a library.
>
> For the initial proposal, please see the related discussion:
>
> http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg04847.html
>
> The idea is to build a PIC version of QEMU embedding only what's
> required to use the TCG frontend (typically
> target/$arch/translate.c). To achieve this, some functions have been
> moved out of translate.c to reduce the coupling with the other object
> files.
>
> All the configurations available on Linux and FreeBSD still build fine
> (without warnings).
>
> The last commit also introduces the libtcg/ directory and a series of
> *-libtcg targets (similar to the *-{bsd,linux}-user) with the bare
> minimum skeleton for the actual implementation and some dummy references
> to some functions that in my previous implementation of libtcg were
> required, to make sure that all the required object files are linked in.

So I guess my question here is: how are we defining the boundary
between libtcg and everything else? How do we disentangle or
abstract away cleanly the parts of a guest CPU frontend that are
annoyingly tightly coupled to the rest of the system model? Some
examples:
 * CPU instructions for reading timers (either cycle counts,
   or real-time timers)
 * CPU instructions that need to update interrupt controller
   state (the ARM M profile CPUs have a bunch of these, as
   do GICv3 ARM CPUs)
 * CPUs where some CPU state is accessed via memory mapped
   registers (again, M profile CPUs have a lot of that)

I think this is overall a good idea but I think I'll find it
easier to review if I have a more solid idea of the design
principles and where we're trying to draw dividing lines
in the tricky cases.

thanks
-- PMM
