Received: from eggs.gnu.org ([209.51.188.92]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glsW6-0006Ht-VJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glsGZ-0008QK-Hf
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:22:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1glsGV-0008MO-Mj
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:22:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so26433151wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:22:37 -0800 (PST)
Date: Tue, 22 Jan 2019 10:22:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190122092232.dij3zujx32w3n6wq@steredhat>
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-5-sgarzare@redhat.com>
	<20190121170541.GN4136@habkost.net>
	<20190121173650.ydihxdyhheq7xcpq@steredhat>
	<e889e61c-f5fe-51cc-c703-45487efd4d3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e889e61c-f5fe-51cc-c703-45487efd4d3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On Mon, Jan 21, 2019 at 07:33:32PM +0100, Paolo Bonzini wrote:
> On 21/01/19 18:36, Stefano Garzarella wrote:
> >>
> >> | On Tue, Jan 15, 2019 at 01:57:22PM -0500, Michael S. Tsirkin wrote:
> >> | > OK but this is guest visible so needs to be guarded by the
> >> | > new machine type.
> >> | 
> >> | Aren't option ROMs treated like other firmware?  i.e.: guest
> >> | visible, but copied during live migration and not considered part
> >> | of guest ABI.
> > I don't know the exact answer, but reading the wiki, I think Michael is right!
> > (https://wiki.qemu.org/Features/Migration/Troubleshooting#ROMs)
> > 
> > Maybe it is related for PVH feature in general, because if we try to
> > migrate to a QEMU version that doesn't support PVH I'm not sure what is
> > the behaviour.
> 
> As far as I understand, QEMU would fail to migrate to the destination
> because the PVH option ROM doesn't have a corresponding RAMBlock.
> 

I tried to migrate from a QEMU with PVH support to a QEMU without PVH,
(both with the same pc-q35-4.0 machine) and the migration doesn't fail.

The guest, after the migration, works well, but when I tried to reboot,
the guest stuck.

The "info ramblock" on both QEMU produce the same output:
              Block Name    PSize              Offset               Used              Total
                  pc.ram    4 KiB  0x0000000000000000 0x0000000020000000 0x0000000020000000
    /rom@etc/acpi/tables    4 KiB  0x0000000020080000 0x0000000000020000 0x0000000000200000
                 pc.bios    4 KiB  0x0000000020000000 0x0000000000040000 0x0000000000040000
                  pc.rom    4 KiB  0x0000000020040000 0x0000000000020000 0x0000000000020000
   /rom@etc/table-loader    4 KiB  0x0000000020280000 0x0000000000001000 0x0000000000001000
      /rom@etc/acpi/rsdp    4 KiB  0x00000000202c0000 0x0000000000001000 0x0000000000001000


The following patch solves the issue. (Thanks Michael!)
Should I send the v6 of series or this patch alone for the review?


Thanks,
Stefano


diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2833b130ba..3be4a06c4f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1211,7 +1211,8 @@ static void load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (load_elfboot(kernel_filename, kernel_size,
+        if (pcmc->pvh_enabled &&
+            load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
 
@@ -2774,6 +2775,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
+    pcmc->pvh_enabled = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5088e2f492..e70818fba2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,21 +428,32 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_4_0_machine_options(MachineClass *m)
+static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+                      pc_i440fx_4_1_machine_options);
+
+static void pc_i440fx_4_0_machine_options(MachineClass *m)
+{
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    pc_i440fx_4_1_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    pcmc->pvh_enabled = false;
+}
+
 DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
                       pc_i440fx_4_0_machine_options);
 
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
     pc_i440fx_4_0_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7b7959934..6e843b991b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,12 +365,24 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
+                   pc_q35_4_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    pc_q35_4_1_machine_options(m);
+    m->alias = NULL;
+    pcmc->pvh_enabled = false;
+}
+
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
 
@@ -378,7 +390,6 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
 {
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split = false;
-    m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0abbe45637..0d04af2021 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -133,6 +133,9 @@ struct PCMachineClass {
 
     /* use DMA capable linuxboot option rom */
     bool linuxboot_dma_enabled;
+
+    /* enable PVH feature to load kernels */
+    bool pvh_enabled;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
