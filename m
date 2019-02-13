Received: from eggs.gnu.org ([209.51.188.92]:60302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gu0XL-0001JF-HD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gu0XJ-00007T-Tq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:49:39 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:55781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gu0XJ-0008FI-BZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:49:37 -0500
Received: from player158.ha.ovh.net (unknown [10.109.143.238])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id ADA2F42ABB
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:49:26 +0100 (CET)
Date: Wed, 13 Feb 2019 20:49:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213204921.059fdbac@bahia.lan>
In-Reply-To: <20190213172926.21740-1-farosas@linux.ibm.com>
References: <20190213172926.21740-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: fix out of bounds write
 in spapr_populate_drmem_v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Wed, 13 Feb 2019 15:29:26 -0200
Fabiano Rosas <farosas@linux.ibm.com> wrote:

> buf_len is uint8_t which is not large enough to hold the result of:
> 
>   nr_entries * sizeof(struct sPAPRDrconfCellV2) + sizeof(uint32_t);
> 
> for a nr_entries greater than 10.
> 
> This causes the allocated buffer 'int_buf' to be smaller than expected
> and we eventually overwrite some of glibc's control structures (see
> "chunk" in https://sourceware.org/glibc/wiki/MallocInternals)
> 
> The following error is seen while trying to free int_buf:
> 
>   "free(): invalid next size (fast)"
> 
> Fixes: a324d6f166 "spapr: Support ibm,dynamic-memory-v2 property"
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 332cba89d4..7c4bf8ed8c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -687,14 +687,14 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
>                                     int offset, MemoryDeviceInfoList *dimms)
>  {
>      MachineState *machine = MACHINE(spapr);
> -    uint8_t *int_buf, *cur_index, buf_len;
> +    uint8_t *int_buf, *cur_index;
>      int ret;
>      uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
>      uint64_t addr, cur_addr, size;
>      uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
>      uint64_t mem_end = machine->device_memory->base +
>                         memory_region_size(&machine->device_memory->mr);
> -    uint32_t node, nr_entries = 0;
> +    uint32_t node, buf_len, nr_entries = 0;
>      sPAPRDRConnector *drc;
>      DrconfCellQueue *elem, *next;
>      MemoryDeviceInfoList *info;
