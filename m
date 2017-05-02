Received: from eggs.gnu.org ([2001:4830:134:3::10]:45143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5a8f-0003XF-5i
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5a8d-0002Ss-Hu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5a8d-0002Rc-7K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:55 -0400
Received: by mail-wm0-x243.google.com with SMTP id y10so5652256wmh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 08:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-8-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-8-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 15:54:43 +0000
Message-ID: <CAJ+F1CLy8ZBRbBbVhibDxf9QzyK=j=k=oJeV79u8X9YyL7=a4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/8] tpm-passthrough: move reusable code
 to utils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, berrange@redhat.com

Hi

On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri <amarnath.valluri@intel.com=
>
wrote:

> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  hw/tpm/tpm_passthrough.c | 64
> ++++--------------------------------------------
>  hw/tpm/tpm_util.c        | 25 +++++++++++++++++++
>  hw/tpm/tpm_util.h        |  4 +++
>  3 files changed, 34 insertions(+), 59 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index a7da0f8..b00efd5 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -68,27 +68,6 @@ typedef struct TPMPassthruState TPMPassthruState;
>
>  static void tpm_passthrough_cancel_cmd(TPMBackend *tb);
>
> -static int tpm_passthrough_unix_write(int fd, const uint8_t *buf,
> uint32_t len)
> -{
> -    int ret, remain;
> -
> -    remain =3D len;
> -    while (remain > 0) {
> -        ret =3D write(fd, buf, remain);
> -        if (ret < 0) {
> -            if (errno !=3D EINTR && errno !=3D EAGAIN) {
> -                return -1;
> -            }
> -        } else if (ret =3D=3D 0) {
> -            break;
> -        } else {
> -            buf +=3D ret;
> -            remain -=3D ret;
> -        }
> -    }
> -    return len - remain;
> -}
> -
>  static int tpm_passthrough_unix_read(int fd, uint8_t *buf, uint32_t len)
>  {
>      int ret;
> @@ -102,45 +81,12 @@ static int tpm_passthrough_unix_read(int fd, uint8_t
> *buf, uint32_t len)
>      }
>      return ret;
>  }
> -
> -static uint32_t tpm_passthrough_get_size_from_buffer(const uint8_t *buf)
> -{
> -    struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)buf;
> -
> -    return be32_to_cpu(resp->len);
> -}
> -
>

Why not keep that function? Possibly in header as inline?


> -/*
> - * Write an error message in the given output buffer.
> - */
> -static void tpm_write_fatal_error_response(uint8_t *out, uint32_t out_le=
n)
> -{
> -    if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
> -        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
> -
> -        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
> -        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
> -        resp->errcode =3D cpu_to_be32(TPM_FAIL);
> -    }
> -}
> -
> -static bool tpm_passthrough_is_selftest(const uint8_t *in, uint32_t
> in_len)
> -{
> -    struct tpm_req_hdr *hdr =3D (struct tpm_req_hdr *)in;
> -
> -    if (in_len >=3D sizeof(*hdr)) {
> -        return (be32_to_cpu(hdr->ordinal) =3D=3D TPM_ORD_ContinueSelfTes=
t);
> -    }
> -
> -    return false;
> -}
> -
>  static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>                                          const uint8_t *in, uint32_t
> in_len,
>                                          uint8_t *out, uint32_t out_len,
>                                          bool *selftest_done)
>  {
> -    int ret;
> +    ssize_t ret;
>      bool is_selftest;
>      const struct tpm_resp_hdr *hdr;
>
> @@ -148,9 +94,9 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>      tpm_pt->tpm_executing =3D true;
>      *selftest_done =3D false;
>
> -    is_selftest =3D tpm_passthrough_is_selftest(in, in_len);
> +    is_selftest =3D tpm_util_is_selftest(in, in_len);
>
> -    ret =3D tpm_passthrough_unix_write(tpm_pt->tpm_fd, in, in_len);
> +    ret =3D qemu_write_full(tpm_pt->tpm_fd, (const void *)in,
> (size_t)in_len);
>      if (ret !=3D in_len) {
>          if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
>              error_report("tpm_passthrough: error while transmitting data=
 "
> @@ -170,7 +116,7 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>                           strerror(errno), errno);
>          }
>      } else if (ret < sizeof(struct tpm_resp_hdr) ||
> -               tpm_passthrough_get_size_from_buffer(out) !=3D ret) {
> +               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
>          ret =3D -1;
>          error_report("tpm_passthrough: received invalid response "
>                       "packet from TPM");
> @@ -183,7 +129,7 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>
>  err_exit:
>      if (ret < 0) {
> -        tpm_write_fatal_error_response(out, out_len);
> +        tpm_util_write_fatal_error_response(out, out_len);
>      }
>
>      tpm_pt->tpm_executing =3D false;
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 7b35429..fb929f6 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -24,6 +24,31 @@
>  #include "tpm_int.h"
>
>  /*
> + * Write an error message in the given output buffer.
> + */
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
> +{
> +    if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
> +        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
> +
> +        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
> +        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
> +        resp->errcode =3D cpu_to_be32(TPM_FAIL);
> +    }
> +}
> +
> +bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
> +{
> +    struct tpm_req_hdr *hdr =3D (struct tpm_req_hdr *)in;
> +
> +    if (in_len >=3D sizeof(*hdr)) {
> +        return (be32_to_cpu(hdr->ordinal) =3D=3D TPM_ORD_ContinueSelfTes=
t);
> +    }
> +
> +    return false;
> +}
> +
> +/*
>   * A basic test of a TPM device. We expect a well formatted response
> header
>   * (error response is fine) within one second.
>   */
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index df76245..2f7c961 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -24,6 +24,10 @@
>
>  #include "sysemu/tpm_backend.h"
>
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)=
;
> +
> +bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
> +
>  int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
>
>  #endif /* TPM_TPM_UTIL_H */
>

looks good otherwise
--=20
Marc-Andr=C3=A9 Lureau
