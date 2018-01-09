Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwz4-0002XT-EK
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwyz-0007GQ-Ir
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:42:42 -0500
Date: Tue, 9 Jan 2018 17:42:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109174229.2dbfc34d.cohuck@redhat.com>
In-Reply-To: <20171211134740.8235-9-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 08/15] s390x/flic: make
 floating interrupts on TCG actually floating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Mon, 11 Dec 2017 14:47:33 +0100
David Hildenbrand <david@redhat.com> wrote:

> Move floating interrupt handling into the flic. Floating interrupts
> will now be considered by all CPUs, not just CPU #0. While at it, convert
> I/O interrupts to use a list and make sure we properly consider I/O
> sub-classes in s390_cpu_has_io_int().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/intc/s390_flic.c          | 144 ++++++++++++++++++++++++++++++++++++++++---
>  include/hw/s390x/s390_flic.h |  41 ++++++++++++
>  target/s390x/cpu.c           |   8 ---
>  target/s390x/cpu.h           |  22 -------
>  target/s390x/excp_helper.c   |  97 ++++++++++-------------------
>  target/s390x/interrupt.c     |  52 ++--------------
>  6 files changed, 212 insertions(+), 152 deletions(-)
> 

> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index d0538134b7..9be0b9ab11 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -16,6 +16,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/s390x/adapter.h"
>  #include "hw/virtio/virtio.h"
> +#include "qemu/queue.h"
>  
>  /*
>   * Reserve enough gsis to accommodate all virtio devices.
> @@ -85,12 +86,52 @@ typedef struct S390FLICStateClass {
>  #define SIC_IRQ_MODE_SINGLE 1
>  #define AIS_MODE_MASK(isc) (0x80 >> isc)
>  
> +#define ISC_TO_PENDING_IO(_isc) (0x80 >> (_isc))
> +#define CR6_TO_PENDING_IO(_cr6) (((_cr6) >> 24) & 0xff)
> +
> +/* the ISC bits are organized in a way that above makros work */

/* organize the ISC bits so that the macros above work */

?

> +#define FLIC_PENDING_IO_ISC7            (1 << 0)
> +#define FLIC_PENDING_IO_ISC6            (1 << 1)
> +#define FLIC_PENDING_IO_ISC5            (1 << 2)
> +#define FLIC_PENDING_IO_ISC4            (1 << 3)
> +#define FLIC_PENDING_IO_ISC3            (1 << 4)
> +#define FLIC_PENDING_IO_ISC2            (1 << 5)
> +#define FLIC_PENDING_IO_ISC1            (1 << 6)
> +#define FLIC_PENDING_IO_ISC0            (1 << 7)
> +#define FLIC_PENDING_SERVICE            (1 << 8)
> +#define FLIC_PENDING_MCHK_CR            (1 << 9)
> +
> +#define FLIC_PENDING_IO (FLIC_PENDING_IO_ISC0 | FLIC_PENDING_IO_ISC1 | \
> +                         FLIC_PENDING_IO_ISC2 | FLIC_PENDING_IO_ISC3 | \
> +                         FLIC_PENDING_IO_ISC4 | FLIC_PENDING_IO_ISC5 | \
> +                         FLIC_PENDING_IO_ISC6 | FLIC_PENDING_IO_ISC7)
