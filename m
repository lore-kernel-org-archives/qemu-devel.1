Received: from eggs.gnu.org ([2001:4830:134:3::10]:49056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cK44a-0003ls-CQ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cK44X-0007tU-4A
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:10:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cK44W-0007sB-R4
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:10:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0654B61E53
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 14:10:15 +0000 (UTC)
Date: Thu, 22 Dec 2016 15:10:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161222151012.6dd0f425@nial.brq.redhat.com>
In-Reply-To: <dfd3adbb-d4d7-cc39-77d7-5254089393df@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-11-git-send-email-imammedo@redhat.com>
	<c30ac489-dec6-a107-0811-f0118693de25@redhat.com>
	<20161222143124.32e03acf@nial.brq.redhat.com>
	<dfd3adbb-d4d7-cc39-77d7-5254089393df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 10/10] memhp: move DIMM devices
 into dedicated scope with related common methods
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

On Thu, 22 Dec 2016 15:53:55 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 12/22/2016 03:31 PM, Igor Mammedov wrote:
> > On Thu, 22 Dec 2016 14:31:19 +0200
> > Marcel Apfelbaum <marcel@redhat.com> wrote:
> >  
> >> On 12/06/2016 01:32 AM, Igor Mammedov wrote:  
> >>> Move DIMM devices from global _SB scope to a new \_SB.MHPC
> >>> container along with common methods used by DIMMs:
> >>>   MCRS, MRST, MPXM, MOST, MEJ00, MSCN, MTFY
> >>>
> >>> this reduces AML size on 12 * #slots bytes,
> >>> i.e. up to 3072 bytes for 265 slots.
> >>>  
> >>
> >> Can you please explain how the bytes number are reduced?
> >> Is it because the devices path is now relative to the new container?  
> > yes
> >  
> >> If so, can you give an example of before/after?  
> > as example:
> >
> > -        Device (MP02)
> > -        {
> > -            Name (_UID, "0x02")  // _UID: Unique ID
> > -            Name (_HID, EisaId ("PNP0C80") /* Memory Device */)  // _HID: Hardware ID
> > -            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > -            {
> > -                Return (\_SB.PCI0.MHPD.MCRS (_UID))
> > -            }
> > -
> > -            Method (_STA, 0, NotSerialized)  // _STA: Status
> > -            {
> > -                Return (\_SB.PCI0.MHPD.MRST (_UID))
> > -            }
> > -
> > -            Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
> > -            {
> > -                Return (\_SB.PCI0.MHPD.MPXM (_UID))
> > -            }
> > -
> > -            Method (_OST, 3, NotSerialized)  // _OST: OSPM Status Indication
> > -            {
> > -                Return (\_SB.PCI0.MHPD.MOST (_UID, Arg0, Arg1, Arg2))
> > -            }
> > -
> > -            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -            {
> > -                Return (\_SB.PCI0.MHPD.MEJ0 (_UID, Arg0))
> > -            }
> > -        }
> > ----
> > +        Device (MP02)
> > +        {
> > +            Name (_UID, "0x02")  // _UID: Unique ID
> > +            Name (_HID, EisaId ("PNP0C80") /* Memory Device */)  // _HID: Hardware ID
> > +            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > +            {
> > +                Return (MCRS (_UID))
> > +            }
> > +
> > +            Method (_STA, 0, NotSerialized)  // _STA: Status
> > +            {
> > +                Return (MRST (_UID))
> > +            }
> > +
> > +            Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
> > +            {
> > +                Return (MPXM (_UID))
> > +            }
> > +
> > +            Method (_OST, 3, NotSerialized)  // _OST: OSPM Status Indication
> > +            {
> > +                Return (MOST (_UID, Arg0, Arg1, Arg2))
> > +            }
> > +
> > +            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > +            {
> > +                Return (MEJ0 (_UID, Arg0))
> > +            }
> > +        }
> >  
> 
> Thanks for the confirmation.
> 
> >>  
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>>  hw/acpi/memory_hotplug.c | 190 ++++++++++++++++++++++++-----------------------
> >>>  1 file changed, 97 insertions(+), 93 deletions(-)
> >>>
> >>> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> >>> index fb04d24..210073d 100644
> >>> --- a/hw/acpi/memory_hotplug.c
> >>> +++ b/hw/acpi/memory_hotplug.c
> >>> @@ -31,6 +31,7 @@
> >>>  #define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> >>>  #define MEMORY_HOTPLUG_DEVICE        "MHPD"
> >>>  #define MEMORY_HOTPLUG_IO_LEN         24
> >>> +#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> >>>
> >>>  static uint16_t memhp_io_base;
> >>>
> >>> @@ -343,9 +344,8 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>      int i;
> >>>      Aml *ifctx;
> >>>      Aml *method;
> >>> -    Aml *sb_scope;
> >>> +    Aml *dev_container;
> >>>      Aml *mem_ctrl_dev;
> >>> -    char *scan_path;
> >>>      char *mhp_res_path;
> >>>
> >>>      if (!memhp_io_base) {
> >>> @@ -356,24 +356,11 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>      mem_ctrl_dev = aml_device("%s", mhp_res_path);
> >>>      {
> >>>          Aml *crs;
> >>> -        Aml *field;
> >>> -        Aml *one = aml_int(1);
> >>> -        Aml *zero = aml_int(0);
> >>> -        Aml *ret_val = aml_local(0);
> >>> -        Aml *slot_arg0 = aml_arg(0);
> >>> -        Aml *slots_nr = aml_name(MEMORY_SLOTS_NUMBER);
> >>> -        Aml *ctrl_lock = aml_name(MEMORY_SLOT_LOCK);
> >>> -        Aml *slot_selector = aml_name(MEMORY_SLOT_SLECTOR);
> >>>
> >>>          aml_append(mem_ctrl_dev, aml_name_decl("_HID", aml_string("PNP0A06")));  
> >>
> >> Do we need the above declaration twice? Here is the first occurrence.
> >>  
> >>>          aml_append(mem_ctrl_dev,
> >>>              aml_name_decl("_UID", aml_string("Memory hotplug resources")));  
> > [...]
> >  
> >>> +
> >>> +    dev_container = aml_device(MEMORY_DEVICES_CONTAINER);
> >>> +    {  
> > [...]  
> >>> +        aml_append(dev_container, aml_name_decl("_HID", aml_string("PNP0A06")));  
> >>
> >> And here is the second occurrence.  
> > It's different containers, the first one is for MMIO registers
> > for x86 it's placed \_SB.PCI0.MHPD consumes resources from parent's PCI0._CRS
> > and the second is for memory devices \_SB.MHPC which consumes resources
> > outside of PCI0._CRS scope.
> >  
> 
> Understood, here is my last R-b tag, however I want to point out
> that I only looked at the re-factoring steps and my acpi-based memory hotplug
> knowledge is rather limited.
> 
> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Thanks,

It's pretty much series subj says cleanups/consolidation.
The only sort of 'functional' change is that memory hotplug
AML is generated only if memory hotplug is enabled, freeing
some guest memory when memory hotplug in not in use.

 
> Thanks,
> Marcel
> 
> >  
> >>
> >> Thanks,
> >> Marcel
> >>  
> >>> +        aml_append(dev_container,
> >>> +            aml_name_decl("_UID", aml_string("DIMM devices")));
> >>> +
> >>> +        assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
> >>> +        aml_append(dev_container,
> >>> +            aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
> >>> +        );
> >>> +
> >>> +        field = aml_field(mmio_path, AML_DWORD_ACC,
> >>>                            AML_NOLOCK, AML_PRESERVE);
> >>>          aml_append(field, /* read only */
> >>>              aml_named_field(MEMORY_SLOT_ADDR_LOW, 32));
> >>> @@ -398,9 +410,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_named_field(MEMORY_SLOT_SIZE_HIGH, 32));
> >>>          aml_append(field, /* read only */
> >>>              aml_named_field(MEMORY_SLOT_PROXIMITY, 32));
> >>> -        aml_append(mem_ctrl_dev, field);
> >>> +        aml_append(dev_container, field);
> >>>
> >>> -        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_BYTE_ACC,
> >>> +        field = aml_field(mmio_path, AML_BYTE_ACC,
> >>>                            AML_NOLOCK, AML_WRITE_AS_ZEROS);
> >>>          aml_append(field, aml_reserved_field(160 /* bits, Offset(20) */));
> >>>          aml_append(field, /* 1 if enabled, read only */
> >>> @@ -414,9 +426,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>          aml_append(field,
> >>>              /* initiates device eject, write only */
> >>>              aml_named_field(MEMORY_SLOT_EJECT, 1));
> >>> -        aml_append(mem_ctrl_dev, field);
> >>> +        aml_append(dev_container, field);
> >>>
> >>> -        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> >>> +        field = aml_field(mmio_path, AML_DWORD_ACC,
> >>>                            AML_NOLOCK, AML_PRESERVE);
> >>>          aml_append(field, /* DIMM selector, write only */
> >>>              aml_named_field(MEMORY_SLOT_SLECTOR, 32));
> >>> @@ -424,7 +436,8 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_named_field(MEMORY_SLOT_OST_EVENT, 32));
> >>>          aml_append(field, /* _OST status code, write only */
> >>>              aml_named_field(MEMORY_SLOT_OST_STATUS, 32));
> >>> -        aml_append(mem_ctrl_dev, field);
> >>> +        aml_append(dev_container, field);
> >>> +        g_free(mmio_path);
> >>>
> >>>          method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >>>          ifctx = aml_if(aml_equal(slots_nr, zero));
> >>> @@ -434,9 +447,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>          aml_append(method, ifctx);
> >>>          /* present, functioning, decoding, not shown in UI */
> >>>          aml_append(method, aml_return(aml_int(0xB)));
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>> -        aml_append(mem_ctrl_dev, aml_mutex(MEMORY_SLOT_LOCK, 0));
> >>> +        aml_append(dev_container, aml_mutex(MEMORY_SLOT_LOCK, 0));
> >>>
> >>>          method = aml_method(MEMORY_SLOT_SCAN_METHOD, 0, AML_NOTSERIALIZED);
> >>>          {
> >>> @@ -492,7 +505,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>              aml_append(method, aml_return(one));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>>          method = aml_method(MEMORY_SLOT_STATUS_METHOD, 1, AML_NOTSERIALIZED);
> >>>          {
> >>> @@ -512,7 +525,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>              aml_append(method, aml_return(ret_val));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>>          method = aml_method(MEMORY_SLOT_CRS_METHOD, 1, AML_SERIALIZED);
> >>>          {
> >>> @@ -603,7 +616,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>              aml_append(method, aml_return(mr64));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>>          method = aml_method(MEMORY_SLOT_PROXIMITY_METHOD, 1,
> >>>                              AML_NOTSERIALIZED);
> >>> @@ -617,7 +630,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>              aml_append(method, aml_return(ret_val));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>>          method = aml_method(MEMORY_SLOT_OST_METHOD, 4, AML_NOTSERIALIZED);
> >>>          {
> >>> @@ -631,7 +644,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_store(aml_arg(2), ost_status));
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> +        aml_append(dev_container, method);
> >>>
> >>>          method = aml_method(MEMORY_SLOT_EJECT_METHOD, 2, AML_NOTSERIALIZED);
> >>>          {
> >>> @@ -643,75 +656,66 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >>>              aml_append(method, aml_store(one, eject));
> >>>              aml_append(method, aml_release(ctrl_lock));
> >>>          }
> >>> -        aml_append(mem_ctrl_dev, method);
> >>> -    }
> >>> -    aml_append(table, mem_ctrl_dev);
> >>> -
> >>> -    sb_scope = aml_scope("_SB");
> >>> -    /* build memory devices */
> >>> -    for (i = 0; i < nr_mem; i++) {
> >>> -        Aml *dev;
> >>> -        char *s;
> >>> -
> >>> -        dev = aml_device("MP%02X", i);
> >>> -        aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
> >>> -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
> >>> -
> >>> -        method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> >>> -        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_CRS_METHOD);
> >>> -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> -        g_free(s);
> >>> -        aml_append(dev, method);
> >>> -
> >>> -        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >>> -        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_STATUS_METHOD);
> >>> -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> -        g_free(s);
> >>> -        aml_append(dev, method);
> >>> -
> >>> -        method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
> >>> -        s = g_strdup_printf("%s.%s", mhp_res_path,
> >>> -                            MEMORY_SLOT_PROXIMITY_METHOD);
> >>> -        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> -        g_free(s);
> >>> -        aml_append(dev, method);
> >>> -
> >>> -        method = aml_method("_OST", 3, AML_NOTSERIALIZED);
> >>> -        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_OST_METHOD);
> >>> -        aml_append(method, aml_return(aml_call4(
> >>> -            s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
> >>> -        )));
> >>> -        g_free(s);
> >>> -        aml_append(dev, method);
> >>> -
> >>> -        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >>> -        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_EJECT_METHOD);
> >>> -        aml_append(method, aml_return(aml_call2(
> >>> -                   s, aml_name("_UID"), aml_arg(0))));
> >>> -        g_free(s);
> >>> -        aml_append(dev, method);
> >>> -
> >>> -        aml_append(sb_scope, dev);
> >>> -    }
> >>> +        aml_append(dev_container, method);
> >>> +
> >>> +        /* build memory devices */
> >>> +        for (i = 0; i < nr_mem; i++) {
> >>> +            Aml *dev;
> >>> +            const char *s;
> >>> +
> >>> +            dev = aml_device("MP%02X", i);
> >>> +            aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
> >>> +            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
> >>> +
> >>> +            method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
> >>> +            s = MEMORY_SLOT_CRS_METHOD;
> >>> +            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> +            aml_append(dev, method);
> >>> +
> >>> +            method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >>> +            s = MEMORY_SLOT_STATUS_METHOD;
> >>> +            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> +            aml_append(dev, method);
> >>> +
> >>> +            method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
> >>> +            s = MEMORY_SLOT_PROXIMITY_METHOD;
> >>> +            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
> >>> +            aml_append(dev, method);
> >>> +
> >>> +            method = aml_method("_OST", 3, AML_NOTSERIALIZED);
> >>> +            s = MEMORY_SLOT_OST_METHOD;
> >>> +            aml_append(method, aml_return(aml_call4(
> >>> +                s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
> >>> +            )));
> >>> +            aml_append(dev, method);
> >>> +
> >>> +            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> >>> +            s = MEMORY_SLOT_EJECT_METHOD;
> >>> +            aml_append(method, aml_return(aml_call2(
> >>> +                       s, aml_name("_UID"), aml_arg(0))));
> >>> +            aml_append(dev, method);
> >>> +
> >>> +            aml_append(dev_container, dev);
> >>> +        }
> >>>
> >>> -    /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
> >>> -     *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
> >>> -     */
> >>> -    method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
> >>> -    for (i = 0; i < nr_mem; i++) {
> >>> -        ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
> >>> -        aml_append(ifctx,
> >>> -            aml_notify(aml_name("MP%.02X", i), aml_arg(1))
> >>> -        );
> >>> -        aml_append(method, ifctx);
> >>> +        /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
> >>> +         *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
> >>> +         */
> >>> +        method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
> >>> +        for (i = 0; i < nr_mem; i++) {
> >>> +            ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
> >>> +            aml_append(ifctx,
> >>> +                aml_notify(aml_name("MP%.02X", i), aml_arg(1))
> >>> +            );
> >>> +            aml_append(method, ifctx);
> >>> +        }
> >>> +        aml_append(dev_container, method);
> >>>      }
> >>> -    aml_append(sb_scope, method);
> >>> -    aml_append(table, sb_scope);
> >>> +    aml_append(table, dev_container);
> >>>
> >>>      method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> >>> -    scan_path = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_SCAN_METHOD);
> >>> -    aml_append(method, aml_call0(scan_path));
> >>> -    g_free(scan_path);
> >>> +    aml_append(method,
> >>> +        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
> >>>      aml_append(table, method);
> >>>
> >>>      g_free(mhp_res_path);
> >>>  
> >>  
> >  
> 
> 
