Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EBB20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="XnUBxiXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EBB20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMb6w-0004h6-QZ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:32:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMayP-0005u1-LX
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMayN-0007p6-Gn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:45 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMayM-0007nC-Ra
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:43 -0400
Received: by mail-yw1-xc41.google.com with SMTP id b74so4606338ywe.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ur8T8LWqDP6W0fjDMK0HxlnVo3TThPJnX1IonkrMF3c=;
	b=XnUBxiXrD44KUAsjTCoKP9ZUWQCCqS/gp9ul+eXsRfWzqUCIyopjjHZZOQcuyZxYgU
	mRz/Kht2qJY6Ad1QZIg8txZyTJFK0YtvYvEldDcyo2u8Cm4FmAqgolyoRSXbXoscwCmH
	15qf38fwGkmnJPkdKISi0DHaPoLnsf78gmpF+yQCGc/nUAI2iW/KYdQI7/LjLAtbx7VY
	Jh0lBIEfVMR54KsAbJLEFNFxxEBxUoD8yXHKuLs+Yx0tm9ZNsukT++G4Hn5TPI2/4NPf
	+x4NmKgDDy9EA8oTJvT9lp6nZagA4Q299BApbJcjmvqBwshEQONJt+mT/HkWilmUCQom
	dr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Ur8T8LWqDP6W0fjDMK0HxlnVo3TThPJnX1IonkrMF3c=;
	b=UrvQ+e1G7F34+OruqgUIuAiZrc0fQsZSA6wSme0mWCgN5qmPpmhiCJIrVjyCVU/ivi
	FLoHOXr0T7bJAg+mIKlpbh1HC7S2OHgPa6EbEW3/sOfkU7nLu9VYN1hH+jfZPedKhnFN
	NJbUi5SnNACdLPiXIYTVjcI1zYVzsqg2KuiiWqikvaD0614n+HhqIXFGdUwHu0DAizah
	jnfMraSYnbJC008ONS9Q/9jTCIT0/YTityOS4VgHZhbEhK5ZPSfGYIjVnxjkiVsFdqlC
	HSe6UxB7gMpM1lpoRnxUWUAXQauSlAxnwbJOfpf9k4DzDx/rjrRtsJcFn/+aySeXr6tv
	LxeQ==
X-Gm-Message-State: APjAAAWstS6J/9GPD4Vpj1JGV1H+ofq5LplcEQ0DEKWxY+DPMFGtkwaU
	G4o2gmrGsC9yMjf3MNPj9TP7w72kh8cUZmqMHe3NMQ==
X-Google-Smtp-Source: APXvYqxifS13lXVVO+85NMgL0tqt8L9ioW27WYUjWGCdu45H/ohu/K8EiA49cC9IJ5IwuezZqsWJ7BxmiAuAT2/beyY=
X-Received: by 2002:a25:ef01:: with SMTP id g1mr8602880ybd.399.1556900620986; 
	Fri, 03 May 2019 09:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
	<87bm0j4im0.fsf@zen.linaroharston>
In-Reply-To: <87bm0j4im0.fsf@zen.linaroharston>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Sat, 4 May 2019 00:23:05 +0800
Message-ID:
 <CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503162305.Fs6Sx7bWB1Oj0SIsrEHA67Qc91fAmR-Ny6q0bvmQVjU@z>

Hi Alex,

Sorry about that, I am still trying to get familiar with the patch
submission process. Since my patch has been changed from your last review,
I thought it would be safe to not include the r-b tag from last time. Will
take care next time!

Best regards,
Boxuan Li

On Sat, May 4, 2019 at 12:18 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Boxuan Li <liboxuan@connect.hku.hk> writes:
>
> > Use traces for debug message and qemu_log_mask for errors.
> >
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
>
> You didn't add my r-b tags from last time. Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> > ---
> > v1:
> https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
> > v2:
> https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
> > v3:
> https://patchew.org/QEMU/20190503084654.18413-1-liboxuan@connect.hku.hk/
> > v4: Fix indentation and do not convert uint64_t to int
> > ---
> >  hw/virtio/trace-events  |  7 +++++++
> >  hw/virtio/virtio-mmio.c | 44
> +++++++++++++++++++++-----------------------
> >  2 files changed, 28 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 60c649c4bc..e28ba48da6 100644
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
> > +virtio_mmio_read(uint64_t offset) "virtio_mmio_read offset 0x%" PRIx64
> > +virtio_mmio_write_offset(uint64_t offset, uint64_t value)
> "virtio_mmio_write offset 0x%" PRIx64 " value 0x%" PRIx64
> > +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%"
> PRIx64 " shift %d"
> > +virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue writ=
e
> 0x%" PRIx64 " max %d"
> > +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 5807aa87fe..96c762f0bf 100644
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
> > +    trace_virtio_mmio_read(offset);
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
> > +                      "%s: wrong size access to register!\n",
> > +                      __func__);
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
> > +                      "%s: read of write-only register\n",
> > +                      __func__);
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
> > +    trace_virtio_mmio_write_offset(offset, value);
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
> > +                      "%s: wrong size access to register!\n",
> > +                      __func__);
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
> > +        trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
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
> > +                      "%s: write to readonly register\n",
> > +                      __func__);
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
>
>
> --
> Alex Benn=C3=A9e
>
