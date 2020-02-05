Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A5C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B4921741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUsvUy7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B4921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNcw-0002Xo-95
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1izNZM-0008Bv-EI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1izNZK-0001bv-9H
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1izNZK-0001aM-3Y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580920225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f52w6ebl5ejOgvkvmMQsoDg9E13Xfwzbm5zspxj+lfU=;
 b=QUsvUy7w64GBfMoU7eOFpRADYhTC4UDiWRT2NIjDcDq8QmlJAGLkJvWCG+TNG9qzVaGcON
 ekZF3u3TsdKkvwbeVxRGyvo7th32qd5N12eUicfk8vfGvSP9XLoyhEWHGMv8LD/Ar8Ym6H
 h+uOLDatJR3iMVvCI/ZcUj37j4AXLRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-0yWj629rM3-_p-x9CUgbxw-1; Wed, 05 Feb 2020 11:30:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A260C800D54
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 16:30:07 +0000 (UTC)
Received: from [10.10.121.233] (ovpn-121-233.rdu2.redhat.com [10.10.121.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E91B8DC13;
 Wed,  5 Feb 2020 16:29:59 +0000 (UTC)
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
 <20200204184336.GG2205287@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <fc875022-31a3-2ef8-fdf9-ac8447886e9e@redhat.com>
Date: Wed, 5 Feb 2020 11:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204184336.GG2205287@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0yWj629rM3-_p-x9CUgbxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 1:43 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
>> Although I've never experienced it, due to not running Windows guests, I=
've
>> recently learned that a Windows guest permits a user (hopefully only one
>> with local admin privileges??!) to "hot-unplug" any PCI device. I've als=
o
>> learned that some hypervisor admins don't want to permit admins of the
>> virtual machines they're managing to unplug PCI devices. I believe this =
is
>> impossible to prevent on an i440fx-based machinetype, and can only be do=
ne
>> on a q35-based machinetype by assigning the devices to the root bus (so =
that
>> they are seen as integrated devices) rather than to a pcie-root-port. Bu=
t
>> when libvirt is assigning PCI addresses to devices in a q35-base guest, =
it
>> will *always* assign a PCIe device to a pcie-root-port specifically so t=
hat
>> hotplug is possible (this was done to maintain functional parity with i4=
40fx
>> guests, where all PCI slots support hotplug).
>=20
> After speaking with Alex & Laine on IRC, I learnt some further relevant
> points
>=20
>   - In a "typical" physical machine PCI slots will not be marked
>     as hotpluggable - /sys/bus/pci/slots only has 2 entries on
>     my HP DL180, corresponding to unused physical PCI slots
>    =20
>   - QEMU is hardcoded to report all pci & pcie-root-ports as hotpluggable=
.
>     So /sys/bus/pci/slots on i440fx has 31 entries, one for every
>     device, while on q35 it has one entry for every pcie-root-port
>     IIUC.
>=20
>   - It is conceptually possible to enhance pcie-root-port device
>     to allow its hotplug capability to be toggled. Alternatively
>     a parallel  pcie-root-port-nohotplug device could be created.
>     The end result would be the same from guest POV
>=20
>   - The vfio-pci device has a companion vfio-pci-nohotplug
>     device. The difference is simply whether the QEMU DEviceClass
>     has the "hotpluggable" attribute set, and is separate from
>     whether the PCI(e) root port has hotplug enabled
>=20
>=20
> The last point here about vfio-pci si particularly important,
> as it shows libvirt needs to be capable of tracking hotpluggability
> independantly on the PCI port and the PCI device attached to the
> port.
>=20
>=20
>> 1) Rather than leaving the task of assignung the PCI addresses of device=
s to
>> libvirt (which is what essentially *all* management apps that use libvir=
t
>> currently do), the management application could itself directly assign t=
he
>> PCI addressed of all devices to be slots on pcie.0.
>=20
> [snip]
>=20
> This is essentially a hack to work around the fact the the pcie-root-port
> is hardcoded to report itself as hotpluggable.
>=20
> As such I don't consider this is serious long term solution. If you
> absolutely cannot wait for a newer libvirt/QEMU, this solution could
> be used as a quick hack for mgmt apps, but long term we need todo
> better.
>=20
>> 2) libvirt could gain a knob "somewhere" in the domain XML to force a si=
ngle
>> device, or all devices, to be assigned to a PCI address on pcie.0 rather
>> than on a pcie-root-port. This could be thought of as a "hint" about dev=
ice
>> placement, as well as extra validation in the case that a PCI address ha=
s
>> been manually assigned. So, for example, let's say a "hotplug=3D'disable=
'"
>> option is added somewhere at the top level of the domain (maybe "<hotplu=
g
>> enable=3D'no'/>" inside <features> or something like that); when PCI add=
resses
>> are assigned by libvirt, it would attempt to find a slot on a controller
>> that didn't support hotplug. And/or a similar knob could be added to eac=
h
>> device. In both cases, the setting would be used both when assigning PCI
>> addresses and also to validate user-provided PCI addresses to assure tha=
t
>> the desired criterion was met (otherwise someone would manually select a=
 PCI
>> address on a controller that supported hotplug, but then set
>> "hotplug=3D'disabled'" and expect hotplug to be magically disabled on th=
e
>> slot).
>=20
> Essentially this is the using "hotpluggable=3Dyes|no" on the device as
> a policy knob to control device placement, to again workaround the
> fact that pcie-root-port are hardcoded to always report themselves
> as hotpluggable.
>=20
> So I'd think this should be ruled out for the same reason as
> option 1.
>=20
> It has a second downside though. As we see from vfio-pci-nohotplug,
> there is a valid use case for a "hotpluggable=3Dyes|no" attribute on
> a device for controlling a specific hardware config choice in QEMU.
>=20
> We don't want to overload this attribute to both control use of
> vfio-pci-nohotplug, and also be a policy knob for device placement.
>=20
>=20
>> 3) qemu could add a "hotpluggable=3Dno" commandline option to all PCI de=
vices
>> (including vfio-pci) and then do whatever is necessary to make sure this=
 is
