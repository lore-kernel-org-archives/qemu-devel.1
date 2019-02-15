Received: from eggs.gnu.org ([209.51.188.92]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubkU-0002Ap-8v
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubkO-0003pu-0k
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:33:37 -0500
Date: Fri, 15 Feb 2019 12:33:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190215123317.6903b818@Igors-MacBook-Pro.local>
In-Reply-To: <4d8518f7-5272-fc18-d5c7-20c4cafdf7e8@redhat.com>
References: <20190214140714.15738-1-imammedo@redhat.com>
	<4d8518f7-5272-fc18-d5c7-20c4cafdf7e8@redhat.com>
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-arm@nongnu.org, jan.kiszka@web.de, atar4qemu@gmail.com

On Thu, 14 Feb 2019 19:11:27 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 14/02/19 15:07, Igor Mammedov wrote:
> > Also some boards (ab)use memory_region_allocate_system_memory(), calling it several
> > times to allocate various fixed sized chunks of RAM and ROMs, which is problematic
> > to map to a single initial RAM Machine::memdev backend and is currently broken if
> > -mem-path points to a not hugepage pool.
> 
> This is certainly a good idea.  However, I'm not sure why you would need
> a memdev property on the Machine instead of just allowing 1 -numa node,
> which is what really is.

using '-numa node' would be confusing to user when he/she is not interested in numa usecase
it also would enable numa fdt/acpi parts generated automatically (fixable but then again
it adds more to confusion) and in the end there are boards that do not support numa at all
(s390x).

Machine memdev (initial-ram-memdev) property looked generic enough to me that it could be
used with every board, but could go on a bit further and instead of memdev an add initial-ram
property that would reference something like -device builtin-ram (I think I've seen some board
using a sysbus based ram device for initial ram).
If you ask why it's machine property, then I'm following '-m' semantics which is basically
a machine property and I don't have a better idea how to tell board on CLI to use some
device/memdev as initial ram.


> Thanks,
> 
> Paolo
> 
