Received: from eggs.gnu.org ([2001:4830:134:3::10]:58262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxCLG-0002qw-CT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxCLD-0001PD-8E
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:25:34 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:48973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxCLC-0001Oh-W7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:25:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id m127so18254120wmm.3
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 06:25:30 -0700 (PDT)
References: <70a6ee09-f482-58f9-dded-2fa90bdab90e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de7c8fda-7e93-b3fb-c1bf-ef7768e808e8@redhat.com>
Date: Wed, 27 Sep 2017 15:25:27 +0200
MIME-Version: 1.0
In-Reply-To: <70a6ee09-f482-58f9-dded-2fa90bdab90e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Something wrong in usb_try_create_simple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27/09/2017 13:38, Thomas Huth wrote:
>  Hi Gerd,
> 
> today, I've run into this issue reported by valgrind:
> 
> $ valgrind x86_64-softmmu/qemu-system-x86_64 -device usb-ehci -nographic -S
> ==2043== Memcheck, a memory error detector
> ==2043== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
> ==2043== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
> ==2043== Command: x86_64-softmmu/qemu-system-x86_64 -device usb-ehci -nographic -S
> ==2043== 
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add usb-tablet
> (qemu) device_add usb-tablet
> (qemu) device_add usb-tablet
> (qemu) device_add usb-tablet
> (qemu) device_add usb-tablet
> (qemu) device_add usb-tablet
> ==2043== Invalid read of size 8
> ==2043==    at 0x60EF50: object_unparent (object.c:445)

This object_unparent is not needed anymore.  See

    commit 69382d8b3e8600b349c191394d761dcb480502cf
    Author: Igor Mammedov <imammedo@redhat.com>
    Date:   Mon Jul 25 11:59:22 2016 +0200

    qdev: Fix object reference leak in case device.realize() fails

Paolo

> ==2043==    by 0x580F0D: usb_try_create_simple (bus.c:346)
> ==2043==    by 0x581BEB: usb_claim_port (bus.c:451)
> ==2043==    by 0x582310: usb_qdev_realize (bus.c:257)
> ==2043==    by 0x4CB399: device_set_realized (qdev.c:914)
> ==2043==    by 0x60E26D: property_set_bool (object.c:1886)
> ==2043==    by 0x61235E: object_property_set_qobject (qom-qobject.c:27)
> ==2043==    by 0x61000F: object_property_set_bool (object.c:1162)
> ==2043==    by 0x4567C3: qdev_device_add (qdev-monitor.c:630)
> ==2043==    by 0x456D52: qmp_device_add (qdev-monitor.c:807)
> ==2043==    by 0x470A99: hmp_device_add (hmp.c:1933)
> ==2043==    by 0x3679C3: handle_hmp_command (monitor.c:3123)
> ==2043==  Address 0x2100b430 is 32 bytes inside a block of size 6,448 free'd
> ==2043==    at 0x4C2ACDD: free (vg_replace_malloc.c:530)
> ==2043==    by 0xA04EBCD: g_free (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==2043==    by 0x60F735: object_finalize (object.c:471)
> ==2043==    by 0x60F735: object_unref (object.c:902)
> ==2043==    by 0x60E746: object_property_del_child.isra.7 (object.c:427)
> ==2043==    by 0x4CB2B2: device_set_realized (qdev.c:994)
> ==2043==    by 0x60E26D: property_set_bool (object.c:1886)
> ==2043==    by 0x61235E: object_property_set_qobject (qom-qobject.c:27)
> ==2043==    by 0x61000F: object_property_set_bool (object.c:1162)
> ==2043==    by 0x580EBB: usb_try_create_simple (bus.c:341)
> ==2043==    by 0x581BEB: usb_claim_port (bus.c:451)
> ==2043==    by 0x582310: usb_qdev_realize (bus.c:257)
> ==2043==    by 0x4CB399: device_set_realized (qdev.c:914)
> ==2043==  Block was alloc'd at
> ==2043==    at 0x4C29BE3: malloc (vg_replace_malloc.c:299)
> ==2043==    by 0xA04EABD: g_malloc (in /usr/lib64/libglib-2.0.so.0.5000.3)
> ==2043==    by 0x60EE0C: object_new_with_type (object.c:482)
> ==2043==    by 0x4CA080: qdev_try_create (qdev.c:152)
> ==2043==    by 0x580E7A: usb_try_create_simple (bus.c:336)
> ==2043==    by 0x581BEB: usb_claim_port (bus.c:451)
> ==2043==    by 0x582310: usb_qdev_realize (bus.c:257)
> ==2043==    by 0x4CB399: device_set_realized (qdev.c:914)
> ==2043==    by 0x60E26D: property_set_bool (object.c:1886)
> ==2043==    by 0x61235E: object_property_set_qobject (qom-qobject.c:27)
> ==2043==    by 0x61000F: object_property_set_bool (object.c:1162)
> ==2043==    by 0x4567C3: qdev_device_add (qdev-monitor.c:630)
> 
> Any idea what could be wrong here?
> 
>  Thomas
> 
> 
