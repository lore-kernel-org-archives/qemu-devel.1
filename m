Received: from eggs.gnu.org ([2001:4830:134:3::10]:37436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec7fV-00072g-JG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ec7fR-0001vG-LC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ec7fR-0001uV-Cx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:33 -0500
Date: Thu, 18 Jan 2018 11:43:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180118114330.53ad7ce7@redhat.com>
In-Reply-To: <CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
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

On Wed, 17 Jan 2018 20:30:14 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 17 January 2018 at 19:15, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Wed, 17 Jan 2018 16:12:09 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> >> I like moving this from being an ifdef ladder into per-cpu
> >> code, but I don't think the definition belongs in target/$ARCH.
> >> It's part of the choice usermode makes about how to handle
> >> binaries it's loading, so it should go in linux-user/$ARCH/target_cpu.h.
> >> target/$ARCH should really be for things that are properties
> >> of the architecture.  
> > That's used not only by linux-user but also reused by null-machine.c
> > to get access to a target specific cpu_class_by_name() callback.  
> 
> That usage must want a different name, though, surely?
> For Arm the default CPU for linux-user is 'any' but that
> is usermode only and won't work for system emulation so
> null-machine.c will need to pick something else.
not really in general as boards set their own default types
and secondly it applies only to null-machine.
Though in both cases it work the same just fine because
current API works like this (system emulation)
 vl.c:
        current_machine->cpu_type = machine_class->default_cpu_type;             
        if (cpu_model) {                                                         
            current_machine->cpu_type =                                          
                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model); 
            ...
        }

which would result for null-machine (patch 20/24) in:

       cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model):
            oc = cpu_class_by_name(TARGET_DEFAULT_CPU_TYPE, cpu_model):
                 cc = CPU_CLASS(object_class_by_name(TARGET_DEFAULT_CPU_TYPE))
                 cc->class_by_name(cpu_model)
            
so it doesn't really matter for system emulation what exact
type is used as a proxy to reach callback, as each target
implements only one cb in base CPU class and any leaf class
will work fine to reach the same class_by_name() cb.
So type that is default for linux-user can be abused for
this purpose and could be used as linux-default at
the same time.

Ugly and hackish, yes.
But it isolates cpu_model handling to a few places and
series removes API that uses it, so we won't have to
watch out for patches that would bring cpu_model
back into boards code after that.

On top of that, we could work on making cpu_parse_cpu_model()
API not to require proxy cpu type and that would affect
only 3 remaining callers in vl.c,bsd/linux-user/main.c
But that another re-factoring beyond the scope of this series,
which is already big as it is.

> thanks
> -- PMM
