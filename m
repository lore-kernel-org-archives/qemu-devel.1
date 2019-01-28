Received: from eggs.gnu.org ([209.51.188.92]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go9Hf-00039K-Bs
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go91n-0000cn-6g
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:40:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1go91l-0000cS-Pm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:40:51 -0500
Date: Mon, 28 Jan 2019 16:40:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190128164046.100ac6f6@redhat.com>
In-Reply-To: <20190128101331-mutt-send-email-mst@kernel.org>
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
	<20190128154553.583f79a3@redhat.com>
	<20190128101331-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On Mon, 28 Jan 2019 10:15:55 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 28, 2019 at 03:45:53PM +0100, Igor Mammedov wrote:
> > On Fri, 25 Jan 2019 16:00:58 -0500
> > Stefan Berger <stefanb@linux.ibm.com> wrote:
> >   
> > > This patch makes the a TPM 2.0 with TIS interface available under the
> > > HID 'MSF0101'. This is supported by Linux and also Windows now  
> > MSF0101 is relatively recent addition to Linux,
> > are there in wild (old) kernels that worked with PNP0C31 but won't work
> > with MSF0101?  
> 
> Well what would you do? You either have TPM 2.0 or you don't.
> If you have a 2.0 backend you need to expose it as 2.0
> to the frontend right?
I wasn't clear enough, question is:
If there are kernels where TPM2 worked with PNP0C31 and without MSF0101 support?

 
> > > recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >  hw/i386/acpi-build.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 2e21a31f82..f51225b4a7 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2141,8 +2141,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > >  
> > >              if (TPM_IS_TIS(tpm)) {
> > > -                dev = aml_device("ISA.TPM");
> > > -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> > > +                if (misc->tpm_version == TPM_VERSION_2_0) {
> > > +                    dev = aml_device("TPM");
> > > +                    aml_append(dev, aml_name_decl("_HID",
> > > +                                                  aml_string("MSFT0101")));
> > > +                } else {
> > > +                    dev = aml_device("ISA.TPM");
> > > +                    aml_append(dev, aml_name_decl("_HID",
> > > +                                                  aml_eisaid("PNP0C31")));
> > > +                }
> > > +
> > >                  aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > >                  crs = aml_resource_template();
> > >                  aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,  
