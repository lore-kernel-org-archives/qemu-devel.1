Received: from eggs.gnu.org ([2001:4830:134:3::10]:50912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBR1M-0000vV-5c
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBR19-00053h-Mt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:28:08 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBR19-000535-A0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:27:55 -0400
Received: by mail-qt0-x242.google.com with SMTP id f16-v6so24796981qth.0
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 13:27:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524670052-28373-1-git-send-email-minyard@acm.org>
	<1524670052-28373-4-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26047f47-95d4-7cc5-68d2-ced812742c33@amsat.org>
Date: Wed, 25 Apr 2018 17:27:50 -0300
MIME-Version: 1.0
In-Reply-To: <1524670052-28373-4-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] ipmi: Use proper struct reference
 for BT vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

Hi Corey,

On 04/25/2018 12:27 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The vmstate for isa_ipmi_bt was referencing into the bt structure,
> instead create a bt structure separate and use that.
> 
> The version 1 of the BT transfer was fairly broken, if a migration
> occured during an IPMI operation, it is likely the migration would
> be corrupted because I misunderstood the VMSTATE_VBUFFER_UINT32()
> handling, I thought it handled transferring the length field,
> too.  So I just remove support for that.  I doubt anyone is using
> it at this point.
> 
> This also removes the transfer of use_irq, since that should come
> from configuration.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

It seems you mis-pasted Signed-off-by -> Reviewed-by.

> ---
>  hw/ipmi/isa_ipmi_bt.c | 68 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index e946030..8bbb1fa 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/ipmi/ipmi.h"
> @@ -450,22 +451,63 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
>      isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
>  }
>  
> -static const VMStateDescription vmstate_ISAIPMIBTDevice = {
> -    .name = TYPE_IPMI_INTERFACE,
> +static int ipmi_bt_vmstate_post_load(void *opaque, int version)
> +{
> +    IPMIBT *ib = opaque;
> +
> +    /* Make sure all the values are sane. */
> +    if (ib->outpos >= MAX_IPMI_MSG_SIZE || ib->outlen >= MAX_IPMI_MSG_SIZE ||
> +        ib->outpos >= ib->outlen) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:bt: vmstate transfer received bad out values: %d %d\n",
> +                      ib->outpos, ib->outlen);
> +        ib->outpos = 0;
> +        ib->outlen = 0;
> +    }
> +
> +    if (ib->inlen >= MAX_IPMI_MSG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:bt: vmstate transfer received bad in value: %d\n",
> +                      ib->inlen);
> +        ib->inlen = 0;
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_IPMIBT = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "bt",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .post_load = ipmi_bt_vmstate_post_load,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIBT),
> +        VMSTATE_BOOL(atn_irq_set, IPMIBT),
> +        VMSTATE_BOOL(irqs_enabled, IPMIBT),
> +        VMSTATE_UINT32(outpos, IPMIBT),
> +        VMSTATE_UINT32(outlen, IPMIBT),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32(inlen, IPMIBT),
> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT8(control_reg, IPMIBT),
> +        VMSTATE_UINT8(mask_reg, IPMIBT),
> +        VMSTATE_UINT8(waiting_rsp, IPMIBT),
> +        VMSTATE_UINT8(waiting_seq, IPMIBT),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_ISAIPMIBTDevice = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    /*
> +     * Version 1 had messed up the array transfer, it's not even usable
> +     * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
> +     * the buffer length, so random things would happen.
> +     */
>      .fields      = (VMStateField[]) {
> -        VMSTATE_BOOL(bt.obf_irq_set, ISAIPMIBTDevice),
> -        VMSTATE_BOOL(bt.atn_irq_set, ISAIPMIBTDevice),
> -        VMSTATE_BOOL(bt.use_irq, ISAIPMIBTDevice),
> -        VMSTATE_BOOL(bt.irqs_enabled, ISAIPMIBTDevice),
> -        VMSTATE_UINT32(bt.outpos, ISAIPMIBTDevice),
> -        VMSTATE_VBUFFER_UINT32(bt.outmsg, ISAIPMIBTDevice, 1, NULL, bt.outlen),
> -        VMSTATE_VBUFFER_UINT32(bt.inmsg, ISAIPMIBTDevice, 1, NULL, bt.inlen),
> -        VMSTATE_UINT8(bt.control_reg, ISAIPMIBTDevice),
> -        VMSTATE_UINT8(bt.mask_reg, ISAIPMIBTDevice),
> -        VMSTATE_UINT8(bt.waiting_rsp, ISAIPMIBTDevice),
> -        VMSTATE_UINT8(bt.waiting_seq, ISAIPMIBTDevice),
> +        VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> 
