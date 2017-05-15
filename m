Received: from eggs.gnu.org ([2001:4830:134:3::10]:58815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dABQF-00088y-Jm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dABQ9-00057I-La
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dABQ9-00057B-DN
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:32:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
	<20170503203604.31462-2-ehabkost@redhat.com>
Date: Mon, 15 May 2017 10:31:54 +0200
In-Reply-To: <20170503203604.31462-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 3 May 2017 17:35:44 -0300")
Message-ID: <87h90m34hx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND v2 01/21] qdev: Replace
 cannot_instantiate_with_device_add_yet with !user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Laszlo Ersek <lersek@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> cannot_instantiate_with_device_add_yet was introduced by commit
> efec3dd631d94160288392721a5f9c39e50fb2bc to replace no_user. It was
> supposed to be a temporary measure.
>
> When it was introduced, we had 54
> cannot_instantiate_with_device_add_yet=true lines in the code.
> Today (3 years later) this number has not shrinked: we now have

shrunk

> 57 cannot_instantiate_with_device_add_yet=true lines. I think it
> is safe to say it is not a temporary measure, and we won't see
> the flag go away soon.
>
> Instead of a long field name that misleads people to believe it
> is temporary, replace it a shorter and less misleading field:
> user_creatable.
>
> Except for code comments, changes were generated using the
> following Coccinelle patch:
>
>   @@
>   expression DC;
>   @@
>   (
>   -DC->cannot_instantiate_with_device_add_yet = false;
>   +DC->user_creatable = true;
>   |
>   -DC->cannot_instantiate_with_device_add_yet = true;
>   +DC->user_creatable = false;
>   )
>
>   @@
>   typedef ObjectClass;
>   expression dc;
>   identifier class, data;
>   @@
>    static void device_class_init(ObjectClass *class, void *data)
>    {
>    ...
>    dc->hotpluggable = true;
>   +dc->user_creatable = true;
>    ...
>    }
>
>   @@
>   @@
>    struct DeviceClass {
>    ...
>   -bool cannot_instantiate_with_device_add_yet;
>   +bool user_creatable;
>    ...
>   }
>
>   @@
>   expression DC;
>   @@
>   (
>   -!DC->cannot_instantiate_with_device_add_yet
>   +DC->user_creatable
>   |
>   -DC->cannot_instantiate_with_device_add_yet
>   +!DC->user_creatable
>   )
>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * (none)
>
> Changes v2 -> v3:
> * Fixed commit ID reference on commit message
> * (No code changes)
> ---
>  include/hw/qdev-core.h              | 10 +++++-----
>  include/hw/qdev-properties.h        |  4 ++--
>  hw/acpi/piix4.c                     |  2 +-
>  hw/arm/spitz.c                      |  2 +-
>  hw/audio/marvell_88w8618.c          |  2 +-
>  hw/audio/pcspk.c                    |  2 +-
>  hw/core/or-irq.c                    |  2 +-
>  hw/core/qdev.c                      |  1 +
>  hw/core/register.c                  |  2 +-
>  hw/dma/i8257.c                      |  2 +-
>  hw/dma/sparc32_dma.c                |  2 +-
>  hw/gpio/omap_gpio.c                 |  4 ++--
>  hw/i2c/omap_i2c.c                   |  2 +-
>  hw/i2c/smbus_eeprom.c               |  2 +-
>  hw/i2c/smbus_ich9.c                 |  2 +-
>  hw/i386/pc.c                        |  2 +-
>  hw/input/vmmouse.c                  |  2 +-
>  hw/intc/apic_common.c               |  2 +-
>  hw/intc/etraxfs_pic.c               |  2 +-
>  hw/intc/grlib_irqmp.c               |  2 +-
>  hw/intc/i8259_common.c              |  2 +-
>  hw/intc/nios2_iic.c                 |  2 +-
>  hw/intc/omap_intc.c                 |  4 ++--
>  hw/isa/lpc_ich9.c                   |  2 +-
>  hw/isa/piix4.c                      |  2 +-
>  hw/isa/vt82c686.c                   |  2 +-
>  hw/mips/gt64xxx_pci.c               |  2 +-
>  hw/misc/vmport.c                    |  2 +-
>  hw/net/dp8393x.c                    |  2 +-
>  hw/net/etraxfs_eth.c                |  2 +-
>  hw/net/lance.c                      |  2 +-
>  hw/pci-bridge/dec.c                 |  2 +-
>  hw/pci-bridge/pci_expander_bridge.c |  2 +-
>  hw/pci-host/apb.c                   |  2 +-
>  hw/pci-host/bonito.c                |  2 +-
>  hw/pci-host/gpex.c                  |  2 +-
>  hw/pci-host/grackle.c               |  2 +-
>  hw/pci-host/piix.c                  |  6 +++---
>  hw/pci-host/ppce500.c               |  2 +-
>  hw/pci-host/prep.c                  |  2 +-
>  hw/pci-host/q35.c                   |  4 ++--
>  hw/pci-host/uninorth.c              |  8 ++++----
>  hw/pci-host/versatile.c             |  2 +-
>  hw/pci-host/xilinx-pcie.c           |  2 +-
>  hw/ppc/ppc4xx_pci.c                 |  2 +-
>  hw/ppc/spapr_drc.c                  |  2 +-
>  hw/s390x/s390-pci-bus.c             |  2 +-
>  hw/sd/milkymist-memcard.c           |  2 +-
>  hw/sd/pl181.c                       |  2 +-
>  hw/sh4/sh_pci.c                     |  2 +-
>  hw/timer/i8254_common.c             |  2 +-
>  hw/timer/mc146818rtc.c              |  2 +-
>  monitor.c                           |  2 +-
>  qdev-monitor.c                      |  6 +++---
>  qom/cpu.c                           |  2 +-
>  target/i386/cpu.c                   |  2 +-
>  56 files changed, 71 insertions(+), 70 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 4bf86b0ad8..6ee49fbe33 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -103,16 +103,16 @@ typedef struct DeviceClass {
>      Property *props;
>  
>      /*
> -     * Shall we hide this device model from -device / device_add?
> +     * Can this device be instantiated with -device / device_add?
>       * All devices should support instantiation with device_add, and
>       * this flag should not exist.  But we're not there, yet.  Some
>       * devices fail to instantiate with cryptic error messages.
>       * Others instantiate, but don't work.  Exposing users to such
> -     * behavior would be cruel; this flag serves to protect them.  It
> -     * should never be set without a comment explaining why it is set.
> -     * TODO remove once we're there
> +     * behavior would be cruel; clearing this flag will protect them.
> +     * It should never be cleared without a comment explaining why it
> +     * is cleared.

Let's keep the TODO comment.

>       */
> -    bool cannot_instantiate_with_device_add_yet;
> +    bool user_creatable;
>      bool hotpluggable;
>  
>      /* callbacks */
[...]

With these two nits taken care of:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
