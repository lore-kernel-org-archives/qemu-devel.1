Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC6C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52CC2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvnsLc0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52CC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3HS-0003T3-WE
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iz3B2-0000qI-Ic
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iz3Az-0000rr-Dc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:43:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iz3Az-0000ea-06
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580841834;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXGiDt59cJ2kbq+0F66RfMVXNmw/WMtVS+HyPuMofzk=;
 b=KvnsLc0W40JT0qomDlAOCwsQnM0Uk/X3UlqnuAbMk4ZNIrXqotCxWtf5RmEnTZqYHsW202
 +Y6obIN0L3EBZfZUUhAOlpdIz4rsNEKXuyVexCSQYFwYhAVvJ4uG5BSK2qcsf8c2g2WcZZ
 6t9nM09xtc9H2oZXaw/WXHDbDrqMTLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Q5oGmxmcOgGeZhKAJmgnSw-1; Tue, 04 Feb 2020 13:43:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6827F1137849
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 18:43:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F4B186C4A;
 Tue,  4 Feb 2020 18:43:38 +0000 (UTC)
Date: Tue, 4 Feb 2020 18:43:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
Message-ID: <20200204184336.GG2205287@redhat.com>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Q5oGmxmcOgGeZhKAJmgnSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> Although I've never experienced it, due to not running Windows guests, I'=
ve
> recently learned that a Windows guest permits a user (hopefully only one
> with local admin privileges??!) to "hot-unplug" any PCI device. I've also
> learned that some hypervisor admins don't want to permit admins of the
> virtual machines they're managing to unplug PCI devices. I believe this i=
s
> impossible to prevent on an i440fx-based machinetype, and can only be don=
e
> on a q35-based machinetype by assigning the devices to the root bus (so t=
hat
> they are seen as integrated devices) rather than to a pcie-root-port. But
> when libvirt is assigning PCI addresses to devices in a q35-base guest, i=
t
> will *always* assign a PCIe device to a pcie-root-port specifically so th=
at
> hotplug is possible (this was done to maintain functional parity with i44=
0fx
> guests, where all PCI slots support hotplug).

After speaking with Alex & Laine on IRC, I learnt some further relevant
points

 - In a "typical" physical machine PCI slots will not be marked
   as hotpluggable - /sys/bus/pci/slots only has 2 entries on
   my HP DL180, corresponding to unused physical PCI slots
  =20
 - QEMU is hardcoded to report all pci & pcie-root-ports as hotpluggable.
   So /sys/bus/pci/slots on i440fx has 31 entries, one for every
   device, while on q35 it has one entry for every pcie-root-port
   IIUC.

 - It is conceptually possible to enhance pcie-root-port device
   to allow its hotplug capability to be toggled. Alternatively
   a parallel  pcie-root-port-nohotplug device could be created.
   The end result would be the same from guest POV

 - The vfio-pci device has a companion vfio-pci-nohotplug
   device. The difference is simply whether the QEMU DEviceClass
   has the "hotpluggable" attribute set, and is separate from
   whether the PCI(e) root port has hotplug enabled


The last point here about vfio-pci si particularly important,
as it shows libvirt needs to be capable of tracking hotpluggability
independantly on the PCI port and the PCI device attached to the
port.


> 1) Rather than leaving the task of assignung the PCI addresses of devices=
 to
> libvirt (which is what essentially *all* management apps that use libvirt
> currently do), the management application could itself directly assign th=
e
> PCI addressed of all devices to be slots on pcie.0.

[snip]

This is essentially a hack to work around the fact the the pcie-root-port
is hardcoded to report itself as hotpluggable.

As such I don't consider this is serious long term solution. If you
absolutely cannot wait for a newer libvirt/QEMU, this solution could
be used as a quick hack for mgmt apps, but long term we need todo
better.

