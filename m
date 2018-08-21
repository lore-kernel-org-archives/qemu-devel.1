Received: from eggs.gnu.org ([2001:4830:134:3::10]:52553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs093-0002Us-RI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs08z-0008Tj-GD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:28:01 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:46263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fs08z-0008Sw-BS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:27:57 -0400
Received: by mail-vk0-x242.google.com with SMTP id b14-v6so7696799vke.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 23:27:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-9-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19f12dd4-4051-9d2a-7ea7-a3f1e0a753a6@amsat.org>
Date: Tue, 21 Aug 2018 03:27:53 -0300
MIME-Version: 1.0
In-Reply-To: <1534796770-10295-9-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/10] i2c:pm_smbus: Add the ability to
 force block transfer enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 08/20/2018 05:26 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The PIIX4 hardware has block transfer buffer always enabled in
> the hardware, but the i801 does not.  Add a parameter to pm_smbus_init
> to force on the block transfer so the PIIX4 handler can enable this
> by default, as it was disabled by default before.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/acpi/piix4.c           | 2 +-
>  hw/i2c/pm_smbus.c         | 5 ++++-
>  hw/i2c/smbus_ich9.c       | 2 +-
>  hw/isa/vt82c686.c         | 2 +-
>  include/hw/i2c/pm_smbus.h | 2 +-
>  5 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index f8d8d2e..313305f 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -513,7 +513,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>      pci_conf[0x90] = s->smb_io_base | 1;
>      pci_conf[0x91] = s->smb_io_base >> 8;
>      pci_conf[0xd2] = 0x09;
> -    pm_smbus_init(DEVICE(dev), &s->smb);
> +    pm_smbus_init(DEVICE(dev), &s->smb, true);
>      memory_region_set_enabled(&s->smb.io, pci_conf[0xd2] & 1);
>      memory_region_add_subregion(pci_address_space_io(dev),
>                                  s->smb_io_base, &s->smb.io);
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 10ba208..4d021bb 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -422,11 +422,14 @@ const VMStateDescription pmsmb_vmstate = {
>      }
>  };
>  
> -void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
> +void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk)
>  {
>      smb->op_done = true;
>      smb->reset = pm_smbus_reset;
>      smb->smbus = i2c_init_bus(parent, "i2c");
> +    if (force_aux_blk) {
> +        smb->smb_auxctl |= AUX_BLK;
> +    }
>      memory_region_init_io(&smb->io, OBJECT(parent), &pm_smbus_ops, smb,
>                            "pm-smbus", 64);
>  }
> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
> index 316c2a4..5860fc9 100644
> --- a/hw/i2c/smbus_ich9.c
> +++ b/hw/i2c/smbus_ich9.c
> @@ -88,7 +88,7 @@ static void ich9_smbus_realize(PCIDevice *d, Error **errp)
>      pci_set_byte(d->config + ICH9_SMB_HOSTC, 0);
>      /* TODO bar0, bar1: 64bit BAR support*/
>  
> -    pm_smbus_init(&d->qdev, &s->smb);
> +    pm_smbus_init(&d->qdev, &s->smb, false);
>      pci_register_bar(d, ICH9_SMB_SMB_BASE_BAR, PCI_BASE_ADDRESS_SPACE_IO,
>                       &s->smb.io);
>  }
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index cff1946..7302f6d 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -370,7 +370,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error **errp)
>      pci_conf[0x90] = s->smb_io_base | 1;
>      pci_conf[0x91] = s->smb_io_base >> 8;
>      pci_conf[0xd2] = 0x90;
> -    pm_smbus_init(&s->dev.qdev, &s->smb);
> +    pm_smbus_init(&s->dev.qdev, &s->smb, false);
>      memory_region_add_subregion(get_system_io(), s->smb_io_base, &s->smb.io);
>  
>      apm_init(dev, &s->apm, NULL, s);
> diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
> index cfe596f..471345e 100644
> --- a/include/hw/i2c/pm_smbus.h
> +++ b/include/hw/i2c/pm_smbus.h
> @@ -33,7 +33,7 @@ typedef struct PMSMBus {
>      bool op_done;
>  } PMSMBus;
>  
> -void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
> +void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
>  
>  extern const VMStateDescription pmsmb_vmstate;
>  
> 
