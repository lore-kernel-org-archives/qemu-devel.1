Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dxF6X-0006sy-NH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dxF6T-0001tA-NX
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:22:33 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:49311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dxF6T-0001pK-Hs
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:22:29 -0400
Received: by mail-pg0-x22e.google.com with SMTP id m30so8040551pgn.6
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 09:22:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b5786d73-10f9-bba8-28c6-275cdf623004@redhat.com>
References: <b5786d73-10f9-bba8-28c6-275cdf623004@redhat.com>
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 27 Sep 2017 19:22:26 +0300
Message-ID: <CAKSfGUC5qvxreaP2cVusw6wAaHV9H8NQ91x9EtiSiz9Y-LkmTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Problem in pcie_pci_bridge_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

2017-09-27 18:50 GMT+03:00 Thomas Huth <thuth@redhat.com>:
>  Hi,
>
> QEMU currently aborts with an assertion when plugging of the
> pcie-pci-bridge fails, e.g.:
>
> $ mips64el-softmmu/qemu-system-mips64el -M malta -nographic -S \
>                 -device pcie-pci-bridge -bios pc-bios/bios.bin
> qemu-system-mips64el: memory.c:1699: memory_region_finalize:
>  Assertion `!mr->container' failed.
> Aborted (core dumped)
>
> The backtrace points to the pcie_pci_bridge_realize() function:
>
> #0  0x00007ffff150f1f7 in raise () at /lib64/libc.so.6
> #1  0x00007ffff15108e8 in abort () at /lib64/libc.so.6
> #2  0x00007ffff1508266 in __assert_fail_base () at /lib64/libc.so.6
> #3  0x00007ffff1508312 in  () at /lib64/libc.so.6
> #4  0x00005555557cedaf in memory_region_finalize (obj=<optimized out>)
>     at /home/thuth/devel/qemu/memory.c:1699
> #5  0x0000555555a49852 in object_unref (type=<optimized out>, obj=0x555556e68580)
>     at /home/thuth/devel/qemu/qom/object.c:453
> #6  0x0000555555a49852 in object_unref (data=0x555556e68580) at /home/thuth/devel/qemu/qom/object.c:467
> #7  0x0000555555a49852 in object_unref (obj=0x555556e68580) at /home/thuth/devel/qemu/qom/object.c:902
> #8  0x0000555555a48887 in object_property_del_child (obj=0x555556dc7760, child=child@entry=0x555556e68580, errp=0x0) at /home/thuth/devel/qemu/qom/object.c:427
> #9  0x0000555555a490a4 in object_unparent (obj=obj@entry=0x555556e68580)
>     at /home/thuth/devel/qemu/qom/object.c:446
> #10 0x00005555559906ae in shpc_free (d=d@entry=0x555556dc7760)
>     at /home/thuth/devel/qemu/hw/pci/shpc.c:676
> #11 0x0000555555987470 in pcie_pci_bridge_realize (d=0x555556dc7760, errp=0x7fffffffd710)
>     at /home/thuth/devel/qemu/hw/pci-bridge/pcie_pci_bridge.c:84
> #12 0x000055555598ca67 in pci_qdev_realize (qdev=0x555556dc7760, errp=0x7fffffffd7b0)
>     at /home/thuth/devel/qemu/hw/pci/pci.c:2024
> #13 0x000055555590ee4a in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffd8e8) at /home/thuth/devel/qemu/hw/core/qdev.c:914
>
> Any clue what might be wrong here?
>
>  Thomas

Hi Thomas,
This bug was already reported by Eduardo with ppc64, try this patch
that is intended to fix it

http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg06696.html

-- 
Aleksandr Bezzubikov
