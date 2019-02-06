Received: from eggs.gnu.org ([209.51.188.92]:43386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKo3-0002uY-Rl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKo2-0006nD-SC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:51:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1grKo2-0006j7-Jp
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:51:50 -0500
Date: Wed, 6 Feb 2019 11:51:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190206115138.7a84a522@Igors-MacBook-Pro.local>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>
Cc: eblake@redhat.com, mst@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, karl.heubaum@oracle.com, jingqi.liu@intel.com, danmei.wei@intel.com, qemu-devel@nongnu.org

On Thu, 31 Jan 2019 15:16:50 +0800
Tao Xu <tao3.xu@intel.com> wrote:

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
> From 1 to 6 patches are the former V1 patches. From 7 to 8 patches are the
> updates per Igor and Eric's comments.
> 
> The V2 patches link:
> http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02276.html
> The V1 RESEND patches link:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg05368.html

pls, use build_append_int_noprefix() to build parts of ACPI table in all patches

> 
> Changelog:
> v3:
>   Per Eric's comments
>     - rebase the fixing patch into the jingqi's patches
>     - update the version tag from 3.10 to 4.0
> v2:
>   Per Igor and Eric's comments, fix some coding style and small issues:
>     - update the version number in qapi/misc.json
>     - including the expansion of the acronym HMAT in qapi/misc.json
>     - correct spell mistakes in qapi/misc.json and qemu-options.hx
>     - fix the comment syle in hw/i386/acpi-build.c
>     and hw/acpi/hmat.h
>    - remove some unnecessary head files in hw/acpi/hmat.c
>    - use hardcoded numbers from spec to generate
>    Memory Subsystem Address Range Structure in hw/acpi/hmat.c
>    - drop the struct AcpiHmat and AcpiHmatSpaRange
>     in hw/acpi/hmat.h
>   Per Igor's comment, rewrite NFIT code to build _HMA method.
> 
> Liu Jingqi (6):
>   hmat acpi: Build Memory Subsystem Address Range Structure(s) in ACPI
>     HMAT
>   hmat acpi: Build System Locality Latency and Bandwidth Information
>     Structure(s) in ACPI HMAT
>   hmat acpi: Build Memory Side Cache Information Structure(s) in ACPI
>     HMAT
>   Extend the command-line to provide memory latency and bandwidth
>     information
>   numa: Extend the command-line to provide memory side cache information
>   hmat acpi: Implement _HMA method to update HMAT at runtime
> 
> Tao Xu (2):
>   hmat acpi: move some function inside of the caller
>   acpi: rewrite the _FIT method to use it in _HMA method
> 
>  default-configs/i386-softmmu.mak |   1 +
>  hw/acpi/Makefile.objs            |   1 +
>  hw/acpi/hmat.c                   | 424 +++++++++++++++++++++++++++++++
>  hw/acpi/hmat.h                   | 245 ++++++++++++++++++
>  hw/acpi/nvdimm.c                 | 389 ++++++++++++++++++----------
>  hw/i386/acpi-build.c             | 125 +++++----
>  hw/i386/acpi-build.h             |  10 +
>  hw/i386/pc.c                     |   2 +
>  hw/i386/pc_piix.c                |   3 +
>  hw/i386/pc_q35.c                 |   3 +
>  include/hw/i386/pc.h             |   2 +
>  include/hw/mem/nvdimm.h          |  11 +
>  include/sysemu/numa.h            |   2 +
>  numa.c                           | 202 +++++++++++++++
>  qapi/misc.json                   | 162 +++++++++++-
>  qemu-options.hx                  |  28 +-
>  16 files changed, 1427 insertions(+), 183 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
> 
