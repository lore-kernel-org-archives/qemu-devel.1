Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082DC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FA020684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiXMbKS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9fE-0002zT-IH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is9eU-00022H-6r
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is9eO-0003Or-NJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:13:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is9eN-0003Mz-Ij
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579198426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bfotCA2HPNLNvzngm0VTRM5zKYhaovGl0uhfQ7rEvg=;
 b=ZiXMbKS2LOXHGJCmeaBadXLYuypUAEpocI21y1MkM9w2eWZRWKR31CJeYbwTuMZi3b0mg+
 nosFMcHo5SpdlHAItXYxO25USGaXtaUWAcXD6Sda7XhPSulxAn3/wYnQrnrksnPVI+v/ht
 QxRBD/PadnaWB6aazow3p956Y7h9FOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ILL9K26xObS6AcwGwmYfEQ-1; Thu, 16 Jan 2020 13:13:40 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so741976wmk.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6bfotCA2HPNLNvzngm0VTRM5zKYhaovGl0uhfQ7rEvg=;
 b=I+z+BjB3b5ov7FVsA4HcHx+VHesKdCneoqSAQtba8WjG+DiL7Ndn6MdsyWp9pL/cdo
 ZXfRPD/aJNGahc0hG8Qx91ofbkmIIgjPsDOeGgMgZVXXktrEn6zp/JCn1cmSgWbmt+pY
 O0FCz3ZBTZL+0/ceoatrShXBPBrfTlsx0GvZqbEIUi8Q+GiWR2R20su4c8m02bwaV5p+
 2yt4iMTd1NiJZGtiXgeYbdUYFDF70eetYLg41Jl36Quxu6ddXaICBYS5QoZF3x3RNkYy
 sZa9wK5gU2TBOZL1iP5I7JpBBc+a1AEdnPNOiM8wC+aV8NJFzd1DGQfWiL8moTgyQTMo
 UO6g==
X-Gm-Message-State: APjAAAWaX7weA5Jg3ngujmrkgztPSvxfBAfnfyuEpD5p03oAOiIvt7Bn
 ihPYOaicAhGMHDbchAPPBY3Px+VWVycuWmNYDtQKAzA4RrRh6rQaaafJ2QL5Oiig5PLMklDqqog
 UCm0tDSGnMd4tLvI=
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr280599wme.111.1579198418257; 
 Thu, 16 Jan 2020 10:13:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIpu7XbIb30OfChFiu7dmnIGsDENTxuJ/9ZBDhc3G5dyvVNM9pstf0SaQbaRr1ijBzBKTYeQ==
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr280568wme.111.1579198417806; 
 Thu, 16 Jan 2020 10:13:37 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id y22sm5417059wma.35.2020.01.16.10.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:13:37 -0800 (PST)
Subject: Re: [PATCH 1/2] qdev: Introduce qdev_get_bus_device
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-2-jusual@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b3aec4e2-ef6d-5864-e29c-578c6cb7577f@redhat.com>
Date: Thu, 16 Jan 2020 19:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115224025.538368-2-jusual@redhat.com>
Content-Language: en-US
X-MC-Unique: ILL9K26xObS6AcwGwmYfEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julia,

Cc'ing Markus for the qdev/qbus analysis.

On 1/15/20 11:40 PM, Julia Suvorova wrote:
> For bus devices, it is useful to be able to handle the parent device.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>   hw/core/qdev.c                      |  5 +++++
>   hw/pci-bridge/pci_expander_bridge.c |  4 +++-
>   hw/scsi/scsi-bus.c                  |  4 +++-
>   hw/usb/bus.c                        |  4 +++-
>   hw/usb/dev-smartcard-reader.c       | 32 +++++++++++++++++++++--------
>   hw/virtio/virtio-pci.c              | 16 +++++++++++++--
>   include/hw/qdev-core.h              |  2 ++

Please consider using the scripts/git.orderfile config.

