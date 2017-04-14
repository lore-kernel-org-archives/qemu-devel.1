Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1czA3d-0002wV-4K
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 18:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1czA3Y-0005Qi-7K
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 18:51:13 -0400
Received: from mail.kernel.org ([198.145.29.136]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1czA3X-0005Pd-PI
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 18:51:08 -0400
Date: Fri, 14 Apr 2017 15:50:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1704141527490.23677@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU build breakage on ARM against Xen 4.9 caused by
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paul.durrant@citrix.com
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, anthony.perard@citrix.com, wei.liu2@citrix.com, jgross@suse.com, julien.grall@arm.com, xen-devel@lists.xenproject.org

Hi Paul,

The following commit in my qemu "next" branch breaks the build on arm
and arm64:

commit 670271647ad15e9d937ced7a72c892349c709216
Author: Paul Durrant <paul.durrant@citrix.com>
Date:   Tue Mar 7 10:55:34 2017 +0000

    xen: use libxendevicemodel when available

See the appended build log. Sorry for not realizing it sooner.

Please note that up to now we have been unable to disentangle the PV
machine from the i386 emulator in QEMU.  Thus, on arm and arm64 we build
qemu with --target-list=3Di386-softmmu as we do on x86. Of course, the
xenfv machine cannot work on arm. Only the xenpv machine can be used.
However, the xenfv machine is still included in the build.

This means that we cannot break the xenfv machine build on arm and arm64.


Going into details, "xen: use libxendevicemodel when available" breaks
the build on arm and arm64 even with -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1=
.
It breaks 4.8 compatibility which is a regression from QEMU's point of
view.


Why 4.8 compatibility? Because the previous commit:

commit 2a15d804eb0e4f8bc25738b6aec30a0142d5d293
Author: Paul Durrant <paul.durrant@citrix.com>
Date:   Tue Mar 7 10:55:33 2017 +0000

    configure: detect presence of libxendevicemodel

doesn't work properly on arm: Xen 4.9 is not detected. However, that is
not a regression per se.


We cannot break the QEMU build against Xen 4.9 with
-DXC_WANT_COMPAT_DEVICEMODEL_API=3D1 or older releases. That has to work,
but I guess it won't be too difficult to fix.

The difficulty is how to introduce proper Xen 4.9 and libxendevicemodel
support in QEMU. We either need to fix libxendevicemodel on arm
(although obviously is never going to be actually used at run time, but
it is necessary for the build), or we need to disentangle the xenpv
machine build from the xenfv machine build in QEMU. I prefer the latter
approach, of course.

I haven't dug into what is the problem with libxendevicemodel on arm.
Needless to say, if there is an issue on the Xen side, it might impact
the Xen 4.9 release.


For your information, you can download a free (as in beer) arm64
software model from ARM called "Foundation Model", see the Xen wiki for
instructions:

https://wiki.xenproject.org/wiki/Xen_ARM_with_Virtualization_Extensions/F=
astModels

In addition, I think you can purchase access to ARM64 servers from
packet.net.


Thanks,

Stefano


---

In file included from /root/qemu/include/hw/xen/xen_backend.h:4:0,
                 from hw/block/xen_disk.c:27:
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_create_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:46:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
            ^
/root/qemu/include/hw/xen/xen_common.h:46:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_get_ioreq_server_info=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:55:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
            ^
/root/qemu/include/hw/xen/xen_common.h:55:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dnested-=
externs]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_io_range_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:63:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
            ^
/root/qemu/include/hw/xen/xen_common.h:63:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_io_range_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:71:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-=
Werror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
            ^
/root/qemu/include/hw/xen/xen_common.h:71:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-Werro=
r=3Dnested-externs]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_pcidev_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:79:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
            ^
/root/qemu/include/hw/xen/xen_common.h:79:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=3Dne=
sted-externs]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_pcidev_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:87:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
            ^
/root/qemu/include/hw/xen/xen_common.h:87:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_destroy_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:94:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
            ^
/root/qemu/include/hw/xen/xen_common.h:94:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dnested-e=
xterns]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_ioreq_server_state=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:100:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3D=
implicit-function-declaration]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
            ^
/root/qemu/include/hw/xen/xen_common.h:100:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3Dneste=
d-externs]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_intx_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:109:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
            ^
  CC      hw/intc/i8259.o
/root/qemu/include/hw/xen/xen_common.h:109:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_isa_irq_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:117:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
            ^
/root/qemu/include/hw/xen/xen_common.h:117:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dnested-ext=
erns]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_link_route=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:123:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
            ^
/root/qemu/include/hw/xen/xen_common.h:123:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_inject_msi=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:130:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
            ^
/root/qemu/include/hw/xen/xen_common.h:130:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_track_dirty_vram=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:137:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
            ^
