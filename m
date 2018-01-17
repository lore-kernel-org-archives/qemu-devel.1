Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebtBD-00071A-OR
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebtB8-0006N1-Sh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:15:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebtB8-0006MO-K2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:15:18 -0500
Date: Wed, 17 Jan 2018 20:15:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180117201515.1a49fcbf@redhat.com>
In-Reply-To: <CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
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

On Wed, 17 Jan 2018 16:12:09 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 17 January 2018 at 15:43, Igor Mammedov <imammedo@redhat.com> wrote:
> > Series is finishing work on generalizing cpu_model parsing
> > and limiting parts that deal with inconsistent cpu_model
> > naming to "-cpu" CLI option processing in vl.c/*-user.main.c
> > and FOO_cpu_class_by_name() callbacks.
> >
> > It introduces TARGET_DEFAULT_CPU_TYPE which must be defined
> > by each target and is used setting default cpu type for
> > linux/bsd-user targets and as anchor point to pick cpu class
> > that provides target specific FOO_cpu_class_by_name()
> > callback for cpu_parse_cpu_model() in null-machine.c
> > which is compiled for all targets that have system
> > mode emulation.  
> 
> I like moving this from being an ifdef ladder into per-cpu
> code, but I don't think the definition belongs in target/$ARCH.
> It's part of the choice usermode makes about how to handle
> binaries it's loading, so it should go in linux-user/$ARCH/target_cpu.h.
> target/$ARCH should really be for things that are properties
> of the architecture.
That's used not only by linux-user but also reused by null-machine.c
to get access to a target specific cpu_class_by_name() callback.
I admit that it's a convoluted API i.e. for cpu_parse_cpu_model()
to require a target specific CPU type to resolve cpu_model name,
but that's what we ended up with and have now.
It seemed logical to me to put YET_ANOTHER_CPU_TYPE to
target/$ARCH/cpu.h along with other target specific CPU type
macros'. 

Main goal of this series is not TARGET_DEFAULT_CPU_TYPE and
its abuse by null-machine.c, but rather getting rid of
cpu_model handling across whole tree (which is easy to misuse
due to existing APIs and its general availability) and limiting
cpu_model translation to option parsing+target specific
cpu_class_by_name() callbacks.

We can build on top of that linux-user specific extension
to pick CPU type based on ELF notes, the difference would
be that it will work with cpu types and not with cpu_model
as it were implemented in:
  [PATCH v3 0/4] linux-user: select CPU type according  ELF header values

> thanks
> -- PMM
