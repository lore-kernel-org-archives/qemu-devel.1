Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJNDW-0007Wy-HG
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJNDT-0003x2-69
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:24:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cJNDS-0003wF-Te
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:24:39 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFBEA3D959
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 16:24:37 +0000 (UTC)
Date: Tue, 20 Dec 2016 17:24:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161220172425.118db13c@Igors-MacBook-Pro.local>
In-Reply-To: <ada80dce-9b7f-8cab-408d-4b1a05f34cd6@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-5-git-send-email-imammedo@redhat.com>
	<ada80dce-9b7f-8cab-408d-4b1a05f34cd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 04/10] memhp: move
 build_memory_devices() into memory_hotplug.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 20 Dec 2016 12:44:22 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/memory_hotplug.h |   2 +
> >  hw/acpi/memory_hotplug.c         | 124 +++++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c             | 124 ---------------------------------------
> >  3 files changed, 126 insertions(+), 124 deletions(-)
> >
> > diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> > index d2c7452..964c244 100644
> > --- a/include/hw/acpi/memory_hotplug.h
> > +++ b/include/hw/acpi/memory_hotplug.h
> > @@ -54,4 +54,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
> >
> >  void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> >                                uint16_t io_base, uint16_t io_len);
> > +void build_memory_devices(Aml *sb_scope, int nr_mem,
> > +                          uint16_t io_base, uint16_t io_len);
> 
> 
> We add an extra function to the header file, but if it can be used
> by the ARM machines is worth it.
it's temporary for purpose of clean small/atocmic movement
and it's removed in 6/10

> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> Thanks,
> Marcel
> 
> >  #endif
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index 57ac4fc..67dd3f8 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -553,3 +553,127 @@ void build_memory_hotplug_aml(Aml *ctx, uint32_t nr_mem,
> >      aml_append(pci_scope, mem_ctrl_dev);
> >      aml_append(ctx, pci_scope);
> >  }
> > +
> > +void build_memory_devices(Aml *sb_scope, int nr_mem,
> > +                          uint16_t io_base, uint16_t io_len)
> > +{
> > +    int i;
> > +    Aml *scope;
> > +    Aml *crs;
> > +    Aml *field;
> > +    Aml *dev;
> > +    Aml *method;
> > +    Aml *ifctx;
> > +
> > +    /* build memory devices */
> > +    assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
> > +    scope = aml_scope("\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE);
> > +    aml_append(scope,
> > +        aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
> > +    );
> > +
> > +    crs = aml_resource_template();
> > +    aml_append(crs,
> > +        aml_io(AML_DECODE16, io_base, io_base, 0, io_len)
> > +    );
> > +    aml_append(scope, aml_name_decl("_CRS", crs));
> > +
> > +    aml_append(scope, aml_operation_region(
> > +        MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> > +        aml_int(io_base), io_len)
> > +    );
> > +
> > +    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > +                      AML_NOLOCK, AML_PRESERVE);
> > +    aml_append(field, /* read only */
> > +        aml_named_field(MEMORY_SLOT_ADDR_LOW, 32));
> > +    aml_append(field, /* read only */
> > +        aml_named_field(MEMORY_SLOT_ADDR_HIGH, 32));
> > +    aml_append(field, /* read only */
> > +        aml_named_field(MEMORY_SLOT_SIZE_LOW, 32));
> > +    aml_append(field, /* read only */
> > +        aml_named_field(MEMORY_SLOT_SIZE_HIGH, 32));
> > +    aml_append(field, /* read only */
> > +        aml_named_field(MEMORY_SLOT_PROXIMITY, 32));
> > +    aml_append(scope, field);
> > +
> > +    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_BYTE_ACC,
> > +                      AML_NOLOCK, AML_WRITE_AS_ZEROS);
> > +    aml_append(field, aml_reserved_field(160 /* bits, Offset(20) */));
> > +    aml_append(field, /* 1 if enabled, read only */
> > +        aml_named_field(MEMORY_SLOT_ENABLED, 1));
> > +    aml_append(field,
> > +        /*(read) 1 if has a insert event. (write) 1 to clear event */
> > +        aml_named_field(MEMORY_SLOT_INSERT_EVENT, 1));
> > +    aml_append(field,
> > +        /* (read) 1 if has a remove event. (write) 1 to clear event */
> > +        aml_named_field(MEMORY_SLOT_REMOVE_EVENT, 1));
> > +    aml_append(field,
> > +        /* initiates device eject, write only */
> > +        aml_named_field(MEMORY_SLOT_EJECT, 1));
> > +    aml_append(scope, field);
> > +
> > +    field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> > +                      AML_NOLOCK, AML_PRESERVE);
> > +    aml_append(field, /* DIMM selector, write only */
> > +        aml_named_field(MEMORY_SLOT_SLECTOR, 32));
> > +    aml_append(field, /* _OST event code, write only */
> > +        aml_named_field(MEMORY_SLOT_OST_EVENT, 32));
> > +    aml_append(field, /* _OST status code, write only */
> > +        aml_named_field(MEMORY_SLOT_OST_STATUS, 32));
> > +    aml_append(scope, field);
> > +    aml_append(sb_scope, scope);
> > +
> > +    for (i = 0; i < nr_mem; i++) {
> > +        #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
> > +        const char *s;
> > +
> > +        dev = aml_device("MP%02X", i);
> > +        aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
> > +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
> > +
> > +        method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> > +        s = BASEPATH MEMORY_SLOT_CRS_METHOD;
> > +        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > +        aml_append(dev, method);
> > +
> > +        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> > +        s = BASEPATH MEMORY_SLOT_STATUS_METHOD;
> > +        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > +        aml_append(dev, method);
> > +
> > +        method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
> > +        s = BASEPATH MEMORY_SLOT_PROXIMITY_METHOD;
> > +        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > +        aml_append(dev, method);
> > +
> > +        method = aml_method("_OST", 3, AML_NOTSERIALIZED);
> > +        s = BASEPATH MEMORY_SLOT_OST_METHOD;
> > +
> > +        aml_append(method, aml_return(aml_call4(
> > +            s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
> > +        )));
> > +        aml_append(dev, method);
> > +
> > +        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > +        s = BASEPATH MEMORY_SLOT_EJECT_METHOD;
> > +        aml_append(method, aml_return(aml_call2(
> > +                   s, aml_name("_UID"), aml_arg(0))));
> > +        aml_append(dev, method);
> > +
> > +        aml_append(sb_scope, dev);
> > +    }
> > +
> > +    /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
> > +     *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
> > +     */
> > +    method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
> > +    for (i = 0; i < nr_mem; i++) {
> > +        ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
> > +        aml_append(ifctx,
> > +            aml_notify(aml_name("MP%.02X", i), aml_arg(1))
> > +        );
> > +        aml_append(method, ifctx);
> > +    }
> > +    aml_append(sb_scope, method);
> > +}
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 9708cdc..38dcac7 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1038,130 +1038,6 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
> >      return crs;
> >  }
> >
> > -static void build_memory_devices(Aml *sb_scope, int nr_mem,
> > -                                 uint16_t io_base, uint16_t io_len)
> > -{
> > -    int i;
> > -    Aml *scope;
> > -    Aml *crs;
> > -    Aml *field;
> > -    Aml *dev;
> > -    Aml *method;
> > -    Aml *ifctx;
> > -
> > -    /* build memory devices */
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
> > -    for (i = 0; i < nr_mem; i++) {
> > -        #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
> > -        const char *s;
> > -
> > -        dev = aml_device("MP%02X", i);
> > -        aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
> > -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
> > -
> > -        method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> > -        s = BASEPATH MEMORY_SLOT_CRS_METHOD;
> > -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > -        aml_append(dev, method);
> > -
> > -        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> > -        s = BASEPATH MEMORY_SLOT_STATUS_METHOD;
> > -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > -        aml_append(dev, method);
> > -
> > -        method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
> > -        s = BASEPATH MEMORY_SLOT_PROXIMITY_METHOD;
> > -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> > -        aml_append(dev, method);
> > -
> > -        method = aml_method("_OST", 3, AML_NOTSERIALIZED);
> > -        s = BASEPATH MEMORY_SLOT_OST_METHOD;
> > -
> > -        aml_append(method, aml_return(aml_call4(
> > -            s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
> > -        )));
> > -        aml_append(dev, method);
> > -
> > -        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > -        s = BASEPATH MEMORY_SLOT_EJECT_METHOD;
> > -        aml_append(method, aml_return(aml_call2(
> > -                   s, aml_name("_UID"), aml_arg(0))));
> > -        aml_append(dev, method);
> > -
> > -        aml_append(sb_scope, dev);
> > -    }
> > -
> > -    /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
> > -     *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
> > -     */
> > -    method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
> > -    for (i = 0; i < nr_mem; i++) {
> > -        ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
> > -        aml_append(ifctx,
> > -            aml_notify(aml_name("MP%.02X", i), aml_arg(1))
> > -        );
> > -        aml_append(method, ifctx);
> > -    }
> > -    aml_append(sb_scope, method);
> > -}
> > -
> >  static void build_hpet_aml(Aml *table)
> >  {
> >      Aml *crs;
> >
> 
> 
