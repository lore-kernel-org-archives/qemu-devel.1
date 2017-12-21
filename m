Received: from eggs.gnu.org ([2001:4830:134:3::10]:60992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1Z7-00027t-69
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1Z6-0001BG-0P
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:17 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS1Z5-0001Ad-M0
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:15 -0500
Received: by mail-wm0-x242.google.com with SMTP id n138so16166249wmg.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:11:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-5-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-5-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 15:11:13 +0100
Message-ID: <CAJ+F1CKWgshVZMbeAmJ2gGLNauF0AGcd-NQVYaoWHA03N=OGTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/13] tpm_tis: move buffers from
 localities into common location
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

Hi

On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> One read buffer and one write buffer is sufficient for all localities.
> The localities cannot all be active at the same time, and only the active
> locality can use the r/w buffers. Inactive localities will require the
> COMMAND_READY flag to be set on the STS register to move to the READY
> state, which then enables access to using the buffer for writing of a
> command, while all other localities are inactive.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index ddfcfc9..f6f5f17 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -64,16 +64,14 @@ typedef struct TPMLocality {
>
>      uint16_t w_offset;
>      uint16_t r_offset;
> -    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
> -    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
>  } TPMLocality;
>
>  typedef struct TPMState {
>      ISADevice busdev;
>      MemoryRegion mmio;
>
> -    uint32_t offset;
> -    uint8_t buf[TPM_TIS_BUFFER_MAX];

Looks like those were never used. Make it a seperate cleanup?

> +    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
> +    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
>
>      uint8_t active_locty;
>      uint8_t aborting_locty;
> @@ -259,7 +257,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t loc=
ty)
>  {
>      TPMLocality *locty_data =3D &s->loc[locty];
>
> -    tpm_tis_show_buffer(s->loc[locty].w_buffer, s->be_buffer_size,
> +    tpm_tis_show_buffer(s->w_buffer, s->be_buffer_size,
>                          "tpm_tis: To TPM");
>
>      /*
> @@ -270,9 +268,9 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t loc=
ty)
>
>      s->cmd =3D (TPMBackendCmd) {
>          .locty =3D locty,
> -        .in =3D locty_data->w_buffer,
> +        .in =3D s->w_buffer,
>          .in_len =3D locty_data->w_offset,
> -        .out =3D locty_data->r_buffer,
> +        .out =3D s->r_buffer,
>          .out_len =3D s->be_buffer_size,
>      };
>
> @@ -424,7 +422,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
>      s->loc[locty].r_offset =3D 0;
>      s->loc[locty].w_offset =3D 0;
>
> -    tpm_tis_show_buffer(s->loc[locty].r_buffer, s->be_buffer_size,
> +    tpm_tis_show_buffer(s->r_buffer, s->be_buffer_size,
>                          "tpm_tis: From TPM");
>
>      if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
> @@ -444,10 +442,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint=
8_t locty)
>      uint16_t len;
>
>      if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
> -        len =3D MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
> +        len =3D MIN(tpm_cmd_get_size(&s->r_buffer),
>                    s->be_buffer_size);
>
> -        ret =3D s->loc[locty].r_buffer[s->loc[locty].r_offset++];
> +        ret =3D s->r_buffer[s->loc[locty].r_offset++];
>          if (s->loc[locty].r_offset >=3D len) {
>              /* got last byte */
>              tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
> @@ -493,12 +491,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
>              "tpm_tis: result buffer : ",
>              s->loc[locty].r_offset);
>      for (idx =3D 0;
> -         idx < MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
> -                   s->be_buffer_size);
> +         idx < MIN(tpm_cmd_get_size(&s->r_buffer), s->be_buffer_size);
>           idx++) {
>          DPRINTF("%c%02x%s",
>                  s->loc[locty].r_offset =3D=3D idx ? '>' : ' ',
> -                s->loc[locty].r_buffer[idx],
> +                s->r_buffer[idx],
>                  ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
>      }
>      DPRINTF("\n"
> @@ -506,12 +503,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
>              "tpm_tis: request buffer: ",
>              s->loc[locty].w_offset);
>      for (idx =3D 0;
> -         idx < MIN(tpm_cmd_get_size(s->loc[locty].w_buffer),
> -                   s->be_buffer_size);
> +         idx < MIN(tpm_cmd_get_size(s->w_buffer), s->be_buffer_size);
>           idx++) {
>          DPRINTF("%c%02x%s",
>                  s->loc[locty].w_offset =3D=3D idx ? '>' : ' ',
> -                s->loc[locty].w_buffer[idx],
> +                s->w_buffer[idx],
>                  ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
>      }
>      DPRINTF("\n");
> @@ -573,7 +569,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>          if (s->active_locty =3D=3D locty) {
>              if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
>                  val =3D TPM_TIS_BURST_COUNT(
> -                       MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
> +                       MIN(tpm_cmd_get_size(&s->r_buffer),
>                             s->be_buffer_size)
>                         - s->loc[locty].r_offset) | s->loc[locty].sts;
>              } else {
> @@ -926,7 +922,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>
>              while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0)=
 {
>                  if (s->loc[locty].w_offset < s->be_buffer_size) {
> -                    s->loc[locty].w_buffer[s->loc[locty].w_offset++] =3D
> +                    s->w_buffer[s->loc[locty].w_offset++] =3D
>                          (uint8_t)val;
>                      val >>=3D 8;
>                      size--;
> @@ -941,7 +937,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>                  /* we have a packet length - see if we have all of it */
>                  bool need_irq =3D !(s->loc[locty].sts & TPM_TIS_STS_VALI=
D);
>
> -                len =3D tpm_cmd_get_size(&s->loc[locty].w_buffer);
> +                len =3D tpm_cmd_get_size(&s->w_buffer);
>                  if (len > s->loc[locty].w_offset) {
>                      tpm_tis_sts_set(&s->loc[locty],
>                                      TPM_TIS_STS_EXPECT | TPM_TIS_STS_VAL=
ID);
> --
> 2.5.5
>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
