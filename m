Received: from eggs.gnu.org ([2001:4830:134:3::10]:55813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g0WEO-00072g-Hk
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g0WEC-0000Xn-RW
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g0WEC-0007QF-0g
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:20:32 -0400
Date: Thu, 13 Sep 2018 14:18:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180913141145-mutt-send-email-mst@kernel.org>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-5-git-send-email-brijesh.singh@amd.com>
	<20180912183510.1fe2c3b8@redhat.com>
	<88997184-3509-4a6d-4fca-cd3fa64d1858@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88997184-3509-4a6d-4fca-cd3fa64d1858@amd.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Wed, Sep 12, 2018 at 02:24:52PM -0500, Brijesh Singh wrote:
> 
> 
> On 09/12/2018 11:35 AM, Igor Mammedov wrote:
> ...
> 
> > > +    /*
> > > +     * When interrupt remapping is enabled, Linux IOMMU driver also checks
> > > +     * for special IVHD device (type IO-APIC), which is typically presented
> > > +     * as PCI device 14:00.0.
> > Probably it shouldn't be a 'typically' device from somewhere but rather address
> > fetched from corresponding device model QEMU implements.
> > 
> 
> IOAPIC is not presented as a true PCI device to guest OS. When IOMMU is
> enabled a pseudo address space to added under root PCI bus. PCI 14:0.0
> presents to this pseudo device.
> 
> > 
> > > +     */
> > > +    if (s->intr_enabled) {
> > > +        build_append_int_noprefix(table_data, 0x0100a00000000048, 8);
> >                                                   ^^ this is incomprehensible,
> > where does this magic number comes from and how was it calculated?
> > 
> 
> In order to provide interrupt remap support, a special IVHD device need
> to be added,  the magic number uses the format defined in Table 95 (IVHD
> device entry type codes).
> 
> 0x01 00a0 00 00 0000 48
> 
> Byte 0: 0x48 (special device)
> Byte 1 & 2: must be zero
> Byte 3: 0 (dte setting)
> Byte 4: 0 (handle)
> Byte 5 & 6: IOAPIC devfn (14:0.0)

Do you mean *bus* devfn? devfn is 0.0.

> Byte 7: 0x1 (IOAPIC) - See Table 97 in spec


Above should go into code comment, along with
first (oldest) version of spec that has this table.
Additionally the number is IMHO more readable as:
	(0x1ull << 56) | (PCI_BUILD_BDF(14, 0) << 40) | 0x48

(assuming I got what it should be).

> 
> > > +    }
> > > +
> > >       build_header(linker, table_data, (void *)(table_data->data + iommu_start),
> > >                    "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
> > >   }
> > 
