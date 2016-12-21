Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJgPX-0006A0-DY
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJgPS-00045F-HC
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cJgPS-000445-7M
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:54:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23510C05167A
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 12:54:17 +0000 (UTC)
Date: Wed, 21 Dec 2016 13:54:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161221135413.5555e80c@nial.brq.redhat.com>
In-Reply-To: <cf7a92bf-bbcc-6de2-d0ab-bef39064e3a6@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-7-git-send-email-imammedo@redhat.com>
	<cf7a92bf-bbcc-6de2-d0ab-bef39064e3a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 06/10] memhp: merge
 build_memory_devices() into build_memory_hotplug_aml()
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

On Wed, 21 Dec 2016 14:10:33 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> > It consolidates memory hotplug AML in one place within DSDT
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/memory_hotplug.h |  2 --
> >  hw/acpi/memory_hotplug.c         | 14 ++++-----
> >  hw/i386/acpi-build.c             | 61 ++++++++++++++++++----------------------
> >  3 files changed, 33 insertions(+), 44 deletions(-)
> >
> > diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> > index c70481e..6dc48d2 100644
> > --- a/include/hw/acpi/memory_hotplug.h
> > +++ b/include/hw/acpi/memory_hotplug.h
> > @@ -54,6 +54,4 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
> >
> >  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >                                uint16_t io_base, uint16_t io_len);
> > -void build_memory_devices(Aml *sb_scope, int nr_mem,
> > -                          uint16_t io_base, uint16_t io_len);
> >  #endif
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index fb40a5e..18b95f2 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -310,9 +310,11 @@ const VMStateDescription vmstate_memory_hotplug = {
> >  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >                                uint16_t io_base, uint16_t io_len)
> >  {
> > +    int i;
> >      Aml *ifctx;
> >      Aml *method;
> >      Aml *pci_scope;
> > +    Aml *sb_scope;
> >      Aml *mem_ctrl_dev;
> >
> >      /* scope for memory hotplug controller device node */
> > @@ -610,19 +612,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> >      }
> >      aml_append(pci_scope, mem_ctrl_dev);
> >      aml_append(table, pci_scope);
> > -}
> > -
> > -void build_memory_devices(Aml *sb_scope, int nr_mem,
> > -                          uint16_t io_base, uint16_t io_len)
> > -{
> > -    int i;
> > -    Aml *dev;
> > -    Aml *method;
> > -    Aml *ifctx;
> >
> > +    sb_scope = aml_scope("_SB");  
> 
> 
> One question here, before this patch the mem devices were
> added to \\_SB scope, now they are added to _SB.
> 
> I suppose is OK? Is there any change in the DSDT? Can we see a diff?

It's ok as sb_scope is added to root context (i.e. table), below in this patch.

This patch doesn't change logic, it only gets rid of
Scope (\_SB.PCI0.MHPD) by moving elements from it to
preceding device declaration which above scope refers to:
    Scope (_SB.PCI0) { Device (MHPD) { ... } }
and places MTFY method right after this declaration.

In other words the patch does exactly what commit message says,
"It consolidates memory hotplug AML in one place within DSDT"


here is diff at this point but it's not really useful as it doesn't
capture enough context to see where AML is being moved.
To get full tables to compare one need run:

make && make tests/bios-tables-test
QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 V=1 tests/bios-tables-test

diff --git a/tmp/asl-EQAJSY.dsl b/tmp/asl-ZSBJSY.dsl
index b4809b1..1cf0a30 100644
--- a/tmp/asl-EQAJSY.dsl
+++ b/tmp/asl-ZSBJSY.dsl
@@ -5,13 +5,13 @@
  * 
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/acpi-test-data/pc/DSDT.bridge, Wed Dec 21 13:34:30 2016
+ * Disassembly of /tmp/aml-AKBJSY, Wed Dec 21 13:34:30 2016
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001EBB (7867)
+ *     Length           0x00001EAF (7855)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x35
+ *     Checksum         0x44
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -798,6 +798,42 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
         {
             Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
             Name (_UID, "Memory hotplug resources")  // _UID: Unique ID
+            Name (MDNR, Zero)
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                IO (Decode16,
+                    0x0A00,             // Range Minimum
+                    0x0A00,             // Range Maximum
+                    0x00,               // Alignment
+                    0x18,               // Length
+                    )
+            })
+            OperationRegion (HPMR, SystemIO, 0x0A00, 0x18)
+            Field (HPMR, DWordAcc, NoLock, Preserve)
+            {
+                MRBL,   32, 
+                MRBH,   32, 
+                MRLL,   32, 
+                MRLH,   32, 
+                MPX,    32
+            }
+
+            Field (HPMR, ByteAcc, NoLock, WriteAsZeros)
+            {
+                Offset (0x14), 
+                MES,    1, 
+                MINS,   1, 
+                MRMV,   1, 
+                MEJ,    1
+            }
+
+            Field (HPMR, DWordAcc, NoLock, Preserve)
+            {
+                MSEL,   32, 
+                MOEV,   32, 
+                MOSC,   32
+            }
+
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 If (MDNR == Zero)
@@ -944,6 +980,13 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
         }
     }
 
