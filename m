Received: from eggs.gnu.org ([2001:4830:134:3::10]:34910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqzAk-0008Fh-Vp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqzAh-0005fa-TC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:41:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eqzAh-0005fG-IS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:41:15 -0500
Date: Wed, 28 Feb 2018 11:41:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180228114111.62689e8c@redhat.com>
In-Reply-To: <CAHNT7Nsc+Ovbm1ZZKv75FfN78tudWYgPqu3SsUzCv1XtG0ZMhw@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<20180227170018.6e4a3b0d@redhat.com>
	<CAHNT7Nsc+Ovbm1ZZKv75FfN78tudWYgPqu3SsUzCv1XtG0ZMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [patches] Re:  [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: RISC-V Patches <patches@groups.riscv.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, 28 Feb 2018 13:41:25 +1300
Michael Clark <mjc@sifive.com> wrote:

> On Wed, Feb 28, 2018 at 5:00 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 27 Feb 2018 14:01:05 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:  
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > >
> > > > The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5a  
> > f8c5c2a6d0:  
> > > >
> > > >   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07  
> > +0000)  
> > > >
> > > > are available in the git repository at:
> > > >
> > > >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v7
> > > >
> > > > for you to fetch changes up to 170a9d412ca1eb3b7ae6f6c1ff86dc  
> > bdff0fd7a8:  
> > > >
> > > >   RISC-V Build Infrastructure (2018-02-27 11:09:43 +1300)
> > > >
> > > > - ----------------------------------------------------------------
> > > > QEMU RISC-V Emulation Support (RV64GC, RV32GC)  
> > >
> > > Hi; thanks for this pull request. Unfortunately it seems to
> > > be missing Signed-off-by: tags. Every commit needs to have
> > > the Signed-off-by: tags from the people who contributed code to
> > > it, indicating that they're OK with the code going into QEMU.
> > > (If the work was done by and copyright a company then you don't
> > > need to provide signoffs from every person at the company who
> > > worked on the code if you don't want to.)
> > >  
> > > > The spike_v1.9
> > > > machine has been renamed to spike_v1.9.1 to match the privileged ISA
> > > > version and spike_v1.10 has been made the default machine.  
> > >
> > > I'm confused about this. Generally QEMU boards should model
> > > hardware, and the board shouldn't care about the ISA versions.
> > > Versioned board names in QEMU generally follow _QEMU_'s versioning,
> > > and indicate that a board is identical to whatever we modelled
> > > in that earlier QEMU version, for VM migration compatibility.
> > > Board renames for minor ISA version bumps sounds like there's going
> > > to be a lot of churn and breakage -- is this stuff really ready?
> > > (Also, should we really have two different board source files
> > > for two different ISA versions? I would have expected these to
> > > share a source file to share code.)
> > >
> > > I did a test build and there are some compile errors:
> > >
> > > /home/pm215/qemu/linux-user/main.c:38:24: fatal error: target_elf.h:
> > > No such file or directory
> > >  #include "target_elf.h"
> > >                         ^
> > > compilation terminated.
> > >
> > > This is because your patchset has a clash with commit 542ca4349878a2e
> > > which has just merged to master, and refactors out an ifdef ladder,
> > > so now all targets supporting linux-user need to provide a
> > > linux-user/$ARCH/target_elf.h file. Could you fix that up and rebase,
> > > please?  
> > also '[PATCH v7 03/23] RISC-V CPU Core Definition' still hasn't addressed
> > comment http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06412.html
> > which isn't fixed since it was first pointed out (v4).
> >
> > I'd prefer that being fixed before merge so another people
> > won't have to clean it up later after original authors,
> > When they try to generalize cpu_type -> cpu_model conversion.
> >  
> 
> I re-read the email and it doesn't seem clear what you want us to do.
> I changed the CPU suffix to a prefix as you requested. The rest of the CPU
> initialisation is "modelled" on arm not sh4.
Not addressed comment is not related to CPU suffix, it's a separate issue.

I haven't had time to clean up that part of ARM cpu initialization yet,
so it still uses old approach, but you've been pointed to right
approach rather early (v4) but ignored it.

There is no point to use legacy approach with new patches
that could block other people and would force them to cleanup
before doing what they intended to do.

I've pointed to sh4 as example that you should use for new CPU
types internalization. Beside making RISC-V consistent with
direction that part of code moves to, it will also simplify patch.

Please ask if something still unclear.

> If you want to make a pull request, please use this branch:
> 
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v7
