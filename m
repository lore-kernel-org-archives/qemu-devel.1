Received: from eggs.gnu.org ([2001:4830:134:3::10]:55848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <matthias@weckbecker.name>) id 1gWcLa-0007vL-AB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <matthias@weckbecker.name>) id 1gWcLU-0002BT-KJ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:20:50 -0500
Received: from weckbecker.name ([87.118.122.104]:64110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <matthias@weckbecker.name>)
	id 1gWcLU-0001y1-2J
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:20:44 -0500
Date: Tue, 11 Dec 2018 08:20:27 +0100
From: Matthias Weckbecker <matthias@weckbecker.name>
Message-ID: <20181211072027.GA4465@weckbecker.name>
References: <20181210145653.GE5000@localhost.localdomain>
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20181210145653.GE5000@localhost.localdomain>
Subject: Re: [Qemu-devel] Fwd: [PATCH] QEMU patch for PCI handling bug
 (invalid free)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 03:56:53PM +0100, Kevin Wolf wrote:
> Am 10.12.2018 um 14:38 hat Matthias Weckbecker geschrieben:
> > Hi Kevin,
> > 
> > I'm attaching a patch for qemu. Read below for details.
> > 
> > There's a bug in qemu in the PCI bridge handling that can be triggered when
> > following the steps below:
> > 
> >   1) Create some VM (e.g. w/ virsh define)
> >   2) Ensure there is a PCI bridge attached, e.g. w/ libvirt like this:
> > 
> >      <controller type='pci' index='1' model='pci-bridge'>
> >       <model name='pci-bridge'/>
> >       <target chassisNr='1'/>
> >       <alias name='pci'/>
> >       <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x1'/>
> >      </controller>
> > 
> >   3) Take a snapshot while it's *running*, like this:
> > 
> >      % virsh start mips64el-vm
> >      % virsh snapshot-create-as mips64el-vm mips64el-snap
> > 
> >   4) Destroy the VM and revert from snapshot:
> > 
> >      % virsh destroy mips64el-vm
> >      % virsh snapshot-revert mips64el-vm mips64el-snap --running
> >        error: internal error: process exited while connecting to monitor: corrupted size vs. prev_size
> > 
> >   5) qemu-system-mips64el crashes
> > 
> > The attached patch resolves the issue. Can you maybe review+commit, please?
> 
> Hi Matthias,
> 

Hi Kevin,

> thanks for sending the patch. The next step is that it needs to be
> reviewed on the qemu-devel mailing list (CCed) and then the PCI
> subsystem maintainers (Michael and Marcel, CCed as well) can commit it.
> 

thank you for looking into it and forwarding it.

> Maybe some of the explanation above should actually be moved to the
> commit message of the patch itself?
> 

yes, I agree. I have --amend'ed my commit message and re-attached it.

> Kevin

Thanks,
Matthias

