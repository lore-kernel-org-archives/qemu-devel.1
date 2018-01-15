Received: from eggs.gnu.org ([2001:4830:134:3::10]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1CP-0003Qu-Io
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1CO-0007xi-Jh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:37:01 -0500
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b5c64f47-26ae-3a80-4162-23ca411fd9c5@vivier.eu>
Date: Mon, 15 Jan 2018 10:35:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180114020412.26160-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] qdev: use
 device_class_set_parent_realize/unrealize/reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

Le 14/01/2018 à 03:04, Philippe Mathieu-Daudé a écrit :
> changes generated using the following Coccinelle patch:
> 
>   @@
>   type DeviceParentClass;
>   DeviceParentClass *pc;
>   DeviceClass *dc;
>   identifier parent_fn;
>   identifier child_fn;
>   @@
>   (
>   +device_class_set_parent_realize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn = dc->realize;
>   ...
>   -dc->realize = child_fn;
>   |
>   +device_class_set_parent_unrealize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn = dc->unrealize;
>   ...
>   -dc->unrealize = child_fn;
>   |
>   +device_class_set_parent_reset(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn = dc->reset;
>   ...
>   -dc->reset = child_fn;
>   )
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/i386/kvm/i8254.c                | 4 ++--
>  hw/i386/kvm/i8259.c                | 3 +--
>  hw/input/adb-kbd.c                 | 4 ++--
>  hw/input/adb-mouse.c               | 4 ++--
>  hw/intc/arm_gic.c                  | 3 +--
>  hw/intc/arm_gic_kvm.c              | 7 +++----
>  hw/intc/arm_gicv3.c                | 3 +--
>  hw/intc/arm_gicv3_its_kvm.c        | 3 +--
>  hw/intc/arm_gicv3_kvm.c            | 7 +++----
>  hw/intc/i8259.c                    | 3 +--
>  hw/net/vmxnet3.c                   | 4 ++--
>  hw/pci-bridge/gen_pcie_root_port.c | 3 +--
>  hw/scsi/vmw_pvscsi.c               | 4 ++--
>  hw/timer/i8254.c                   | 3 +--
>  hw/vfio/amd-xgbe.c                 | 4 ++--
>  hw/vfio/calxeda-xgmac.c            | 4 ++--
>  hw/virtio/virtio-pci.c             | 4 ++--
>  target/alpha/cpu.c                 | 4 ++--
>  target/arm/cpu.c                   | 4 ++--
>  target/cris/cpu.c                  | 4 ++--
>  target/hppa/cpu.c                  | 4 ++--
>  target/i386/cpu.c                  | 8 ++++----
>  target/lm32/cpu.c                  | 5 ++---
>  target/m68k/cpu.c                  | 5 ++---
>  target/microblaze/cpu.c            | 5 ++---
>  target/mips/cpu.c                  | 5 ++---
>  target/moxie/cpu.c                 | 5 ++---
>  target/nios2/cpu.c                 | 4 ++--
>  target/openrisc/cpu.c              | 5 ++---
>  target/ppc/translate_init.c        | 8 ++++----
>  target/s390x/cpu.c                 | 4 ++--
>  target/sh4/cpu.c                   | 4 ++--
>  target/sparc/cpu.c                 | 4 ++--
>  target/tilegx/cpu.c                | 4 ++--
>  target/tricore/cpu.c               | 4 ++--
>  target/unicore32/cpu.c             | 4 ++--
>  target/xtensa/cpu.c                | 4 ++--
>  37 files changed, 73 insertions(+), 88 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
