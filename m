Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQihI-0007ln-1s
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQihE-0000jM-2Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQihD-0000iR-Pv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:17:59 -0400
Date: Fri, 30 Jun 2017 02:17:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630020622-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 12:55:56AM +0300, Aleksandr Bezzubikov wrote:
> The series adds hotplug support to legacy PCI buses for Q35 machines.
> The ACPI hotplug code is emitted if at least one legacy pci-bridge is present.
> 
> This series is mostly based on past Marcel's series 
> https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05681.html,
> but rebased on current master with some minor changes according to current codebase.
> 
> ACPI code emission approach used in this series can be called "static", 
> because it checkswhether a bridge exists only at initial DSDT generation moment. 
> The main goal is to enable AML PCI hotplug-related code to be generated dynamically. 
> In other words, the bridge plugged in - a new acpi definition block is
> loaded (using LoadTable method). 
> This is necessary for PCIE-PCI bridge hotplugging feature. 

I wonder whether we really need ACPI hotplug.
Most modern systems are limited to native PCIE.

I do understand the need to add PCI devices sometimes,
but maybe we can find a way to do this with native hotplug.

For example, how about the following approach


- PCIE downstream port - X - PCIE-to-PCI bridge - PCI device


By hotplugging the bridge+device combination into a downstream
port (point X) we can potentially make devices enumerate
properly.

This might cause some issues with IO port assignment (uses 4K
io port space due to bridge aperture limitations)
but maybe we do not need so many legacy PCI devices -
people who do can simply use piix.


For this to work we need a way to create bridge instance
that is invisible to the guest. There is already a
way to do this for multifunction devices:

create bridge in function != 0
attach device
then create a dummy function 0

Inelegant - it would be cleaner to support this for function 0
as well - but should allow you to test the idea directly.



> Aleksandr Bezzubikov (6):
>   hw/acpi: remove dead acpi code
>   hw/acpi: simplify dsdt building code
>   hw/acpi: fix pcihp io initialization
>   hw/acpi: prepare pci hotplug IO for ich9
>   hw/acpi: extend acpi pci hotplug support for pci express
>   hw/ich9: enable acpi pci hotplug
> 
>  hw/acpi/ich9.c         |  31 +++++++++++++
>  hw/i386/acpi-build.c   | 116 ++++++++++++++++++++++++-------------------------
>  hw/isa/lpc_ich9.c      |  12 +++++
>  include/hw/acpi/ich9.h |   4 ++
>  include/hw/i386/pc.h   |   7 ++-
>  5 files changed, 111 insertions(+), 59 deletions(-)
> 
> -- 
> 2.7.4
