Received: from eggs.gnu.org ([209.51.188.92]:36901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hH8YX-0005xw-Hp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsuryacse7k@gmail.com>) id 1hH8YT-0006Am-BG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:29 -0400
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsuryacse7k@gmail.com>)
	id 1hH8YN-00068Z-Tx
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:02:21 -0400
Received: by mail-it1-x133.google.com with SMTP id u65so3793624itc.2
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:02:19 -0700 (PDT)
MIME-Version: 1.0
From: suresh gumpula <gsuryacse7k@gmail.com>
Date: Thu, 18 Apr 2019 08:02:07 -0700
Message-ID: <CAJOqHmiHMKcDiwzCFR0QDr1U59_8GwXUFDZGj=1yyjKmT=uwkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel]  Live migration fails with all 8 memslots used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
I was trying to migrate a VM(CentOS7) which  started with 4G memory and hot
plugged 5 memslots with 1G each.  So the VM has total of 9G memory and
trying to migrate fails in vhost_dev_init() on destination host


    if (used_memslots >
hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {

        error_report("vhost backend memory slots limit is less"

                     " than current number of present memory slots");

        r = -1;

        if (busyloop_timeout) {

            goto fail_busyloop;

        } else {

            goto fail;

        }

    }


Debugged more into this and understood that, after vhost_dev_init()
used_memslots are 4


(gdb) show-vhost-dev-memory-regions 0x555556d27000

n_mem_sections:4

n_regions:4

Region0:

$101 = {

  guest_phys_addr = 0x100000000,        ; 1G above 4G

  memory_size = 0x40000000,

  userspace_addr = 0x7fffb4600000,

  flags_padding = 0x0

}

Region1:

$102 = {

  guest_phys_addr = 0xc0000,     ; 768k-896k

  memory_size = 0x20000,

  userspace_addr = 0x7ffef4200000,

  flags_padding = 0x0

}

Region2:

$103 = {

  guest_phys_addr = 0x100000,             ;;3G from 1M

  memory_size = 0xbff00000,

  userspace_addr = 0x7ffef4700000,

  flags_padding = 0x0

}

Region3:

$104 = {

  guest_phys_addr = 0x0,

  memory_size = 0xa0000,              ;   First 640K;   0 - 640k;

  userspace_addr = 0x7ffef4600000,

  flags_padding = 0x0

}

(gdb) p used_memslots

$150 = 4


And later on it coalesced the VGA region of 128k at 0xc0000( 768-896k) upon
guest config write

with  i440fx_update_memory_mappings(d);

(gdb) f 5

#5  0x000055555595b920 in i440fx_write_config (dev=0x5555572b8000,
address=90, val=51, len=1) at hw/pci-host/piix.c:168

168             i440fx_update_memory_mappings(d);

(gdb) l

163

164         /* XXX: implement SMRAM.D_LOCK */

165         pci_default_write_config(dev, address, val, len);

166         if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||

167             range_covers_byte(address, len, I440FX_SMRAM)) {

168             i440fx_update_memory_mappings(d);

169         }

170     }



(gdb) p used_memslots

$150 = 3


Since the destination QEMU does not know that the source host coalesced one
region,  vhost_dev_init for kernel started with 4 slots and  hot plugged 5
slots and then the vhost_dev_init for user fails since 9>8 is true.


    if (used_memslots >
hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {

        error_report("vhost backend memory slots limit is less"

                     " than current number of present memory slots");

        r = -1;

        if (busyloop_timeout) {

            goto fail_busyloop;

        } else {

            goto fail;

        }

    }


Can you guys please answer my questions here:

1)  Why is the VGA region of 128k coalesced on guest vcpu execution with
pci config write?

2)  We have memslots limit of 8 and 3 are pre occupied with initial memory
and we can only use 4 memslots for hotplug instead of 5 to migrate a VM.
Is there any reason for this?  We cannot hotplug 5 slots and migrate the VM.



Thanks much

Suresh.G
