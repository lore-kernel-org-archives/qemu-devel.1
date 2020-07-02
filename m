Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5780C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2B520748
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQIcs0GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2B520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqy36-0001le-T3
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqy2U-0001Lw-Lj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:10:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqy2R-0006SO-AI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593691798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JU7HUj192QRP6nfGKfnolOufjkFXZyaI5ooIYBDVOFo=;
 b=eQIcs0GK+udVxSKx4DQY3KvgZORtajBMTkhFy7FKpZlk8I7n039xZ5zrdb6/+YKzZ0PkVy
 Cas384z1zW6+iMqteT97wYmIagqLHvW9CANti4KY1t+vO/zoRb9HLLdyqvTDKsF4Cm15TB
 75SHtu3PSC6Ug5tmJizevoYpf2u+DJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-h_ACvLd3Psy2URo-2qWoRw-1; Thu, 02 Jul 2020 08:09:54 -0400
X-MC-Unique: h_ACvLd3Psy2URo-2qWoRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBF5804003;
 Thu,  2 Jul 2020 12:09:52 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEF8F10013D4;
 Thu,  2 Jul 2020 12:09:44 +0000 (UTC)
Date: Thu, 2 Jul 2020 13:09:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 16/21] multi-process: create IOHUB object to handle irq
Message-ID: <20200702120943.GA152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <be2466be0c94a172ecb5060ea35244f6af5bd3af.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <be2466be0c94a172ecb5060ea35244f6af5bd3af.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:38AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20

CCing Alex Williamson in case he has time to think about how PCI INTx
interrupts should work in multi-process QEMU where the device emulation
runs as a separate process. I don't know enough about interrupts to give
this a full review.

> IOHUB object is added to manage PCI IRQs. It uses KVM_IRQFD
> ioctl to create irqfd to injecting PCI interrupts to the guest.
> IOHUB object forwards the irqfd to the remote process. Remote process
> uses this fd to directly send interrupts to the guest, bypassing QEMU.

Each PCIDevice has exactly one legacy interrupt pin. This raises two
questions:

1. Why perform interrupt mapping in the remote device program? The IOHUB
   object really only needs a PCIDevice -> irqfd lookup so it can set
   the correct EventNotifier when the device raises an interrupt.

   The mapping scheme in this patch can suffer from collisions when
   multiple devices are attached to an IOHUB. On a physical machine that
   results in shared legacy interrupts, but there is no need to recreate
   that in the remote device program since it's a guest issue, not a
   device issue. When a collision occurs this patch doesn't seem to
   share the irqfd for both devices. It overwrites the irqfd so the
   older device stops getting interrupts!

   Unless I'm missing something I suggest dropping the N:8
   PCIDevice:pirq interrupt mapping and using a 1:1 PCIDevice:irqfd
   mapping.

2. Why is the intx pin number sent as part of the SetIrqFdMsg? The intx
   pin does not matter - each PCIDevice still just exactly one legacy
   interrupt pin, regardless of whether it is A, B, C, or D.

> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS               |   2 +
>  hw/Makefile.objs          |   1 +
>  hw/i386/remote-msg.c      |   4 +
>  hw/i386/remote.c          |  15 ++++
>  hw/pci/proxy.c            |  52 +++++++++++++
>  hw/remote/Makefile.objs   |   1 +
>  hw/remote/iohub.c         | 153 ++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/remote.h  |   2 +
>  include/hw/pci/pci_ids.h  |   3 +
>  include/hw/pci/proxy.h    |   8 ++
>  include/hw/remote/iohub.h |  50 +++++++++++++
>  include/io/mpqemu-link.h  |   6 ++
>  io/mpqemu-link.c          |   1 +
>  13 files changed, 298 insertions(+)
>  create mode 100644 hw/remote/Makefile.objs
>  create mode 100644 hw/remote/iohub.c
>  create mode 100644 include/hw/remote/iohub.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38d605445e..f9ede7e094 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2956,6 +2956,8 @@ F: hw/pci/proxy.c
>  F: include/hw/pci/proxy.h
>  F: hw/pci/memory-sync.c
>  F: include/hw/pci/memory-sync.h
> +F: hw/remote/iohub.c
> +F: include/hw/remote/iohub.h
> =20
>  Build and test automation
>  -------------------------
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 4cbe5e4e57..8caf659de0 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -40,6 +40,7 @@ devices-dirs-$(CONFIG_MEM_DEVICE) +=3D mem/
>  devices-dirs-$(CONFIG_NUBUS) +=3D nubus/
>  devices-dirs-y +=3D semihosting/
>  devices-dirs-y +=3D smbios/
> +devices-dirs-y +=3D remote/
>  endif
> =20
>  common-obj-y +=3D $(devices-dirs-y)
> diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
> index 48b153eaae..67fee4bb57 100644
> --- a/hw/i386/remote-msg.c
> +++ b/hw/i386/remote-msg.c
> @@ -10,6 +10,7 @@
>  #include "hw/pci/pci.h"
>  #include "exec/memattrs.h"
>  #include "hw/i386/remote-memory.h"
> +#include "hw/remote/iohub.h"
> =20
>  static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
>                                      Error **errp);
> @@ -67,6 +68,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOConditi=
on cond,
>      case SYNC_SYSMEM:
>          remote_sysmem_reconfig(&msg, &local_err);
>          break;
> +    case SET_IRQFD:
> +        process_set_irqfd_msg(pci_dev, &msg);
> +        break;
>      default:
>          error_setg(&local_err, "Unknown command (%d) received from proxy=
 \
>                     in remote process pid=3D%d", msg.cmd, getpid());
> diff --git a/hw/i386/remote.c b/hw/i386/remote.c
> index 5342e884ad..8e74a6f1af 100644
> --- a/hw/i386/remote.c
> +++ b/hw/i386/remote.c
> @@ -17,12 +17,16 @@
>  #include "qapi/error.h"
>  #include "io/channel-util.h"
>  #include "io/channel.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/remote/iohub.h"
> =20
>  static void remote_machine_init(MachineState *machine)
>  {
>      MemoryRegion *system_memory, *system_io, *pci_memory;
>      RemMachineState *s =3D REMOTE_MACHINE(machine);
>      RemotePCIHost *rem_host;
> +    PCIHostState *pci_host;
> +    PCIDevice *pci_dev;
> =20
>      system_memory =3D get_system_memory();
>      system_io =3D get_system_io();
> @@ -42,6 +46,17 @@ static void remote_machine_init(MachineState *machine)
>      memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, =
-1);
> =20
>      qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
> +
> +    pci_host =3D PCI_HOST_BRIDGE(rem_host);
> +    pci_dev =3D pci_create_simple_multifunction(pci_host->bus,
> +                                              PCI_DEVFN(REMOTE_IOHUB_DEV=
,
> +                                                        REMOTE_IOHUB_FUN=
C),
> +                                              true, TYPE_REMOTE_IOHUB_DE=
VICE);
> +
> +    s->iohub =3D REMOTE_IOHUB_DEVICE(pci_dev);
> +
> +    pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_i=
rq,
> +                 s->iohub, REMOTE_IOHUB_NB_PIRQS);
>  }
> =20
>  static void remote_set_socket(Object *obj, const char *str, Error **errp=
)
> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> index 5ecbdd2dcf..9d8559b6d4 100644
> --- a/hw/pci/proxy.c
> +++ b/hw/pci/proxy.c
> @@ -19,6 +19,9 @@
>  #include "qemu/error-report.h"
>  #include "hw/pci/memory-sync.h"
>  #include "qom/object.h"
> +#include "qemu/event_notifier.h"
> +#include "sysemu/kvm.h"
> +#include "util/event_notifier-posix.c"
> =20
>  static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
>  {
> @@ -57,6 +60,53 @@ static Property proxy_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void proxy_intx_update(PCIDevice *pci_dev)
> +{
> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(pci_dev);
> +    PCIINTxRoute route;
> +    int pin =3D pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
> +
> +    if (dev->irqfd.fd) {

0 is a valid file descriptor number. In practice fd 0 is standard input
so this code won't encounter it, but for clarity please stick to the
commonly-used -1 constant for invalid file descriptors.

> +        dev->irqfd.flags =3D KVM_IRQFD_FLAG_DEASSIGN;
> +        (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
> +        memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
> +    }
> +
> +    route =3D pci_device_route_intx_to_irq(pci_dev, pin);
> +
> +    dev->irqfd.fd =3D event_notifier_get_fd(&dev->intr);
> +    dev->irqfd.resamplefd =3D event_notifier_get_fd(&dev->resample);
> +    dev->irqfd.gsi =3D route.irq;
> +    dev->irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
> +    (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
> +}

Can this code use kvm_irqchip_add/remove_irqfd_notifier_gsi() instead of
duplicating it?

> +
> +static void setup_irqfd(PCIProxyDev *dev)
> +{
> +    PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> +    MPQemuMsg msg;
> +
> +    event_notifier_init(&dev->intr, 0);
> +    event_notifier_init(&dev->resample, 0);

Missing .unrealize() function that does cleanup.

> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +    msg.cmd =3D SET_IRQFD;
> +    msg.num_fds =3D 2;
> +    msg.fds[0] =3D event_notifier_get_fd(&dev->intr);
> +    msg.fds[1] =3D event_notifier_get_fd(&dev->resample);
> +    msg.data1.set_irqfd.intx =3D
> +        pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
> +    msg.size =3D sizeof(msg.data1);
> +
> +    mpqemu_msg_send(&msg, dev->dev);
> +
> +    memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
> +
> +    proxy_intx_update(pci_dev);
> +
> +    pci_device_set_intx_routing_notifier(pci_dev, proxy_intx_update);
> +}
> +
>  static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>  {
>      PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
> @@ -72,6 +122,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, E=
rror **errp)
>      }
> =20
>      configure_memory_sync(&dev->sync, dev->com);
> +
> +    setup_irqfd(dev);
>  }
> =20
>  static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *va=
l,
> diff --git a/hw/remote/Makefile.objs b/hw/remote/Makefile.objs
> new file mode 100644
> index 0000000000..635ce5e0ab
> --- /dev/null
> +++ b/hw/remote/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-$(CONFIG_MPQEMU) +=3D iohub.o
> diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
> new file mode 100644
> index 0000000000..9c6cfaecd4
> --- /dev/null
> +++ b/hw/remote/iohub.c
> @@ -0,0 +1,153 @@
> +/*
> + * Remote IO Hub
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_ids.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/remote/iohub.h"
> +#include "qemu/thread.h"
> +#include "hw/boards.h"
> +#include "hw/i386/remote.h"
> +#include "qemu/main-loop.h"
> +
> +static void remote_iohub_initfn(Object *obj)
> +{
> +    RemoteIOHubState *iohub =3D REMOTE_IOHUB_DEVICE(obj);
> +    int slot, intx, pirq;
> +
> +    memset(&iohub->irqfds, 0, sizeof(iohub->irqfds));
> +    memset(&iohub->resamplefds, 0, sizeof(iohub->resamplefds));
> +
> +    for (slot =3D 0; slot < PCI_SLOT_MAX; slot++) {
> +        for (intx =3D 0; intx < PCI_NUM_PINS; intx++) {
> +            iohub->irq_num[slot][intx] =3D (slot + intx) % 4 + 4;
> +        }
> +    }
> +
> +    for (pirq =3D 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
> +        qemu_mutex_init(&iohub->irq_level_lock[pirq]);
> +        iohub->irq_level[pirq] =3D 0;
> +        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
> +        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
> +    }
> +}
> +
> +static void remote_iohub_class_init(ObjectClass *klass, void *data)
> +{
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +    k->vendor_id =3D PCI_VENDOR_ID_ORACLE;
> +    k->device_id =3D PCI_DEVICE_ID_REMOTE_IOHUB;
> +}
> +
> +static const TypeInfo remote_iohub_info =3D {
> +    .name       =3D TYPE_REMOTE_IOHUB_DEVICE,
> +    .parent     =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(RemoteIOHubState),
> +    .instance_init =3D remote_iohub_initfn,
> +    .class_init  =3D remote_iohub_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    }
> +};
> +
> +static void remote_iohub_register(void)
> +{
> +    type_register_static(&remote_iohub_info);
> +}
> +
> +type_init(remote_iohub_register);

Why is this a PCI device? It has no BARs, configuration space,
interrupts, DMA transfers, etc. It's simpler to make this a plain old
struct + functions that are used by the remote machine type.

> +
> +int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
> +{
> +    BusState *bus =3D qdev_get_parent_bus(&pci_dev->qdev);
> +    PCIBus *pci_bus =3D PCI_BUS(bus);
> +    PCIDevice *pci_iohub =3D
> +        pci_bus->devices[PCI_DEVFN(REMOTE_IOHUB_DEV, REMOTE_IOHUB_FUNC)]=
;
> +    RemoteIOHubState *iohub =3D REMOTE_IOHUB_DEVICE(pci_iohub);
> +
> +    return iohub->irq_num[PCI_SLOT(pci_dev->devfn)][intx];
> +}

This function can be rewritten like this:

  int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
  {
      return (PCI_SLOT(pci_dev->devfn) + intx) % 4 + 4;
  }

There is no need to access RemoteIOHubState and iohub->irq_num[] can be
dropped.

> +
> +/*
> + * TODO: Using lock to set the interrupt level could become a
> + *       performance bottleneck. Check if atomic arithmetic
> + *       is possible.
> + */
> +void remote_iohub_set_irq(void *opaque, int pirq, int level)
> +{
> +    RemoteIOHubState *iohub =3D opaque;
> +
> +    assert(pirq >=3D 0);
> +    assert(pirq < REMOTE_IOHUB_NB_PIRQS);
> +
> +    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
> +
> +    if (level) {
> +        if (++iohub->irq_level[pirq] =3D=3D 1) {
> +            event_notifier_set(&iohub->irqfds[pirq]);
> +        }
> +    } else if (iohub->irq_level[pirq] > 0) {
> +        iohub->irq_level[pirq]--;
> +    }
> +
> +    qemu_mutex_unlock(&iohub->irq_level_lock[pirq]);
> +}
> +
> +static void intr_resample_handler(void *opaque)
> +{
> +    ResampleToken *token =3D opaque;
> +    RemoteIOHubState *iohub =3D token->iohub;
> +    int pirq, s;
> +
> +    pirq =3D token->pirq;
> +
> +    s =3D event_notifier_test_and_clear(&iohub->resamplefds[pirq]);
> +
> +    assert(s >=3D 0);
> +
> +    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
> +
> +    if (iohub->irq_level[pirq]) {
> +        event_notifier_set(&iohub->irqfds[pirq]);
> +    }
> +
> +    qemu_mutex_unlock(&iohub->irq_level_lock[pirq]);
> +}
> +
> +void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
> +{
> +    RemMachineState *machine =3D REMOTE_MACHINE(current_machine);
> +    RemoteIOHubState *iohub =3D machine->iohub;
> +    int pirq;
> +
> +    g_assert(msg->data1.set_irqfd.intx < 4);
> +    g_assert(msg->num_fds =3D=3D 2);

Please handle errors instead of using asserts that allow clients to
terminate the program by sending invalid values.

> +
> +    pirq =3D remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx);
> +
> +    if (event_notifier_get_fd(&iohub->irqfds[pirq]) !=3D -1) {
> +        event_notifier_cleanup(&iohub->irqfds[pirq]);
> +        event_notifier_cleanup(&iohub->resamplefds[pirq]);
> +        memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
> +    }

Missing qemu_set_fd_handler(event_notifier_get_fd(&resamplefds[pirq]), NULL=
, NULL, NULL);

> +
> +    event_notifier_init_fd(&iohub->irqfds[pirq], msg->fds[0]);
> +    event_notifier_init_fd(&iohub->resamplefds[pirq], msg->fds[1]);
> +
> +    iohub->token[pirq].iohub =3D iohub;
> +    iohub->token[pirq].pirq =3D pirq;
> +
> +    qemu_set_fd_handler(msg->fds[1], intr_resample_handler, NULL,
> +                        &iohub->token[pirq]);
> +}

