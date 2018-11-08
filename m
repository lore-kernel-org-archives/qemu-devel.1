Received: from eggs.gnu.org ([2001:4830:134:3::10]:51025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKhxn-0003xb-LS
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKhxj-00015W-1h
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:55:03 -0500
Date: Thu, 8 Nov 2018 11:54:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108115426.10efcf21.cohuck@redhat.com>
In-Reply-To: <63c85f6b-2a3f-941b-cac3-4ec0cf6a01d3@linux.ibm.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-2-david@redhat.com>
	<20181105121936.243260a6.cohuck@redhat.com>
	<63c85f6b-2a3f-941b-cac3-4ec0cf6a01d3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/4] s390x/zpci: drop
 msix.available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 7 Nov 2018 11:26:50 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 11/5/18 6:19 AM, Cornelia Huck wrote:
> > On Mon,  5 Nov 2018 12:03:10 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> I fail to see why this is useful as we require MSIX always and
> >> completely fail adding a device.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/s390x/s390-pci-bus.c | 2 --
> >>  hw/s390x/s390-pci-bus.h | 1 -
> >>  2 files changed, 3 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> >> index e1b14b131b..1eaae3aca6 100644
> >> --- a/hw/s390x/s390-pci-bus.c
> >> +++ b/hw/s390x/s390-pci-bus.c
> >> @@ -745,7 +745,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
> >>  
> >>      pos = pci_find_capability(pbdev->pdev, PCI_CAP_ID_MSIX);
> >>      if (!pos) {
> >> -        pbdev->msix.available = false;
> >>          return -1;
> >>      }
> >>  
> >> @@ -761,7 +760,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
> >>      pbdev->msix.pba_bar = pba & PCI_MSIX_FLAGS_BIRMASK;
> >>      pbdev->msix.pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
> >>      pbdev->msix.entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
> >> -    pbdev->msix.available = true;
> >>  
> >>      name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
> >>      memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
> >> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> >> index 1f7f9b5814..f47a0f2da5 100644
> >> --- a/hw/s390x/s390-pci-bus.h
> >> +++ b/hw/s390x/s390-pci-bus.h
> >> @@ -252,7 +252,6 @@ typedef struct ChscSeiNt2Res {
> >>  } QEMU_PACKED ChscSeiNt2Res;
> >>  
> >>  typedef struct S390MsixInfo {
> >> -    bool available;
> >>      uint8_t table_bar;
> >>      uint8_t pba_bar;
> >>      uint16_t entries;  
> > 
> > OK, so that was a write-only variable? :)
> > 
> > Question for the IBMers: is there any change we might have a different
> > implementation not relying on msi-x in the future?
> >   
> 
> @Conny
> Currently, the plan would be to stick with a hard requirement for MSIX unless someone 
> strongly supports the legacy alternatives. I'm certainly open to discuss that. Maybe it 
> would make sense to fallback to MSI for devices that don't support MSIX?

I'm not sure whether that would be very useful. My question was more
along the lines of "ok, so now that available flag is gone for good?" :)

> 
> @David
> Thanks for the cleanup.
> 
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 
