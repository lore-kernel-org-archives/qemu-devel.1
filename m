Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecAKq-0005o2-EV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecAKm-0005uA-Dj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ecAKm-0005t4-6u
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:24 -0500
Date: Thu, 18 Jan 2018 14:34:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180118143421.10499441@redhat.com>
In-Reply-To: <CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
	<20180118140605.028b7e33@redhat.com>
	<CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
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

On Thu, 18 Jan 2018 13:10:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 18 January 2018 at 13:06, Igor Mammedov <imammedo@redhat.com> wrote:
> > I've looked and such case is rather an exception,
> > I can fix it up in 2 ways:
> > 1st:
> >   target/arm/cpu.h
> >   +#if !defined(CONFIG_USER_ONLY)
> >   +#define TARGET_DEFAULT_CPU_TYPE TYPE_ARM_CPU
> >   +else
> >   +#define TARGET_DEFAULT_CPU_TYPE ARM_CPU_TYPE_NAME("any")
> >   +#endif  
> 
> This is weird, because TYPE_ARM_CPU isn't really
> a sensible thing to use for anything, so you've really set
> it up as a "this is only of any use for null-machine.c",
> in which case you should just do that in null-machine.c.
yep, that would be only for null-machine.c use as proxy type,
however null-machine.c is build for every target so this
proxy type can't be defined null-machine.c unless we resort
to ifdef ladder there.

How about adding to each $ARCH/cpu.h a null-machine dedicated
define:
  
  #define CPU_RESOLVING_TYPE TYPE_FOO_CPU

using that in null machine and renaming

TARGET_DEFAULT_CPU_TYPE to USERONLY_DEFAULT_CPU_TYPE

but I'd still keep it within $ARCH/cpu.h so we won't
have to create a bunch of new linux-user/$ARCH/target_elf.h
files just for that and duplicate it to bsd-user/$ARCH/target_elf.h

> thanks
> -- PMM
