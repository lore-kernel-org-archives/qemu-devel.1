Received: from eggs.gnu.org ([209.51.188.92]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubwK-0000Xl-14
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubwH-0003rD-RL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:45:55 -0500
Date: Fri, 15 Feb 2019 12:45:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190215124534.48cadc1e@Igors-MacBook-Pro.local>
In-Reply-To: <CAFEAcA8Jh6B+aOJMEAgQWhbuun6e5HSVRZ1+k5adO9PcgGua4g@mail.gmail.com>
References: <20190214140714.15738-1-imammedo@redhat.com>
	<CAFEAcA8Jh6B+aOJMEAgQWhbuun6e5HSVRZ1+k5adO9PcgGua4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] memory: use memory_region_init_ram() instead
 of memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 14 Feb 2019 18:30:37 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 14 Feb 2019 at 14:07, Igor Mammedov <imammedo@redhat.com> wrote:
> > Also some boards (ab)use memory_region_allocate_system_memory(), calling it several
> > times to allocate various fixed sized chunks of RAM and ROMs, which is problematic
> > to map to a single initial RAM Machine::memdev backend and is currently broken if
> > -mem-path points to a not hugepage pool.
> 
> These boards are buggy and we could fix them, if we wanted to
> keep the existing API. We should in that case add assertions
> that memory_region_allocate_system_memory() is called once and
> only once, which would let "make check" enforce the rule.
we can do this, but I'd rather remove memory_region_allocate_system_memory() API
altogether which looks like overkill for most boards and use simpler memory_region_init_ram().
Then boards that need numa/hugepages could be switched to newer memdev/device model
instead of using memory_region_init_ram() directly.

My end-goal in all this exercise is to switch initial RAM to frontend/backend
model and replace adhoc legacy numa memory code (-numa node,mem=size  & default numa splitting)
handling with a generic device or memdev based one.

> 
> thanks
> - PMM
