Received: from eggs.gnu.org ([2001:4830:134:3::10]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkE5d-0008HN-3P
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkE5a-0001qp-VU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:39:49 -0400
References: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b835c12-04c2-b1f9-4768-0f443742eb07@redhat.com>
Date: Tue, 22 Aug 2017 14:39:38 -0400
MIME-Version: 1.0
In-Reply-To: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Use after free problem somewhere in ahci.c or
 ich.c code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>



On 08/22/2017 02:15 PM, Thomas Huth wrote:
> 
>  Hi!
> 
> Looks like there is a use-after-free problem somewhere in
> the ahci.c or ich.c code when trying to add the ich9-ahci
> on a old PC machine. Using valgrind, I get:
> 

I'll look; it looks like it works okay for pc-i440fx-2.9 as well as 2.0
and 1.7.

1.6 appears to be the most modern board that has issues, as well as 1.4
and the pc-1.2 board you specify.

> $ valgrind x86_64-softmmu/qemu-system-x86_64 -M pc-1.2 -nographic -S
> ==6604== Memcheck, a memory error detector
> ==6604== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
> ==6604== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
> ==6604== Command: x86_64-softmmu/qemu-system-x86_64 -M pc-1.2 -nographic -S
> ==6604== 
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add ich9-ahci,id=ich9-ahci
> ==6604== Invalid read of size 8
> ==6604==    at 0x609AB0: object_unparent (object.c:445)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==    by 0x6E5D27: readline_handle_byte (readline.c:393)
> ==6604==    by 0x364311: monitor_read (monitor.c:3905)
> ==6604==    by 0x67C573: mux_chr_read (char-mux.c:216)
> ==6604==  Address 0x15fc5448 is 30,328 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x60A350: object_finalize_child_property (object.c:1395)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==    by 0x6E5D27: readline_handle_byte (readline.c:393)
> ==6604==    by 0x364311: monitor_read (monitor.c:3905)
> ==6604==  Address 0x15fc5428 is 30,296 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x609CA9: object_dynamic_cast_assert (object.c:614)
> ==6604==    by 0x4C879F: bus_unparent (bus.c:115)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==  Address 0x15fc5428 is 30,296 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x609CCB: object_dynamic_cast_assert (object.c:621)
> ==6604==    by 0x4C879F: bus_unparent (bus.c:115)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==  Address 0x15fc5428 is 30,296 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x4C87A0: bus_unparent (bus.c:118)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==    by 0x6E5D27: readline_handle_byte (readline.c:393)
> ==6604==  Address 0x15fc5470 is 30,368 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x4C87C1: bus_unparent (bus.c:122)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==    by 0x365439: monitor_command_cb (monitor.c:3922)
> ==6604==    by 0x6E5D27: readline_handle_byte (readline.c:393)
> ==6604==  Address 0x15fc5450 is 30,336 bytes inside a block of size 36,288 free'd
> ==6604==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==6604==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50100E: pci_ich9_uninit (ich.c:161)
> ==6604==    by 0x5428AB: pci_qdev_unrealize (pci.c:1083)
> ==6604==    by 0x4C5EE9: device_set_realized (qdev.c:988)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604==    by 0x364083: handle_hmp_command (monitor.c:3119)
> ==6604==  Block was alloc'd at
> ==6604==    at 0x4C2B975: calloc (vg_replace_malloc.c:711)
> ==6604==    by 0xA04EB15: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==6604==    by 0x50094F: ahci_realize (ahci.c:1468)
> ==6604==    by 0x501098: pci_ich9_ahci_realize (ich.c:115)
> ==6604==    by 0x543E6D: pci_qdev_realize (pci.c:2002)
> ==6604==    by 0x4C5E69: device_set_realized (qdev.c:914)
> ==6604==    by 0x608DCD: property_set_bool (object.c:1886)
> ==6604==    by 0x60CEBE: object_property_set_qobject (qom-qobject.c:27)
> ==6604==    by 0x60AB6F: object_property_set_bool (object.c:1162)
> ==6604==    by 0x4516F3: qdev_device_add (qdev-monitor.c:630)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> ==6604==    by 0x46B689: hmp_device_add (hmp.c:1925)
> ==6604== 
> ==6604== Invalid read of size 8
> ==6604==    at 0x4C87C8: bus_unparent (bus.c:123)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x4C4478: device_unparent (qdev.c:1095)
> ==6604==    by 0x60A364: object_finalize_child_property (object.c:1396)
> ==6604==    by 0x6092A6: object_property_del_child.isra.7 (object.c:427)
> ==6604==    by 0x451728: qdev_device_add (qdev-monitor.c:634)
> ==6604==    by 0x451C82: qmp_device_add (qdev-monitor.c:807)
> Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set
> 
> Does anybody have an idea what could be wrong here?
> 

Is it expected that this should be addable to these old boards?

Best guess is some code that we added to unrealize the AHCI device does
not work exactly correctly; I've no clue about the acpi-pcihp-bsel
property, though.

>  Thanks,
>   Thomas
> 