> 
> ----- Forwarded message from Matthias Weckbecker <matthias@weckbecker.name> -----
> 
> (gdb) bt
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007fde12dfc801 in __GI_abort () at abort.c:79
> #2  0x00007fde12e45897 in __libc_message (action=action@entry=do_abort, fmt=fmt@entry=0x7fde12f72b9a "%s\n") at ../sysdeps/posix/libc_fatal.c:181
> #3  0x00007fde12e4c90a in malloc_printerr (str=str@entry=0x7fde12f70c9d "corrupted size vs. prev_size") at malloc.c:5350
> #4  0x00007fde12e4cb0c in malloc_consolidate (av=av@entry=0x7fde131a7c40 <main_arena>) at malloc.c:4456
> #5  0x00007fde12e5403b in _int_free (have_lock=0, p=<optimized out>, av=0x7fde131a7c40 <main_arena>) at malloc.c:4362
> #6  __GI___libc_free (mem=0x55f089173c20) at malloc.c:3124
> #7  0x000055f086c85062 in phys_section_destroy (mr=0x55f089173c20) at ./exec.c:1317
> #8  phys_sections_free (map=0x55f0890f1560) at ./exec.c:1325
> #9  address_space_dispatch_free (d=0x55f0890f1550) at ./exec.c:2777
> #10 0x000055f086cc0509 in flatview_destroy (view=0x55f088a5caf0) at ./memory.c:301
> #11 0x000055f087031dc0 in call_rcu_thread (opaque=<optimized out>) at ./util/rcu.c:272
> #12 0x00007fde131b46db in start_thread (arg=0x7fde0aa39700) at pthread_create.c:463
> #13 0x00007fde12edd88f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> ==13641== Thread 2:                                                                                                                                                                                   [0/5041]
> ==13641== Invalid read of size 8
> ==13641==    at 0x42755B: memory_region_unref (memory.c:1749)
> ==13641==    by 0x42755B: flatview_destroy (memory.c:307)
> ==13641==    by 0x798DBF: call_rcu_thread (rcu.c:272)
> ==13641==    by 0x97BF6DA: start_thread (pthread_create.c:463)
> ==13641==    by 0x9AF888E: clone (clone.S:95)
> ==13641==  Address 0x408e4670 is 64 bytes inside a block of size 1,440 free'd
> ==13641==    at 0x4C30D3B: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==13641==    by 0x5E988B: get_pci_config_device (pci.c:491)
> ==13641==    by 0x660069: vmstate_load_state (vmstate.c:140)
> ==13641==    by 0x660236: vmstate_load_state (vmstate.c:137)
> ==13641==    by 0x659994: vmstate_load (savevm.c:748)
> ==13641==    by 0x65A7B1: qemu_loadvm_section_start_full.isra.11 (savevm.c:1918)
> ==13641==    by 0x65AA67: qemu_loadvm_state_main.isra.13 (savevm.c:2013)
> ==13641==    by 0x65D7CE: qemu_loadvm_state (savevm.c:2092)
> ==13641==    by 0x65E40D: load_snapshot (savevm.c:2406)
> ==13641==    by 0x3E28C2: main (vl.c:4918)
> ==13641==  Block was alloc'd at
> ==13641==    at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==13641==    by 0x8D35A28: g_malloc (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.5600.3)
> ==13641==    by 0x5ECA8A: pci_bridge_region_init (pci_bridge.c:187)
> ==13641==    by 0x5ECEFC: pci_bridge_initfn (pci_bridge.c:384)
> ==13641==    by 0x5E654F: pci_bridge_dev_realize (pci_bridge_dev.c:59)
> ==13641==    by 0x5EBED0: pci_qdev_realize (pci.c:2034)
> ==13641==    by 0x5742D8: device_set_realized (qdev.c:914)
> ==13641==    by 0x6B8F96: property_set_bool (object.c:1906)
> ==13641==    by 0x6BD11E: object_property_set_qobject (qom-qobject.c:27)
> ==13641==    by 0x6BAD7F: object_property_set_bool (object.c:1171)
> ==13641==    by 0x4FA75D: qdev_device_add (qdev-monitor.c:629)
> ==13641==    by 0x4FCD36: device_init_func (vl.c:2432)
> ==13641==
> 
> 
> From 8229eb9cb97a1806e264290e2935261bf23c7f34 Mon Sep 17 00:00:00 2001
> From: Matthias Weckbecker <matthias@weckbecker.name>
> Date: Mon, 10 Dec 2018 14:00:48 +0100
> Subject: [PATCH] hw/pci-bridge: Fix invalid free()
> 
> When loadvm'ing a *running* snapshot qemu crashes due to an invalid
> free. It's fortunately caught early by glibc heap memory corruption
> protection and qemu gets killed with SIGABRT.
> 
> This commit fixes the issue.
> 
> Signed-off-by: Matthias Weckbecker <matthias@weckbecker.name>
> ---
>  hw/pci/pci_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index ee9dff2d3a..b9143ac88b 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -241,9 +241,9 @@ void pci_bridge_update_mappings(PCIBridge *br)
>       * while another accesses an unaffected region. */
>      memory_region_transaction_begin();
>      pci_bridge_region_del(br, br->windows);
> +    pci_bridge_region_cleanup(br, w);
>      br->windows = pci_bridge_region_init(br);
>      memory_region_transaction_commit();
> -    pci_bridge_region_cleanup(br, w);
>  }
>  
>  /* default write_config function for PCI-to-PCI bridge */
> -- 
> 2.11.0
> 
> ----- End forwarded message -----

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-hw-pci-bridge-Fix-invalid-free.patch"

>From 3f5ea73db8f781a43b0af0d3855cec604ba0434e Mon Sep 17 00:00:00 2001
From: Matthias Weckbecker <matthias@weckbecker.name>
Date: Mon, 10 Dec 2018 14:00:48 +0100
Subject: [PATCH] hw/pci-bridge: Fix invalid free()

When loadvm'ing a *running* snapshot qemu crashes due to an invalid
free. It's fortunately caught early by glibc heap memory corruption
protection and qemu gets killed with SIGABRT.

Steps to reproduce:

1) Create VM (e.g w/ virsh define)
2) Start the VM and take a snapshot while it's running and having a
   PCI bridge attached
3) Destroy the VM and revert the running snapshot.

This commit fixes the issue.

Signed-off-by: Matthias Weckbecker <matthias@weckbecker.name>
---
 hw/pci/pci_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index ee9dff2d3a..b9143ac88b 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -241,9 +241,9 @@ void pci_bridge_update_mappings(PCIBridge *br)
      * while another accesses an unaffected region. */
     memory_region_transaction_begin();
     pci_bridge_region_del(br, br->windows);
+    pci_bridge_region_cleanup(br, w);
     br->windows = pci_bridge_region_init(br);
     memory_region_transaction_commit();
-    pci_bridge_region_cleanup(br, w);
 }
 
 /* default write_config function for PCI-to-PCI bridge */
-- 
2.11.0


--y0ulUmNC+osPPQO6--