>   7 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9f1753f5cf..ad8226e240 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -114,6 +114,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>       }
>   }
>   
> +DeviceState *qdev_get_bus_device(const DeviceState *dev)

We have qdev_get_bus_hotplug_handler(), this follow the naming, OK.

> +{
> +    return dev->parent_bus ? dev->parent_bus->parent : NULL;
> +}
> +
>   /* Create a new device.  This only initializes the device state
>      structure and allows properties to be set.  The device still needs
>      to be realized.  See qdev-core.h.  */
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0592818447..63a6c07406 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -125,9 +125,11 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>       assert(position >= 0);
>   
>       pxb_dev_base = DEVICE(pxb_dev);
> -    main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
> +    main_host = PCI_HOST_BRIDGE(qdev_get_bus_device(pxb_dev_base));
>       main_host_sbd = SYS_BUS_DEVICE(main_host);
>   
> +    g_assert(main_host);

I found myself stuck reviewing this patch for 25min, I'm not sure what's 
bugging me yet, so I'll take notes a-la-Markus-style.

We have the qdev API, with DeviceState.


We have the qbus API, with BusState.

A BusState is not a DeviceState but a raw Object.
It keeps a pointer to the a DeviceState parent, a HotplugHandler, and a 
list of BusChild.


BusChild are neither DeviceState nor Object, but keep a pointer the a 
DeviceState.


TYPE_HOTPLUG_HANDLER is an interface. It can be implemented by any 
object, but its API seems expects a DeviceState as argument.

Looking at examples implementing TYPE_HOTPLUG_HANDLER:

- TYPE_USB_BUS. It inherits TYPE_BUS. Handlers will be called with 
USBDevice as argument (TYPE_USB_DEVICE -> TYPE_DEVICE).

- TYPE_PCI_BRIDGE_DEV. Inherits TYPE_PCI_BRIDGE -> TYPE_PCI_DEVICE -> 
TYPE_DEVICE. Handlers expects PCIDevice (TYPE_PCI_DEVICE).

- TYPE_PC_MACHINE. It inherits TYPE_X86_MACHINE -> TYPE_MACHINE -> 
TYPE_OBJECT. Not a TYPE_BUS. Handlers for TYPE_PC_DIMM, TYPE_CPU and 
TYPE_VIRTIO_PMEM_PCI. Complex... TYPE_PC_DIMM/TYPE_CPU are TYPE_DEVICE.
For TYPE_VIRTIO_PMEM_PCI we have VirtIOPMEMPCI -> VirtIOPCIProxy -> 
PCIDevice.

- USB_CCID_DEV. Inherits TYPE_USB_DEVICE -> TYPE_DEVICE. Only one 
'unplug' handler which likely expects USBCCIDState.

- TYPE_SCSI_BUS. Inherits TYPE_BUS. Also a single 'unplug' handler 
expecting SCSIDevice.

- TYPE_VIRTIO_SCSI. Inherits TYPE_VIRTIO_SCSI_COMMON -> 
TYPE_VIRTIO_DEVICE -> TYPE_DEVICE. Handlers expect VirtIOSCSI.


No simple pattern so far.


Looking back at qbus. qbus_initfn() enforces a TYPE_HOTPLUG_HANDLER 
property on BusState (which is not a DeviceState). So IIUC TYPE_BUS also 
implements TYPE_HOTPLUG_HANDLER.

---

Back to your patch, you add asserts() calls because you expect 
SysBusDeviceClass::explicit_ofw_unit_address() to be called before the 
device is plugged on a bus.

This handler is only used by sysbus_get_fw_dev_path(), so 
BusClass::get_dev_path(), similar to the scsi/usb following cases.

BusClass::get_dev_path() is only called in qdev_get_dev_path() were we 
know that dev->parent_bus is not NULL, because checked there.

So the assert is pointless.

