Received: from eggs.gnu.org ([2001:4830:134:3::10]:41960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJNNA-0004Fi-0X
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJNN4-0008O0-Ux
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:34:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cJNN4-0008MB-Lu
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:34:34 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D652EC04D2B8
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 16:34:33 +0000 (UTC)
Date: Tue, 20 Dec 2016 17:34:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161220173421.1bcb670e@Igors-MacBook-Pro.local>
In-Reply-To: <deac4d64-4109-fcaf-801d-3a4533127fb7@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-6-git-send-email-imammedo@redhat.com>
	<deac4d64-4109-fcaf-801d-3a4533127fb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 05/10] memhp: consolidate scattered
 MHPD device declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>

On Tue, 20 Dec 2016 13:00:35 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> > since static and dynamic parts of memory MHPD device are now
> > in the same table (DSDT), there is no point keeping
> > them scattered across the table, so consolidate it
> > in one place.
> >
> > There aren't any functional change, only AML text movement
> > from externally refferenced MHPD scope directly into
> > MHPD device declaration.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/memory_hotplug.h |   2 +-
> >  hw/acpi/memory_hotplug.c         | 123 +++++++++++++++++++--------------------
> >  2 files changed, 61 insertions(+), 64 deletions(-)
> >
> > diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> > index 964c244..c70481e 100644
> > --- a/include/hw/acpi/memory_hotplug.h
> > +++ b/include/hw/acpi/memory_hotplug.h
> > @@ -52,7 +52,7 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
> >  #define MEMORY_HOTPLUG_HANDLER_PATH "\\_SB.PCI0." \
> >       MEMORY_HOTPLUG_DEVICE "." MEMORY_SLOT_SCAN_METHOD
> >
> > -void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> > +void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >                                uint16_t io_base, uint16_t io_len);
> >  void build_memory_devices(Aml *sb_scope, int nr_mem,
> >                            uint16_t io_base, uint16_t io_len);
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index 67dd3f8..fb40a5e 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -307,7 +307,7 @@ const VMStateDescription vmstate_memory_hotplug = {
> >      }
> >  };
> >
> > -void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> > +void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >                                uint16_t io_base, uint16_t io_len)
> 
> The signature of the function is changed, but I see no caller changes.
> Is this function used?
There is no need to change callers, it's in acpi-build.c,
this change is here for better documenting what this argument means
within build_memory_hotplug_aml(), see it at the end of patch.

