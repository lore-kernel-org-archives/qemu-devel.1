Received: from eggs.gnu.org ([209.51.188.92]:40855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpWEn-0008QS-El
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpWEm-0002BG-LV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:39:57 -0500
Date: Fri, 1 Feb 2019 11:39:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190201113948.1bae8beb.cohuck@redhat.com>
In-Reply-To: <20190130155733.32742-6-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] s390x/pci: Drop release timer and
 replace it with a flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On Wed, 30 Jan 2019 16:57:32 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's handle it similar to x86 ACPI PCI code and don't use a timer.
> Instead, remember if an unplug request is pending and keep it pending
> for eternity. (a follow up patch will process the request on
> reboot).
> 
> We expect that a guest that is up and running, will process the unplug
> request and trigger the unplug. This is normal operation, no timer needed.
> 
> If the guest does not react, this usually means something in the guest
> is going wrong. Simply removing the device after 30 seconds does not
> really sound like a good idea. It might sometimes be wanted, but I
> consider this rather an "opt-in" decision as it might harm a guest not
> prepared for it.
> 
> If we ever actually want a "forced/surprise removal", we will have to
> implement something on top of the existing "device_del" framework. E.g.
> also x86 might want to do a forced/surprise removal of PCI devices under
> some conditions. "device_del X, forced=true" could be an option and will
> require changes to the hotplug handler infrastructure.
> 
> This will then move the responsibility on when to do a forced removal
> to a higher level. Doing a forced removal right now overcomplicates
> things and doesn't really.
> 
> Let's allow to send multiple requests.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 38 +++++++-------------------------------
>  hw/s390x/s390-pci-bus.h |  3 +--
>  2 files changed, 8 insertions(+), 33 deletions(-)

Thanks, applied.
