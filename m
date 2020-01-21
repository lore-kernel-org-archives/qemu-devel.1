Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D96C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FACC21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAq9tny5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FACC21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ito22-00062r-Ct
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 02:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ito0v-0005Zs-D8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ito0p-00055x-Kc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:31:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ito0p-00055S-An
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579591906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8fhPLulwmKAbAGZd05laaXzW81eyFGVFOMHBU6mKI0=;
 b=KAq9tny519eo9ugcSA8J7Sj08tr89u94YBWgzwxpufljG51mKkSoEnisnnk5EUZ47OpY5P
 qaauNA/oNxFja3k3d1nA8mYpncf/5MO7KIA17Yvgodoo8kbx11sLTZs3sfyWsyYPi3sPhT
 YWoLChrH4Sunn4VuoVu92tqWaL8h7vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-VK6iPduRMCCWEBPbJY7BFw-1; Tue, 21 Jan 2020 02:31:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE0910054E3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:31:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3C18BE27;
 Tue, 21 Jan 2020 07:31:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07FD91138600; Tue, 21 Jan 2020 08:31:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] qdev: Introduce qdev_get_bus_device
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-2-jusual@redhat.com>
 <b3aec4e2-ef6d-5864-e29c-578c6cb7577f@redhat.com>
Date: Tue, 21 Jan 2020 08:31:30 +0100
In-Reply-To: <b3aec4e2-ef6d-5864-e29c-578c6cb7577f@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 16 Jan 2020 19:13:33
 +0100")
Message-ID: <87o8uxjmel.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VK6iPduRMCCWEBPbJY7BFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Julia,
>
> Cc'ing Markus for the qdev/qbus analysis.
>
> On 1/15/20 11:40 PM, Julia Suvorova wrote:
>> For bus devices, it is useful to be able to handle the parent device.
>>
>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>> ---
>>   hw/core/qdev.c                      |  5 +++++
>>   hw/pci-bridge/pci_expander_bridge.c |  4 +++-
>>   hw/scsi/scsi-bus.c                  |  4 +++-
>>   hw/usb/bus.c                        |  4 +++-
>>   hw/usb/dev-smartcard-reader.c       | 32 +++++++++++++++++++++--------
>>   hw/virtio/virtio-pci.c              | 16 +++++++++++++--
>>   include/hw/qdev-core.h              |  2 ++
>
> Please consider using the scripts/git.orderfile config.
>
>>   7 files changed, 54 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 9f1753f5cf..ad8226e240 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -114,6 +114,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState=
 *bus)
>>       }
>>   }
>>   +DeviceState *qdev_get_bus_device(const DeviceState *dev)
>
> We have qdev_get_bus_hotplug_handler(), this follow the naming, OK.
>
>> +{
>> +    return dev->parent_bus ? dev->parent_bus->parent : NULL;
>> +}
>> +
>>   /* Create a new device.  This only initializes the device state
>>      structure and allows properties to be set.  The device still needs
>>      to be realized.  See qdev-core.h.  */
>> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_exp=
ander_bridge.c
>> index 0592818447..63a6c07406 100644
>> --- a/hw/pci-bridge/pci_expander_bridge.c
>> +++ b/hw/pci-bridge/pci_expander_bridge.c
>> @@ -125,9 +125,11 @@ static char *pxb_host_ofw_unit_address(const SysBus=
Device *dev)
>>       assert(position >=3D 0);
>>         pxb_dev_base =3D DEVICE(pxb_dev);
>> -    main_host =3D PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
>> +    main_host =3D PCI_HOST_BRIDGE(qdev_get_bus_device(pxb_dev_base));
>>       main_host_sbd =3D SYS_BUS_DEVICE(main_host);
>>   +    g_assert(main_host);
>
> I found myself stuck reviewing this patch for 25min, I'm not sure
> what's bugging me yet, so I'll take notes a-la-Markus-style.
>
> We have the qdev API, with DeviceState.
>
>
> We have the qbus API, with BusState.
>
> A BusState is not a DeviceState but a raw Object.

It's a completely separate kind of Object.

> It keeps a pointer to the a DeviceState parent, a HotplugHandler, and
> a list of BusChild.
>
>
> BusChild are neither DeviceState nor Object, but keep a pointer the a
> DeviceState.

It's a thin wrapper around DeviceState to support collecting the
DeviceState into a list.

> TYPE_HOTPLUG_HANDLER is an interface. It can be implemented by any
> object, but its API seems expects a DeviceState as argument.

What do you mean by "interface expects an argument"?

The interface methods all take a HotplugHandler * and a DeviceState *.
The latter is the device being plugged / unplugged, the former is its
hotplug handler.  In the generic case, @dev's hotplug handler is
qdev_get_hotplug_handler(dev).

> Looking at examples implementing TYPE_HOTPLUG_HANDLER:
>
> - TYPE_USB_BUS. It inherits TYPE_BUS. Handlers will be called with
> USBDevice as argument (TYPE_USB_DEVICE -> TYPE_DEVICE).
>
> - TYPE_PCI_BRIDGE_DEV. Inherits TYPE_PCI_BRIDGE -> TYPE_PCI_DEVICE ->=20
> TYPE_DEVICE. Handlers expects PCIDevice (TYPE_PCI_DEVICE).
>
> - TYPE_PC_MACHINE. It inherits TYPE_X86_MACHINE -> TYPE_MACHINE ->=20
> TYPE_OBJECT. Not a TYPE_BUS. Handlers for TYPE_PC_DIMM, TYPE_CPU and
> TYPE_VIRTIO_PMEM_PCI. Complex... TYPE_PC_DIMM/TYPE_CPU are
> TYPE_DEVICE.
> For TYPE_VIRTIO_PMEM_PCI we have VirtIOPMEMPCI -> VirtIOPCIProxy ->=20
> PCIDevice.
>
> - USB_CCID_DEV. Inherits TYPE_USB_DEVICE -> TYPE_DEVICE. Only one
> 'unplug' handler which likely expects USBCCIDState.
>
> - TYPE_SCSI_BUS. Inherits TYPE_BUS. Also a single 'unplug' handler
> expecting SCSIDevice.
>
> - TYPE_VIRTIO_SCSI. Inherits TYPE_VIRTIO_SCSI_COMMON ->=20
> TYPE_VIRTIO_DEVICE -> TYPE_DEVICE. Handlers expect VirtIOSCSI.
>
>
> No simple pattern so far.
>
>
> Looking back at qbus. qbus_initfn() enforces a TYPE_HOTPLUG_HANDLER
> property on BusState (which is not a DeviceState). So IIUC TYPE_BUS
> also implements TYPE_HOTPLUG_HANDLER.

I think this merely creates a reference to the concrete bus's hotplug
handler.  TYPE_BUS is abstract, and doesn't implement any interfaces
(its .interfaces is empty).

Anything else you'd like me to check for you?

[...]


