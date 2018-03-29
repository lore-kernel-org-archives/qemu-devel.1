Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V3W-00080A-N2
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1V3Q-0001hO-Gb
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:45:18 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1V3Q-0001gn-8m
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:45:12 -0400
Received: by mail-wr0-x241.google.com with SMTP id y55so4958676wry.3
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:45:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522270761-29646-4-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522270761-29646-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Mar 2018 12:45:10 +0200
Message-ID: <CAJ+F1C+D6cKaZc=BN3Y_hz3fius3oz10BNPvZg1Gnwvr3FfG-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] tpm: CRB: Enforce locality is
 requested before processing buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Mar 28, 2018 at 10:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Section 5.5.3.2.2 of the CRB specs states that use of the TPM
> through the localty control method must first be requested,
> otherwise TPM commands will be dropped. This patch makes sure
> that the current locality is the active locality and only then
> sends off the command for processing.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_crb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index ee6c87e..520e74e 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -76,6 +76,8 @@ enum crb_cancel {
>      CRB_CANCEL_INVOKE =3D BIT(0),
>  };
>
> +#define TPM_CRB_NO_LOCALITY 0xff
> +
>  static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>                                    unsigned size)
>  {
> @@ -95,10 +97,18 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwadd=
r addr,
>      return val;
>  }
>
> +static uint8_t tpm_crb_get_active_locty(CRBState *s)
> +{
> +    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned))
> +         return TPM_CRB_NO_LOCALITY;
> +    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
> +}
> +
>  static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                 uint64_t val, unsigned size)
>  {
>      CRBState *s =3D CRB(opaque);
> +    uint8_t locty =3D  addr >> 12;
>
>      trace_tpm_crb_mmio_write(addr, size, val);
>
> @@ -123,7 +133,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
>          break;
>      case A_CRB_CTRL_START:
>          if (val =3D=3D CRB_START_INVOKE &&
> -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
> +            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> +            tpm_crb_get_active_locty(s) =3D=3D locty) {
>              void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
>
>              s->regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
