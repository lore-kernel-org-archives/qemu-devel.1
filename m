Received: from eggs.gnu.org ([2001:4830:134:3::10]:49471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esony-0002an-98
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esont-0005WG-4S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:01:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1esons-0005Vr-Uq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:01:17 -0500
Date: Mon, 5 Mar 2018 12:00:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305120058.GF3131@work-vm>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<1520004397-28521-3-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520004397-28521-3-git-send-email-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ipmi: Use proper struct reference
 for BT vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

* minyard@acm.org (minyard@acm.org) wrote:
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
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 61 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index e946030..b64dce2 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -450,22 +450,57 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
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
> +        ib->outpos = 0;
> +        ib->outlen = 0;
> +    }
> +
> +    if (ib->inlen >= MAX_IPMI_MSG_SIZE) {
> +        ib->inlen = 0;
> +    }
> +
> +    return 0;
> +}

OK, this one looks fine; I'd personally add a printf or something in the
case where you're having to fix up the output/outlen just so you know;
but that's OK; and since you know the device I'll leave the use_irq etc
to you, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
