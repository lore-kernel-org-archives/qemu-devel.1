Received: from eggs.gnu.org ([209.51.188.92]:40620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpWDv-0007uF-3a
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpWDp-0001lL-C6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:39:02 -0500
Date: Fri, 1 Feb 2019 11:38:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190201113845.3af53d6a.cohuck@redhat.com>
In-Reply-To: <20190130155733.32742-5-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Introduce unplug
 requests and split unplug handler
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

On Wed, 30 Jan 2019 16:57:31 +0100
David Hildenbrand <david@redhat.com> wrote:

> PCI on s390x is really weird and how it was modeled in QEMU might not have
> been the right choice. Anyhow, right now it is the case that:
> - Hotplugging a PCI device will silently create a zPCI device
>   (if none is provided)
> - Hotunplugging a zPCI device will unplug the PCI device (if any)
> - Hotunplugging a PCI device will unplug also the zPCI device
> As far as I can see, we can no longer change this behavior. But we
> should fix it.
> 
> Both device types are handled via a single hotplug handler call. This
> is problematic for various reasons:
> 1. Unplugging via the zPCI device allows to unplug devices that are not
>    hot removable. (check performed in qdev_unplug()) - bad.
> 2. Hotplug handler chains are not possible for the unplug case. In the
>    future, the machine might want to override hotplug handlers, to
>    process device specific stuff and to then branch off to the actual
>    hotplug handler. We need separate hotplug handler calls for both the
>    PCI and zPCI device to make this work reliably. All other PCI
>    implementations are already prepared to handle this correctly, only
>    s390x is missing.
> 
> Therefore, introduce the unplug_request handler and properly perform
> unplug checks by redirecting to the separate unplug_request handlers.
> When finally unplugging, perform two separate hotplug_handler_unplug()
> calls, first for the PCI device, followed by the zPCI device. This now
> nicely splits unplugging paths for both devices.
> 
> The redirect part is a little hairy, as the user is allowed to trigger
> unplug either via the PCI or the zPCI device. So redirect always to the
> PCI unplug request handler first and remember if that check has been
> performed in the zPCI device. Redirect then to the zPCI device unplug
> request handler to perform the magic. Remembering that we already
> checked the PCI device breaks the redirect loop.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 166 +++++++++++++++++++++++++++-------------
>  hw/s390x/s390-pci-bus.h |   1 +
>  2 files changed, 113 insertions(+), 54 deletions(-)

Thanks, applied.