/root/qemu/include/hw/xen/xen_common.h:137:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dnested-exte=
rns]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_modified_memory=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:145:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:145:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dnested-exter=
ns]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_mem_type=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:152:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:152:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
     ^
  CC      hw/intc/ioapic_common.o
  CC      hw/intc/intc.o
  CC      hw/ipack/ipack.o
  CC      hw/ipmi/ipmi.o
  CC      hw/ipack/tpci200.o
  CC      hw/ipmi/ipmi_bmc_sim.o
In file included from /root/qemu/include/hw/xen/xen_backend.h:4:0,
                 from hw/char/xen_console.c:29:
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_create_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:46:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
            ^
/root/qemu/include/hw/xen/xen_common.h:46:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_get_ioreq_server_info=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:55:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
            ^
/root/qemu/include/hw/xen/xen_common.h:55:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dnested-=
externs]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
     ^
  CC      hw/ipmi/isa_ipmi_kcs.o
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_io_range_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:63:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
            ^
/root/qemu/include/hw/xen/xen_common.h:63:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_io_range_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:71:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-=
Werror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
            ^
/root/qemu/include/hw/xen/xen_common.h:71:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-Werro=
r=3Dnested-externs]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_pcidev_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:79:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
            ^
/root/qemu/include/hw/xen/xen_common.h:79:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=3Dne=
sted-externs]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_pcidev_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:87:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
            ^
/root/qemu/include/hw/xen/xen_common.h:87:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_destroy_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:94:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
            ^
/root/qemu/include/hw/xen/xen_common.h:94:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dnested-e=
xterns]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_ioreq_server_state=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:100:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3D=
implicit-function-declaration]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
            ^
/root/qemu/include/hw/xen/xen_common.h:100:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3Dneste=
d-externs]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_intx_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:109:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
            ^
/root/qemu/include/hw/xen/xen_common.h:109:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_isa_irq_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:117:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
            ^
/root/qemu/include/hw/xen/xen_common.h:117:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dnested-ext=
erns]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_link_route=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:123:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
            ^
/root/qemu/include/hw/xen/xen_common.h:123:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_inject_msi=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:130:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
            ^
/root/qemu/include/hw/xen/xen_common.h:130:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_track_dirty_vram=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:137:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
            ^
/root/qemu/include/hw/xen/xen_common.h:137:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dnested-exte=
rns]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_modified_memory=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:145:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:145:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dnested-exter=
ns]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_mem_type=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:152:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:152:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
     ^
  CC      hw/ipmi/ipmi_bmc_extern.o
  CC      hw/ipmi/isa_ipmi_bt.o
  CC      hw/mem/pc-dimm.o
  CC      hw/isa/isa-bus.o
  CC      hw/isa/apm.o
  CC      hw/mem/nvdimm.o
  CC      hw/misc/applesmc.o
  CC      hw/misc/debugexit.o
  CC      hw/misc/sga.o
  CC      hw/misc/pc-testdev.o
  CC      hw/misc/pci-testdev.o
  CC      hw/misc/unimp.o
  CC      hw/net/xen_nic.o
  CC      hw/net/ne2000.o
  CC      hw/net/pcnet.o
  CC      hw/net/eepro100.o
  CC      hw/net/pcnet-pci.o
  CC      hw/net/e1000.o
  CC      hw/net/e1000x_common.o
  CC      hw/net/net_rx_pkt.o
  CC      hw/net/net_tx_pkt.o
cc1: all warnings being treated as errors
/root/qemu/rules.mak:69: recipe for target 'hw/char/xen_console.o' failed
make: *** [hw/char/xen_console.o] Error 1
make: *** Waiting for unfinished jobs....
In file included from /root/qemu/include/hw/xen/xen_backend.h:4:0,
                 from hw/display/xenfb.c:32:
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_create_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:46:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
            ^
/root/qemu/include/hw/xen/xen_common.h:46:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_get_ioreq_server_info=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:55:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
            ^
/root/qemu/include/hw/xen/xen_common.h:55:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dnested-=
externs]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_io_range_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:63:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
            ^
/root/qemu/include/hw/xen/xen_common.h:63:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_io_range_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:71:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-=
Werror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
            ^
/root/qemu/include/hw/xen/xen_common.h:71:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-Werro=
r=3Dnested-externs]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_pcidev_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:79:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
            ^
/root/qemu/include/hw/xen/xen_common.h:79:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=3Dne=
sted-externs]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_pcidev_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:87:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
            ^
/root/qemu/include/hw/xen/xen_common.h:87:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_destroy_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:94:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
            ^
/root/qemu/include/hw/xen/xen_common.h:94:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dnested-e=
xterns]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_ioreq_server_state=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:100:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3D=
implicit-function-declaration]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
            ^