+    Scope (_SB)
+    {
+        Method (MTFY, 2, NotSerialized)
+        {
+        }
+    }
+
     Scope (_GPE)
     {
         Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
@@ -1084,49 +1127,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
 
     Scope (\_SB)
     {
-        Scope (\_SB.PCI0.MHPD)
-        {
-            Name (MDNR, Zero)
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                IO (Decode16,
-                    0x0A00,             // Range Minimum
-                    0x0A00,             // Range Maximum
-                    0x00,               // Alignment
-                    0x18,               // Length
-                    )
-            })
-            OperationRegion (HPMR, SystemIO, 0x0A00, 0x18)
-            Field (HPMR, DWordAcc, NoLock, Preserve)
-            {
-                MRBL,   32, 
-                MRBH,   32, 
-                MRLL,   32, 
-                MRLH,   32, 
-                MPX,    32
-            }
-
-            Field (HPMR, ByteAcc, NoLock, WriteAsZeros)
-            {
-                Offset (0x14), 
-                MES,    1, 
-                MINS,   1, 
-                MRMV,   1, 
-                MEJ,    1
-            }
-
-            Field (HPMR, DWordAcc, NoLock, Preserve)
-            {
-                MSEL,   32, 
-                MOEV,   32, 
-                MOSC,   32
-            }
-        }
-
-        Method (MTFY, 2, NotSerialized)
-        {
-        }
-
         Scope (PCI0)
         {
             Name (BSEL, Zero)


> 
> Thanks,
> Marcel
> 
> >      /* build memory devices */
> >      for (i = 0; i < nr_mem; i++) {
> >          #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
> > +        Aml *dev;
> >          const char *s;
> >
> >          dev = aml_device("MP%02X", i);
> > @@ -673,4 +668,5 @@ void build_memory_devices(Aml *sb_scope, int nr_mem,
> >          aml_append(method, ifctx);
> >      }
> >      aml_append(sb_scope, method);
> > +    aml_append(table, sb_scope);
> >  }
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 38dcac7..690e9a0 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2197,45 +2197,40 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >
> >      sb_scope = aml_scope("\\_SB");
> >      {
> > -        build_memory_devices(sb_scope, nr_mem, pm->mem_hp_io_base,
> > -                             pm->mem_hp_io_len);
> > +        Object *pci_host;
> > +        PCIBus *bus = NULL;
> >
> > -        {
> > -            Object *pci_host;
> > -            PCIBus *bus = NULL;
> > +        pci_host = acpi_get_i386_pci_host();
> > +        if (pci_host) {
> > +            bus = PCI_HOST_BRIDGE(pci_host)->bus;
> > +        }
> >
> > -            pci_host = acpi_get_i386_pci_host();
> > -            if (pci_host) {
> > -                bus = PCI_HOST_BRIDGE(pci_host)->bus;
> > +        if (bus) {
> > +            Aml *scope = aml_scope("PCI0");
> > +            /* Scan all PCI buses. Generate tables to support hotplug. */
> > +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > +
> > +            if (misc->tpm_version != TPM_VERSION_UNSPEC) {
> > +                dev = aml_device("ISA.TPM");
> > +                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> > +                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > +                crs = aml_resource_template();
> > +                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> > +                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > +                /*
> > +                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> > +                    Rewrite to take IRQ from TPM device model and
> > +                    fix default IRQ value there to use some unused IRQ
> > +                 */
> > +                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> > +                aml_append(dev, aml_name_decl("_CRS", crs));
> > +                aml_append(scope, dev);
> >              }
> >
> > -            if (bus) {
> > -                Aml *scope = aml_scope("PCI0");
> > -                /* Scan all PCI buses. Generate tables to support hotplug. */
> > -                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
> > -
> > -                if (misc->tpm_version != TPM_VERSION_UNSPEC) {
> > -                    dev = aml_device("ISA.TPM");
> > -                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> > -                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > -                    crs = aml_resource_template();
> > -                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> > -                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > -                    /*
> > -                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> > -                        Rewrite to take IRQ from TPM device model and
> > -                        fix default IRQ value there to use some unused IRQ
> > -                     */
> > -                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> > -                    aml_append(dev, aml_name_decl("_CRS", crs));
> > -                    aml_append(scope, dev);
> > -                }
> > -
> > -                aml_append(sb_scope, scope);
> > -            }
> > +            aml_append(sb_scope, scope);
> >          }
> > -        aml_append(dsdt, sb_scope);
> >      }
> > +    aml_append(dsdt, sb_scope);
> >
> >      /* copy AML table into ACPI tables blob and patch header there */
> >      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> >  
> 
