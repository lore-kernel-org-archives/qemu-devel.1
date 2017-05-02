Received: from eggs.gnu.org ([2001:4830:134:3::10]:35351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5Wvd-00005W-AY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5Wvb-0000vq-HQ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:29:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5Wvb-0000vR-7v
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:29:15 -0400
Received: by mail-wm0-x241.google.com with SMTP id u65so4055110wmu.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-5-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-5-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 12:29:03 +0000
Message-ID: <CAJ+F1CJC21gXOHuVf09NstSs278Aw9no6H51XPa8_fMgYP+AVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] tpm-backend: Made few interface
 methods optional
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

On Tue, May 2, 2017 at 3:52 PM Amarnath Valluri <amarnath.valluri@intel.com=
>
wrote:

> This allows backend implementations left optional interface methods.
> For mandatory methods assertion checks added.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

---
>  backends/tpm.c           | 24 ++++++++++++++++++------
>  hw/tpm/tpm_passthrough.c | 16 ----------------
>  2 files changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index cf5abf1..8245426 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -48,7 +48,7 @@ const char *tpm_backend_get_desc(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->desc();
> +    return k->ops->desc ? k->ops->desc() : "";
>  }
>

If it only need to returns const, we may consider using a class field,
defaulting to null.

Who is using it? tpm_backend_get_desc() not being called anywhere. Let's
remove it?


>  int tpm_backend_init(TPMBackend *s, TPMState *state,
> @@ -59,7 +59,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
>      s->tpm_state =3D state;
>      s->recv_data_callback =3D datacb;
>
> -    return k->ops->init(s);
> +    return k->ops->init ? k->ops->init(s) : 0;
>  }
>
>  int tpm_backend_startup_tpm(TPMBackend *s)
> @@ -73,13 +73,15 @@ int tpm_backend_startup_tpm(TPMBackend *s)
>                                         NULL);
>      g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT,
> NULL);
>
> -    return k->ops->startup_tpm(s);
> +    return k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
>  }
>
>  bool tpm_backend_had_startup_error(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    assert(k->ops->had_startup_error);
> +
>      return k->ops->had_startup_error(s);
>  }
>
> @@ -87,6 +89,8 @@ size_t tpm_backend_realloc_buffer(TPMBackend *s,
> TPMSizedBuffer *sb)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    assert(k->ops->realloc_buffer);
> +
>      return k->ops->realloc_buffer(sb);
>  }
>
> @@ -100,7 +104,9 @@ void tpm_backend_reset(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    k->ops->reset(s);
> +    if (k->ops->reset) {
> +        k->ops->reset(s);
> +    }
>
>      tpm_backend_thread_end(s);
>  }
> @@ -109,6 +115,8 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    g_assert(k->ops->cancel_cmd);
>

Let's use assert() for consistency in the file


> +
>      k->ops->cancel_cmd(s);
>  }
>
> @@ -116,20 +124,24 @@ bool tpm_backend_get_tpm_established_flag(TPMBacken=
d
> *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->get_tpm_established_flag(s);
> +    return k->ops->get_tpm_established_flag ?
> +           k->ops->get_tpm_established_flag(s) : false;
>  }
>
>  int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->reset_tpm_established_flag(s, locty);
> +    return k->ops->reset_tpm_established_flag ?
> +           k->ops->reset_tpm_established_flag(s, locty) : 0;
>  }
>
>  TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    assert(k->ops->get_tpm_version);
> +
>      return k->ops->get_tpm_version(s);
>  }
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 815a72e..bbe9e5a 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -227,15 +227,6 @@ static void tpm_passthrough_handle_request(TPMBacken=
d
> *tb, TPMBackendCmd cmd)
>      }
>  }
>
> -/*
> - * Start the TPM (thread). If it had been started before, then terminate
> - * and start it again.
> - */
> -static int tpm_passthrough_startup_tpm(TPMBackend *tb)
> -{
> -    return 0;
> -}
> -
>  static void tpm_passthrough_reset(TPMBackend *tb)
>  {
>      TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> @@ -247,11 +238,6 @@ static void tpm_passthrough_reset(TPMBackend *tb)
>      tpm_pt->had_startup_error =3D false;
>  }
>
> -static int tpm_passthrough_init(TPMBackend *tb)
> -{
> -    return 0;
> -}
> -
>  static bool tpm_passthrough_get_tpm_established_flag(TPMBackend *tb)
>  {
>      return false;
> @@ -455,8 +441,6 @@ static const TPMDriverOps tpm_passthrough_driver =3D =
{
>      .opts                     =3D tpm_passthrough_cmdline_opts,
>      .desc                     =3D tpm_passthrough_create_desc,
>      .create                   =3D tpm_passthrough_create,
> -    .init                     =3D tpm_passthrough_init,
> -    .startup_tpm              =3D tpm_passthrough_startup_tpm,
>      .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
>      .reset                    =3D tpm_passthrough_reset,
>      .had_startup_error        =3D tpm_passthrough_get_startup_error,
> --
> 2.7.4
>
>
othewise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
--=20
Marc-Andr=C3=A9 Lureau
