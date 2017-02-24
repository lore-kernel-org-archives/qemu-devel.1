Received: from eggs.gnu.org ([2001:4830:134:3::10]:43540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1chDp3-0000cl-7Y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1chDoy-0008Qw-6G
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:14:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1chDox-0008Py-Sa
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1OBCO3H088366
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:13:54 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28tc28hmy8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:13:54 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 21:13:51 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <148776029578.5865.5785337570950575739.stgit@bahia>
References: <148776029578.5865.5785337570950575739.stgit@bahia>
Date: Fri, 24 Feb 2017 16:42:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lzj3kqy.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: populate PCI DT in reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Greg Kurz <groug@kaod.org> writes:

> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
>
> Since commit 1d2d974244c6 "spapr_pci: enumerate and add PCI device tree", QEMU
> populates the PCI device tree in the opposite order compared to SLOF.
>
> Before 1d2d974244c6:
>
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
>
> 7e5294b8 :  /pci@800000020000000
> 7e52b998 :  |-- ethernet@0
> 7e52c0c8 :  |-- scsi@1
> 7e52c7e8 :  +-- unknown-legacy-device@2 ok
>
> Since 1d2d974244c6:
>
> Populating /pci@800000020000000
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>
> 7e5e8118 :  /pci@800000020000000
> 7e5ea6a0 :  |-- unknown-legacy-device@2
> 7e5eadb8 :  |-- scsi@1
> 7e5eb4d8 :  +-- ethernet@0 ok
>
> This behaviour change is not actually a bug since no assumptions should be
> made on DT ordering. But it has no real justification either, other than
> being the consequence of the way fdt_add_subnode() inserts new elements
> to the front of the FDT rather than adding them to the tail.
>
> This patch reverts to the historical SLOF ordering by walking PCI devices
> in reverse order. This reconciles pseries with x86 machine types behavior.
> It is expected to make things easier when porting existing applications to
> power.
>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> (slight update to the changelog)
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/pci/pci.c         |   28 ++++++++++++++++++++++++++++
>  hw/ppc/spapr_pci.c   |   12 ++++++------
>  include/hw/pci/pci.h |    4 ++++
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> David,
>
> This patch was posted and already discussed during 2.5 development:
>
> http://patchwork.ozlabs.org/patch/549925/
>
> The "consensus" at the time was that guests should not rely on device
> ordering (i.e. use persistent naming instead).
>
> I got recently contacted by OpenStack people who had several complaints
> about the reverse ordering of PCI devices in pseries: different behavior
> between ppc64 and x86, lots of time spent in debugging when porting
> applications from x86 to ppc64 before realizing that it is caused by the
> reverse ordering, necessity to carry hacky workarounds...
>
> One strong argument against handling this properly with persistent naming
> is that it requires systemd/udev. This option is considered as painful
> with CirrOS, which aims at remaining as minimal as possible and is widely
> used in the OpenStack ecosystem.
>
> Would you re-consider your position and apply this patch ?

+1

I was the one who introduced the reverse ordering inadvertently.

Regards
Nikunj
