Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGlbF-0006uW-25
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGlbB-0001Xt-Vb
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:50:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57247
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cGlbB-0001Xe-Pf
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:50:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBDBoFfk121532
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 06:50:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27adk1gru8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 06:50:19 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 13 Dec 2016 11:49:31 -0000
Date: Tue, 13 Dec 2016 12:49:20 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
References: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161213124920.4d3c0d7d.cornelia.huck@de.ibm.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

On Mon, 12 Dec 2016 18:49:05 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Original problem description by Greg Kurz:
> 
> > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio
> > behaviour", passing -device virtio-blk-pci.disable-modern=off
> > has no effect on 2.6 machine types because the internal
> > virtio-pci.disable-modern=on compat property always prevail.
> 
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

Hm...

static void spapr_phb_vfio_instance_init(Object *obj)
{
    if (!qtest_enabled()) {
        error_report("spapr-pci-vfio-host-bridge is deprecated");
    }
}

I guess we can live with that :)

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 (RFC) -> v2:
> * New commit message
> * Clarified comments
>   Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> * Moved variable declaration outside of loop
>   Suggested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
