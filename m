Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A36EECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A562086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A562086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKYWm-00037s-U2
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 21:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iKYVy-00021F-6H
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iKYVv-0003it-TL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iKYVv-0003il-KG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C25C5C057E32;
 Wed, 16 Oct 2019 01:54:10 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42A9D5C21F;
 Wed, 16 Oct 2019 01:54:01 +0000 (UTC)
Date: Tue, 15 Oct 2019 19:52:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 10/10] vfio: unplug failover primary device before
 migration
Message-ID: <20191015195212.27e0f944@x1.home>
In-Reply-To: <20191011112015.11785-11-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-11-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 16 Oct 2019 01:54:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 13:20:15 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> As usual block all vfio-pci devices from being migrated, but make an
> exception for failover primary devices. This is achieved by setting
> unmigratable to 0 but also add a migration blocker for all vfio-pci
> devices except failover primary devices. These will be unplugged before
> migration happens by the migration handler of the corresponding
> virtio-net standby device.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/vfio/pci.c | 35 ++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h |  2 ++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c5e6fe61cb..64cf8e07d9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,9 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/blocker.h"
> +#include "qemu/option.h"
> +#include "qemu/option_int.h"
>  
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -2698,6 +2701,12 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static int has_net_failover_arg(void *opaque, const char *name,
> +                           const char *value, Error **errp)
> +{
> +    return (strcmp(name, "net_failover_pair_id") == 0);
> +}
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> @@ -2710,6 +2719,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      int groupid;
>      int i, ret;
>      bool is_mdev;
> +    uint16_t class_id;
> +
> +    if (qemu_opt_foreach(pdev->qdev.opts, has_net_failover_arg,
> +                         (void *) pdev->qdev.opts, &err) == 0) {

Why do we need a qemu_opt_foreach here versus testing
vdev->net_failover_pair_id as you do below or similar to how we test
sysfsdev immediately below this chunk?

> +        error_setg(&vdev->migration_blocker,
> +                "VFIO device doesn't support migration");
> +        ret = migrate_add_blocker(vdev->migration_blocker, &err);

Where's the migrate_del_blocker()/error_free() for any other realize
error or device removal?

> +        if (err) {
> +            error_propagate(errp, err);
> +            error_free(vdev->migration_blocker);
> +        }

As Connie noted, unclear if this aborts or continues without a
migration blocker, which would be bad.

> +    } else {
> +        pdev->qdev.allow_unplug_during_migration = true;
> +    }
>  
>      if (!vdev->vbasedev.sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2812,6 +2835,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> +    if (vdev->net_failover_pair_id != NULL) {
> +        class_id = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
> +        if (class_id != PCI_CLASS_NETWORK_ETHERNET) {
> +            error_setg(errp, "failover device is not an Ethernet device");
> +            goto error;
> +        }
> +    }

Not clear to me why we do this separate from setting up the migration
blocker or why we use a different mechanism to test for the property.

> +
>      /* vfio emulates a lot for us, but some bits need extra love */
>      vdev->emulated_config_bits = g_malloc0(vdev->config_size);
>  
> @@ -3110,6 +3141,8 @@ static Property vfio_pci_dev_properties[] = {
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>      DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
> +    DEFINE_PROP_STRING("net_failover_pair_id", VFIOPCIDevice,
> +            net_failover_pair_id),

Should this and the Ethernet class test be done in PCIDevice?  The
migration aspect is the only thing unique to vfio since we don't
otherwise support it, right?  For instance, I should be able to
setup an emulated NIC with this failover pair id too, right?  Thanks,

Alex

>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> @@ -3152,7 +3185,7 @@ static Property vfio_pci_dev_properties[] = {
>  
>  static const VMStateDescription vfio_pci_vmstate = {
>      .name = "vfio-pci",
> -    .unmigratable = 1,
> +    .unmigratable = 0,
>  };
>  
>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 834a90d646..da4417071a 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -134,6 +134,7 @@ typedef struct VFIOPCIDevice {
>      PCIHostDeviceAddress host;
>      EventNotifier err_notifier;
>      EventNotifier req_notifier;
> +    char *net_failover_pair_id;
>      int (*resetfn)(struct VFIOPCIDevice *);
>      uint32_t vendor_id;
>      uint32_t device_id;
> @@ -168,6 +169,7 @@ typedef struct VFIOPCIDevice {
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
>      VFIODisplay *dpy;
> +    Error *migration_blocker;
>  } VFIOPCIDevice;
>  
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);


