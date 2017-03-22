Received: from eggs.gnu.org ([2001:4830:134:3::10]:45542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqmv6-0000XQ-HW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqmv3-0004B2-Cy
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cqmv3-00049u-83
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1252DC065107
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 20:31:45 +0000 (UTC)
Date: Wed, 22 Mar 2017 17:31:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170322203140.GA12155@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Hi,

I am investigating the current status of has_dynamic_sysbus and
sysbus device support on each of QEMU's machine types. The good
news is that almost all has_dynamic_sysbus=1 machines have their
own internal (often short) whitelist of supported sysbus device
types, and automatically reject unsupported devices.

...except for q35.

q35 currently accepts all sys-bus-device subtypes on "-device",
and today this includes the following 23 devices:

* allwinner-ahci
* amd-iommu
* cfi.pflash01
* esp
* fw_cfg_io
* fw_cfg_mem
* generic-sdhci
* hpet
* intel-iommu
* ioapic
* isabus-bridge
* kvmclock
* kvm-ioapic
* kvmvapic
* SUNW,fdtwo
* sysbus-ahci
* sysbus-fdc
* sysbus-ohci
* unimplemented-device
* virtio-mmio
* xen-backend
* xen-sysdev

My question is: do all those devices really make sense to be used
with "-device" on q35? Should we make q35 validate dynamic sysbus
devices against a whitelist, like the other has_dynamic_sysbus
machines?

I'm asking this because I will resume work on the
"query-device-slots" command, which will report supported sysbus
devices too. And I don't want the new command to report any
devices that it shouldn't.

-- 
Eduardo
