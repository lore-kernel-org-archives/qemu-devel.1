Received: from eggs.gnu.org ([209.51.188.92]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gufdH-00073L-Jz
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gufd7-0005my-8F
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:42:23 -0500
Date: Fri, 15 Feb 2019 16:42:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190215164209.54a6f747@Igors-MacBook-Pro.local>
In-Reply-To: <2d99aca8-5ed0-bea3-4a4f-7b2a8e89b049@redhat.com>
References: <20190214140714.15738-1-imammedo@redhat.com>
	<4d8518f7-5272-fc18-d5c7-20c4cafdf7e8@redhat.com>
	<20190215123317.6903b818@Igors-MacBook-Pro.local>
	<2d99aca8-5ed0-bea3-4a4f-7b2a8e89b049@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, qemu-arm@nongnu.org, jan.kiszka@web.de, atar4qemu@gmail.com

On Fri, 15 Feb 2019 15:48:43 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 15/02/19 12:33, Igor Mammedov wrote:
> > On Thu, 14 Feb 2019 19:11:27 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> >> On 14/02/19 15:07, Igor Mammedov wrote:
> >>> Also some boards (ab)use memory_region_allocate_system_memory(), calling it several
> >>> times to allocate various fixed sized chunks of RAM and ROMs, which is problematic
> >>> to map to a single initial RAM Machine::memdev backend and is currently broken if
> >>> -mem-path points to a not hugepage pool.
> >>
> >> This is certainly a good idea.  However, I'm not sure why you would need
> >> a memdev property on the Machine instead of just allowing 1 -numa node,
> >> which is what really is.
> > 
> > using '-numa node' would be confusing to user when he/she is not interested in numa usecase
> > it also would enable numa fdt/acpi parts generated automatically (fixable but then again
> > it adds more to confusion) and in the end there are boards that do not support numa at all
> > (s390x).
> 
> Fair enough.
> 
> What about -m, too?  Then you'd specify a memdev instead of the initial
> memory size.
that somewhat what I've planned,
make -m X translate into -object memory-backend-ram,id=magically-get-what-board-uses-now,size=X -machine memdev=thatid

one more reason for memdev vs device is that -numa now uses memdevs and so far it
doesn't look that non-numa initial RAM would get immediate benefits from using -device
on most boards (well, I couldn't come up with any modulo backend/frontend consistent usage)

> 
> Paolo
> 
