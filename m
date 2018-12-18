Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZC6G-0006A6-Rn
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZC6D-0005l5-CC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:55:40 -0500
Date: Tue, 18 Dec 2018 10:55:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181218105518.2574fa64.cohuck@redhat.com>
In-Reply-To: <1544806422-21418-2-git-send-email-pmorel@linux.ibm.com>
References: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
	<1544806422-21418-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On Fri, 14 Dec 2018 17:53:42 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.ibm.com>
> 
> Common function measurement block is used to report zPCI internal
> counters of successful pcilg/stg/stb and rpcit instructions to
> a memory location provided by the program.
> 
> This patch introduces a new ZpciFmb structure and schedules a timer
> callback to copy the zPCI measures to the FMB in the guest memory
> at an interval time set to 4s by default.

Hm, is there any way to change the interval? If not, just drop the "by
default"?

> 
> An error while attemping to update the FMB, would generated an error

s/generated/generate/

> event to the guest.
> 
> The pcilg/stg/stb and rpcit interception handlers issue, increase
> the related counter on success.

"When the ... handlers are called, ..." ?

> The guest shall pass a null FMBA (FMB address) in the FIB (Function
> Information Block) when it issues a Modify PCI Function Control
> instrcuction to switch off FMB and stop the corresponding timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 ++++++++++
>  hw/s390x/s390-pci-inst.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 171 insertions(+), 4 deletions(-)
> 

> +static int fmb_do_update64(S390PCIBusDevice *pbdev, int offset, int cnt)
> +{
> +    MemTxResult ret = MEMTX_OK;
> +    uint64_t dst = pbdev->fmb_addr + offset;
> +    uint64_t *src = (uint64_t *) ((unsigned long)(&pbdev->fmb) + offset);
> +    int i;
> +
> +    for (i = 0; i < cnt; i++, dst += 8, src++) {
> +        address_space_stq_be(&address_space_memory, dst, *src,
> +                             MEMTXATTRS_UNSPECIFIED, &ret);
> +        if (ret != MEMTX_OK) {
> +            s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
> +                                          pbdev->fmb_addr, 0);
> +            fmb_timer_free(pbdev);
> +            return ret;
> +        }
> +    }
> +    return ret;
> +}
> +
> +static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, int val, int len)
> +{
> +    MemTxResult ret;
> +    uint64_t dst = pbdev->fmb_addr + offset;
> +
> +    switch (len) {
> +    case 4:
> +        address_space_stl_be(&address_space_memory, dst, val,
> +                             MEMTXATTRS_UNSPECIFIED,
> +                             &ret);
> +        break;
> +    case 2:
> +        address_space_stw_be(&address_space_memory, dst, val,
> +                             MEMTXATTRS_UNSPECIFIED,
> +                             &ret);
> +        break;
> +    case 1:
> +        address_space_stb(&address_space_memory, dst, val,
> +                          MEMTXATTRS_UNSPECIFIED,
> +                          &ret);
> +        break;
> +    default:
> +        ret = MEMTX_ERROR;
> +        break;
> +    }
> +    if (ret != MEMTX_OK) {
> +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
> +                                      pbdev->fmb_addr, 0);
> +        fmb_timer_free(pbdev);
> +    }
> +
> +    return ret;
> +}
> +
> +static void fmb_update(void *opaque)
> +{
> +    S390PCIBusDevice *pbdev = opaque;
> +    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    uint8_t offset;
> +
> +    /* Update U bit */
> +    pbdev->fmb.last_update |= UPDATE_U_BIT;
> +    offset = offsetof(ZpciFmb, last_update);
> +    if (fmb_do_update64(pbdev, offset, 1)) {
> +        return;
> +    }
> +
> +    /* Update FMB sample count */
> +    offset = offsetof(ZpciFmb, sample);
> +    if (fmb_do_update(pbdev, offset, pbdev->fmb.sample++,
> +                      sizeof(pbdev->fmb.sample))) {

This is the only caller of fmb_do_update(), right? Any chance that a
new format of the block would introduce new callers?

> +        return;
> +    }
> +    /* Update FMB counters */
> +    offset = offsetof(ZpciFmb, counter);
> +    if (fmb_do_update64(pbdev, offset, ZPCI_FMB_CNT_MAX)) {
> +        return;
> +    }
> +
> +    /* Clear U bit and update the time */
> +    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    pbdev->fmb.last_update <<= 1;
> +    offset = offsetof(ZpciFmb, last_update);
> +    if (fmb_do_update64(pbdev, offset, 1)) {
> +        return;
> +    }

Hm, one thing that I don't quite like about the update code is the odd
split between fmb_do_update() (which always updates one value) and
fmb_do_update64() (which may update multiple values).

What does the code look like if you:
- have a fmb_do_update() that can also handle 64bit values,
- have the update of the counters loop and break out if you get an
  error?

Of course, you may have already tried that ;) If it looks ugly, I don't
have a real issue with this code, either.

> +
> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> +}
> +
>  int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
>                          uintptr_t ra)
>  {
