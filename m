Received: from eggs.gnu.org ([2001:4830:134:3::10]:52837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS22j-0001Uq-W6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS22g-0008Vj-Ma
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:41:53 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS22g-0008So-8Z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:41:50 -0500
Received: by mail-wm0-x243.google.com with SMTP id b199so16493415wme.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:41:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-6-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-6-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 15:41:48 +0100
Message-ID: <CAJ+F1CKR2RFASLUMY-GhANbS7dvQFS94neidd=eXAqREdinmhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/13] tpm_tis: merge read and write
 buffer into single buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Since we can only be in read or write mode, we can merge the buffers
> into a single buffer.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_tis.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index f6f5f17..0b6dd7f 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -70,8 +70,7 @@ typedef struct TPMState {
>      ISADevice busdev;
>      MemoryRegion mmio;
>
> -    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
> -    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
> +    unsigned char buffer[TPM_TIS_BUFFER_MAX];
>
>      uint8_t active_locty;
>      uint8_t aborting_locty;
> @@ -257,7 +256,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t loc=
ty)
>  {
>      TPMLocality *locty_data =3D &s->loc[locty];
>
> -    tpm_tis_show_buffer(s->w_buffer, s->be_buffer_size,
> +    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
>                          "tpm_tis: To TPM");
>
>      /*
> @@ -268,9 +267,9 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t loc=
ty)
>
>      s->cmd =3D (TPMBackendCmd) {
>          .locty =3D locty,
> -        .in =3D s->w_buffer,
> +        .in =3D s->buffer,
>          .in_len =3D locty_data->w_offset,
> -        .out =3D s->r_buffer,
> +        .out =3D s->buffer,
>          .out_len =3D s->be_buffer_size,
>      };
>
> @@ -422,7 +421,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
>      s->loc[locty].r_offset =3D 0;
>      s->loc[locty].w_offset =3D 0;
>
> -    tpm_tis_show_buffer(s->r_buffer, s->be_buffer_size,
> +    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
>                          "tpm_tis: From TPM");
>
>      if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
> @@ -442,10 +441,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint=
8_t locty)
>      uint16_t len;
>
>      if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
> -        len =3D MIN(tpm_cmd_get_size(&s->r_buffer),
> +        len =3D MIN(tpm_cmd_get_size(&s->buffer),
>                    s->be_buffer_size);
>
> -        ret =3D s->r_buffer[s->loc[locty].r_offset++];
> +        ret =3D s->buffer[s->loc[locty].r_offset++];
>          if (s->loc[locty].r_offset >=3D len) {
>              /* got last byte */
>              tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
> @@ -491,11 +490,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
>              "tpm_tis: result buffer : ",
>              s->loc[locty].r_offset);
>      for (idx =3D 0;
> -         idx < MIN(tpm_cmd_get_size(&s->r_buffer), s->be_buffer_size);
> +         idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
>           idx++) {
>          DPRINTF("%c%02x%s",
>                  s->loc[locty].r_offset =3D=3D idx ? '>' : ' ',
> -                s->r_buffer[idx],
> +                s->buffer[idx],
>                  ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
>      }
>      DPRINTF("\n"
> @@ -503,11 +502,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
>              "tpm_tis: request buffer: ",
>              s->loc[locty].w_offset);
>      for (idx =3D 0;
> -         idx < MIN(tpm_cmd_get_size(s->w_buffer), s->be_buffer_size);
> +         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
>           idx++) {
>          DPRINTF("%c%02x%s",
>                  s->loc[locty].w_offset =3D=3D idx ? '>' : ' ',
> -                s->w_buffer[idx],
> +                s->buffer[idx],
>                  ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
>      }
>      DPRINTF("\n");
> @@ -569,7 +568,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>          if (s->active_locty =3D=3D locty) {
>              if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
>                  val =3D TPM_TIS_BURST_COUNT(
> -                       MIN(tpm_cmd_get_size(&s->r_buffer),
> +                       MIN(tpm_cmd_get_size(&s->buffer),
>                             s->be_buffer_size)
>                         - s->loc[locty].r_offset) | s->loc[locty].sts;
>              } else {
> @@ -922,7 +921,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>
>              while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0)=
 {
>                  if (s->loc[locty].w_offset < s->be_buffer_size) {
> -                    s->w_buffer[s->loc[locty].w_offset++] =3D
> +                    s->buffer[s->loc[locty].w_offset++] =3D
>                          (uint8_t)val;
>                      val >>=3D 8;
>                      size--;
> @@ -937,7 +936,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>                  /* we have a packet length - see if we have all of it */
>                  bool need_irq =3D !(s->loc[locty].sts & TPM_TIS_STS_VALI=
D);
>
> -                len =3D tpm_cmd_get_size(&s->w_buffer);
> +                len =3D tpm_cmd_get_size(&s->buffer);
>                  if (len > s->loc[locty].w_offset) {
>                      tpm_tis_sts_set(&s->loc[locty],
>                                      TPM_TIS_STS_EXPECT | TPM_TIS_STS_VAL=
ID);
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
