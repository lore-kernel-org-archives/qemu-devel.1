Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqn90-0003D8-Pi
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqn8x-00087H-M2
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqn8x-00087D-Fb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 472DA7FD68
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 20:46:07 +0000 (UTC)
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
Date: Wed, 22 Mar 2017 21:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170322203140.GA12155@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 03/22/17 21:31, Eduardo Habkost wrote:
> Hi,
> 
> I am investigating the current status of has_dynamic_sysbus and
> sysbus device support on each of QEMU's machine types. The good
> news is that almost all has_dynamic_sysbus=1 machines have their
> own internal (often short) whitelist of supported sysbus device
> types, and automatically reject unsupported devices.
> 
> ...except for q35.
> 
> q35 currently accepts all sys-bus-device subtypes on "-device",
> and today this includes the following 23 devices:
> 
> * allwinner-ahci
> * amd-iommu
> * cfi.pflash01
> * esp
> * fw_cfg_io
> * fw_cfg_mem
> * generic-sdhci
> * hpet
> * intel-iommu
> * ioapic
> * isabus-bridge
> * kvmclock
> * kvm-ioapic
> * kvmvapic
> * SUNW,fdtwo
> * sysbus-ahci
> * sysbus-fdc
> * sysbus-ohci
> * unimplemented-device
> * virtio-mmio
> * xen-backend
> * xen-sysdev
> 
> My question is: do all those devices really make sense to be used
> with "-device" on q35?

I think fw_cfg_io and fw_cfg_mem should be board-only devices (no
-device switch).

Regarding cfi.pflash01, I think originally it would have been nice to
specify pflash chips with the modern (non-legacy) syntax, that is,
separate -drive if=none,file=... backend options combined with -device
cfi.pflash01,drive=... frontend options. However, that ship has sailed,
even libvirt uses -drive if=pflash for these, and given the purpose we
use pflash chips for, on Q35, I don't see much benefit in exposing
cfi.pflash01 with a naked -device *now*.

Re: virtio-mmio, I don't think that should be available on Q35 at all.

I can't comment on the rest.

Thanks
Laszlo

> Should we make q35 validate dynamic sysbus
> devices against a whitelist, like the other has_dynamic_sysbus
> machines?
> 
> I'm asking this because I will resume work on the
> "query-device-slots" command, which will report supported sysbus
> devices too. And I don't want the new command to report any
> devices that it shouldn't.
> 