Missing event_notifier_cleanup() and qemu_set_fd_handler() calls when
the mplink connection closes. The connection lifecycle isn't implemented
and will leak resources.

> diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
> index c3890e57ab..6af423ab54 100644
> --- a/include/hw/i386/remote.h
> +++ b/include/hw/i386/remote.h
> @@ -18,12 +18,14 @@
>  #include "hw/boards.h"
>  #include "hw/pci-host/remote.h"
>  #include "io/channel.h"
> +#include "hw/remote/iohub.h"
> =20
>  typedef struct RemMachineState {
>      MachineState parent_obj;
> =20
>      RemotePCIHost *host;
>      QIOChannel *ioc;
> +    RemoteIOHubState *iohub;
>  } RemMachineState;
> =20
>  #define TYPE_REMOTE_MACHINE "remote-machine"
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 11f8ab7149..bd0c17dc78 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -192,6 +192,9 @@
>  #define PCI_DEVICE_ID_SUN_SIMBA          0x5000
>  #define PCI_DEVICE_ID_SUN_SABRE          0xa000
> =20
> +#define PCI_VENDOR_ID_ORACLE             0x108e
> +#define PCI_DEVICE_ID_REMOTE_IOHUB       0xb000
> +
>  #define PCI_VENDOR_ID_CMD                0x1095
>  #define PCI_DEVICE_ID_CMD_646            0x0646
> =20
> diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
> index a41a6aeaa5..e6f076ae95 100644
> --- a/include/hw/pci/proxy.h
> +++ b/include/hw/pci/proxy.h
> @@ -12,9 +12,12 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> =20
> +#include <linux/kvm.h>
> +
>  #include "hw/pci/pci.h"
>  #include "io/channel.h"
>  #include "hw/pci/memory-sync.h"
> +#include "qemu/event_notifier.h"
> =20
>  #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
> =20
> @@ -45,6 +48,11 @@ struct PCIProxyDev {
> =20
>      RemoteMemSync sync;
> =20
> +    struct kvm_irqfd irqfd;
> +
> +    EventNotifier intr;
> +    EventNotifier resample;
> +
>      ProxyMemoryRegion region[PCI_NUM_REGIONS];
>  };
> =20
> diff --git a/include/hw/remote/iohub.h b/include/hw/remote/iohub.h
> new file mode 100644
> index 0000000000..9aacf3e04c
> --- /dev/null
> +++ b/include/hw/remote/iohub.h
> @@ -0,0 +1,50 @@
> +/*
> + * IO Hub for remote device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef REMOTE_IOHUB_H
> +#define REMOTE_IOHUB_H
> +
> +#include "qemu/osdep.h"

CODING_STYLE.rst says:

  Do not include "qemu/osdep.h" from header files since the .c file will
  have already included it.

> +#include "qemu-common.h"
> +
> +#include "hw/pci/pci.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/thread-posix.h"
> +#include "io/mpqemu-link.h"
> +
> +#define REMOTE_IOHUB_NB_PIRQS    8
> +
> +#define REMOTE_IOHUB_DEV         31
> +#define REMOTE_IOHUB_FUNC        0
> +
> +#define TYPE_REMOTE_IOHUB_DEVICE "remote-iohub"
> +#define REMOTE_IOHUB_DEVICE(obj) \
> +    OBJECT_CHECK(RemoteIOHubState, (obj), TYPE_REMOTE_IOHUB_DEVICE)
> +
> +typedef struct ResampleToken {
> +    void *iohub;
> +    int pirq;
> +} ResampleToken;
> +
> +typedef struct RemoteIOHubState {
> +    PCIDevice d;
> +    uint8_t irq_num[PCI_SLOT_MAX][PCI_NUM_PINS];
> +    EventNotifier irqfds[REMOTE_IOHUB_NB_PIRQS];
> +    EventNotifier resamplefds[REMOTE_IOHUB_NB_PIRQS];
> +    unsigned int irq_level[REMOTE_IOHUB_NB_PIRQS];
> +    ResampleToken token[REMOTE_IOHUB_NB_PIRQS];
> +    QemuMutex irq_level_lock[REMOTE_IOHUB_NB_PIRQS];
> +} RemoteIOHubState;
> +
> +int remote_iohub_map_irq(PCIDevice *pci_dev, int intx);
> +void remote_iohub_set_irq(void *opaque, int pirq, int level);
> +void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg);
> +
> +#endif
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 0422213863..a563b557ce 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -42,6 +42,7 @@ typedef enum {
>      PCI_CONFIG_READ,
>      BAR_WRITE,
>      BAR_READ,
> +    SET_IRQFD,
>      MAX =3D INT_MAX,
>  } MPQemuCmd;
> =20
> @@ -64,6 +65,10 @@ typedef struct {
>      bool memory;
>  } BarAccessMsg;
> =20
> +typedef struct {
> +    int intx;
> +} SetIrqFdMsg;
> +
>  /**
>   * Maximum size of data2 field in the message to be transmitted.
>   */
> @@ -92,6 +97,7 @@ typedef struct {
>          uint64_t u64;
>          SyncSysmemMsg sync_sysmem;
>          BarAccessMsg bar_access;
> +        SetIrqFdMsg set_irqfd;
>      } data1;
> =20
>      int fds[REMOTE_MAX_FDS];
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 026e25dca4..561ac0576f 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -258,6 +258,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>          break;
>      case BAR_WRITE:
>      case BAR_READ:
> +    case SET_IRQFD:
>          if (msg->size !=3D sizeof(msg->data1)) {
>              return false;
>          }
> --=20
> 2.25.GIT
>=20

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl79zocACgkQnKSrs4Gr
c8ga6Qf9FZdX52ot7TUSrir5j2ZckPADBue4xxRMLwrGr9z/8aqLbHaoBP5wk71Y
ThU2GCHOwQ8xeA40djHh9GHuxjJW+M6Ahtf2M2cmYqaAzBdj5Wvo2vGW34Dw4Pbs
FRfUNizLk4g9iCpoXtPPHC0xuoUPg0lsJOJj1KGJ+G/KDLpM1yF3H/ntjQKkNiOw
S43uSvgizuTrR05ialgG3/K1AwEsWCIC/uJwDzKD0eNFfrlbhsCShs9ZxK0SdaSu
yMiguQoO83gTS+TDK1qRvOd9g97NlmSrVEh2UrK1uo6GiBj/p8IKck263S3ypdLp
ArSte3i+TPa+WVg5TRWCJOd46u5QLQ==
=aYI+
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


