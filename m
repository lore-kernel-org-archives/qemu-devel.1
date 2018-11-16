Received: from eggs.gnu.org ([2001:4830:134:3::10]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gNbk0-0004h9-07
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gNbju-0002Kn-9o
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:52:47 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gNbjp-00024y-6B
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:52:41 -0500
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so19906337ljh.6
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 02:52:27 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
	<CAHmQWvA7fyCFz-qE2_B1SHH+29gns5m_tccLSwF_GTs52LV9Lw@mail.gmail.com>
	<CAFEAcA8601qTOVRJiMpe84w62ObpzvM-jeq5hLxhs9OFTvCskQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8601qTOVRJiMpe84w62ObpzvM-jeq5hLxhs9OFTvCskQ@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 16 Nov 2018 18:52:15 +0800
Message-ID: <CAHmQWvBjPR6498BZL1_BUiCtYFL-4cudixWHMf0_nUq1Upj_+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Fri, 16 Nov 2018 at 17:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 16 November 2018 at 08:23, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > Well, for the SMP booting, when GICv2 used, there is no problem, max
> > CPU number 8 can be booted, including all the three cases: kernel
> > only, UEFI+kernel and ATF+UEFI+kernel.
> >
> > But when GICv3 used, these two cases still work: kernel only, and
> > UEFI+kernel, but ATF+UEFI+kernel fails booting more than 4 cores with
> > GICv3.
> > The original ATF didn't support GICv3, so I added the support:
> > http://git.linaro.org/people/hongbo.zhang/atf-sbsa.git/log/?h=sbsa_gicv3
> >
> > Root cause of failing to boot more than 4 cores with ATF+UEFI+kernel
> > with my GICv3 enabled is due to this:
> > In QEMU, we have this defination
> > #define ARM_DEFAULT_CPUS_PER_CLUSTER 8
> > But in ATF, the defination is
> > #define PLATFORM_MAX_CPUS_PER_CLUSTER 4
> > So when we pass smp=6 for example, QEMU generates MPIDR showing all
> > the 6 cores are at cluster 0, but when ATF parses such MPIDR, the
> > function plat_core_pos_by_mpidr() in plat/qemu/topology.c returns
> > error since there should be no more cores than 4.
> >
> > I think we should change the definition in QEMU to 4, instead of
> > changing the ATF's, because I checked Cortext a57/a72/a73/a75 spec, it
> > says there are 4 cores max at one cluster.
>
> Architecturally 8 per cluster is entirely legal. This is
> an ATF limitation and there's an argument for fixing it there.
> However, since for this board we're trying to match what real
> hardware with these CPUs would look like, it does make sense
> to use the same number of CPUs per cluster as the hardware.
> If you want your board to instantiate 4 per cluster this is possible,
> and you don't need to change ARM_DEFAULT_CPUS_PER_CLUSTER.
> This value is only used if the board code does not set the
> cpu->mp_affinity value itself (it is the default, as the
> name suggests). So you can just make your board code set
> the mp_affinity up however you like, after the CPU object
> is created but before it is realized.
>
Get it, thanks.

> thanks
> -- PMM
