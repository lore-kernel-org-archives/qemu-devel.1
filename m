Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E58C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1862A20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBR6hL7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1862A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhZr-0003XD-7V
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGhYe-0002G7-AK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGhYa-0007L3-W5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGhYa-0007Kb-6K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585048635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4+PcyV+rSRWDwG5Lp1+QxxdtjQ4Fa3BgcCfMtvCuzs=;
 b=XBR6hL7Uu7orIDF8Ksr5YMMYEcPsEc1F1aG0PqZOHKHiRiImLQPxQfLVfd2Cgx5VqfNiG7
 uuWOUZNtQMoqkzsJcUzwl4pUZmx+txr03iT0qIQ9ZqZ0ahXq57xfAPaiDH/bBTNJ2w0nzc
 m33P25XGv/oSyLS1h8QpT24+L/XS9K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-G4-I9S9AO6SsuQidFtHaWA-1; Tue, 24 Mar 2020 07:17:13 -0400
X-MC-Unique: G4-I9S9AO6SsuQidFtHaWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA941005513;
 Tue, 24 Mar 2020 11:17:12 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98A745C1B2;
 Tue, 24 Mar 2020 11:17:04 +0000 (UTC)
Date: Tue, 24 Mar 2020 12:17:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Message-ID: <20200324121703.472b034b@redhat.com>
In-Reply-To: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 10:06:00 +0000
Ani Sinha <ani.sinha@nutanix.com> wrote:
[...]
> 
> To that end, I have been experimenting with Qemu using the patch I attach below. I have attached the virtio balloon driver with bus 1 which is attached to the pci bridge. Following is the libvirt 4.5 xml snippet which I am using:
> 
>    <controller type='pci' index='0' model='pci-root'>
>       <alias name='pci.0'/>
>    </controller>
>   <controller type='pci' index='1' model='pci-bridge'>
>       <model name='pci-bridge'/>
>       <target chassisNr='1'/>
>       <alias name='pci.1'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
>    </controller>
>   <memballoon model='virtio'>
>       <stats period='30'/>
>       <alias name='balloon0'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x01' function='0x0'/>
>    </memballoon>
> 
> 
> I am using a windows guest and from the guest I can see that the balloon driver is indeed attached to the pci bridge (see attached screenshot).
> I still find Windows giving me an option to hot eject the pci balloon driver.
> 
> So what am I doing wrong here?

you probably have APCI hotplug for bridges enabled (which applies to
all  cold-plugged bridges).
You can disable it by setting following property
 -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
then it should fall back to SHPC which are are tying to disable

> [cid:F2407B5B-BBB1-4A0C-91C4-975692E3BDE1]
> 
> 
> 
> The Qemu patch I am experimenting with (which is currently a hack) is attached below. It is based off Qemu 2.12 and not the latest mainline.
> 
> ---
> hw/pci-bridge/pci_bridge_dev.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index b2d861d..e706d49 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -58,7 +58,7 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
> 
>     pci_bridge_initfn(dev, TYPE_PCI_BUS);
> 
> -    if (bridge_dev->flags & (1 << PCI_BRIDGE_DEV_F_SHPC_REQ)) {
> +    if (0) {//bridge_dev->flags & (1 << PCI_BRIDGE_DEV_F_SHPC_REQ)) {
>         dev->config[PCI_INTERRUPT_PIN] = 0x1;
>         memory_region_init(&bridge_dev->bar, OBJECT(dev), "shpc-bar",
>                            shpc_bar_size(dev));
> @@ -161,7 +161,7 @@ static Property pci_bridge_dev_properties[] = {
>     DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
>                             ON_OFF_AUTO_AUTO),
>     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
> -                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> +                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
>     DEFINE_PROP_END_OF_LIST(),
> };
> 
> @@ -181,7 +181,7 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
>         VMSTATE_END_OF_LIST()
>     }
> };
> -
> +#if 0
> static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp)
> {
> @@ -208,12 +208,12 @@ static void pci_bridge_dev_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>     }
>     shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
> }
> -
> +#endif
> static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
>     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> -    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
> +    //HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
> 
>     k->realize = pci_bridge_dev_realize;
>     k->exit = pci_bridge_dev_exitfn;
> @@ -227,8 +227,8 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>     dc->props = pci_bridge_dev_properties;
>     dc->vmsd = &pci_bridge_dev_vmstate;
>     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug = pci_bridge_dev_hotplug_cb;
> -    hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
> +    //hc->plug = pci_bridge_dev_hotplug_cb;
> +    //hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
> }
> 
> static const TypeInfo pci_bridge_dev_info = {
> @@ -238,7 +238,7 @@ static const TypeInfo pci_bridge_dev_info = {
>     .class_init        = pci_bridge_dev_class_init,
>     .instance_finalize = pci_bridge_dev_instance_finalize,
>     .interfaces = (InterfaceInfo[]) {
> -        { TYPE_HOTPLUG_HANDLER },
> +        //{ TYPE_HOTPLUG_HANDLER },
>         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>         { }
>     }
> --
> 1.9.4
> 