>> honored in the emulated hardware (is it possible to set this on a per-sl=
ot
>> basis in a PCI controller? Or must it be done for an entire controller? =
I
>> suppose it's not as much of an issue for pcie-root-port, as long as you'=
re
>> not using multiple functions). libvirt would then need to add this optio=
n to
>> the XML for each device, and management applications would need to set i=
t -
>> it would essentially look the same to the management application, but it
>> would be implemented differently - instead of libvirt using that flag to
>> make a choice about which slot to assign, it would assign PCI addresses =
in
>> the same manner as before, and use the libvirt XML flag to set a QEMU
>> commandline flag for the device.
>=20
> I think this, or something close to it is the desirable way forward
> here, as it gives us more explicit control over what the emulated
> hardware actually advertizes. So instead of trying to workaround
> limitations of QEMU, we'd be working /with/ QEMU to improve its
> feature offerings.
>=20
> In QEMU pcie-root-port either needs to gain a hotpluggable=3Dyes|no
> attribute, or a second pcie-root-port-nohotplug needs adding.
>=20
> Withever of these two approaches are taken in QEMU, this can be
> controlled from libvirt via an attribute on the controller.eg
>=20
>     <controller type=3D'pci' model=3D'pcie-root-port' hotpluggable=3D"no|=
yes"/>
>=20
> This hotpluggable attribute can be mapped to whichever CLI syntax
> QEMU wants to support.
>=20
> This alone is probably sufficient for the Windows problem motivating
> this thread.
>=20
> There already exists the vfio-pci-nohotplug device, but this is not
> exposed by libvirt. So we can add an attribute to <hostdev> to
> control its use.
>=20
> The remaining question is whether there's any compelling reason to
> add non-hotpluggable variants of other devices, virtio-net-pci-nohotplug =
?
>=20
> I'd probably /not/ do this, unless there's a clear compelling benefit
> it gives which can't be achieved already via the pcie-root-port
> hotpluggability controls.
>=20
>=20
> For management applications, with Q35 we already recommend that they
> explicitly add *many*
>=20
>     <controller type=3D'pci' model=3D'pcie-root-port'/>
>=20
> to new guests. Enough to cover all the initial cold-plugged devices,
> and enough spare ports to enable future hotplug of extra devices.
> OpenStack for example will add 32 pcie-root-ports, so that Q35 has
> approximately the same hotplug capacity as i440fx would have offered.
>=20
> To control hotplug, management apps simply need tweak what they're
> doing with pcie-root-ports with an extra attribute
>=20
> eg, consider there were 4 devices on the initially booted VM which
> need hotplug disabled, and we still want freedom to hotplug 2
> extra devices at runtime.
>=20
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"yes"/>
>     <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"yes"/>
>=20
> This is quite easy,

