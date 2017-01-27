Received: from eggs.gnu.org ([2001:4830:134:3::10]:60122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cX6lf-0001Gg-Lz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cX6lb-0002Mn-QB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:40:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cX6lb-0002MC-7Z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:40:39 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0RDd1T1126329
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:40:37 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2884kkp7tm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:40:37 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 27 Jan 2017 08:40:36 -0500
References: <1485523252-88288-1-git-send-email-pbonzini@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Jan 2017 14:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <1485523252-88288-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <ccb7e139-8d71-35f1-94db-b98a328ab746@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-pci: fix compilation on older GCC
 versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com

On 01/27/2017 02:20 PM, Paolo Bonzini wrote:
> S390PCIBusDevice is typedef'ed earlier in the file, before the hunks
> that this patch modifies.  The double typedef causes old versions of
> GCC to complain.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index b0adefa..a25e926 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -279,7 +279,7 @@ typedef struct S390PCIIOMMUTable {
>      S390PCIIOMMU *iommu[PCI_SLOT_MAX];
>  } S390PCIIOMMUTable;
> 
> -typedef struct S390PCIBusDevice {
> +struct S390PCIBusDevice {
>      DeviceState qdev;
>      PCIDevice *pdev;
>      ZpciState state;
> @@ -301,7 +301,7 @@ typedef struct S390PCIBusDevice {
>      IndAddr *indicator;
>      QEMUTimer *release_timer;
>      QTAILQ_ENTRY(S390PCIBusDevice) link;
> -} S390PCIBusDevice;
> +};
> 
>  typedef struct S390PCIBus {
>      BusState qbus;
> 
We cannot move this before S390PCIIOMMUTable due to the cross
dependency and we need a forward declaration of the typedef, so
yet this makes sense.

applied to our tree.
