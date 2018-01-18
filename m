Received: from eggs.gnu.org ([2001:4830:134:3::10]:48815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec9tU-00013m-BG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec9tR-0004wG-4b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:06:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ec9tQ-0004vg-RV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:06:09 -0500
Date: Thu, 18 Jan 2018 14:06:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180118140605.028b7e33@redhat.com>
In-Reply-To: <CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Thu, 18 Jan 2018 10:50:19 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 18 January 2018 at 10:43, Igor Mammedov <imammedo@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> >> That usage must want a different name, though, surely?
> >> For Arm the default CPU for linux-user is 'any' but that
> >> is usermode only and won't work for system emulation so
> >> null-machine.c will need to pick something else.  
> 
> > not really in general as boards set their own default types
> > and secondly it applies only to null-machine.
> > Though in both cases it work the same just fine because
> > current API works like this (system emulation)
> >  vl.c:
> >         current_machine->cpu_type = machine_class->default_cpu_type;
> >         if (cpu_model) {
> >             current_machine->cpu_type =
> >                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
> >             ...
> >         }
> >
> > which would result for null-machine (patch 20/24) in:
> >
> >        cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model):
> >             oc = cpu_class_by_name(TARGET_DEFAULT_CPU_TYPE, cpu_model):
> >                  cc = CPU_CLASS(object_class_by_name(TARGET_DEFAULT_CPU_TYPE))
> >                  cc->class_by_name(cpu_model)  
> 
> In system emulation we don't define the "any" cpu type
> at all, so I would expect cpu_class_by_name() to always
> return an error here.

My bad, 'make check' was fine but it looks like we don't test
null-machine with -cpu foo, I should add a patch for that
along with series on respin.

I've looked and such case is rather an exception,
I can fix it up in 2 ways:
1st:
  target/arm/cpu.h
  +#if !defined(CONFIG_USER_ONLY)
  +#define TARGET_DEFAULT_CPU_TYPE TYPE_ARM_CPU
  +else
  +#define TARGET_DEFAULT_CPU_TYPE ARM_CPU_TYPE_NAME("any")
  +#endif

or 2nd is to compile in "any" type in system mode
(which most targets do), roughly it would amount to:
  target/arm/cpu.c
  @@ -1671,10 +1671,8 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
     { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
     { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
  -#ifdef CONFIG_USER_ONLY
     { .name = "any",         .initfn = arm_any_initfn },
   #endif
  -#endif
     { .name = NULL }
   };

and it would allow us to drop/cleanup more ifdefs in target/arm/cpu.c
I'd prefer 2nd approach, so code would be more consistent
with other targets and as benefit with less ifdefs.

> thanks
> -- PMM