Not quite so easy as you might think :-). The problem is that, in our=20
fervor to make Q35 guests "as similar as possible" to 440fx guests, we=20
have made the PCI address assignment code search out a hotplug-capable=20
slot for each unassigned device, and if no hotpluggable slot is=20
available it automatically adds a new root port so that there is a=20
hotplug-capable slot. With the current set of VIR_PCI_CONNECT_TYPE=20
flags, unless we lie to that code and tell it that these new root ports=20
support hotplug, the the devices will be assigned first to the two=20
available hotpluggable root ports (in your example above), and then when=20
those are both used, it will start adding new root ports - the ports=20
with hotplug=3D'no' will never be used.

On the other hand, if we change the code to *not* require a=20
hotplug-capable port, then the new devices will just be assigned to=20
slots on the root bus.

So the address assignment code is going to need to be re-jiggered. I=20
guess we would need to create yet another PCI controller capability for=20
use by the address assignment code - "Not=20
Hot-Pluggable-But-Still-Okay-For-Auto-Assign-When-The-Guest-Is-Powered-Off"=
.

So, a mental exercise - let's say we make a new virDomainPCIConnectFlag=20
called VIR_PCI_CONNECT_AUTO_ASSIGNABLE (that's a bit easier to say than=20
what I had in the previous paragraph). That connect type would be added=20
to all the controllers that currently have CONNECT_HOTPLUGGABLE set:

     pci-root
     pci-bridge
     pcie-root
     pcie-pci-bridge
     pcie-root-port
     pcie-downstream-port

We then add a new controller model=20
VIR_DOMAIN_CONTROLLER_PCIE_ROOT_PORT_NO_HOTPLUG and set it as=20
AUTO_ASSIGNABLE, but *not* HOTPLUGGABLE.

Now when a device is added to "cold" config, instead of requiring=20
HOTPLUGGABLE, we require AUTO_ASSIGNABLE, which will get the same=20
assignment as before the change (except that the NO_HOTPLUG root ports=20
will also be used). If we actually hotplug a device, then we continue to=20
require the HOTPLUGGABLE connect flag.

So that much works, but we still have the problem that in order to add a=20
device to the "cold" config that can later be hotplugged, we have to=20
make sure all of the hotplug=3D'no' controllers are in use.

I guess that will work, but it's getting pretty obtuse and complicated=20
just to avoid adding a single flag that says "this device shouldn't be=20
put in a hotplug-capable slot" directly to the XML for the device that=20
you don't want hotplugged. It would be *much* simpler if qemu could=20
provide an attribute for endpoint devices that would disable hotplug for=20
that device, rather than requiring the option to be set on the=20
controller that the device is plugged into. Then libvirt could just have=20
that attribute added to the XML, and the management app would just=20
simply add "hotplug=3D'no'" to each device. It's too bad that the method=20
vfio-pci-nohotplug uses apparently doesn't work for PCIe...


> as applications still do *not* have to taken on
> responsibility for full PCI device addressing. They merely need to
> be able to count how many PCI devices they're using. The only "gotcha"
> is if they forget about the auto-added USB, VGA and Balloon devices,
> but that's not a big deal.
>=20
> Regards,
> Daniel
>=20


