Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSWuZ-0006qy-3u
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSWuU-00058o-47
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:44:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSWuT-00057z-P4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:43:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so3657161wrs.8
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:43:57 -0800 (PST)
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a05ba14f-b261-bb8c-12a1-4c91d005961f@redhat.com>
Date: Fri, 30 Nov 2018 01:43:54 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Clement Deschamps <clement.deschamps@antfield.fr>, Guenter Roeck <linux@roeck-us.net>

Hi Zoltan,

On 29/11/18 21:29, BALATON Zoltan wrote:
> Hello,
> 
> I could not boot Raspbian on QEMU's raspi emulation and I'm not sure why
> it fails. So question is if this is supposed to work or am I doing
> something wrong or any clues what may be missing? I'm trying with this
> command line with v3.1.0-rc3:
> 
> qemu-system-arm -M raspi2 -serial stdio \
> -kernel rpi-kernel7.img -dtb bcm2709-rpi-2-b.dtb \
> -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200
> dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2" \
> -drive file=2018-10-09-raspbian-stretch-lite.img,format=raw,if=sd
> 
> Kernel starts to boot, I see raspberries on the guest screen and log
> output to serial:
> 
> Booting Linux on physical CPU 0xf00
> Linux version 4.14.71-v7+ (dc4@dc4-XPS13-9333) (gcc version 4.9.3
> (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1145 SMP Fri Sep 21
> 15:38:35 BST 2018
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> [...]
> 
> I get a lot of warnings like these:
> 
> bcm2835-clk 3f101000.cprman: plla: couldn't lock PLL
> 
> which I think are due to missing clock part emulation and I've also
> tried with the corresponding patch that got rid of these but apart from
> that failed similarly (see below).
> 
> The problem seems to be that the SD card with the root filesystem is not
> found. I get these mmc related logs:
> 
> sdhost-bcm2835 3f202000.mmc: could not get clk, deferring probe
> mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
> 
> and then eventually ends with:
> 
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: Problem switching card into high-speed mode!
> mmc0: new SDHC card at address 4567
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6
> Please append a correct "root=" boot option; here are the available
> partitions:
> 0100            4096 ram0
>  (driver?)
> 0101            4096 ram1
>  (driver?)
> 0102            4096 ram2
>  (driver?)
> 0103            4096 ram3
>  (driver?)
> 0104            4096 ram4
>  (driver?)
> 0105            4096 ram5
>  (driver?)
> 0106            4096 ram6
>  (driver?)
> 0107            4096 ram7
>  (driver?)
> 0108            4096 ram8
>  (driver?)
> mmcblk0: mmc0:4567 QEMU! 1.74 GiB
> 0109            4096 ram9
>  (driver?)
> 010a            4096 ram10
>  (driver?)
> 010b            4096 ram11
>  (driver?)
> 010c            4096 ram12
>  (driver?)
> 010d            4096 ram13
>  (driver?)
> 010e            4096 ram14
>  (driver?)
> 010f            4096 ram15
>  (driver?)
> b300         1822720 mmcblk0
>  driver: mmcblk
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> CPU: 3 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8011dcb4>] (panic+0xf0/0x274)
> [<8011dcb4>] (panic) from [<80b014f8>] (mount_block_root+0x1e8/0x2b8)
> [<80b014f8>] (mount_block_root) from [<80b017e8>] (mount_root+0x12c/0x134)
> [<80b017e8>] (mount_root) from [<80b01990>] (prepare_namespace+0x1a0/0x1e8)
> [<80b01990>] (prepare_namespace) from [<80b010ac>]
> (kernel_init_freeable+0x2a8/0x2bc)
> [<80b010ac>] (kernel_init_freeable) from [<8079cf80>]
> (kernel_init+0x18/0x128)
> [<8079cf80>] (kernel_init) from [<8010810c>] (ret_from_fork+0x14/0x28)
> CPU0: stopping
> CPU: 0 PID: 61 Comm: mmcqd/0 Tainted: G        W       4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xba283ca0 to 0xba283ce8)
> 3ca0: ba9fa1c0 ba9fa200 a0000013 ba9fa240 ba9fa1c0 ba158580 014000c0
> ba158588
> 3cc0: 000d0418 ba9f9548 00000000 ba283d3c ba283ca8 ba283cf0 80277598
> 80272874
> 3ce0: 40000013 ffffffff
> [<807a3abc>] (__irq_svc) from [<80272874>] (dma_pool_alloc+0x9c/0x23c)
> [<80272874>] (dma_pool_alloc) from [<804fb694>]
> (bcm2835_dma_create_cb_chain+0x1b4/0x214)
> [<804fb694>] (bcm2835_dma_create_cb_chain) from [<804fbb9c>]
> (bcm2835_dma_prep_slave_sg+0x12c/0x2a8)
> [<804fbb9c>] (bcm2835_dma_prep_slave_sg) from [<806385d8>]
> (bcm2835_sdhost_request+0x418/0x5fc)
> [<806385d8>] (bcm2835_sdhost_request) from [<806194bc>]
> (__mmc_start_request+0x78/0x1a8)
> [<806194bc>] (__mmc_start_request) from [<8061a030>]
> (mmc_start_request+0x158/0x184)
> [<8061a030>] (mmc_start_request) from [<8061a2d8>]
> (mmc_start_areq+0x27c/0x3d0)
> [<8061a2d8>] (mmc_start_areq) from [<8062b864>]
> (mmc_blk_issue_rw_rq+0xa8/0x3ac)
> [<8062b864>] (mmc_blk_issue_rw_rq) from [<8062c838>]
> (mmc_blk_issue_rq+0x2b4/0x74c)
> [<8062c838>] (mmc_blk_issue_rq) from [<8062cd48>]
> (mmc_queue_thread+0x78/0x14c)
> [<8062cd48>] (mmc_queue_thread) from [<8013dad4>] (kthread+0x13c/0x16c)
> [<8013dad4>] (kthread) from [<8010810c>] (ret_from_fork+0x14/0x28)
> CPU1: stopping
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xba925f38 to 0xba925f80)
> 5f20:                                                       00000000
> 000007b8
> 5f40: 3a3b9000 00000000 ba924000 80c03dcc 80c03d68 80c885b2 00000001
> 410fc075
> 5f60: 00000000 ba925f94 80c04174 ba925f88 80108a4c 80108a50 60000013
> ffffffff
> [<807a3abc>] (__irq_svc) from [<80108a50>] (arch_cpu_idle+0x34/0x4c)
> [<80108a50>] (arch_cpu_idle) from [<807a323c>]
> (default_idle_call+0x34/0x48)
> [<807a323c>] (default_idle_call) from [<80161494>] (do_idle+0xd8/0x150)
> [<80161494>] (do_idle) from [<801617a8>] (cpu_startup_entry+0x28/0x2c)
> [<801617a8>] (cpu_startup_entry) from [<8010df50>]
> (secondary_start_kernel+0x130/0x13c)
> [<8010df50>] (secondary_start_kernel) from [<0010196c>] (0x10196c)
> CPU2: stopping
> CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W       4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xba927f38 to 0xba927f80)
> 7f20:                                                       00000000
> 0000065c
> 7f40: 3a3ca000 00000000 ba926000 80c03dcc 80c03d68 80c885b2 00000001
> 410fc075
> 7f60: 00000000 ba927f94 80c04174 ba927f88 80108a4c 80108a50 60000013
> ffffffff
> [<807a3abc>] (__irq_svc) from [<80108a50>] (arch_cpu_idle+0x34/0x4c)
> [<80108a50>] (arch_cpu_idle) from [<807a323c>]
> (default_idle_call+0x34/0x48)
> [<807a323c>] (default_idle_call) from [<80161494>] (do_idle+0xd8/0x150)
> [<80161494>] (do_idle) from [<801617a8>] (cpu_startup_entry+0x28/0x2c)
> [<801617a8>] (cpu_startup_entry) from [<8010df50>]
> (secondary_start_kernel+0x130/0x13c)
> [<8010df50>] (secondary_start_kernel) from [<0010196c>] (0x10196c)
> ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> 
> Not sure what this means but looks like mmcblk0 was found too late for
> some reason? (And its partitions are not found.)

