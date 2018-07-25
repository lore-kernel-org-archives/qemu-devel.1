Received: from eggs.gnu.org ([2001:4830:134:3::10]:43079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiIxo-0008ED-Ad
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiIxl-0000Q2-Ak
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:32:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fiIxl-0000OQ-3c
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12E37F2B5B
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:32:16 +0000 (UTC)
Date: Wed, 25 Jul 2018 14:32:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180725143211.2fe32f43@redhat.com>
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH hack dontapply v2 0/7] Dynamic _CST
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On Tue, 10 Jul 2018 03:01:30 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Now that basic support for guest CPU PM is upstream, I started looking
> for making it migrateable.  Since a VM can be migrated between different
> hosts, PM info needs to change each time with move the VM to a different
> host.
Considering notification is async, so there will be a window when
guest will be using old Cstates on new host. What will happen if
machine is migrated to host that doesn't support a Cstate
that was used on source when guest was started?

> This adds infrastructure - based on Load/Unload - to support exactly
> that: QEMU generates AML (changing it on migration) and stores it in
> reserved memory, OSPM loads _CST from there on demand.
Cool and very tempting idea but I have 2 worries about this approach:
1. How well does it work with Windows based guests?
   (I've tried something similar but generating new AML from AML itself
    to get rid of our long if/else chains there to make up Notify target name.
    I ditched it (unfortunately I don't recall why) )

2. (probably biggest issue) Loading dynamically generated AML
   basically would make all AML code ABI, so that static AML
   in RAM of old QEMU version would match dynamic generated
   one on target side with new QEMU (/me generalizing approach beyond _CST support).
   I'd try to keep our AML version less as much as possible
   and go this route only if there is no other way to do it.

> This is a partially functional prototype.
> 
> What works:
>     loading _CST dynamically and reporting it to OSPM
> 
> What doesn't:
>     detecting host configuration and generating correct _CST package
>     notifying guest about the change to trigger _CST re-evaluation
>     disabling mwait/halt exists as appropriate
> 
> Michael S. Tsirkin (6):
>   acpi: aml: add aml_register()
>   acpi: generalize aml_package / aml_varpackage
>   acpi: aml_load/aml_unload
>   acpi: export acpi_checksum
>   acpi: init header without linking
>   acpi: aml generation for _CST
>   pc: HACK: acpi: tie in _CST object to Processor
> 
>  include/hw/acpi/acpi.h      |   2 +
>  include/hw/acpi/aml-build.h |  14 ++-
>  include/hw/acpi/cst.h       |   8 ++
>  include/hw/i386/pc.h        |   5 ++
>  hw/acpi/aml-build.c         |  81 ++++++++++++++---
>  hw/acpi/core.c              |   2 +-
>  hw/acpi/cpu.c               |   5 ++
>  hw/acpi/cpu_hotplug.c       |  11 +--
>  hw/acpi/cst.c               | 173 ++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    |   2 +-
>  hw/i386/acpi-build.c        |  10 ++-
>  hw/acpi/Makefile.objs       |   2 +-
>  12 files changed, 290 insertions(+), 25 deletions(-)
>  create mode 100644 include/hw/acpi/cst.h
>  create mode 100644 hw/acpi/cst.c
> 
