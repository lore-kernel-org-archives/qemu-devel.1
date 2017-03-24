Received: from eggs.gnu.org ([2001:4830:134:3::10]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crNan-0003md-AU
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crNaj-0007SV-DO
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crNaj-0007SM-6v
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:41:13 -0400
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <83013730-a027-7bc6-70fc-be59270d5dc4@redhat.com>
Date: Fri, 24 Mar 2017 12:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170322203140.GA12155@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 22.03.2017 21:31, Eduardo Habkost wrote:
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

I think that SUNW,fdtwo device only makes sense on the sun4m machine, so
the code should likely be extracted from fdc.c into a separate file,
which should then only be compiled if CONFIG_SUN4M is set.

 Thomas

> * sysbus-ahci
> * sysbus-fdc
> * sysbus-ohci
> * unimplemented-device
> * virtio-mmio
> * xen-backend
> * xen-sysdev
> 
> My question is: do all those devices really make sense to be used
> with "-device" on q35? Should we make q35 validate dynamic sysbus
> devices against a whitelist, like the other has_dynamic_sysbus
> machines?
> 
> I'm asking this because I will resume work on the
> "query-device-slots" command, which will report supported sysbus
> devices too. And I don't want the new command to report any
> devices that it shouldn't.
> 
