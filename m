Received: from eggs.gnu.org ([2001:4830:134:3::10]:59546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fAloW-0006Dr-Ub
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <erik.schmauss@intel.com>) id 1fAloS-0003XS-VQ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:28:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:10954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <erik.schmauss@intel.com>)
	id 1fAloS-0003Wy-N6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 20:28:04 -0400
From: "Schmauss, Erik" <erik.schmauss@intel.com>
Date: Tue, 24 Apr 2018 00:28:01 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53973A713@ORSMSX110.amr.corp.intel.com>
References: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
	<20180423234259-mutt-send-email-mst@kernel.org>
	<20180424020443-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180424020443-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] RFC: altering the NVDIMM acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "He,
	Junyan" <junyan.he@intel.com>, "Moore, Robert" <robert.moore@intel.com>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Monday, April 23, 2018 4:05 PM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: imammedo@redhat.com; qemu-devel@nongnu.org; Williams, Dan J
> <dan.j.williams@intel.com>; He, Junyan <junyan.he@intel.com>; Moore, Robe=
rt
> <robert.moore@intel.com>
> Subject: Re: RFC: altering the NVDIMM acpi table
>=20
> On Mon, Apr 23, 2018 at 11:57:04PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Apr 23, 2018 at 08:35:45PM +0000, Schmauss, Erik wrote:
> > > Hello,
> > >
> > > I work on ACPICA and we have recently made changes to the behavior
> > > of the Linux AML interpreter to match other OS implementations.
> > > After sending the patches to upstream Linux, we have identified that
> > > hw/acpi/nvdimm.c specifies an ACPI table with a forward reference
> > > (MEMA is a forward reference that is no longer supported as of Linux
> > > 4.17-rc1).
> >
Hi Michael,

Thanks for your responses. Comments below:

> > Interesting. What is the result if such a table is encountered?

As of now, what happens is that this results in a runtime error while tryin=
g to create the NRAM operation region and fail to create the NRAM operation=
 region and the NRAM fields. If there are any tables that cause an error du=
ring the initial table load, the table is not loaded.=20

> > Will this break on old hypervisors that already shipped with this set
> > of tables?

Yes

> >
> > > We would like to change this file to move the declaration of Name
> > > (MEMA,...) to appear as the very first declaration in the SSDT. Below=
 is a
> patch outlining the change that I would like to make.
> >
> > I think this will work just fine, but I would like to see a comment
> > explaining what the issue is.
> > Names aren't actually resolved until method actually runs, right?
> > For example, a name could be defined by a dynamically loaded
> > definition block ...

What happens after 4.17-rc1 is that once a acpi_load_table() is called, we =
will load the table in a single pass. Aside from packages elements, we no l=
onger support forward references.

> >
> > > However, I am having a hard time getting make check to run  to
> > > completion in a reasonable amount of time. It always seems to fail
> > > on some sort of checksum test...
> >
> > Are you running this on Linux? On bare metal or within a VM?
> > Most people here test it on Linux with KVM.

I am running this on Linux. I'm fairly novice user of QEMU in general and I=
 have only used the Makefile commands like make, make check, make check-cle=
an, make check-qtest-x86_64

>=20
> In addition, isn't https://github.com/acpica/acpica/commit/0c08790c
> trying to fix exactly this configuration?

This is the case for package elements. This is the only forward reference t=
hat we support. MEMA is a named object and we do not support forward refere=
ncing of named objects.

>=20
> > > It would be great if you could let me know what you think of the
> > > change and what I can do to speed up the execution time of make
> > > check...
> >
> > You could limit to just qtest tests.
> >
> > make check-qtest
> >
> > >
> > > Thanks,
> > >
> > > Erik Schmauss
> > >
> > > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c index
> > > 59d6e4254c..7c9efd9ac7 100644
> > > --- a/hw/acpi/nvdimm.c
> > > +++ b/hw/acpi/nvdimm.c
> > > @@ -1234,6 +1234,9 @@ static void nvdimm_build_ssdt(GArray
> *table_offsets, GArray *table_data,
> > >      ssdt =3D init_aml_allocator();
> > >      acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> > >
> > > +    mem_addr_offset =3D build_append_named_dword(table_data,
> > > +
> > > + NVDIMM_ACPI_MEM_ADDR);
> > > +
> > >      sb_scope =3D aml_scope("\\_SB");
> > >
> > >      dev =3D aml_device("NVDR");
> > > @@ -1266,9 +1269,6 @@ static void nvdimm_build_ssdt(GArray
> > > *table_offsets, GArray *table_data,
> > >
> > >      /* copy AML table into ACPI tables blob and patch header there *=
/
> > >      g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len)=
;
> > > -    mem_addr_offset =3D build_append_named_dword(table_data,
> > > -                                               NVDIMM_ACPI_MEM_ADDR)=
;
> > > -
> > >      bios_linker_loader_alloc(linker,
> > >                               NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
> > >                               sizeof(NvdimmDsmIn), false /* high
> > > memory */);
> >
> >
> > --
> > MST
