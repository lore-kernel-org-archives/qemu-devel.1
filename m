Received: from eggs.gnu.org ([209.51.188.92]:57427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghCQk-0004nn-Gc
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghCQj-0002GC-Ll
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:53:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ghCQj-0002Fn-Gs
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:53:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so6039616oiw.9
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:53:52 -0800 (PST)
MIME-Version: 1.0
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<CAGxU2F53zsuVRBbvGTOU81zObL+4tTg_FgE0i04G2eOWckc29Q@mail.gmail.com>
	<aa1cbeec-bb31-8849-c34b-e2397dc1c475@oracle.com>
In-Reply-To: <aa1cbeec-bb31-8849-c34b-e2397dc1c475@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jan 2019 12:53:40 +0100
Message-ID: <CAGxU2F7rHv7HNNmvLSw9b5_GPEZqvo-XgCoc0penp8eFmWm6gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: maran.wilson@oracle.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Hi Liam,

On Tue, Jan 8, 2019 at 3:47 PM Liam Merwick <liam.merwick@oracle.com> wrote:
> QEMU sets the hvm_modlist_entry in load_linux() after the call to
> load_elfboot() and then qboot loads it in boot_pvh_from_fw_cfg()
>
> But the current PVH patches don't handle initrd (they have
> start_info.nr_modules == 1).

Looking in the linux kernel (arch/x86/platform/pvh/enlighten.c) I saw:
    /* The first module is always ramdisk. */
    if (pvh_start_info.nr_modules) {
        struct hvm_modlist_entry *modaddr =
            __va(pvh_start_info.modlist_paddr);
        pvh_bootparams.hdr.ramdisk_image = modaddr->paddr;
        pvh_bootparams.hdr.ramdisk_size = modaddr->size;
    }

So, putting start_info.nr_modules = 1, means that the first
hvm_modlist_entry should have the ramdisk paddr and size. Is it
correct?


>
> During (or after) the call to load_elfboot() it looks like we'd need to
> do something like what load_multiboot() does below (along with the
> associated initialisation)
>
> 400     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, ADDR_MBI);
> 401     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, sizeof(bootinfo));
> 402     fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
> 403                      sizeof(bootinfo));
>

In this case I think they used the FW_CFG_INITRD_* to pass bootinfo
varibales to the guest, maybe we could add something like what
linux_load() does:

    /* load initrd */
    if (initrd_filename) {
        ...
        initrd_addr = (initrd_max-initrd_size) & ~4095;

        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
        ...
    }

Then we can load the initrd in qboot or in the optionrom that I'm writing.

What do you think?

Thanks,
Stefano

> I'm checking to see if that has any implications for the kernel side.
>
> Regards,
> Liam
>


-- 
Stefano Garzarella
Red Hat
