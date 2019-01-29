Received: from eggs.gnu.org ([209.51.188.92]:60840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goTUS-0001oq-Na
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goTUQ-0001MS-PQ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:31:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1goTUK-0001I9-0M
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:31:43 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDRW6Z104521
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:31:33 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qangh02dp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:31:32 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 29 Jan 2019 13:31:29 -0000
Reply-To: pmorel@linux.ibm.com
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 29 Jan 2019 14:31:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190121134249.16615-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7f7d8582-b6d2-b120-c768-8cc8350b416c@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/pci: Introduce unplug
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 21/01/2019 14:42, David Hildenbrand wrote:
> PCI on s390x is really weird and how it was modeled in QEMU might not h=
ave
> been the right choice. Anyhow, right now it is the case that:
> - Hotplugging a PCI device will silently create a zPCI device
>    (if none is provided)
> - Hotunplugging a zPCI device will unplug the PCI device (if any)
> - Hotunplugging a PCI device will unplug also the zPCI device
> As far as I can see, we can no longer change this behavior. But we
> should fix it.

hum, is it really a problem per se?

>=20
> Both device types are handled via a single hotplug handler call. This
> is problematic for various reasons:
> 1. Unplugging via the zPCI device allows to unplug PCI bridges as
>     checks are not performed - bad.

bad

> 2. Unplugging via the zPCI device allows to unplug devices that are not
>     hot removable. (check performed in qdev_unplug()) - bad.

bad

> 3. Hotplug handler chains are not possible for the unplug case. In the
>     future, the machine might want to override hotplug handlers, to
>     process device specific stuff and to then branch off to the actual
>     hotplug handler. We need separate hotplug handler calls for both th=
e
>     PCI and zPCI device to make this work reliably. All other PCI
>     implementations are already prepared to handle this correctly, only
>     s390x is missing.

ok

>=20
> Therefore, introduce the unplug_request handler and properly perform
> unplug checks by redirecting to the separate unplug_request handlers.
> When finally unplugging, perform two separate hotplug_handler_unplug()
> calls, first for the PCI device, followed by the zPCI device. This now
> nicely splits unplugging paths for both devices.

hum, PCI device handle the backend, host side, while zPCI handle the=20
front end, guest side.
So unplugging PCI first will deny the guest any possibility to smoothly=20
relinquish a device.


Is it possible the other way around?

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
