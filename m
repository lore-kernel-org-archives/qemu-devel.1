Received: from eggs.gnu.org ([209.51.188.92]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gk3z2-0008FS-3I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gk3z0-00012R-1P
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1gk3yx-0000tD-VE
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:29:04 -0500
Date: Thu, 17 Jan 2019 10:21:54 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20190117092154.tqmxptxg2aywqdeb@hawk.localdomain>
References: <20190114215225.GA16760@habkost.net>
	<CAL1e-=iBx0Dt=S5fyLs8v-XN+2Zmx5hb7StQBJhquUmmdw6uNA@mail.gmail.com>
	<20190116153011.GB14807@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116153011.GB14807@habkost.net>
Subject: Re: [Qemu-devel] Meaning of "-smp threads" on mips_malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Jan 16, 2019 at 01:30:11PM -0200, Eduardo Habkost wrote:
> On Tue, Jan 15, 2019 at 03:28:50AM +0100, Aleksandar Markovic wrote:
> > On Monday, January 14, 2019, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > Hi,
> > >
> > > I'm trying to refactor the SMP topology code in QEMU
> > 
> > 
> > >
> > Eduardo, I truly appreciate your interest in details of Malta
> > implementations, but before I answer your questions, could you please
> > outline the motivation and the current concept of your envisioned
> > refactoring of SMP, so that I have some picture of the whole context?
> 
> I don't have any concrete plans right now.  I'm trying to
> understand how existing code uses the -smp options, before
> deciding what to do.
> 
> My goal is to make features like
>   "[PATCH v1 0/5] Introduce cpu die topology and enable CPUID.1F for i386"
> easier, less intrusive, and less risky.
> 
> My current impression is that things will be better if we move
> the complex PC-specific topology rules from vl.c to PC-specific
> code.  Most of the other architectures seem to have different
> assumptions and expectations about -smp/cores/threads.
>

Yes. For example, if we start describing cpu topology for mach-virt
then, in order to maintain compatibility, we'll need these semantics

  -smp <n>   : sockets=1,cores=<n>,threads=1
 
And any other -smp incantation, attempting to describe the topology,
should enforce explicitly providing a value for each parameter. As
that's different behavior than what x86 does and what the common
-smp parsing code does, then we really need to refactor things and
push more down into machine code.

Also, if we could make these parameters machine and cpu properties,
instead of global variables, that would be a huge improvement.

Thanks for doing this :-)

drew
