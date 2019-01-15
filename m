Received: from eggs.gnu.org ([209.51.188.92]:39938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjLOJ-0007va-7D
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjLOH-0008BD-UR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:52:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gjLOH-00089v-Lv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:52:13 -0500
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<CAGxU2F53zsuVRBbvGTOU81zObL+4tTg_FgE0i04G2eOWckc29Q@mail.gmail.com>
	<aa1cbeec-bb31-8849-c34b-e2397dc1c475@oracle.com>
	<CAGxU2F7rHv7HNNmvLSw9b5_GPEZqvo-XgCoc0penp8eFmWm6gw@mail.gmail.com>
	<fb7e62ea-0d3e-9b6f-4f1c-4bd780e50398@oracle.com>
	<d1877cd9-7374-1512-7b01-2a2fb184643a@oracle.com>
	<20190110151241.t5jxzsjsnujhkftw@steredhat>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <11e1206f-d6f8-45c0-5670-21c50c32d819@oracle.com>
Date: Tue, 15 Jan 2019 09:51:03 +0000
MIME-Version: 1.0
In-Reply-To: <20190110151241.t5jxzsjsnujhkftw@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Maran Wilson <maran.wilson@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>

Hi Stefano,

On 10/01/2019 15:12, Stefano Garzarella wrote:
> On Wed, Jan 09, 2019 at 01:18:12PM -0800, Maran Wilson wrote:
>> On 1/9/2019 11:53 AM, Boris Ostrovsky wrote:
>>> On 1/9/19 6:53 AM, Stefano Garzarella wrote:
>>>> Hi Liam,
>>>>
>>>> On Tue, Jan 8, 2019 at 3:47 PM Liam Merwick <liam.merwick@oracle.com> wrote:
>>>>> QEMU sets the hvm_modlist_entry in load_linux() after the call to
>>>>> load_elfboot() and then qboot loads it in boot_pvh_from_fw_cfg()
>>>>>
>>>>> But the current PVH patches don't handle initrd (they have
>>>>> start_info.nr_modules == 1).
>>>> Looking in the linux kernel (arch/x86/platform/pvh/enlighten.c) I saw:
>>>>       /* The first module is always ramdisk. */
>>>>       if (pvh_start_info.nr_modules) {
>>>>           struct hvm_modlist_entry *modaddr =
>>>>               __va(pvh_start_info.modlist_paddr);
>>>>           pvh_bootparams.hdr.ramdisk_image = modaddr->paddr;
>>>>           pvh_bootparams.hdr.ramdisk_size = modaddr->size;
>>>>       }
>>>>
>>>> So, putting start_info.nr_modules = 1, means that the first
>>>> hvm_modlist_entry should have the ramdisk paddr and size. Is it
>>>> correct?
>>
>> That's my understanding.
>>
>> I think what's missing, is that we just need Qemu or qboot/seabios to
>> properly populate the pvh_start_info.modlist_paddr with the address (as
>> usable by the guest) of the hvm_modlist_entry which correctly defines the
>> details of the initrd that has already been loaded into memory that is
>> accessible by the guest.
>>
>> -Maran
>>
> 
> I tried and it works, I modified QEMU to load the initrd and to expose it
> through fw_cfg, then qboot loads it and set correctly the hvm_modlist_entry.
> 
> You can find the patch of QEMU at the end of this email and the qboot
> patch here: https://github.com/stefano-garzarella/qboot/commit/41e1fd765c8419e270fd79d9b3af5d53576e88a8
> 
> Do you think can be a good approach? If you want, you can add this patch
> to your series.

Code looks good to me. I'll include it with v3 of my QEMU patches.

Regards,
Liam


> 
> Thanks,
> Stefano
> 
> 
>  From d5c0d51768f5a8fb214be6c2bb0cb7e86e9917b7 Mon Sep 17 00:00:00 2001
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Thu, 10 Jan 2019 15:16:44 +0100
> Subject: [PATCH] pvh: load initrd and expose it through fw_cfg
> 
> When initrd is specified, load and expose it to the guest firmware
> through fw_cfg. The firmware will fill the hvm_start_info for the
> kernel.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
> ---
>   hw/i386/pc.c | 38 +++++++++++++++++++++++++++++---------
>   1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 06bce6a101..f6721f51be 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -986,25 +986,45 @@ static void load_linux(PCMachineState *pcms,
>            */
>           if (load_elfboot(kernel_filename, kernel_size,
>                            header, pvh_start_addr, fw_cfg)) {
> -            struct hvm_modlist_entry ramdisk_mod = { 0 };
> -
>               fclose(f);
>   
>               fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
>                   strlen(kernel_cmdline) + 1);
>               fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>   
> -            assert(machine->device_memory != NULL);
> -            ramdisk_mod.paddr = machine->device_memory->base;
> -            ramdisk_mod.size =
> -                memory_region_size(&machine->device_memory->mr);
> -
> -            fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, &ramdisk_mod,
> -                             sizeof(ramdisk_mod));
>               fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
>               fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
>                                header, sizeof(header));
>   
> +            /* load initrd */
> +            if (initrd_filename) {
> +                gsize initrd_size;
> +                gchar *initrd_data;
> +                GError *gerr = NULL;
> +
> +                if (!g_file_get_contents(initrd_filename, &initrd_data,
> +                            &initrd_size, &gerr)) {
> +                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
> +                            initrd_filename, gerr->message);
> +                    exit(1);
> +                }
> +
> +                initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
> +                if (initrd_size >= initrd_max) {
> +                    fprintf(stderr, "qemu: initrd is too large, cannot support."
> +                            "(max: %"PRIu32", need %"PRId64")\n",
> +                            initrd_max, (uint64_t)initrd_size);
> +                    exit(1);
> +                }
> +
> +                initrd_addr = (initrd_max - initrd_size) & ~4095;
> +
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
> +                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
> +                                 initrd_size);
> +            }
> +
>               return;
>           }
>           /* This looks like a multiboot kernel. If it is, let's stop
> 
