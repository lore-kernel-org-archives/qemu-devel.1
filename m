Received: from eggs.gnu.org ([2001:4830:134:3::10]:42410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJhZm-0003DE-AC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJhZl-0000jW-07
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:45:50 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fJhZk-0000iy-ME
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:45:48 -0400
Received: by mail-wm0-x241.google.com with SMTP id n10-v6so15975871wmc.1
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524670052-28373-3-git-send-email-minyard@acm.org>
References: <1524670052-28373-1-git-send-email-minyard@acm.org>
	<1524670052-28373-3-git-send-email-minyard@acm.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 May 2018 17:45:46 +0200
Message-ID: <CAJ+F1C+xyDCjjVhm1ypAEHQ6gSqbHVijYtoJ8n27mTqx+SXTWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] ipmi: Use proper struct reference
 for KCS vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>

Hi Corey

On Wed, Apr 25, 2018 at 5:27 PM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
> instead create a kcs structure separate and use that.
>
> There were also some issues in the state transfer.  The inlen field
> was not being transferred, so if a transaction was in process during
> the transfer it would be messed up.  And the use_irq field was
> transferred, but that should come from the configuration.
>
> To fix this, the new VMS_VSTRUCT macros are used so the exact
> version of the structure can be specified, depending on what
> version was being received.  So an upgrade should work for KCS.

Looks good overall,

You could easily split this patch further to help review/bisecting etc.

Introduce VMSTATE_STRUCT, unuse use_irq, introduce version 2, add the
postload checks.

You could also help reviewers by giving your test setup, so we can
more easily reproduce the fix and/or try variants.

I also wonder if you could have used subsections, but the VSTRUCT type
seems a good approach to me, David would have to review it though.


> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_kcs.c | 81 ++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 66 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index 689587b..a794315 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/ipmi/ipmi.h"
> @@ -422,24 +423,69 @@ static void ipmi_isa_realize(DeviceState *dev, Erro=
r **errp)
>      isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
>  }
>
> -const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
> +static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
> +{
> +    IPMIKCS *ik =3D opaque;
> +
> +    /* Make sure all the values are sane. */
> +    if (ik->outpos >=3D MAX_IPMI_MSG_SIZE || ik->outlen >=3D MAX_IPMI_MS=
G_SIZE ||
> +        ik->outpos >=3D ik->outlen) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:kcs: vmstate transfer received bad out value=
s: %d %d\n",
> +                      ik->outpos, ik->outlen);
> +        ik->outpos =3D 0;
> +        ik->outlen =3D 0;
> +    }
> +
> +    if (ik->inlen >=3D MAX_IPMI_MSG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:kcs: vmstate transfer received bad in value:=
 %d\n",
> +                      ik->inlen);
> +        ik->inlen =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vmstate_kcs_before_version2(void *opaque, int version)
> +{
> +    return version <=3D 1;
> +}
> +
> +static const VMStateDescription vmstate_IPMIKCS =3D {
> +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "kcs",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D ipmi_kcs_vmstate_post_load,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> +        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_=
irq */
> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> +        VMSTATE_UINT32(outpos, IPMIKCS),
> +        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
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
> +static const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
>      .name =3D TYPE_IPMI_INTERFACE,
> -    .version_id =3D 1,
> +    .version_id =3D 2,
>      .minimum_version_id =3D 1,
>      .fields      =3D (VMStateField[]) {
> -        VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
> -        VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
> -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
> -        VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
> -        VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
> -        VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_S=
IZE),
> -        VMSTATE_UINT8_ARRAY(kcs.inmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SI=
ZE),
> -        VMSTATE_BOOL(kcs.write_end, ISAIPMIKCSDevice),
> -        VMSTATE_UINT8(kcs.status_reg, ISAIPMIKCSDevice),
> -        VMSTATE_UINT8(kcs.data_out_reg, ISAIPMIKCSDevice),
> -        VMSTATE_INT16(kcs.data_in_reg, ISAIPMIKCSDevice),
> -        VMSTATE_INT16(kcs.cmd_reg, ISAIPMIKCSDevice),
> -        VMSTATE_UINT8(kcs.waiting_rsp, ISAIPMIKCSDevice),
> +        VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_v=
ersion2,
> +                             0, vmstate_IPMIKCS, IPMIKCS, 1),
> +        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
> +                          IPMIKCS, 2),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -450,6 +496,11 @@ static void isa_ipmi_kcs_init(Object *obj)
>
>      ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
>
> +    /*
> +     * Version 1 had an incorrect name, it clashed with the BT
> +     * IPMI device, so receive it, but transmit a different
> +     * version.
> +     */
>      vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
>  }
>
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
