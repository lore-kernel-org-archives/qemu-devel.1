Received: from eggs.gnu.org ([2001:4830:134:3::10]:49156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehxah-00026E-4P
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehxab-0002ES-L4
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:10:46 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ehxab-0002EF-Gr
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:10:41 -0500
Received: by mail-qt0-f194.google.com with SMTP id t25so752178qtg.3
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 05:10:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517582668-10923-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517582668-10923-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Sat, 3 Feb 2018 14:10:40 +0100
Message-ID: <CAMxuvazxwHXAPOb6OrznHWpO9JumVCS3obKAwGu80OdopFNdLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] tpm: Split off tpm_crb_reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>

On Fri, Feb 2, 2018 at 3:44 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Split off the tpm_crb_reset function part from tpm_crb_realize
> that we need to run every time the machine resets.
>
> Also register our reset function with the system since TYPE_DEVICE
> seems to not get a reset otherwise.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> ---
>  v1->v2: register reset function with qemu_register_reset since
>          TYPE_DEVICE seems to not get a reset otherwise
> ---
>  hw/tpm/tpm_crb.c | 48 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 687d255..b5b8256 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -26,6 +26,7 @@
>  #include "hw/acpi/tpm.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/tpm_backend.h"
> +#include "sysemu/reset.h"
>  #include "tpm_int.h"
>  #include "tpm_util.h"
>
> @@ -210,29 +211,10 @@ static Property tpm_crb_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> -static void tpm_crb_realize(DeviceState *dev, Error **errp)
> +static void tpm_crb_reset(void *dev)
>  {
>      CRBState *s =3D CRB(dev);
>
> -    if (!tpm_find()) {
> -        error_setg(errp, "at most one TPM device is permitted");
> -        return;
> -    }
> -    if (!s->tpmbe) {
> -        error_setg(errp, "'tpmdev' property is required");
> -        return;
> -    }
> -
> -    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> -        "tpm-crb-mmio", sizeof(s->regs));
> -    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> -        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> -
> -    memory_region_add_subregion(get_system_memory(),
> -        TPM_CRB_ADDR_BASE, &s->mmio);
> -    memory_region_add_subregion(get_system_memory(),
> -        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> -
>      tpm_backend_reset(s->tpmbe);
>
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> @@ -267,6 +249,32 @@ static void tpm_crb_realize(DeviceState *dev, Error =
**errp)
>      tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
>  }
>
> +static void tpm_crb_realize(DeviceState *dev, Error **errp)
> +{
> +    CRBState *s =3D CRB(dev);
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +    if (!s->tpmbe) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> +        "tpm-crb-mmio", sizeof(s->regs));
> +    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +
> +    memory_region_add_subregion(get_system_memory(),
> +        TPM_CRB_ADDR_BASE, &s->mmio);
> +    memory_region_add_subregion(get_system_memory(),
> +        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> +
> +    qemu_register_reset(tpm_crb_reset, dev);
> +}
> +
>  static void tpm_crb_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> --
> 2.5.5
>
