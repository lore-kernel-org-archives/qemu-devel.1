Received: from eggs.gnu.org ([209.51.188.92]:60713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJ1v-0005C5-0H
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJ1t-0003By-RK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:33:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gpJ1t-00034v-G1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:33:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VKVnnk119204
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:33:24 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc84mg1yu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:33:23 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 31 Jan 2019 20:33:23 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-6-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 31 Jan 2019 15:33:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8f4b29e0-80c7-05f9-375b-842607d86131@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 5/6] s390x/pci: Drop
 release timer and replace it with a flag
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

nit: "over-complicates" or "over complicates"

> things and doesn't really.

"...and doesn't really." sounds odd to me :)

> 
> Let's allow to send multiple requests.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Just a quick clean up of the commit message, and all is good.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
