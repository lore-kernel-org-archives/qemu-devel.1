Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fs5yq-000884-Vp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fs5ym-0002y4-TP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:41:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fs5ym-0002xG-Ic
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:41:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id n2-v6so5261155wrw.7
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:41:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-6-git-send-email-minyard@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1aac39bc-5cd6-350f-9c8e-b5374f25510e@redhat.com>
Date: Tue, 21 Aug 2018 14:41:45 +0200
MIME-Version: 1.0
In-Reply-To: <1534796770-10295-6-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/10] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 20/08/2018 22:26, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Transfer the state information for the SMBus registers and
> internal data so it will work on a VM transfer.

Since the device is mostly unused, I would rather have this in a
subsection.  This way the format remains backwards-compatible as long as
the registers have the default values.

Also, in case you are interested, a few years ago I was thinking of
implementing clock stretching; the plan was that clock stretching would
let you pass host I2C devices down to the guest.  Basically, the I2C
recv function was changed to accept a callback+opaque, and said callback
would be invoked later if recv returned -EAGAIN (or something like
that).  Unfortunately I didn't finish adding support to all the I2C
controllers when my laptop was stolen, so the patches are lost. :/

Paolo

> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/acpi/piix4.c           |  3 ++-
>  hw/i2c/pm_smbus.c         | 20 ++++++++++++++++++++
>  hw/i2c/smbus_ich9.c       |  5 +++--
>  include/hw/i2c/pm_smbus.h |  2 ++
>  4 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 6404af5..f8d8d2e 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -309,7 +309,7 @@ static const VMStateDescription vmstate_cpuhp_state = {
>   */
>  static const VMStateDescription vmstate_acpi = {
>      .name = "piix4_pm",
> -    .version_id = 3,
> +    .version_id = 4,
>      .minimum_version_id = 3,
>      .minimum_version_id_old = 1,
>      .load_state_old = acpi_load_old,
> @@ -320,6 +320,7 @@ static const VMStateDescription vmstate_acpi = {
>          VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
>          VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
>          VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
> +        VMSTATE_STRUCT(smb, PIIX4PMState, 4, pmsmb_vmstate, PMSMBus),
>          VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
>          VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
>          VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 32132be..9e11d47 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -383,6 +383,26 @@ static const MemoryRegionOps pm_smbus_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +const VMStateDescription pmsmb_vmstate = {
> +    .name = "pmsmb",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(smb_stat, PMSMBus),
> +        VMSTATE_UINT8(smb_ctl, PMSMBus),
> +        VMSTATE_UINT8(smb_cmd, PMSMBus),
> +        VMSTATE_UINT8(smb_addr, PMSMBus),
> +        VMSTATE_UINT8(smb_data0, PMSMBus),
> +        VMSTATE_UINT8(smb_data1, PMSMBus),
> +        VMSTATE_UINT32(smb_index, PMSMBus),
> +        VMSTATE_UINT8_ARRAY(smb_data, PMSMBus, PM_SMBUS_MAX_MSG_SIZE),
> +        VMSTATE_UINT8(smb_auxctl, PMSMBus),
> +        VMSTATE_BOOL(i2c_enable, PMSMBus),
> +        VMSTATE_BOOL(op_done, PMSMBus),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
>  {
>      smb->op_done = true;
> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
> index a66a114..c8b8413 100644
> --- a/hw/i2c/smbus_ich9.c
> +++ b/hw/i2c/smbus_ich9.c
> @@ -45,10 +45,11 @@ typedef struct ICH9SMBState {
>  
>  static const VMStateDescription vmstate_ich9_smbus = {
>      .name = "ich9_smb",
> -    .version_id = 1,
> +    .version_id = 2,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, struct ICH9SMBState),
> +        VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
> +        VMSTATE_STRUCT(smb, ICH9SMBState, 2, pmsmb_vmstate, PMSMBus),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
> index 99d5489..b1e1970 100644
> --- a/include/hw/i2c/pm_smbus.h
> +++ b/include/hw/i2c/pm_smbus.h
> @@ -33,4 +33,6 @@ typedef struct PMSMBus {
>  
>  void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
>  
> +extern const VMStateDescription pmsmb_vmstate;
> +
>  #endif /* PM_SMBUS_H */
> 