/root/qemu/include/hw/xen/xen_common.h:100:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3Dneste=
d-externs]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_intx_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:109:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
            ^
/root/qemu/include/hw/xen/xen_common.h:109:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_isa_irq_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:117:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
            ^
/root/qemu/include/hw/xen/xen_common.h:117:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dnested-ext=
erns]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_link_route=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:123:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
            ^
/root/qemu/include/hw/xen/xen_common.h:123:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_inject_msi=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:130:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
            ^
/root/qemu/include/hw/xen/xen_common.h:130:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_track_dirty_vram=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:137:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
            ^
/root/qemu/include/hw/xen/xen_common.h:137:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dnested-exte=
rns]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_modified_memory=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:145:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:145:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dnested-exter=
ns]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_mem_type=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:152:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:152:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
     ^
In file included from /root/qemu/include/hw/xen/xen_backend.h:4:0,
                 from hw/net/xen_nic.c:31:
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_create_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:46:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
            ^
/root/qemu/include/hw/xen/xen_common.h:46:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_create_ioreq_server=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_get_ioreq_server_info=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:55:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
            ^
/root/qemu/include/hw/xen/xen_common.h:55:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_get_ioreq_server_info=E2=80=99 [-Werror=3Dnested-=
externs]
     return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_io_range_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:63:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
            ^
/root/qemu/include/hw/xen/xen_common.h:63:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_io_range_to_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_io_range_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:71:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-=
Werror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
            ^
/root/qemu/include/hw/xen/xen_common.h:71:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_io_range_from_ioreq_server=E2=80=99 [-Werro=
r=3Dnested-externs]
     return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_m=
mio,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_map_pcidev_to_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:79:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
            ^
/root/qemu/include/hw/xen/xen_common.h:79:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_map_pcidev_to_ioreq_server=E2=80=99 [-Werror=3Dne=
sted-externs]
     return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_unmap_pcidev_from_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:87:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
            ^
/root/qemu/include/hw/xen/xen_common.h:87:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_unmap_pcidev_from_ioreq_server=E2=80=99 [-Werror=3D=
nested-externs]
     return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segmen=
t,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_destroy_ioreq_server=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:94:12: error: implicit declaration=
 of function =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
            ^
/root/qemu/include/hw/xen/xen_common.h:94:5: error: nested extern declara=
tion of =E2=80=98xc_hvm_destroy_ioreq_server=E2=80=99 [-Werror=3Dnested-e=
xterns]
     return xc_hvm_destroy_ioreq_server(dmod, domid, id);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_ioreq_server_state=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:100:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3D=
implicit-function-declaration]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
            ^
/root/qemu/include/hw/xen/xen_common.h:100:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_ioreq_server_state=E2=80=99 [-Werror=3Dneste=
d-externs]
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_intx_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:109:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
            ^
/root/qemu/include/hw/xen/xen_common.h:109:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_intx_level=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_isa_irq_level=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:117:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
            ^
/root/qemu/include/hw/xen/xen_common.h:117:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_isa_irq_level=E2=80=99 [-Werror=3Dnested-ext=
erns]
     return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_pci_link_route=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:123:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
            ^
/root/qemu/include/hw/xen/xen_common.h:123:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_pci_link_route=E2=80=99 [-Werror=3Dnested-ex=
terns]
     return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_inject_msi=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:130:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
            ^
/root/qemu/include/hw/xen/xen_common.h:130:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_inject_msi=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_track_dirty_vram=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:137:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
            ^
/root/qemu/include/hw/xen/xen_common.h:137:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_track_dirty_vram=E2=80=99 [-Werror=3Dnested-exte=
rns]
     return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_modified_memory=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:145:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:145:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_modified_memory=E2=80=99 [-Werror=3Dnested-exter=
ns]
     return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
     ^
/root/qemu/include/hw/xen/xen_common.h: In function =E2=80=98xendevicemod=
el_set_mem_type=E2=80=99:
/root/qemu/include/hw/xen/xen_common.h:152:12: error: implicit declaratio=
n of function =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
            ^
/root/qemu/include/hw/xen/xen_common.h:152:5: error: nested extern declar=
ation of =E2=80=98xc_hvm_set_mem_type=E2=80=99 [-Werror=3Dnested-externs]
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
     ^
cc1: all warnings being treated as errors
cc1: all warnings being treated as errors
/root/qemu/rules.mak:69: recipe for target 'hw/block/xen_disk.o' failed
make: *** [hw/block/xen_disk.o] Error 1
/root/qemu/rules.mak:69: recipe for target 'hw/display/xenfb.o' failed
make: *** [hw/display/xenfb.o] Error 1
cc1: all warnings being treated as errors
/root/qemu/rules.mak:69: recipe for target 'hw/net/xen_nic.o' failed
make: *** [hw/net/xen_nic.o] Error 1
