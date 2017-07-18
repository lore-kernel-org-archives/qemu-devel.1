Received: from eggs.gnu.org ([2001:4830:134:3::10]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXPY1-0001Ta-KV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXPXz-0006uS-FO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:16:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dXPXz-0006uD-1q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:16:07 -0400
Received: by mail-lf0-x243.google.com with SMTP id t72so1307946lff.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-5-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1500367747-8992-5-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 10:15:55 +0000
Message-ID: <CAJ+F1CKjMFFBA-0W0QZPze5o5vd+rzFkMvF4oWYyfPWQQ-rXwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 4/8] tpm-backend: Made few interface
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
Cc: stefanb@linux.vnet.ibm.com

Hi

On Tue, Jul 18, 2017 at 10:48 AM Amarnath Valluri <
amarnath.valluri@intel.com> wrote:

> This allows backend implementations left optional interface methods.
> For mandatory methods assertion checks added.
>
> Took the opportunity to remove unused methods:
>   tpm_backend_get_type()
>   tpm_backend_get_desc()
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Stefan Berger<stefanb@linux.vnet.ibm.com>
> ---
>  backends/tpm.c               | 36 +++++++++++++++++-------------------
>  hw/tpm/tpm_passthrough.c     | 23 +----------------------
>  include/sysemu/tpm_backend.h | 19 +------------------
>  tpm.c                        |  2 +-
>  4 files changed, 20 insertions(+), 60 deletions(-)
>

   LINK    x86_64-softmmu/qemu-system-x86_64
../tpm.o: In function `qmp_query_tpm_inst':
/home/elmarco/src/qq/tpm.c:261: undefined reference to
`tpm_backend_get_type'
collect2: error: ld returned 1 exit status


> diff --git a/backends/tpm.c b/backends/tpm.c
> index cf5abf1..05002e6 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -37,20 +37,6 @@ static void tpm_backend_thread_end(TPMBackend *s)
>      }
>  }
>
> -enum TpmType tpm_backend_get_type(TPMBackend *s)
> -{
> -    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> -
> -    return k->ops->type;
> -}
> -
> -const char *tpm_backend_get_desc(TPMBackend *s)
> -{
> -    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> -
> -    return k->ops->desc();
> -}
> -
>  int tpm_backend_init(TPMBackend *s, TPMState *state,
>                       TPMRecvDataCB *datacb)
>  {
> @@ -59,7 +45,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
>      s->tpm_state =3D state;
>      s->recv_data_callback =3D datacb;
>
> -    return k->ops->init(s);
> +    return k->ops->init ? k->ops->init(s) : 0;
>  }
>
>  int tpm_backend_startup_tpm(TPMBackend *s)
> @@ -73,13 +59,15 @@ int tpm_backend_startup_tpm(TPMBackend *s)
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
> @@ -87,6 +75,8 @@ size_t tpm_backend_realloc_buffer(TPMBackend *s,
> TPMSizedBuffer *sb)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    assert(k->ops->realloc_buffer);
> +
>      return k->ops->realloc_buffer(sb);
>  }
>
> @@ -100,7 +90,9 @@ void tpm_backend_reset(TPMBackend *s)
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
> @@ -109,6 +101,8 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
>  {
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> +    assert(k->ops->cancel_cmd);
> +
>      k->ops->cancel_cmd(s);
>  }
>
> @@ -116,20 +110,24 @@ bool tpm_backend_get_tpm_established_flag(TPMBacken=
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
> index 815a72e..a0459a6 100644
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
> @@ -309,11 +295,6 @@ static void tpm_passthrough_cancel_cmd(TPMBackend *t=
b)
>      }
>  }
>
> -static const char *tpm_passthrough_create_desc(void)
> -{
> -    return "Passthrough TPM backend driver";
> -}
> -
>  static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
>  {
>      TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> @@ -453,10 +434,8 @@ static const QemuOptDesc
> tpm_passthrough_cmdline_opts[] =3D {
>  static const TPMDriverOps tpm_passthrough_driver =3D {
>      .type                     =3D TPM_TYPE_PASSTHROUGH,
>      .opts                     =3D tpm_passthrough_cmdline_opts,
> -    .desc                     =3D tpm_passthrough_create_desc,
> +    .desc                     =3D "Passthrough TPM backend driver",
>      .create                   =3D tpm_passthrough_create,
> -    .init                     =3D tpm_passthrough_init,
> -    .startup_tpm              =3D tpm_passthrough_startup_tpm,
>      .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
>      .reset                    =3D tpm_passthrough_reset,
>      .had_startup_error        =3D tpm_passthrough_get_startup_error,
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index f61bcfe..d6ae463 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -75,7 +75,7 @@ struct TPMDriverOps {
>      enum TpmType type;
>      const QemuOptDesc *opts;
>      /* get a descriptive text of the backend to display to the user */
> -    const char *(*desc)(void);
> +    const char *desc;
>
>      TPMBackend *(*create)(QemuOpts *opts, const char *id);
>
> @@ -99,23 +99,6 @@ struct TPMDriverOps {
>      TPMVersion (*get_tpm_version)(TPMBackend *t);
>  };
>
> -
> -/**
> - * tpm_backend_get_type:
> - * @s: the backend
> - *
> - * Returns the TpmType of the backend.
> - */
> -enum TpmType tpm_backend_get_type(TPMBackend *s);
> -
> -/**
> - * tpm_backend_get_desc:
> - * @s: the backend
> - *
> - * Returns a human readable description of the backend.
> - */
> -const char *tpm_backend_get_desc(TPMBackend *s);
> -
>  /**
>   * tpm_backend_init:
>   * @s: the backend to initialized
> diff --git a/tpm.c b/tpm.c
> index 70f74fa..2979508 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -102,7 +102,7 @@ static void tpm_display_backend_drivers(void)
>
>      for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
>          fprintf(stderr, "%12s   %s\n",
> -                TpmType_lookup[be_drivers[i]->type],
> be_drivers[i]->desc());
> +                TpmType_lookup[be_drivers[i]->type], be_drivers[i]->desc=
);
>      }
>      fprintf(stderr, "\n");
>  }
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