I'd say Linux now wants to use DMA which aren't configured in
bcm2835_peripherals.c for the SDHC.

> 
> Then I've tried the same with the pll patches posted by Philippe
> Mathieu-Daudé here:
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg00191.html
> 
> on top of v3.1.0-rc3 which helped to get rid of the cprman warnings but
> did not help with the mmc problem. In fact now also mmcblk0 is gone and
> log ends with:
> 
> mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
> of_cfs_init
> of_cfs_init: OK
> uart-pl011 3f201000.serial: no DMA platform data
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6
> Please append a correct "root=" boot option; here are the available
> partitions:
> 0100            4096 ram0
>  (driver?)
> 0101            4096 ram1
>  (driver?)
> 0102            4096 ram2
>  (driver?)
> 0103            4096 ram3
>  (driver?)
> 0104            4096 ram4
>  (driver?)
> 0105            4096 ram5
>  (driver?)
> 0106            4096 ram6
>  (driver?)
> 0107            4096 ram7
>  (driver?)
> 0108            4096 ram8
>  (driver?)
> 0109            4096 ram9
>  (driver?)
> 010a            4096 ram10
>  (driver?)
> 010b            4096 ram11
>  (driver?)
> 010c            4096 ram12
>  (driver?)
> 010d            4096 ram13
>  (driver?)
> 010e            4096 ram14
>  (driver?)
> 010f            4096 ram15
>  (driver?)
> NOHZ: local_softirq_pending 80
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: Problem switching card into high-speed mode!
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> mmc0: new SDHC card at address 4567
> [<80787f24>] (dump_stack) from [<8011dcb4>] (panic+0xf0/0x274)
> [<8011dcb4>] (panic) from [<80b014f8>] (mount_block_root+0x1e8/0x2b8)
> [<80b014f8>] (mount_block_root) from [<80b017e8>] (mount_root+0x12c/0x134)
> [<80b017e8>] (mount_root) from [<80b01990>] (prepare_namespace+0x1a0/0x1e8)
> [<80b01990>] (prepare_namespace) from [<80b010ac>]
> (kernel_init_freeable+0x2a8/0x2bc)
> [<80b010ac>] (kernel_init_freeable) from [<8079cf80>]
> (kernel_init+0x18/0x128)
> [<8079cf80>] (kernel_init) from [<8010810c>] (ret_from_fork+0x14/0x28)
> CPU1: stopping
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xba925f38 to 0xba925f80)
> 5f20:                                                       00000000
> 000003c4
> 5f40: 3a3b9000 00000000 ba924000 80c03dcc 80c03d68 80c885b2 00000001
> 410fc075
> 5f60: 00000000 ba925f94 80c04174 ba925f88 80108a4c 80108a50 60000013
> ffffffff
> [<807a3abc>] (__irq_svc) from [<80108a50>] (arch_cpu_idle+0x34/0x4c)
> [<80108a50>] (arch_cpu_idle) from [<807a323c>]
> (default_idle_call+0x34/0x48)
> [<807a323c>] (default_idle_call) from [<80161494>] (do_idle+0xd8/0x150)
> [<80161494>] (do_idle) from [<801617a8>] (cpu_startup_entry+0x28/0x2c)
> [<801617a8>] (cpu_startup_entry) from [<8010df50>]
> (secondary_start_kernel+0x130/0x13c)
> [<8010df50>] (secondary_start_kernel) from [<0010196c>] (0x10196c)
> CPU3: stopping
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.14.71-v7+ #1145
> Hardware name: BCM2835
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xba929f38 to 0xba929f80)
> 9f20:                                                       00000000
> 0000031c
> 9f40: 3a3db000 00000000 ba928000 80c03dcc 80c03d68 80c885b2 00000001
> 410fc075
> 9f60: 00000000 ba929f94 80c04174 ba929f88 80108a4c 80108a50 60000013
> ffffffff
> [<807a3abc>] (__irq_svc) from [<80108a50>] (arch_cpu_idle+0x34/0x4c)
> [<80108a50>] (arch_cpu_idle) from [<807a323c>]
> (default_idle_call+0x34/0x48)
> [<807a323c>] (default_idle_call) from [<80161494>] (do_idle+0xd8/0x150)
> [<80161494>] (do_idle) from [<801617a8>] (cpu_startup_entry+0x28/0x2c)
> [<801617a8>] (cpu_startup_entry) from [<8010df50>]
> (secondary_start_kernel+0x130/0x13c)
> [<8010df50>] (secondary_start_kernel) from [<0010196c>] (0x10196c)
> CPU0: stopping
> CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.14.71-v7+ #1145
> Hardware name: BCM2835
> Workqueue: events_freezable mmc_rescan
> [<8010ffd4>] (unwind_backtrace) from [<8010c240>] (show_stack+0x20/0x24)
> [<8010c240>] (show_stack) from [<80787f24>] (dump_stack+0xd4/0x118)
> [<80787f24>] (dump_stack) from [<8010e458>] (handle_IPI+0x2bc/0x33c)
> [<8010e458>] (handle_IPI) from [<801014d8>]
> (bcm2836_arm_irqchip_handle_irq+0x7c/0xac)
> [<801014d8>] (bcm2836_arm_irqchip_handle_irq) from [<807a3abc>]
> (__irq_svc+0x5c/0x7c)
> Exception stack(0xbaa55b80 to 0xbaa55bc8)
> 5b80: ba270458 00000000 ba128300 00000000 ba27045c 00000000 ba81c800
> ba270000
> 5ba0: 80c57084 ba270460 00000000 baa55bf4 80c04174 baa55bd0 80491f2c
> 80491f30
> 5bc0: 60000013 ffffffff
> [<807a3abc>] (__irq_svc) from [<80491f30>]
> (blkcg_activate_policy+0x188/0x218)
> [<80491f30>] (blkcg_activate_policy) from [<804993ec>]
> (cfq_init_queue+0xd0/0x340)
> [<804993ec>] (cfq_init_queue) from [<8046ab70>] (elevator_init+0x78/0x174)
> [<8046ab70>] (elevator_init) from [<80471e80>]
> (blk_init_allocated_queue+0xe8/0x174)
> [<80471e80>] (blk_init_allocated_queue) from [<8062d070>]
> (mmc_init_queue+0xd0/0x29c)
> [<8062d070>] (mmc_init_queue) from [<80629fb8>]
> (mmc_blk_alloc_req+0xe8/0x2e4)
> [<80629fb8>] (mmc_blk_alloc_req) from [<8062a838>]
> (mmc_blk_probe+0xbc/0x520)
> [<8062a838>] (mmc_blk_probe) from [<8061c828>] (mmc_bus_probe+0x28/0x2c)
> [<8061c828>] (mmc_bus_probe) from [<80544b4c>]
> (driver_probe_device+0x244/0x300)
> [<80544b4c>] (driver_probe_device) from [<80544db4>]
> (__device_attach_driver+0xa4/0xbc)
> [<80544db4>] (__device_attach_driver) from [<80542c3c>]
> (bus_for_each_drv+0x74/0xa8)
> [<80542c3c>] (bus_for_each_drv) from [<805447c0>]
> (__device_attach+0xc0/0x120)
> [<805447c0>] (__device_attach) from [<80544de8>]
> (device_initial_probe+0x1c/0x20)
> [<80544de8>] (device_initial_probe) from [<80543cb0>]
> (bus_probe_device+0x94/0x9c)
> [<80543cb0>] (bus_probe_device) from [<80541cd4>] (device_add+0x400/0x588)
> [<80541cd4>] (device_add) from [<8061cce0>] (mmc_add_card+0x120/0x2bc)
> [<8061cce0>] (mmc_add_card) from [<806237f0>] (mmc_attach_sd+0xa4/0x150)
> [<806237f0>] (mmc_attach_sd) from [<8061c500>] (mmc_rescan+0x328/0x394)
> [<8061c500>] (mmc_rescan) from [<801376f0>] (process_one_work+0x158/0x454)
> [<801376f0>] (process_one_work) from [<80137a50>]
> (worker_thread+0x64/0x5b8)
> [<80137a50>] (worker_thread) from [<8013dad4>] (kthread+0x13c/0x16c)
> [<8013dad4>] (kthread) from [<8010810c>] (ret_from_fork+0x14/0x28)
> ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> 
> Any ideas why this happens and what's needed to get this image booted?

The clock patch you mentioned is very trivial and was put together to
have the UART working, which uses very little of the clock tree. For the
MMC we probably need more work.

> 
> (I've also tried with raspi3 like this:
> 
> qemu-system-aarch64 -M raspi3 -serial stdio \
> -kernel rpi-kernel7.img -dtb bcm2710-rpi-3-b-plus.dtb \
> -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200
> dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2" \
> -drive file=2018-10-09-raspbian-stretch-lite.img,format=raw,if=sd
> 
> but did not get any serial output and only black guest window without
> berries so not sure where did it hang. Same result even with these
> different serial options I've found somewhere:
> 
> -append "rw earlycon=uart8250,mmio32,0x3f215040 loglevel=8
> console=ttyS1,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2" \
> 
> but no serial output and black screen with this too.)
> 
> Thanks,
> BALATON Zoltan
