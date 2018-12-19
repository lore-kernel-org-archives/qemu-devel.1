Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZYSj-0004bl-0l
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZYSf-0007kC-QF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:48:20 -0500
Date: Wed, 19 Dec 2018 10:48:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181219104807.4c11f39f.cohuck@redhat.com>
In-Reply-To: <1545154139-8740-2-git-send-email-pmorel@linux.ibm.com>
References: <1545154139-8740-1-git-send-email-pmorel@linux.ibm.com>
	<1545154139-8740-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390x/pci: add common function
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

On Tue, 18 Dec 2018 18:28:59 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.ibm.com>
> 
> Common function measurement block is used to report zPCI internal
> counters of successful pcilg/stg/stb and rpcit instructions to
> a memory location provided by the program.
> 
> This patch introduces a new ZpciFmb structure and schedules a timer
> callback to copy the zPCI measures to the FMB in the guest memory
> at an interval time set to 4s.
> 
> An error while attemping to update the FMB, would generate an error
> event to the guest.
> 
> The pcilg/stg/stb and rpcit interception handlers increase the
> related counter on a successul call.

s/successul/successful/

> The guest shall pass a null FMBA (FMB address) in the FIB (Function
> Information Block) when it issues a Modify PCI Function Control
> instruction to switch off FMB and stop the corresponding timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>  hw/s390x/s390-pci-inst.c | 129 +++++++++++++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 159 insertions(+), 4 deletions(-)
> 

> +static void fmb_update(void *opaque)
> +{
> +    S390PCIBusDevice *pbdev = opaque;
> +    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    int i;
> +
> +    /* Update U bit */
> +    pbdev->fmb.last_update *= 2;
> +    pbdev->fmb.last_update |= UPDATE_U_BIT;
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
> +                      pbdev->fmb.last_update, 8)) {
> +        return;
> +    }
> +
> +    /* Update FMB sample count */
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, sample),
> +                      pbdev->fmb.sample++, 4)) {
> +        return;
> +    }
> +
> +    /* Update FMB counters */
> +    for (i = 0; i < ZPCI_FMB_CNT_MAX; i++) {
> +        if (fmb_do_update(pbdev, offsetof(ZpciFmb, counter[i]),
> +                          pbdev->fmb.counter[i], 8)) {
> +            return;
> +        }
> +    }
> +
> +    /* Clear U bit and update the time */
> +    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    pbdev->fmb.last_update *= 2;
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
> +                      pbdev->fmb.last_update, 8)) {
> +        return;
> +    }
> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> +}
> +

Might be better to use sizeof() instead of hard-coded values when
calling fmb_do_update()?

Otherwise, looks good.