> 2) libvirt could gain a knob "somewhere" in the domain XML to force a sin=
gle
> device, or all devices, to be assigned to a PCI address on pcie.0 rather
> than on a pcie-root-port. This could be thought of as a "hint" about devi=
ce
> placement, as well as extra validation in the case that a PCI address has
> been manually assigned. So, for example, let's say a "hotplug=3D'disable'=
"
> option is added somewhere at the top level of the domain (maybe "<hotplug
> enable=3D'no'/>" inside <features> or something like that); when PCI addr=
esses
> are assigned by libvirt, it would attempt to find a slot on a controller
> that didn't support hotplug. And/or a similar knob could be added to each
> device. In both cases, the setting would be used both when assigning PCI
> addresses and also to validate user-provided PCI addresses to assure that
> the desired criterion was met (otherwise someone would manually select a =
PCI
> address on a controller that supported hotplug, but then set
> "hotplug=3D'disabled'" and expect hotplug to be magically disabled on the
> slot).

Essentially this is the using "hotpluggable=3Dyes|no" on the device as
a policy knob to control device placement, to again workaround the
fact that pcie-root-port are hardcoded to always report themselves
as hotpluggable.

So I'd think this should be ruled out for the same reason as
option 1.

It has a second downside though. As we see from vfio-pci-nohotplug,
there is a valid use case for a "hotpluggable=3Dyes|no" attribute on
a device for controlling a specific hardware config choice in QEMU.

We don't want to overload this attribute to both control use of
vfio-pci-nohotplug, and also be a policy knob for device placement.


> 3) qemu could add a "hotpluggable=3Dno" commandline option to all PCI dev=
ices
> (including vfio-pci) and then do whatever is necessary to make sure this =
is
> honored in the emulated hardware (is it possible to set this on a per-slo=
t
> basis in a PCI controller? Or must it be done for an entire controller? I
> suppose it's not as much of an issue for pcie-root-port, as long as you'r=
e
> not using multiple functions). libvirt would then need to add this option=
 to
> the XML for each device, and management applications would need to set it=
 -
> it would essentially look the same to the management application, but it
> would be implemented differently - instead of libvirt using that flag to
> make a choice about which slot to assign, it would assign PCI addresses i=
n
> the same manner as before, and use the libvirt XML flag to set a QEMU
> commandline flag for the device.

I think this, or something close to it is the desirable way forward
here, as it gives us more explicit control over what the emulated
hardware actually advertizes. So instead of trying to workaround
limitations of QEMU, we'd be working /with/ QEMU to improve its
feature offerings.

In QEMU pcie-root-port either needs to gain a hotpluggable=3Dyes|no
attribute, or a second pcie-root-port-nohotplug needs adding.

Withever of these two approaches are taken in QEMU, this can be
controlled from libvirt via an attribute on the controller.eg

   <controller type=3D'pci' model=3D'pcie-root-port' hotpluggable=3D"no|yes=
"/>

This hotpluggable attribute can be mapped to whichever CLI syntax
QEMU wants to support.

This alone is probably sufficient for the Windows problem motivating
this thread.

There already exists the vfio-pci-nohotplug device, but this is not
exposed by libvirt. So we can add an attribute to <hostdev> to
control its use.

The remaining question is whether there's any compelling reason to
add non-hotpluggable variants of other devices, virtio-net-pci-nohotplug ?

I'd probably /not/ do this, unless there's a clear compelling benefit
it gives which can't be achieved already via the pcie-root-port
hotpluggability controls.


For management applications, with Q35 we already recommend that they
explicitly add *many*

   <controller type=3D'pci' model=3D'pcie-root-port'/>

to new guests. Enough to cover all the initial cold-plugged devices,
and enough spare ports to enable future hotplug of extra devices.
OpenStack for example will add 32 pcie-root-ports, so that Q35 has
approximately the same hotplug capacity as i440fx would have offered.

To control hotplug, management apps simply need tweak what they're
doing with pcie-root-ports with an extra attribute

eg, consider there were 4 devices on the initially booted VM which
need hotplug disabled, and we still want freedom to hotplug 2
extra devices at runtime.

   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"no"/>
   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"yes"/>
   <controller type=3D'pci' model=3D'pcie-root-port' hotplug=3D"yes"/>

This is quite easy, as applications still do *not* have to taken on
responsibility for full PCI device addressing. They merely need to
be able to count how many PCI devices they're using. The only "gotcha"
is if they forget about the auto-added USB, VGA and Balloon devices,
but that's not a big deal.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


