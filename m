Received: from eggs.gnu.org ([209.51.188.92]:42785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boris.ostrovsky@oracle.com>) id 1ghJv1-0001fm-QQ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boris.ostrovsky@oracle.com>) id 1ghJv0-0004So-Q3
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:53:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <boris.ostrovsky@oracle.com>)
	id 1ghJv0-0004DH-FA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:53:38 -0500
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<CAGxU2F53zsuVRBbvGTOU81zObL+4tTg_FgE0i04G2eOWckc29Q@mail.gmail.com>
	<aa1cbeec-bb31-8849-c34b-e2397dc1c475@oracle.com>
	<CAGxU2F7rHv7HNNmvLSw9b5_GPEZqvo-XgCoc0penp8eFmWm6gw@mail.gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <fb7e62ea-0d3e-9b6f-4f1c-4bd780e50398@oracle.com>
Date: Wed, 9 Jan 2019 14:53:20 -0500
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7rHv7HNNmvLSw9b5_GPEZqvo-XgCoc0penp8eFmWm6gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v2 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Liam Merwick <liam.merwick@oracle.com>
Cc: maran.wilson@oracle.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>

On 1/9/19 6:53 AM, Stefano Garzarella wrote:
> Hi Liam,
>
> On Tue, Jan 8, 2019 at 3:47 PM Liam Merwick <liam.merwick@oracle.com> wrote:
>> QEMU sets the hvm_modlist_entry in load_linux() after the call to
>> load_elfboot() and then qboot loads it in boot_pvh_from_fw_cfg()
>>
>> But the current PVH patches don't handle initrd (they have
>> start_info.nr_modules == 1).
> Looking in the linux kernel (arch/x86/platform/pvh/enlighten.c) I saw:
>     /* The first module is always ramdisk. */
>     if (pvh_start_info.nr_modules) {
>         struct hvm_modlist_entry *modaddr =
>             __va(pvh_start_info.modlist_paddr);
>         pvh_bootparams.hdr.ramdisk_image = modaddr->paddr;
>         pvh_bootparams.hdr.ramdisk_size = modaddr->size;
>     }
>
> So, putting start_info.nr_modules = 1, means that the first
> hvm_modlist_entry should have the ramdisk paddr and size. Is it
> correct?
>
>
>> During (or after) the call to load_elfboot() it looks like we'd need to
>> do something like what load_multiboot() does below (along with the
>> associated initialisation)
>>
>> 400     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, ADDR_MBI);
>> 401     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, sizeof(bootinfo));
>> 402     fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>> 403                      sizeof(bootinfo));
>>
> In this case I think they used the FW_CFG_INITRD_* to pass bootinfo
> varibales to the guest, maybe we could add something like what
> linux_load() does:
>
>     /* load initrd */
>     if (initrd_filename) {
>         ...
>         initrd_addr = (initrd_max-initrd_size) & ~4095;
>
>         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>         fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
>         ...
>     }
>
> Then we can load the initrd in qboot or in the optionrom that I'm writing.
>
> What do you think?


Why not specify this in pvh_start_info? This will be much faster for
everyone, no need to go through fw_cfg.

-boris
