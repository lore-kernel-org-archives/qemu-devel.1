Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGm1v-0000yn-24
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cGm1r-0000fb-25
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:17:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40047
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cGm1q-0000fQ-R0
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:17:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBDCEvEk068087
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 07:17:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27afuj322h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 07:17:53 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 13 Dec 2016 12:17:51 -0000
References: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 13 Dec 2016 13:17:45 +0100
MIME-Version: 1.0
In-Reply-To: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <b272a7e2-8110-c1e5-c553-e7c0f2907b04@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8.1 v2] machine: Convert abstract
 typename on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>



On 12/12/2016 09:49 PM, Eduardo Habkost wrote:
> Original problem description by Greg Kurz:
> 
>> Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio
>> behaviour", passing -device virtio-blk-pci.disable-modern=off
>> has no effect on 2.6 machine types because the internal
>> virtio-pci.disable-modern=on compat property always prevail.
> The same bug also affects other abstract type names mentioned on
> compat_props by machine-types: apic-common, i386-cpu, pci-device,
> powerpc64-cpu, s390-skeys, spapr-pci-host-bridge, usb-device,
> virtio-pci, x86_64-cpu.
> 
> The right fix for this problem is to make sure compat_props and
> -global options are always applied in the order they are
> registered, instead of reordering them based on the type
> hierarchy. But changing the ordering rules of -global is risky
> and might break existing configurations, so we shouldn't do that
> on a stable branch.
> 
> This is a temporary hack that will work around the bug when
> registering compat_props properties: if we find an abstract class
> on compat_props, register properties for all its non-abstract
> subtypes instead. This will make sure -global won't be overridden
> by compat_props, while keeping the existing ordering rules on
> -global options.
> 
> Note that there's one case that won't be fixed by this hack:
> "-global spapr-pci-vfio-host-bridge.<option>=<value>" won't be
> able to override compat_props, because spapr-pci-host-bridge is
> not an abstract class.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
