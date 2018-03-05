Received: from eggs.gnu.org ([2001:4830:134:3::10]:51265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esqoB-0006P3-PZ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esqo6-0003of-8b
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:09:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1esqo6-0003o5-2F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:09:38 -0500
Date: Mon, 5 Mar 2018 14:09:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305140926.GK3131@work-vm>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<1520004397-28521-2-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520004397-28521-2-git-send-email-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ipmi: Use proper struct reference
 for KCS vmstate
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
> The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
> instead create a kcs structure separate and use that.
> 
> There were also some issues in the state transfer.  The inlen field
> was not being transferred, so if a transaction was in process during
> the transfer it would be messed up.  And the use_irq field was
> transferred, but that should come from the configuration.

> And the
> name on the man VMStateDescription was incorrect, it needed to be
> differentiated from the BT one.

I think that's a bigger problem; lets see below.

> To fix this, a new VMStateDescription is added that is hopefully
> correct, and the old one is kept (modified to remove use_irq) in
> a way that it can be received from the remote but will not be sent.
> So an upgrade should work for KCS.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index 689587b..2a2784d 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -422,14 +422,86 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>      isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
>  }
>  
> -const VMStateDescription vmstate_ISAIPMIKCSDevice = {
> +static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
> +{
> +    IPMIKCS *ik = opaque;
> +
> +    /* Make sure all the values are sane. */
> +    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
> +        ik->outpos >= ik->outlen) {
> +        ik->outpos = 0;
> +        ik->outlen = 0;
> +    }
> +
> +    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
> +        ik->inlen = 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_IPMIKCS = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = ipmi_kcs_vmstate_post_load,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> +        VMSTATE_UINT32(outpos, IPMIKCS),
> +        VMSTATE_UINT32(outlen, IPMIKCS),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32(inlen, IPMIKCS),
> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_BOOL(write_end, IPMIKCS),
> +        VMSTATE_UINT8(status_reg, IPMIKCS),
> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

I've got the following, which is only build tested but:

+static const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .post_load = ipmi_kcs_vmstate_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
+        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
+        VMSTATE_UNUSED(1), /* Was use_irq */
+        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
+        VMSTATE_UINT32(outpos, IPMIKCS),
+        VMSTATE_UINT32_V(outlen, IPMIKCS,2),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32_V(inlen, IPMIKCS,2),
+        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_BOOL(write_end, IPMIKCS),
+        VMSTATE_UINT8(status_reg, IPMIKCS),
+        VMSTATE_UINT8(data_out_reg, IPMIKCS),
+        VMSTATE_INT16(data_in_reg, IPMIKCS),
+        VMSTATE_INT16(cmd_reg, IPMIKCS),
+        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};

Note how the outlen and inlen fields use the _V modifier and are only
bound to v2, and I leave the UNUSED in for use_irq, that means we can
then mae the vmstate_v1_ISAIPMIKCSDevice just have:

const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
    .name = TYPE_IPMI_INTERFACE,
    .version_id = 1,
    .minimum_version_id = 1,
    .post_load = ipmi_kcs_v1_vmstate_post_load,
    .needed = ipmi_kcs_v1_vmstate_needed,
    .fields      = (VMStateField[]) {
        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
        VMSTATE_END_OF_LIST()
    }
};

Note the '1'. in the VMSTATE_STRUCT.
As I say, that's untested, but if it works it saves a lot of
duplication.

> +
> +/*
> + * Old version of the vmstate transfer that has a number of issues.
> + * We changed the vm state description name, so we need a separate
> + * structure and need to register it separately.
> + */
> +static int ipmi_kcs_v1_vmstate_post_load(void *opaque, int version)
> +{
> +    ISAIPMIKCSDevice *iik = opaque;
> +
> +    return ipmi_kcs_vmstate_post_load(&iik->kcs, version);
> +}
> +
> +static bool ipmi_kcs_v1_vmstate_needed(void *opaque)
> +{
> +    /* Never transmit this, it is just for receiving old versions. */
> +    return false;
> +}
> +
> +const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
>      .name = TYPE_IPMI_INTERFACE,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .post_load = ipmi_kcs_v1_vmstate_post_load,
> +    .needed = ipmi_kcs_v1_vmstate_needed,
>      .fields      = (VMStateField[]) {
>          VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
>          VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
> -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
> +        VMSTATE_UNUSED(1), /* Was use_irq */
>          VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
>          VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
>          VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
> @@ -451,6 +523,7 @@ static void isa_ipmi_kcs_init(Object *obj)
>      ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
>  
>      vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
> +    vmstate_register(NULL, 0, &vmstate_v1_ISAIPMIKCSDevice, iik);

OK, a bit scary - I don't think anyone else does that trick of
registering it under two names with a '_needed' always saying false.

So I think we have the istuation where the old version had two things
with the same name, and if you instantiated both device types you
probably lost one of them?
In the new world both the 'bt' one is incompatible and renamed,
but this one has the hack to load the old kcs version;  so I guess
that's OK.

Could you just add a comment above that second vmstate_register
  ' old version had different (clashing) name, register both'

However it's worth asking if it's really worth it, if you just ekpt this
one called TYPE_IPMI_INTERFACE then you wouldn't need that hack, and the
only downside I can see is that loading an image that had a ipmi-bt
would fail badly, as opposed to failing clearly.

Dave

>  }
>  
>  static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
