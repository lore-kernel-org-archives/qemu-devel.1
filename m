Received: from eggs.gnu.org ([208.118.235.92]:59702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehdOk-0004Xz-EG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ehdNW-0007Wp-Ui
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:56 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ehdNW-0007Ua-8l
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:50 -0500
Received: by mail-qt0-f194.google.com with SMTP id l20so31308759qtj.11
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:35:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517527416-31328-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517527416-31328-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517527416-31328-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 2 Feb 2018 10:32:36 +0100
Message-ID: <CAMxuvawB1yNyg-Q8rPdgp=21kdVcZBSDhO3QQ5SSMQpA8RPmNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm: wrap stX_be_p in tpm_cmd_set_XYZ
 functions
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

Hi

On Fri, Feb 2, 2018 at 12:23 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Wrap the calls to stl_be_p and stw_be_p in tpm_cmd_set_XYZ functions
> that are similar to existing getters.

why not,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_util.c |  6 +++---
>  hw/tpm/tpm_util.h | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 8abde59..2de52a0 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -106,9 +106,9 @@ const PropertyInfo qdev_prop_tpm =3D {
>  void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
>  {
>      if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
> -        stw_be_p(out, TPM_TAG_RSP_COMMAND);
> -        stl_be_p(out + 2, sizeof(struct tpm_resp_hdr));
> -        stl_be_p(out + 6, TPM_FAIL);
> +        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
> +        tpm_cmd_set_size(out, sizeof(struct tpm_resp_hdr));
> +        tpm_cmd_set_error(out, TPM_FAIL);
>      }
>  }
>
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index f003d15..f397ac2 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -36,11 +36,21 @@ static inline uint16_t tpm_cmd_get_tag(const void *b)
>      return lduw_be_p(b);
>  }
>
> +static inline void tpm_cmd_set_tag(void *b, uint16_t tag)
> +{
> +    stw_be_p(b, tag);
> +}
> +
>  static inline uint32_t tpm_cmd_get_size(const void *b)
>  {
>      return ldl_be_p(b + 2);
>  }
>
> +static inline void tpm_cmd_set_size(void *b, uint32_t size)
> +{
> +    stl_be_p(b + 2, size);
> +}
> +
>  static inline uint32_t tpm_cmd_get_ordinal(const void *b)
>  {
>      return ldl_be_p(b + 6);
> @@ -51,6 +61,11 @@ static inline uint32_t tpm_cmd_get_errcode(const void =
*b)
>      return ldl_be_p(b + 6);
>  }
>
> +static inline void tpm_cmd_set_error(void *b, uint32_t error)
> +{
> +    stl_be_p(b + 6, error);
> +}
> +
>  int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>                               size_t *buffersize);
>
> --
> 2.5.5
>
