Received: from eggs.gnu.org ([209.51.188.92]:55203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggT7A-00019U-S9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggT7A-0002Ak-1o
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:30:40 -0500
References: <1546510620-6707-1-git-send-email-pmorel@linux.ibm.com>
	<1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <787ebc5e-73e7-dfc8-fda5-91ac560f2e59@redhat.com>
Date: Mon, 7 Jan 2019 12:30:35 +0100
MIME-Version: 1.0
In-Reply-To: <1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 03.01.19 11:17, Pierre Morel wrote:
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
> related counter on a successful call.
> The guest shall pass a null FMBA (FMB address) in the FIB (Function
> Information Block) when it issues a Modify PCI Function Control
> instruction to switch off FMB and stop the corresponding timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>  hw/s390x/s390-pci-inst.c | 133 +++++++++++++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 163 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 060ff06..f0d34dd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -989,6 +989,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
>      bus = pci_get_bus(pci_dev);
>      devfn = pci_dev->devfn;
>      object_unparent(OBJECT(pci_dev));
> +    fmb_timer_free(pbdev);

I wonder if this should go into the unrealize function instead.



-- 

Thanks,

David / dhildenb
