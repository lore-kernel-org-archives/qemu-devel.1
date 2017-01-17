Received: from eggs.gnu.org ([2001:4830:134:3::10]:41902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUYP-0000dH-GT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUYL-0008VY-G9
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:16:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTUYL-0008VM-7K
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:16:01 -0500
Date: Tue, 17 Jan 2017 12:15:57 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117141557.GL3491@thinpad.lan.raisama.net>
References: <1484654591-11108-1-git-send-email-thuth@redhat.com>
	<20170117123217.GF3491@thinpad.lan.raisama.net>
	<1ed26b63-985f-0a68-dd19-e3c2a665b4e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed26b63-985f-0a68-dd19-e3c2a665b4e0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/core/null-machine: Add the
 possibility to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On Tue, Jan 17, 2017 at 02:10:35PM +0100, Thomas Huth wrote:
> On 17.01.2017 13:32, Eduardo Habkost wrote:
> > On Tue, Jan 17, 2017 at 01:03:11PM +0100, Thomas Huth wrote:
> >> Sometimes it is useful to have just a machine with CPU and RAM, without
> >> any further hardware in it, e.g. if you just want to do some instruction
> >> debugging for TCG with a remote GDB attached to QEMU, or run some embedded
> >> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
> >> features a "dummy" machine, and xtensa a "sim" machine for exactly this
> >> purpose.
> >> All target architectures have nowadays also a "none" machine, which would
> >> be a perfect match for this, too - but it currently does not allow to add
> >> CPU, RAM or a kernel yet. Thus let's add these possibilities in a generic
> >> way to the "none" machine, too, so that we hopefully do not need additional
> >> "dummy" machines in the future anymore (and maybe can also get rid of the
> >> already existing "dummy"/"sim" machines one day).
> >> Note that the default behaviour of the "none" machine is not changed, i.e.
> >> no CPU and no RAM is instantiated by default. You've explicitely got to
> >> specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
> >> these new features.
> >> We also introduce a wrapper called cpu_init_def() for the target-specific
> >> macro cpu_init() in cpus.c here, so we can continue to compile the file
> >> null-machine.c independently from the target.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  v2:
> >>  - Use the generic-loader device for providing the functionality of
> >>    the "-kernel" parameter
> > 
> > Peter argued in v1 against providing a -kernel option that
> > doesn't have the same capabilities as the other machines in the
> > same architecture (I will continue the discussion there).
> 
> I'd prefer to use the generic loader for -kernel, but yes, let's
> continue that discussion in the other thread.
> 
> >>  - Make sure that null-machine.c can be compiled independent from the
> >>    target (by introducing a wrapper function for cpu_init())
> > 
> > Most (or all?) architectures should work if you use
> > cpu_generic_init(). I wonder how many architectures don't use
> > cpu_generic_init() to implement cpu_init() yet.
> 
> I wanted to use cpu_generic_init() first, but that does not work for
> machine "none", since that function needs a "typename" parameter beside
> the "cpu_model", and I don't see any way to get hold of the correct
> string for that typename parameter in generic code like null-machine.c.

Oops, you're right.

> Do you see any possibility to do that here?

This kind of information could be provided by arch_init.c, but
currently that file is a bit messy. I will try to clean it up,
but we will still need something that works in the meantime.

> 
> >>
> >>  cpus.c                 |  5 +++++
> >>  hw/core/null-machine.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >>  include/qom/cpu.h      | 11 +++++++++++
> >>  3 files changed, 54 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/cpus.c b/cpus.c
> >> index 5213351..7c4dc38 100644
> >> --- a/cpus.c
> >> +++ b/cpus.c
> >> @@ -80,6 +80,11 @@ static unsigned int throttle_percentage;
> >>  #define CPU_THROTTLE_PCT_MAX 99
> >>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
> >>  
> >> +CPUState *cpu_init_def(const char *cpu_model)
> >> +{
> >> +    return cpu_init(cpu_model);
> >> +}
> >> +
> > 
> > So, now we have two interfaces to do exactly the same thing:
> > cpu_init() and cpu_init_def(). But cpu_init() is a macro and
> > cpu_init_def() is a function. cpu_init() is available only if you
> > include cpu.h, but cpu_init_def() is available elsewhere.
> > Ideally, code should be able to simply call a cpu_init()
> > function, and it should work the same everywhere.
> > 
> > In practice, cleaning this up might take a while, so
> > cpu_init_def() might be a temporary solution. But now I am not
> > sure if having this additional wrapper is better than simply
> > making null-machine.o target-dependent like you did before.
> 
> I don't mind either way ...
> Does anybody else got an opinion on this problem?

Well, it's not the first time we have arch-dependent code in
hw/core, so I think it should be OK to move it to
obj-$(CONFIG_SOFTMMU) to keep things simpler.

-- 
Eduardo
