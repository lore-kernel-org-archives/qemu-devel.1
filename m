Received: from eggs.gnu.org ([2001:4830:134:3::10]:55631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS24x-0003Ze-Gv
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS24w-0002zn-JA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:11 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS24w-0002zB-C6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:44:10 -0500
Received: by mail-wr0-x242.google.com with SMTP id y21so25379069wrc.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:44:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-9-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-9-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 15:44:08 +0100
Message-ID: <CAJ+F1C+PrqDQoN9SMPKZS8hr49099dkJdL7xy-KMJ=TKMRGV_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/13] tpm: Implement
 tpm_sized_buffer_reset
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
> Move the definition of TPMSizedBuffer out of tpm_tis.c into tpm_util.h
> and implement tpm_sized_buffer_reset() for the following patches to use.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Or maybe it's time to use qemu Buffer or glib GArray...

could be done later so,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_tis.c  | 5 -----
>  hw/tpm/tpm_util.c | 7 +++++++
>  hw/tpm/tpm_util.h | 7 +++++++
>  3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7d7e2cd..035c6ef 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -48,11 +48,6 @@ typedef enum {
>      TPM_TIS_STATE_RECEPTION,
>  } TPMTISState;
>
> -typedef struct TPMSizedBuffer {
> -    uint32_t size;
> -    uint8_t  *buffer;
> -} TPMSizedBuffer;
> -
>  /* locality data  -- all fields are persisted */
>  typedef struct TPMLocality {
>      TPMTISState state;
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index a317243..bf97811 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -288,3 +288,10 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion =
tpm_version,
>
>      return 0;
>  }
> +
> +void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
> +{
> +    g_free(tsb->buffer);
> +    tsb->buffer =3D NULL;
> +    tsb->size =3D 0;
> +}
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index 1c17e39..26c9613 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -39,4 +39,11 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
>  int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>                               size_t *buffersize);
>
> +typedef struct TPMSizedBuffer {
> +    uint32_t size;
> +    uint8_t  *buffer;
> +} TPMSizedBuffer;
> +
> +void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
> +
>  #endif /* TPM_TPM_UTIL_H */
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
