Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcnRn-0003JI-9Z
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcnRk-0000lQ-6k
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:52:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fcnRk-0000lG-1Z
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:52:28 -0400
Date: Tue, 10 Jul 2018 09:52:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180710095223.05c72466@redhat.com>
In-Reply-To: <20180705021038.14036-1-douly.fnst@cn.fujitsu.com>
References: <20180705021038.14036-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/acpi-build: Add a check for non-memory
 NUMA nodes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, ehabkost@redhat.com

On Thu, 5 Jul 2018 10:10:38 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Currently, Qemu ACPI builder doesn't consider the non-memory NUMA nodes, eg:
s/non-memory/memory-less/ throughout subj/commit message


>   -m 4G,slots=4,maxmem=8G \
>   -numa node,nodeid=0 \
>   -numa node,nodeid=1,mem=2G \
>   -numa node,nodeid=2,mem=2G \
>   -numa node,nodeid=3\
> 
> Guest Linux will report
> 
>   [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffffffffffff]
>   [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00000000-0x0009ffff]
>   [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00100000-0x7fffffff]
>   [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x80000000-0xbfffffff]
>   [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x100000000-0x13fffffff]
>   [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x13fffffff]
>   [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x33fffffff] hotplug
> 
> [mem 0x00000000-0xffffffffffffffff] and [mem 0x140000000-0x13fffffff] are bogus.
> 
> Add a check to avoid building srat memory for non-memory NUMA nodes, also update
> the test file. Now the info in guest linux will be
> 
>   [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00000000-0x0009ffff]
>   [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00100000-0x7fffffff]
>   [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x80000000-0xbfffffff]
>   [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x100000000-0x13fffffff]
>   [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x140000000-0x33fffffff] hotplug
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
> Have done a bootup test in Linux and window 10, 7

add here":
note to maintainer: update ACPI tables test blobs on commit.

with patch amended

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c                  |   9 ++++++---
>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 224 -> 224 bytes
>  tests/acpi-test-data/q35/SRAT.numamem | Bin 224 -> 224 bytes
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9e8350c55d..c584642e4e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2392,9 +2392,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              mem_len = next_base - pcms->below_4g_mem_size;
>              next_base = mem_base + mem_len;
>          }
> -        numamem = acpi_data_push(table_data, sizeof *numamem);
> -        build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                          MEM_AFFINITY_ENABLED);
> +
> +        if (mem_len > 0) {
> +            numamem = acpi_data_push(table_data, sizeof *numamem);
> +            build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +                              MEM_AFFINITY_ENABLED);
> +        }
>      }
>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {

Drop binary blobs from patch (for reviewer convenience we post
blobs as separate patch with DO NOT APPLY tag in subject).

Michael will update test blobs manually when merging your patch.

> diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/acpi-test-data/pc/SRAT.numamem
> index dbc595d9cb85d3fcb5a4243153f42bb431c9de8f..119922f4973f621602047d1dc160519f810922a3 100644
> GIT binary patch
> delta 24
> gcmaFB_<)fsILI;N0RsaA<JXB?78A3|ChpJx0A~{jk^lez
> 
> delta 24
> gcmaFB_<)fsILI;N0RsaA<ClqC787?#O*Cl%0A_s%T>t<8
> 
> diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/acpi-test-data/q35/SRAT.numamem
> index dbc595d9cb85d3fcb5a4243153f42bb431c9de8f..119922f4973f621602047d1dc160519f810922a3 100644
> GIT binary patch
> delta 24
> gcmaFB_<)fsILI;N0RsaA<JXB?78A3|ChpJx0A~{jk^lez
> 
> delta 24
> gcmaFB_<)fsILI;N0RsaA<ClqC787?#O*Cl%0A_s%T>t<8
> 
