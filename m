Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7174FC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 22:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F67A2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 22:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F67A2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR2mu-0006QL-6s
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 18:54:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hR2ll-0005vV-J2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 18:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hR2lk-0004MS-7t
	for qemu-devel@nongnu.org; Wed, 15 May 2019 18:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hR2lj-0004LX-SX
	for qemu-devel@nongnu.org; Wed, 15 May 2019 18:53:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11E2F13A5C;
	Wed, 15 May 2019 22:53:02 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 57ED1627D7;
	Wed, 15 May 2019 22:52:59 +0000 (UTC)
Date: Wed, 15 May 2019 16:52:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190515165258.0855fcb9@x1.home>
In-Reply-To: <20190409155831.18764-1-eric.auger@redhat.com>
References: <20190409155831.18764-1-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 15 May 2019 22:53:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: aik@ozlabs.ru, cohuck@redhat.com, qemu-devel@nongnu.org,
	eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  9 Apr 2019 17:58:31 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER or
> ACTION_UNMASK action.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> This is a follow-up to
> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
> It looks to me that introducing vfio_set_irq_signaling() has more
> benefits in term of code reduction and the helper abstraction
> looks cleaner.
> ---
>  hw/vfio/common.c              |  61 +++++++++
>  hw/vfio/pci.c                 | 224 ++++++++--------------------------
>  hw/vfio/platform.c            |  55 +++------
>  include/hw/vfio/vfio-common.h |   2 +
>  4 files changed, 134 insertions(+), 208 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4374cc6176..f88fd10ca3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -95,6 +95,67 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
>      ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
>  }
>  
> +static inline const char *action_to_str(int action)
> +{
> +    switch (action) {
> +    case VFIO_IRQ_SET_ACTION_MASK:
> +        return "MASK";
> +    case VFIO_IRQ_SET_ACTION_UNMASK:
> +        return "UNMASK";
> +    case VFIO_IRQ_SET_ACTION_TRIGGER:
> +        return "TRIGGER";
> +    default:
> +        return "UNKNOWN ACTION";
> +    }
> +}
> +
> +int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> +                           int action, int fd, Error **errp)
> +{
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> +                                      .index = index };
> +    struct vfio_irq_set *irq_set;
> +    int argsz, ret = 0;
> +    int32_t *pfd;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "index %d does not exist", index);
> +        goto error;
> +    }
> +    if (irq_info.count < subindex + 1) {
> +        error_setg_errno(errp, errno, "subindex %d does not exist", subindex);
> +        goto error;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
> +    irq_set->index = index;
> +    irq_set->start = subindex;
> +    irq_set->count = 1;
> +    pfd = (int32_t *)&irq_set->data;
> +    *pfd = fd;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);

Hi Eric,

Sorry for the long delay.  While I like the code reduction and
simplification, is it really acceptable that every SET_IRQS ioctl is
now a GET_IRQ_INFO + SET_IRQS?  Are we trying to protect against
devices dynamically changing their interrupt support?  Do we not trust
the callers?

> +
> +    g_free(irq_set);
> +
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
> +        goto error;
> +    }
> +    return 0;
> +error:
> +    error_prepend(errp,
> +                  "Failed to %s %s eventfd signaling for interrupt [%d,%d]: ",
> +                  fd < 0 ? "tear down" : "set up", action_to_str(action),
> +                  index, subindex);


Maybe icing on the cake, but this leaves me wishing it printed "MSIX-3"
rather than "[2,3]" for a PCI device ;)


> +    return ret;
> +}
> +
>  /*
>   * IO Port/MMIO - Beware of the endians, VFIO is always little endian
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 504019c458..cd93ff6fa3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
[snip]
> @@ -2718,77 +2630,43 @@ static void vfio_req_notifier_handler(void *opaque)
>  
>  static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>  {
> -    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> -                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> +    Error *err = NULL;
> +    int32_t fd;
>  
>      if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>          return;
>      }
>  
> -    if (ioctl(vdev->vbasedev.fd,
> -              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
> -        return;
> -    }

Here we used GET_IRQ_INFO to quietly only enable the request notifier
when it's available, now it looks like this is no longer quiet if that
support is unavailable.  Is that intentional?  Thanks,

Alex

> -
>      if (event_notifier_init(&vdev->req_notifier, 0)) {
>          error_report("vfio: Unable to init event notifier for device request");
>          return;
>      }
>  
> -    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +    fd = event_notifier_get_fd(&vdev->req_notifier);
> +    qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>  
> -    irq_set = g_malloc0(argsz);
> -    irq_set->argsz = argsz;
> -    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
> -    irq_set->start = 0;
> -    irq_set->count = 1;
> -    pfd = (int32_t *)&irq_set->data;
> -
> -    *pfd = event_notifier_get_fd(&vdev->req_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
> -
> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to set up device request notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> +                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>          event_notifier_cleanup(&vdev->req_notifier);
>      } else {
>          vdev->req_enabled = true;
>      }
> -
> -    g_free(irq_set);
>  }

