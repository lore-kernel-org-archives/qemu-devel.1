Received: from eggs.gnu.org ([2001:4830:134:3::10]:35517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDaSu-0005ch-KT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDaSt-0000RB-Ik
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 15:29:44 -0400
Date: Fri, 19 Oct 2018 15:29:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181019192932.GA17761@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<f7067d72-3b2a-9e6e-4636-f18ac1cf5202@redhat.com>
	<20181019145018.GB7279@flamenco>
	<6190036c-cd1f-4549-9b7e-9e7913c972d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6190036c-cd1f-4549-9b7e-9e7913c972d4@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 0/56] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On Fri, Oct 19, 2018 at 18:01:18 +0200, Paolo Bonzini wrote:
> On 19/10/2018 16:50, Emilio G. Cota wrote:
> > On Fri, Oct 19, 2018 at 08:59:24 +0200, Paolo Bonzini wrote:
> >> On 19/10/2018 03:05, Emilio G. Cota wrote:
> >>> I'm calling this series a v3 because it supersedes the two series
> >>> I previously sent about using atomics for interrupt_request:
> >>>   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02013.html
> >>> The approach in that series cannot work reliably; using (locked) atomics
> >>> to set interrupt_request but not using (locked) atomics to read it
> >>> can lead to missed updates.
> >>
> >> The idea here was that changes to protected fields are all followed by
> >> kick.  That may not have been the case, granted, but I wonder if the
> >> plan is unworkable.
> > 
> > I suspect that the cpu->interrupt_request+kick mechanism is not the issue,
> > otherwise master should not work--we do atomic_read(cpu->interrupt_request)
> > and only if that read != 0 we take the BQL.
> > 
> > My guess is that the problem is with other reads of cpu->interrupt_request,
> > e.g. those in cpu_has_work. Currently those reads happen with the
> > BQL held, and updates to cpu->interrupt_request take the BQL. If we drop
> > the BQL from the setters to instead use locked atomics (like in the
> > aforementioned series), those BQL-protected readers might miss updates.
> 
> cpu_has_work is only needed to handle the processor's halted state (or
> is it?).  If it is, OR+kick should work.
> 
> > Given that we need a per-CPU lock anyway to remove the BQL from the
> > CPU loop, extending this lock to protect cpu->interrupt_request is
> > a simple solution that keeps the current logic and allows for
> > greater scalability.
> 
> Sure, I was just curious what the problem was.  KVM uses OR+kick with no
> problems.

I never found exactly where things break. The hangs happen
pretty early when booting a large (-smp > 16) x86_64 Ubuntu guest.
Booting never completes (ssh unresponsive) if I don't have the
console output (I suspect the console output slows things down
enough to hide some races). I only see a few threads busy:
a couple of vCPU threads, and the I/O thread.

I didn't have time to debug any further, so I moved on
to an alternative approach.

So it is possible that it was my implementation, and not the approach,
what was at fault :-)

Thanks,

		E.
