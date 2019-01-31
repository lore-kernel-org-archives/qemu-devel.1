Received: from eggs.gnu.org ([209.51.188.92]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJ8Z-0007aK-EH
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJ8T-0005bk-Pp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:40:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gpJ8S-0005ZG-4q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:40:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VKdLA3096094
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:40:24 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qc65t5she-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:40:23 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 31 Jan 2019 20:40:23 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-5-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 31 Jan 2019 15:40:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <189454f3-61d4-cfff-5449-ae6510fd963a@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
> PCI on s390x is really weird and how it was modeled in QEMU might not have
> been the right choice. Anyhow, right now it is the case that:
> - Hotplugging a PCI device will silently create a zPCI device
>    (if none is provided)
> - Hotunplugging a zPCI device will unplug the PCI device (if any)
> - Hotunplugging a PCI device will unplug also the zPCI device
> As far as I can see, we can no longer change this behavior. But we
> should fix it.
> 
> Both device types are handled via a single hotplug handler call. This
> is problematic for various reasons:
> 1. Unplugging via the zPCI device allows to unplug devices that are not
>     hot removable. (check performed in qdev_unplug()) - bad.
> 2. Hotplug handler chains are not possible for the unplug case. In the
>     future, the machine might want to override hotplug handlers, to
>     process device specific stuff and to then branch off to the actual
>     hotplug handler. We need separate hotplug handler calls for both the
>     PCI and zPCI device to make this work reliably. All other PCI
>     implementations are already prepared to handle this correctly, only
>     s390x is missing.
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

Thanks for clearing up some of the areas I was having troubles following
during the last post. I think this looks a lot better than what we had
before. Patches 4, 5, and 6 make the code a lot easier to understand
what is going on here.

I assume you were able to squeeze in an easy test? At least making sure
we can still hot unplug a device from a guest successfully?

 From the code perspective:

Reviewed-by: Collin Walling <walling@linux.ibm.com>
