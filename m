Received: from eggs.gnu.org ([209.51.188.92]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzkPw-0007MU-ES
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzkPv-0000qk-Di
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gzkPv-0000ph-7s
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:49:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so28220599qtc.10
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 07:49:43 -0800 (PST)
Date: Fri, 1 Mar 2019 10:49:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190301104928-mutt-send-email-mst@kernel.org>
References: <1551407310-32413-1-git-send-email-guoheyi@huawei.com>
	<20190301084619-mutt-send-email-mst@kernel.org>
	<cc3c8e42-0632-0c90-41cc-27bfdcaef11d@huawei.com>
	<20190301091214-mutt-send-email-mst@kernel.org>
	<20190301153311.79c0d287@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301153311.79c0d287@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/acpi: enable SHPC native hot plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Heyi Guo <guoheyi@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Heyi Guo <heyi.guo@linaro.org>

On Fri, Mar 01, 2019 at 03:33:11PM +0100, Igor Mammedov wrote:
> On Fri, 1 Mar 2019 09:12:33 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Mar 01, 2019 at 10:04:38PM +0800, Heyi Guo wrote:
> > > 
> > > 
> > > On 2019/3/1 21:47, Michael S. Tsirkin wrote:  
> > > > On Fri, Mar 01, 2019 at 10:28:30AM +0800, Heyi Guo wrote:  
> > > > > After the introduction of generic PCIe root port and PCIe-PCI bridge,
> > > > > we will also have SHPC controller on ARM, so just enalbe SHPC native
> > > > > hot plug.
> > > > > 
> > > > > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > > > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > > > > Signed-off-by: Heyi Guo <heyi.guo@linaro.org>  
> > > > 
> > > > So when OS enables SHPC, should we block ACPI hotplug events?  
> > > I supposed we don't support ACPI hotplug events on ARM virt; do we have any currently?
> > > 
> > > Thanks,
> > > Heyi  
> > 
> > Oh I didn't realise. That explains it sorry about the noise.
> And I thought we did not support them on PCIe completely (I mean q35/ich9).
> (Or did I miss something)?

True for PCIe.

> > 
> > > >   
> > > > > ---
> > > > >   hw/arm/virt-acpi-build.c | 7 ++++++-
> > > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > > index 04b62c7..7849ec5 100644
> > > > > --- a/hw/arm/virt-acpi-build.c
> > > > > +++ b/hw/arm/virt-acpi-build.c
> > > > > @@ -265,7 +265,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> > > > >           aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> > > > >       aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> > > > >       aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> > > > > -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
> > > > > +
> > > > > +    /*
> > > > > +     * Allow OS control for all 5 features:
> > > > > +     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> > > > > +     */
> > > > > +    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1F), NULL),
> > > > >                                   aml_name("CTRL")));
> > > > >       ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> > > > > -- 
> > > > > 1.8.3.1  
> > > > .
> > > >   
> > >   