> +
>       if (main_host_sbd->num_mmio > 0) {
>           return g_strdup_printf(TARGET_FMT_plx ",%x",
>                                  main_host_sbd->mmio[0].addr, position + 1);
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index ad0e7f6d88..3d9497882b 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1558,10 +1558,12 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
>   static char *scsibus_get_dev_path(DeviceState *dev)
>   {
>       SCSIDevice *d = SCSI_DEVICE(dev);
> -    DeviceState *hba = dev->parent_bus->parent;
> +    DeviceState *hba = qdev_get_bus_device(dev);
>       char *id;
>       char *path;
>   
> +    g_assert(hba);

Similarly, we checked in qdev_get_dev_path().

> +
>       id = qdev_get_dev_path(hba);
>       if (id) {
>           path = g_strdup_printf("%s/%d:%d:%d", id, d->channel, d->id, d->lun);
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index a6522f5429..26bf794315 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -587,9 +587,11 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
>   static char *usb_get_dev_path(DeviceState *qdev)
>   {
>       USBDevice *dev = USB_DEVICE(qdev);
> -    DeviceState *hcd = qdev->parent_bus->parent;
> +    DeviceState *hcd = qdev_get_bus_device(qdev);
>       char *id = NULL;
>   
> +    g_assert(hcd);

Similarly, we checked in qdev_get_dev_path().

> +
>       if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
>           id = qdev_get_dev_path(hcd);
>       }
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 4568db2568..fbb3599ddd 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1185,10 +1185,12 @@ void ccid_card_send_apdu_to_guest(CCIDCardState *card,
>                                     uint8_t *apdu, uint32_t len)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>       Answer *answer;
>   
> +    g_assert(dev);

Skipping this one for now.

> +
>       if (!ccid_has_pending_answers(s)) {
>           DPRINTF(s, 1, "CCID ERROR: got an APDU without pending answers\n");
>           return;
> @@ -1208,9 +1210,11 @@ void ccid_card_send_apdu_to_guest(CCIDCardState *card,
>   void ccid_card_card_removed(CCIDCardState *card)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>   
> +    g_assert(dev);

At removal time we assume it was previously inserted.

> +
>       ccid_on_slot_change(s, false);
>       ccid_flush_pending_answers(s);
>       ccid_reset(s);
> @@ -1219,9 +1223,11 @@ void ccid_card_card_removed(CCIDCardState *card)
>   int ccid_card_ccid_attach(CCIDCardState *card)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>   
> +    g_assert(dev);

Skipping this one for now.

> +
>       DPRINTF(s, 1, "CCID Attach\n");
>       return 0;
>   }
> @@ -1229,9 +1235,11 @@ int ccid_card_ccid_attach(CCIDCardState *card)
>   void ccid_card_ccid_detach(CCIDCardState *card)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>   
> +    g_assert(dev);

At detach time we assume it was attached.

> +
>       DPRINTF(s, 1, "CCID Detach\n");
>       if (ccid_card_inserted(s)) {
>           ccid_on_slot_change(s, false);
> @@ -1242,9 +1250,11 @@ void ccid_card_ccid_detach(CCIDCardState *card)
>   void ccid_card_card_error(CCIDCardState *card, uint64_t error)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>   
> +    g_assert(dev);

Skipping this one for now.

> +
>       s->bmCommandStatus = COMMAND_STATUS_FAILED;
>       s->last_answer_error = error;
>       DPRINTF(s, 1, "VSC_Error: %" PRIX64 "\n", s->last_answer_error);
> @@ -1261,9 +1271,11 @@ void ccid_card_card_error(CCIDCardState *card, uint64_t error)
>   void ccid_card_card_inserted(CCIDCardState *card)
>   {
>       DeviceState *qdev = DEVICE(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>   
> +    g_assert(dev);

Skipping this one for now.

> +
>       s->bmCommandStatus = COMMAND_STATUS_NO_ERROR;
>       ccid_flush_pending_answers(s);
>       ccid_on_slot_change(s, true);
> @@ -1273,10 +1285,12 @@ static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
>   {
>       CCIDCardState *card = CCID_CARD(qdev);
>       CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>       Error *local_err = NULL;
>   
> +    g_assert(dev);

Here we assume it was realized.

> +
>       if (ccid_card_inserted(s)) {
>           ccid_card_card_removed(card);
>       }
> @@ -1294,10 +1308,12 @@ static void ccid_card_realize(DeviceState *qdev, Error **errp)
>   {
>       CCIDCardState *card = CCID_CARD(qdev);
>       CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
> -    USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> +    USBDevice *dev = USB_DEVICE(qdev_get_bus_device(qdev));
>       USBCCIDState *s = USB_CCID_DEV(dev);
>       Error *local_err = NULL;
>   
> +    g_assert(dev);
> +
>       if (card->slot != 0) {
>           error_setg(errp, "usb-ccid supports one slot, can't add %d",
>                      card->slot);
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f723b9f631..8ce9269aab 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1317,9 +1317,21 @@ static uint64_t virtio_pci_notify_read(void *opaque, hwaddr addr,
>   static void virtio_pci_notify_write(void *opaque, hwaddr addr,
>                                       uint64_t val, unsigned size)
>   {
> +    DeviceState *dev = DEVICE(opaque);
>       VirtIODevice *vdev = opaque;
> -    VirtIOPCIProxy *proxy = VIRTIO_PCI(DEVICE(vdev)->parent_bus->parent);
> -    unsigned queue = addr / virtio_pci_queue_mem_mult(proxy);
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev_get_bus_device(dev));
> +    unsigned queue;
> +
> +    /*
> +     * During unplug virtio device may have
> +     * already been disconnected from the bus
> +     */
> +    if (!proxy) {

So VIRTIO_PCI() calls OBJECT_CHECK().

/*
  * OBJECT_CHECK:
  * If an invalid object is passed to this function, a run time assert 
will be
  * generated.
  */
#define OBJECT_CHECK(type, obj, name) \
     ((type *)object_dynamic_cast_assert(OBJECT(obj), (name), \
                                         __FILE__, __LINE__, __func__))

Looking at object_dynamic_cast_assert(), even building with 
CONFIG_QOM_CAST_DEBUG, it looks passing obj=NULL will return NULL...

OK, so this check makes sense. I wonder how you got there. No bugreport 
or crash mentioned in this patch or the cover. Googling for 
'virtio_pci_notify_write' I found 
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667664.html which 
is not filled as a Launchpad QEMU bug. The reporter wrote "but parent 
BusState was already freed & set to NULL." If you are trying to fix a 
bug, it would help if you give the context to the reviewers, at least 
the backtrace would have saved me some minutes of the 2 hours+ I'm 
looking at this.

> +        warn_report("Device %s doesn't have parent bus", vdev->name);
> +        return;
> +    }
> +
> +    queue = addr / virtio_pci_queue_mem_mult(proxy);
>   
>       if (queue < VIRTIO_QUEUE_MAX) {
>           virtio_queue_notify(vdev, queue);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1518495b1e..05d68f0f1a 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -452,6 +452,8 @@ Object *qdev_get_machine(void);
>   /* FIXME: make this a link<> */
>   void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>   
> +DeviceState *qdev_get_bus_device(const DeviceState *dev);
> +
>   extern bool qdev_hotplug;
>   extern bool qdev_hot_removed;
>   

I suggest you split this patch in:

1/ introduce qdev_get_bus_device()
-  hw/core/qdev.c
-  include/hw/qdev-core.h

2/ obvious use of qdev_get_bus_device(), no assert
- hw/pci-bridge/pci_expander_bridge.c
- hw/scsi/scsi-bus.c
- hw/usb/bus.c

3/ use of qdev_get_bus_device(), assertions
- hw/usb/dev-smartcard-reader.c

4a/ use qdev_get_bus_device()
- hw/virtio/virtio-pci.c

4b/ !proxy bugfix
- hw/virtio/virtio-pci.c

In 4b/ please mention the bug report and backtrace.

You might squash 1 + 4a or 4a + 4b.

Regards,

Phil.


