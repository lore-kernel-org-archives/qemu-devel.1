Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff2BL-0003pX-Aj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff2BD-0007HG-4F
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:00:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ff2BC-0007GT-TB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:00:39 -0400
Date: Mon, 16 Jul 2018 14:00:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716140035.0345db39@redhat.com>
In-Reply-To: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 0/6] Build ACPI Heterogeneous
 Memory Attribute Table (HMAT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com, qemu-devel@nongnu.org

On Tue, 19 Jun 2018 23:20:51 +0800
Liu Jingqi <jingqi.liu@intel.com> wrote:

> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the System Physical Address (SPA) Memory Ranges.
> The software is expected to use this information as hint for optimization.
> 
> OSPM evaluates HMAT only during system initialization. Any changes to the HMAT
> state at runtime or information regarding HMAT for hot plug are communicated
> using the _HMA method.
> 
> Liu Jingqi (6):
>   hmat acpi: Build Memory Subsystem Address Range Structure(s) in ACPI
>     HMAT
you've converted this patch to build_append_int_noprefix() API as requested

>   hmat acpi: Build System Locality Latency and Bandwidth Information
>     Structure(s) in ACPI HMAT
>   hmat acpi: Build Memory Side Cache Information Structure(s) in ACPI
>     HMAT
but left out above 2 with the same issues.
So I'd repeat,
using "struct FOO {} packed" is discouraged, you should use
build_append_int_noprefix() API to build ACPI tables

>   numa: Extend the command-line to provide memory latency and bandwidth
>     information
>   numa: Extend the command-line to provide memory side cache information
>   hmat acpi: Implement _HMA method to update HMAT at runtime
> 
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/acpi/Makefile.objs              |   1 +
>  hw/acpi/hmat.c                     | 649 +++++++++++++++++++++++++++++++++++++
>  hw/acpi/hmat.h                     | 264 +++++++++++++++
>  hw/i386/acpi-build.c               | 122 ++++---
>  hw/i386/acpi-build.h               |  10 +
>  hw/i386/pc.c                       |   2 +
>  hw/i386/pc_piix.c                  |   3 +
>  hw/i386/pc_q35.c                   |   3 +
>  include/hw/i386/pc.h               |   2 +
>  include/sysemu/numa.h              |   2 +
>  numa.c                             | 202 ++++++++++++
>  qapi/misc.json                     | 160 ++++++++-
>  qemu-options.hx                    |  28 +-
>  14 files changed, 1401 insertions(+), 48 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
> 
