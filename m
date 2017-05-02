Received: from eggs.gnu.org ([2001:4830:134:3::10]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5a8h-0003Ya-Ta
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5a8g-0002W1-Hh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:59 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5a8g-0002V9-97
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:58 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so18328553wrb.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 08:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-7-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-7-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 15:54:46 +0000
Message-ID: <CAJ+F1CKbZjz0PhZEvJ1MmMH4ngkBcOATpU+1HGn=MJDF+YYQLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/8] tpm-backend: Move realloc_buffer()
 implementation to base class
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

> Provide base implementation of realloc_buffer(), so that backend
> implementations
> can resue.
>
>
I doubt that base class facility helps at this point, and would suggest
moving it to tpm-tis only.


> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  backends/tpm.c           |  9 ++++++++-
>  hw/tpm/tpm_passthrough.c | 12 ------------
>  2 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 4a6358e..f048c1d 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -88,8 +88,15 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
>  size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> +    if (!k->ops->realloc_buffer) {
> +        size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
>
> -    assert(k->ops->realloc_buffer);
> +        if (sb->size !=3D wanted_size) {
> +            sb->buffer =3D g_realloc(sb->buffer, wanted_size);
> +            sb->size =3D wanted_size;
> +        }
> +        return sb->size;
> +    }
>
>      return k->ops->realloc_buffer(sb);
>  }
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 2efced1..a7da0f8 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -258,17 +258,6 @@ static bool
> tpm_passthrough_get_startup_error(TPMBackend *tb)
>      return tpm_pt->had_startup_error;
>  }
>
> -static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
> -{
> -    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
> -
> -    if (sb->size !=3D wanted_size) {
> -        sb->buffer =3D g_realloc(sb->buffer, wanted_size);
> -        sb->size =3D wanted_size;
> -    }
> -    return sb->size;
> -}
> -
>  static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
>  {
>      TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> @@ -470,7 +459,6 @@ static const TPMDriverOps tpm_passthrough_driver =3D =
{
>      .opts                     =3D tpm_passthrough_cmdline_opts,
>      .desc                     =3D tpm_passthrough_create_desc,
>      .create                   =3D tpm_passthrough_create,
> -    .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
>      .reset                    =3D tpm_passthrough_reset,
>      .had_startup_error        =3D tpm_passthrough_get_startup_error,
>      .cancel_cmd               =3D tpm_passthrough_cancel_cmd,
> --
> 2.7.4
>
> --
Marc-Andr=C3=A9 Lureau
