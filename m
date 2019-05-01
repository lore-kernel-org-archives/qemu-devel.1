Received: from eggs.gnu.org ([209.51.188.92]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLoZx-0002Du-7y
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLoZt-0003mB-AK
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:43:16 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hLoZs-0003kr-D6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:43:13 -0400
Received: by mail-yw1-xc42.google.com with SMTP id y131so8198297ywa.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 05:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190501081039.58938-1-liboxuan@connect.hku.hk>
	<20190501085805.GA8174@lap1>
In-Reply-To: <20190501085805.GA8174@lap1>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Wed, 1 May 2019 20:42:35 +0800
Message-ID: <CALM0=-=cbHTajGz8R4Who9eKh=sfa19H_nMuH4PFO8vVq2=drQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio/virtio-mmio: Convert DPRINTF
 to traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, May 1, 2019 at 4:58 PM Yuval Shaia <yuval.shaia@oracle.com> wrote:

> On Wed, May 01, 2019 at 04:10:39PM +0800, Boxuan Li wrote:
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> > ---
> > v2: Instead of using conditional debugs, convert DPRINTF to traces
> > ---
> >  hw/virtio/trace-events  | 13 +++++++++++++
> >  hw/virtio/virtio-mmio.c | 35 ++++++++++++-----------------------
> >  2 files changed, 25 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 60c649c4bc..37c781b487 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -46,3 +46,16 @@ virtio_balloon_handle_output(const char *name,
> uint64_t gpa) "section name: %s g
> >  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual)
> "num_pages: %d actual: %d"
> >  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual:
> %d oldactual: %d"
> >  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon
> target: 0x%"PRIx64" num_pages: %d"
> > +
> > +# virtio-mmio.c
> > +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
> > +virtio_mmio_wrong_size_read(void) "wrong size access to register!"
> > +virtio_mmio_read_interrupt(void) "read of write-only register"
> > +virtio_mmio_bad_read_offset(void) "bad register offset"
> > +virtio_mmio_write_offset(int offset, uint64_t value) "virtio_mmio_write
> offset 0x%x value 0x%" PRIx64
> > +virtio_mmio_wrong_size_write(void) "wrong size access to register!"
> > +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%"
> PRIx64 " shift %d"
> > +virtio_mmio_queue_write(int value, int max_size) "mmio_queue write %d
> max %d"
> > +virtio_mmio_write_interrupt(void) "write to readonly register"
> > +virtio_mmio_bad_write_offset(void) "bad register offset"
> > +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 5807aa87fe..4251df399d 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -27,16 +27,7 @@
> >  #include "sysemu/kvm.h"
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "qemu/error-report.h"
> > -
> > -/* #define DEBUG_VIRTIO_MMIO */
> > -
> > -#ifdef DEBUG_VIRTIO_MMIO
> > -
> > -#define DPRINTF(fmt, ...) \
> > -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) do {} while (0)
> > -#endif
> > +#include "trace.h"
> >
> >  /* QOM macros */
> >  /* virtio-mmio-bus */
> > @@ -107,7 +98,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr
> offset, unsigned size)
> >      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
> >      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> >
> > -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> > +    trace_virtio_mmio_read((int)offset);
> >
> >      if (!vdev) {
> >          /* If no backend is present, we treat most registers as
> > @@ -144,7 +135,7 @@ static uint64_t virtio_mmio_read(void *opaque,
> hwaddr offset, unsigned size)
> >          }
> >      }
> >      if (size != 4) {
> > -        DPRINTF("wrong size access to register!\n");
> > +        trace_virtio_mmio_wrong_size_read();
>
> Have you considered using qemu_error_report to report such errors?
>
>
Thanks for the suggestion. I am a newcomer here so my question might be a
bit dumb: I thought they are warnings instead of errors since return values
are 0. Do you suggest using error_report function and changing return
values from 0 to -1?

Best regards,
Boxuan Li


> >          return 0;
> >      }
> >      switch (offset) {
> > @@ -182,10 +173,10 @@ static uint64_t virtio_mmio_read(void *opaque,
> hwaddr offset, unsigned size)
> >      case VIRTIO_MMIO_QUEUE_ALIGN:
> >      case VIRTIO_MMIO_QUEUE_NOTIFY:
> >      case VIRTIO_MMIO_INTERRUPT_ACK:
> > -        DPRINTF("read of write-only register\n");
> > +        trace_virtio_mmio_read_interrupt();
> >          return 0;
> >      default:
> > -        DPRINTF("bad register offset\n");
> > +        trace_virtio_mmio_bad_read_offset();
>
> Ditto to all other errors.
>
> >          return 0;
> >      }
> >      return 0;
> > @@ -197,8 +188,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >      VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
> >      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> >
> > -    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
> > -            (int)offset, value);
> > +    trace_virtio_mmio_write_offset((int)offset, value);
> >
> >      if (!vdev) {
> >          /* If no backend is present, we just make all registers
> > @@ -226,7 +216,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >          return;
> >      }
> >      if (size != 4) {
> > -        DPRINTF("wrong size access to register!\n");
> > +        trace_virtio_mmio_wrong_size_write();
> >          return;
> >      }
> >      switch (offset) {
> > @@ -246,8 +236,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >          if (proxy->guest_page_shift > 31) {
> >              proxy->guest_page_shift = 0;
> >          }
> > -        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
> > -                proxy->guest_page_shift);
> > +        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
> >          break;
> >      case VIRTIO_MMIO_QUEUE_SEL:
> >          if (value < VIRTIO_QUEUE_MAX) {
> > @@ -255,7 +244,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >          }
> >          break;
> >      case VIRTIO_MMIO_QUEUE_NUM:
> > -        DPRINTF("mmio_queue write %d max %d\n", (int)value,
> VIRTQUEUE_MAX_SIZE);
> > +        trace_virtio_mmio_queue_write((int)value, VIRTQUEUE_MAX_SIZE);
> >          virtio_queue_set_num(vdev, vdev->queue_sel, value);
> >          /* Note: only call this function for legacy devices */
> >          virtio_queue_update_rings(vdev, vdev->queue_sel);
> > @@ -303,11 +292,11 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >      case VIRTIO_MMIO_DEVICE_FEATURES:
> >      case VIRTIO_MMIO_QUEUE_NUM_MAX:
> >      case VIRTIO_MMIO_INTERRUPT_STATUS:
> > -        DPRINTF("write to readonly register\n");
> > +        trace_virtio_mmio_write_interrupt();
> >          break;
> >
> >      default:
> > -        DPRINTF("bad register offset\n");
> > +        trace_virtio_mmio_bad_write_offset();
> >      }
> >  }
> >
> > @@ -327,7 +316,7 @@ static void virtio_mmio_update_irq(DeviceState
> *opaque, uint16_t vector)
> >          return;
> >      }
> >      level = (atomic_read(&vdev->isr) != 0);
> > -    DPRINTF("virtio_mmio setting IRQ %d\n", level);
> > +    trace_virtio_mmio_setting_irq(level);
> >      qemu_set_irq(proxy->irq, level);
> >  }
>
> I went through all code changes and found no mistakes but suggesting to
> turn errors to errors and not just threat them as traces.
>
> If you already considered it then fine.
>
> >
> > --
> > 2.13.2
> >
> >
>