> 
> >  {
> >      Aml *ifctx;
> > @@ -319,6 +319,8 @@ void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> >      pci_scope = aml_scope("_SB.PCI0");
> >      mem_ctrl_dev = aml_device(MEMORY_HOTPLUG_DEVICE);
> >      {
> > +        Aml *crs;
> > +        Aml *field;
> >          Aml *one = aml_int(1);
> >          Aml *zero = aml_int(0);
> >          Aml *ret_val = aml_local(0);
> > @@ -331,6 +333,62 @@ void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> >          aml_append(mem_ctrl_dev,
> >              aml_name_decl("_UID", aml_string("Memory hotplug resources")));
> >
> > +        assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
> > +        aml_append(mem_ctrl_dev,
> > +            aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
> > +        );
> > +
> > +        crs = aml_resource_template();
> > +        aml_append(crs,
> > +            aml_io(AML_DECODE16, io_base, io_base, 0, io_len)
> > +        );
> > +        aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
> > +
> > +        aml_append(mem_ctrl_dev, aml_operation_region(
> > +            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> > +            aml_int(io_base), io_len)
> > +        );
> > +
> > +        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > +                          AML_NOLOCK, AML_PRESERVE);
> > +        aml_append(field, /* read only */
> > +            aml_named_field(MEMORY_SLOT_ADDR_LOW, 32));
> > +        aml_append(field, /* read only */
> > +            aml_named_field(MEMORY_SLOT_ADDR_HIGH, 32));
> > +        aml_append(field, /* read only */
> > +            aml_named_field(MEMORY_SLOT_SIZE_LOW, 32));
> > +        aml_append(field, /* read only */
> > +            aml_named_field(MEMORY_SLOT_SIZE_HIGH, 32));
> > +        aml_append(field, /* read only */
> > +            aml_named_field(MEMORY_SLOT_PROXIMITY, 32));
> > +        aml_append(mem_ctrl_dev, field);
> > +
> > +        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_BYTE_ACC,
> > +                          AML_NOLOCK, AML_WRITE_AS_ZEROS);
> > +        aml_append(field, aml_reserved_field(160 /* bits, Offset(20) */));
> > +        aml_append(field, /* 1 if enabled, read only */
> > +            aml_named_field(MEMORY_SLOT_ENABLED, 1));
> > +        aml_append(field,
> > +            /*(read) 1 if has a insert event. (write) 1 to clear event */
> > +            aml_named_field(MEMORY_SLOT_INSERT_EVENT, 1));
> > +        aml_append(field,
> > +            /* (read) 1 if has a remove event. (write) 1 to clear event */
> > +            aml_named_field(MEMORY_SLOT_REMOVE_EVENT, 1));
> > +        aml_append(field,
> > +            /* initiates device eject, write only */
> > +            aml_named_field(MEMORY_SLOT_EJECT, 1));
> > +        aml_append(mem_ctrl_dev, field);
> > +
> > +        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > +                          AML_NOLOCK, AML_PRESERVE);
> > +        aml_append(field, /* DIMM selector, write only */
> > +            aml_named_field(MEMORY_SLOT_SLECTOR, 32));
> > +        aml_append(field, /* _OST event code, write only */
> > +            aml_named_field(MEMORY_SLOT_OST_EVENT, 32));
> > +        aml_append(field, /* _OST status code, write only */
> > +            aml_named_field(MEMORY_SLOT_OST_STATUS, 32));
> > +        aml_append(mem_ctrl_dev, field);
> > +
> >          method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >          ifctx = aml_if(aml_equal(slots_nr, zero));
> >          {
> > @@ -551,79 +609,18 @@ void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> >          aml_append(mem_ctrl_dev, method);
> >      }
> >      aml_append(pci_scope, mem_ctrl_dev);
> > -    aml_append(ctx, pci_scope);
> > +    aml_append(table, pci_scope);
> >  }
> >
> >  void build_memory_devices(Aml *sb_scope, int nr_mem,
> >                            uint16_t io_base, uint16_t io_len)
> 
> Do you still need the io_base/io_len parameters here?
> 
> Thanks,
> Marcel
> 
> >  {
> >      int i;
> > -    Aml *scope;
> > -    Aml *crs;
> > -    Aml *field;
> >      Aml *dev;
> >      Aml *method;
> >      Aml *ifctx;
> >
> >      /* build memory devices */
> > -    assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
> > -    scope = aml_scope("\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE);
> > -    aml_append(scope,
> > -        aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
> > -    );
> > -
> > -    crs = aml_resource_template();
> > -    aml_append(crs,
> > -        aml_io(AML_DECODE16, io_base, io_base, 0, io_len)
> > -    );
> > -    aml_append(scope, aml_name_decl("_CRS", crs));
> > -
> > -    aml_append(scope, aml_operation_region(
> > -        MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> > -        aml_int(io_base), io_len)
> > -    );
> > -
> > -    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > -                      AML_NOLOCK, AML_PRESERVE);
> > -    aml_append(field, /* read only */
> > -        aml_named_field(MEMORY_SLOT_ADDR_LOW, 32));
> > -    aml_append(field, /* read only */
> > -        aml_named_field(MEMORY_SLOT_ADDR_HIGH, 32));
> > -    aml_append(field, /* read only */
> > -        aml_named_field(MEMORY_SLOT_SIZE_LOW, 32));
> > -    aml_append(field, /* read only */
> > -        aml_named_field(MEMORY_SLOT_SIZE_HIGH, 32));
> > -    aml_append(field, /* read only */
> > -        aml_named_field(MEMORY_SLOT_PROXIMITY, 32));
> > -    aml_append(scope, field);
> > -
> > -    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_BYTE_ACC,
> > -                      AML_NOLOCK, AML_WRITE_AS_ZEROS);
> > -    aml_append(field, aml_reserved_field(160 /* bits, Offset(20) */));
> > -    aml_append(field, /* 1 if enabled, read only */
> > -        aml_named_field(MEMORY_SLOT_ENABLED, 1));
> > -    aml_append(field,
> > -        /*(read) 1 if has a insert event. (write) 1 to clear event */
> > -        aml_named_field(MEMORY_SLOT_INSERT_EVENT, 1));
> > -    aml_append(field,
> > -        /* (read) 1 if has a remove event. (write) 1 to clear event */
> > -        aml_named_field(MEMORY_SLOT_REMOVE_EVENT, 1));
> > -    aml_append(field,
> > -        /* initiates device eject, write only */
> > -        aml_named_field(MEMORY_SLOT_EJECT, 1));
> > -    aml_append(scope, field);
> > -
> > -    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > -                      AML_NOLOCK, AML_PRESERVE);
> > -    aml_append(field, /* DIMM selector, write only */
> > -        aml_named_field(MEMORY_SLOT_SLECTOR, 32));
> > -    aml_append(field, /* _OST event code, write only */
> > -        aml_named_field(MEMORY_SLOT_OST_EVENT, 32));
> > -    aml_append(field, /* _OST status code, write only */
> > -        aml_named_field(MEMORY_SLOT_OST_STATUS, 32));
> > -    aml_append(scope, field);
> > -    aml_append(sb_scope, scope);
> > -
> >      for (i = 0; i < nr_mem; i++) {
> >          #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
> >          const char *s;
> >
> 
> 
