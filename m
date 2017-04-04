Received: from eggs.gnu.org ([2001:4830:134:3::10]:35876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvOty-00062v-Mc
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvOtw-0003CN-Qv
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:53:42 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvOtw-0003Bt-At
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:53:40 -0400
Received: by mail-lf0-x244.google.com with SMTP id v2so15601368lfi.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-7-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-7-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Apr 2017 13:53:28 +0000
Message-ID: <CAJ+F1CJyHiLs=NMynZB=dadqJsRzoWwthY6gP5Pfrd3qwKHgzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] tpm-passthrough: move reusable code to
 utils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

Hi

On Fri, Mar 31, 2017 at 4:57 PM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>

Nothing really controversial here. You could point out in the commit
message that those functions will be used in the new backend perhaps.


> ---
>  hw/tpm/tpm_passthrough.c | 77
> ++++--------------------------------------------
>  hw/tpm/tpm_util.c        | 60 +++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_util.h        |  8 +++++
>  3 files changed, 73 insertions(+), 72 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index fce1163..fc60914 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -69,73 +69,6 @@ typedef struct TPMPassthruState TPMPassthruState;
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
>

that looks like qemu_write_full()


> -
> -static int tpm_passthrough_unix_read(int fd, uint8_t *buf, uint32_t len)
> -{
> -    int ret;
> - reread:
> -    ret =3D read(fd, buf, len);
> -    if (ret < 0) {
> -        if (errno !=3D EINTR && errno !=3D EAGAIN) {
> -            return -1;
> -        }
> -        goto reread;
> -    }
> -    return ret;
> -}
> -
>

Eventually, we may want to switch to QIOChannel.. just some thoughts

-static uint32_t tpm_passthrough_get_size_from_buffer(const uint8_t *buf)
> -{
> -    struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)buf;
> -
> -    return be32_to_cpu(resp->len);
> -}
> -
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
> @@ -149,9 +82,9 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>      tpm_pt->tpm_executing =3D true;
>      *selftest_done =3D false;
>
> -    is_selftest =3D tpm_passthrough_is_selftest(in, in_len);
> +    is_selftest =3D tpm_util_is_selftest(in, in_len);
>
> -    ret =3D tpm_passthrough_unix_write(tpm_pt->tpm_fd, in, in_len);
> +    ret =3D tpm_util_unix_write(tpm_pt->tpm_fd, in, in_len);
>      if (ret !=3D in_len) {
>          if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
>              error_report("tpm_passthrough: error while transmitting data=
 "
> @@ -163,7 +96,7 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>
>      tpm_pt->tpm_executing =3D false;
>
> -    ret =3D tpm_passthrough_unix_read(tpm_pt->tpm_fd, out, out_len);
> +    ret =3D tpm_util_unix_read(tpm_pt->tpm_fd, out, out_len);
>      if (ret < 0) {
>          if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
>              error_report("tpm_passthrough: error while reading data from=
 "
> @@ -171,7 +104,7 @@ static int
> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>                           strerror(errno), errno);
>          }
>      } else if (ret < sizeof(struct tpm_resp_hdr) ||
> -               tpm_passthrough_get_size_from_buffer(out) !=3D ret) {
> +               ((struct tpm_resp_hdr *)out)->len !=3D ret) {
>          ret =3D -1;
>          error_report("tpm_passthrough: received invalid response "
>                       "packet from TPM");
> @@ -184,7 +117,7 @@ static int
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
> index 7b35429..5475acf 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -23,6 +23,66 @@
>  #include "tpm_util.h"
>  #include "tpm_int.h"
>
> +int tpm_util_unix_write(int fd, const uint8_t *buf, uint32_t len)
> +{
> +    int ret, remain;
> +
> +    remain =3D len;
> +    while (remain > 0) {
> +        ret =3D write(fd, buf, remain);
> +        if (ret < 0) {
> +            if (errno !=3D EINTR && errno !=3D EAGAIN) {
> +                return -1;
> +            }
> +        } else if (ret =3D=3D 0) {
> +            break;
> +        } else {
> +            buf +=3D ret;
> +            remain -=3D ret;
> +        }
> +    }
> +    return len - remain;
> +}
> +
> +int tpm_util_unix_read(int fd, uint8_t *buf, uint32_t len)
> +{
> +    int ret;
> + reread:
> +    ret =3D read(fd, buf, len);
> +    if (ret < 0) {
> +        if (errno !=3D EINTR && errno !=3D EAGAIN) {
> +            return -1;
> +        }
> +        goto reread;
> +    }
> +    return ret;
> +}
> +
> +/*
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
>  /*
>   * A basic test of a TPM device. We expect a well formatted response
> header
>   * (error response is fine) within one second.
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index df76245..c2feca7 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -24,6 +24,14 @@
>
>  #include "sysemu/tpm_backend.h"
>
> +int tpm_util_unix_write(int fd, const uint8_t *buf, uint32_t len);
> +
> +int tpm_util_unix_read(int fd, uint8_t *buf, uint32_t len);
> +
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)=
;
> +
> +bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
> +
>  int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
>
>  #endif /* TPM_TPM_UTIL_H */
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
