Received: from eggs.gnu.org ([209.51.188.92]:41286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMUhE-0004Mj-My
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMUhC-00068a-Iu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:41:36 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:43694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMUhC-000689-8q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:41:34 -0400
Received: by mail-yw1-xc43.google.com with SMTP id p19so980160ywe.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190503084654.18413-1-liboxuan@connect.hku.hk>
	<0f731e62-b716-8f90-4505-019f731bd072@redhat.com>
In-Reply-To: <0f731e62-b716-8f90-4505-019f731bd072@redhat.com>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Fri, 3 May 2019 17:40:57 +0800
Message-ID: <CALM0=-kVRG+gdcBXQdpowuq89pDCkmwbyE9Ha8T=MKdA5eEM0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

Gotcha, thanks for the tip! I'll resend updated patch soon.

On Fri, May 3, 2019 at 5:12 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Li,
>
> On 5/3/19 10:46 AM, Boxuan Li wrote:
> > Use traces for debug message and qemu_log_mask for errors.
> >
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> > ---
> > v1:
> https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
> > v2:
> https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
> > v3: Use qemu_log_mask for errors
> > ---
> >  hw/virtio/trace-events  |  7 +++++++
> >  hw/virtio/virtio-mmio.c | 44
> +++++++++++++++++++++-----------------------
> >  2 files changed, 28 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 60c649c4bc..81cbe1c4b2 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name,
> uint64_t gpa) "section name: %s g
> >  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual)
> "num_pages: %d actual: %d"
> >  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual=
:
> %d oldactual: %d"
> >  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon
> target: 0x%"PRIx64" num_pages: %d"
> > +
> > +# virtio-mmio.c
> > +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
> > +virtio_mmio_write_offset(int offset, uint64_t value) "virtio_mmio_writ=
e
> offset 0x%x value 0x%" PRIx64
>
> If possible, use uint64_t/PRIx64 for offset (to avoid casting to int).
>
> > +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%"
> PRIx64 " shift %d"
> > +virtio_mmio_queue_write(int value, int max_size) "mmio_queue write %d
> max %d"
> > +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 5807aa87fe..c8a9d974b3 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -27,16 +27,8 @@
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
> > +#include "qemu/log.h"
> > +#include "trace.h"
> >
> >  /* QOM macros */
> >  /* virtio-mmio-bus */
> > @@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwadd=
r
> offset, unsigned size)
> >      VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >
> > -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> > +    trace_virtio_mmio_read((int)offset);
> >
> >      if (!vdev) {
> >          /* If no backend is present, we treat most registers as
> > @@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque,
> hwaddr offset, unsigned size)
> >          }
> >      }
> >      if (size !=3D 4) {
> > -        DPRINTF("wrong size access to register!\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                "%s: wrong size access to register!\n",
> > +                __func__);
>
> QEMU codying style is to indent the arguments aligned, after the caller
> parenthesis:
>
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "%s: wrong size access to register!\n",
>                       __func__);
>
> That said:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks for the cleanup!
>
> >          return 0;
> >      }
> >      switch (offset) {
> > @@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque,
> hwaddr offset, unsigned size)
> >      case VIRTIO_MMIO_QUEUE_ALIGN:
> >      case VIRTIO_MMIO_QUEUE_NOTIFY:
> >      case VIRTIO_MMIO_INTERRUPT_ACK:
> > -        DPRINTF("read of write-only register\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                "%s: read of write-only register\n",
> > +                __func__);
> >          return 0;
> >      default:
> > -        DPRINTF("bad register offset\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n",
> __func__);
> >          return 0;
> >      }
> >      return 0;
> > @@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >      VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >
> > -    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
> > -            (int)offset, value);
> > +    trace_virtio_mmio_write_offset((int)offset, value);
> >
> >      if (!vdev) {
> >          /* If no backend is present, we just make all registers
> > @@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >          return;
> >      }
> >      if (size !=3D 4) {
> > -        DPRINTF("wrong size access to register!\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                "%s: wrong size access to register!\n",
> > +                __func__);
> >          return;
> >      }
> >      switch (offset) {
> > @@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
> offset, uint64_t value,
> >          if (proxy->guest_page_shift > 31) {
> >              proxy->guest_page_shift =3D 0;
> >          }
> > -        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
> > -                proxy->guest_page_shift);
> > +        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
> >          break;
> >      case VIRTIO_MMIO_QUEUE_SEL:
> >          if (value < VIRTIO_QUEUE_MAX) {
> > @@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr
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
> > @@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwadd=
r
> offset, uint64_t value,
> >      case VIRTIO_MMIO_DEVICE_FEATURES:
> >      case VIRTIO_MMIO_QUEUE_NUM_MAX:
> >      case VIRTIO_MMIO_INTERRUPT_STATUS:
> > -        DPRINTF("write to readonly register\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                "%s: write to readonly register\n",
> > +                __func__);
> >          break;
> >
> >      default:
> > -        DPRINTF("bad register offset\n");
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n",
> __func__);
> >      }
> >  }
> >
> > @@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState
> *opaque, uint16_t vector)
> >          return;
> >      }
> >      level =3D (atomic_read(&vdev->isr) !=3D 0);
> > -    DPRINTF("virtio_mmio setting IRQ %d\n", level);
> > +    trace_virtio_mmio_setting_irq(level);
> >      qemu_set_irq(proxy->irq, level);
> >  }
> >
> >
>
