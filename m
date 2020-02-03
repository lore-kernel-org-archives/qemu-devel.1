Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A0C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD75920732
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0/B2V85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD75920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyk6p-00069j-Qf
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 17:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1iyk5p-0005i2-Md
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1iyk5k-0005o8-Pa
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:21:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1iyk5k-0005ih-0B
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580768470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ai3RVoE1TG0a/Rx2LKoUeOR37qCR/j/lgzRY2cEbE18=;
 b=K0/B2V8514vhydG6QnTuEXK7pUJcpdBvt++OSNBDU2UgDYBXQgyrIOiGUXTViM8Qx830U7
 g77Gu6aI+x62iiBCmzbFKLHlPlnHkZhP8SP2wQGcYY/DvNYHlvI9KS53CxzE7OJgILXPZ9
 xT9wsYeprjNz2uJNrB+2vE6YaKRnHOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-khqj7gooOm2k-_4Zp1sKHg-1; Mon, 03 Feb 2020 17:19:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07747800D41
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 22:19:57 +0000 (UTC)
Received: from [10.10.121.233] (ovpn-121-233.rdu2.redhat.com [10.10.121.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 219C790F4D;
 Mon,  3 Feb 2020 22:19:51 +0000 (UTC)
From: Laine Stump <laine@redhat.com>
Subject: Disabling PCI "hot-unplug" for a guest (and/or a single PCI device)
To: libvir-list@redhat.com
Message-ID: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
Date: Mon, 3 Feb 2020 17:19:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: khqj7gooOm2k-_4Zp1sKHg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although I've never experienced it, due to not running Windows guests, 
I've recently learned that a Windows guest permits a user (hopefully 
only one with local admin privileges??!) to "hot-unplug" any PCI device. 
I've also learned that some hypervisor admins don't want to permit 
admins of the virtual machines they're managing to unplug PCI devices. I 
believe this is impossible to prevent on an i440fx-based machinetype, 
and can only be done on a q35-based machinetype by assigning the devices 
to the root bus (so that they are seen as integrated devices) rather 
than to a pcie-root-port. But when libvirt is assigning PCI addresses to 
devices in a q35-base guest, it will *always* assign a PCIe device to a 
pcie-root-port specifically so that hotplug is possible (this was done 
to maintain functional parity with i440fx guests, where all PCI slots 
support hotplug).


To make the above-mentioned admins happy, we need to make it possible to 
(easily) create guest configurations for q35-based virtual machines 
where the PCI devices can't be hot-unplugged by the guest OS.


Thinking in the context of a management platform (e.g. OpenStack or 
ovirt) that goes through libvirt to use QEMU (and forgetting about 
i440fx, concentrating only on q35), I can think of a few different ways 
this could be done:


1) Rather than leaving the task of assignung the PCI addresses of 
devices to libvirt (which is what essentially *all* management apps that 
use libvirt currently do), the management application could itself 
directly assign the PCI addressed of all devices to be slots on pcie.0.


This is problematic because once a management application has taken over 
the PCI address assignment of a single device, it must learn the rules 
of what type of device can be plugged into what type of PCI controller 
(including plugging in new controllers when necessary), and keep track 
of which slots on which PCI controllers are already in use - effectively 
tossing that part of libvirt's functionality / embedded knowledge / 
usefulness to management applications out the window. It's even more of 
a problem for management applications that have no provision for 
manually assigning PCI addresses - virt-manager for example only 
supports this by using "XML mode" where the froopy point-click UI is 
swapped out for an edit window where the user is simply presented with 
the full XML for a device and allowed to tweak it around as they see fit 
(including duplicate addresses, plugging the wrong kind of device into 
the wrong slot, referencing non-existent controllers, etc). (NB: you 
could argue that management could just take over PCI address assignment 
in the case of wanting hotplug disabled, and only care about / support 
pcie.0 (which makes the task much easier, since you just ignore the 
existence of any other PCI controllers, leaving you with a homogenous 
array of 32 slot x 8 functions, but becomes much more complicated if you 
want to allow a mix of hotpluggable and non-hotpluggable devices, and 
you *know* someone will)


2) libvirt could gain a knob "somewhere" in the domain XML to force a 
single device, or all devices, to be assigned to a PCI address on pcie.0 
rather than on a pcie-root-port. This could be thought of as a "hint" 
about device placement, as well as extra validation in the case that a 
PCI address has been manually assigned. So, for example, let's say a 
"hotplug='disable'" option is added somewhere at the top level of the 
domain (maybe "<hotplug enable='no'/>" inside <features> or something 
like that); when PCI addresses are assigned by libvirt, it would attempt 
to find a slot on a controller that didn't support hotplug. And/or a 
similar knob could be added to each device. In both cases, the setting 
would be used both when assigning PCI addresses and also to validate 
user-provided PCI addresses to assure that the desired criterion was met 
(otherwise someone would manually select a PCI address on a controller 
that supported hotplug, but then set "hotplug='disabled'" and expect 
hotplug to be magically disabled on the slot).


Some of you will remember that I proposed such a knob for libvirt a few 
years ago when we were first fleshing out support for QEMU's PCI Express 
controllers and the Q35 machinetype, and it was rejected as "libvirt 
dictating policy". Of course at that time there weren't actual users 
demanding the functionality, and now there are. Aside from that, all I 
can say is that it isn't libvirt dictating this policy, it's the user of 
libvirt, and libvirt is just following directions :-) (and that I really 
really dislike the idea of a forced handover of the entire task of 
assigning/managing device PCI addresses to management apps just because 
they decide they want to disable guest-initiated hotplug


3) qemu could add a "hotpluggable=no" commandline option to all PCI 
devices (including vfio-pci) and then do whatever is necessary to make 
sure this is honored in the emulated hardware (is it possible to set 
this on a per-slot basis in a PCI controller? Or must it be done for an 
entire controller? I suppose it's not as much of an issue for 
pcie-root-port, as long as you're not using multiple functions). libvirt 
would then need to add this option to the XML for each device, and 
management applications would need to set it - it would essentially look 
the same to the management application, but it would be implemented 
differently - instead of libvirt using that flag to make a choice about 
which slot to assign, it would assign PCI addresses in the same manner 
as before, and use the libvirt XML flag to set a QEMU commandline flag 
for the device.


The upside of this is that we would be disabling hotplug by "disabling 
hotplug" rather than by "assigning the device to a slot that 
coincidentally doesn't support hotplug", making it all more orthogonal - 
everything else in a guest's config could remain exactly the same while 
enabling/disabling hotplug. (Another upside is that it could possibly be 
made to work for i440fx machine types, but we're not supposed to care 
about that any more, so I won't mention it :-)) The downside is that it 
requires a new feature in QEMU (whose difficulty/feasibility I have 0 
knowledge of), so there are 3 layers of work rather than 2.


So does anyone have any different (and hopefully better) idea of how to 
do this? Arguments for/against the 3 possibilities I've listed here?



