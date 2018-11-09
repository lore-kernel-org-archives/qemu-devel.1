Received: from eggs.gnu.org ([2001:4830:134:3::10]:45732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gL15z-0008Cr-Cv
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mingo.kernel.org@gmail.com>) id 1gL15v-0005NB-4F
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:20:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mingo.kernel.org@gmail.com>)
	id 1gL15m-0004wd-G4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:20:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id b203-v6so969598wme.5
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 23:20:20 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 9 Nov 2018 08:20:15 +0100
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <20181109072015.GA86700@gmail.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>


* Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> > If the kernel initrd creation process creates an initrd which
> > is larger than 2GB and also claims that it can't be placed
> > with any part of it above 2GB, then that sounds like a bug
> > in the initrd creation process...
> 
> Exactly, it's a real problem.
> 
> Add x86 maintainers and LKML:
> 
> The background is that QEMU want to support up to 4G initrd. but linux header (
> initrd_addr_max field) only allow 2G-1.
> Is one of the below approaches reasonable:
> 1) change initrd_addr_max to 4G-1 directly simply(arch/x86/boot/header.S)?
> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header said 2G-1
> 3) any else

A 10 years old comment from hpa says:

  initrd_addr_max: .long 0x7fffffff
                                        # (Header version 0x0203 or later)
                                        # The highest safe address for
                                        # the contents of an initrd
                                        # The current kernel allows up to 4 GB,
                                        # but leave it at 2 GB to avoid
                                        # possible bootloader bugs.

To avoid the potential of bugs lurking in dozens of major and hundreds of 
minor iterations of various Linux bootloaders I'd prefer a real solution 
and extend it - because if there's a 2GB initrd for some weird reason 
today there might be a 4GB one in two years.

The real solution would be to:

 - Extend the boot protocol with a 64-bit field, named initrd_addr64_max 
   or such.

 - We don't change the old field - but if the new field is set by new
   kernels then new bootloaders can use that as a new initrd_addr64_max
   value. (or reject to load the kernel if the address is too high.)

 - The kernel build should also emit a warning when building larger than 
   2GB initrds, with a list of bootloaders that support the new protocol.

Or something along those lines.

Thanks,

	Ingo
