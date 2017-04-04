Received: from eggs.gnu.org ([2001:4830:134:3::10]:47872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvO29-00067U-Ok
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvO28-0003jt-F0
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:58:05 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvO27-0003jm-VS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:58:04 -0400
Received: by mail-lf0-x243.google.com with SMTP id r36so15491226lfi.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 05:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-4-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-4-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Apr 2017 12:57:51 +0000
Message-ID: <CAJ+F1CJLoawhs-HS_yahMc2bpK8nKdT1KLxkGG3R9VKRO45Zkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] tpm-backend: Initialize and free data
 members in it's own methods
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

On Fri, Mar 31, 2017 at 5:01 PM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

> Initialize and free TPMBackend data members in it's own instance_init() a=
nd
> instance_finalize methods.
>
> Took the opportunity to fix object cleanup in tpm_backend_destroy() metho=
d
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  backends/tpm.c           | 14 +++++++++++++-
>  hw/tpm/tpm_passthrough.c |  8 +-------
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 50a7809..00c82d7 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -59,7 +59,7 @@ void tpm_backend_destroy(TPMBackend *s)
>
>      k->ops->destroy(s);
>
> -    tpm_backend_thread_end(s);
> +    object_unref(OBJECT(s));
>  }
>

tpm_backend_destroy() wrapping object_unref().. I think we could do it the
correct way instead, caller use object_unref() and implementation can use
finalizers.

>
>  int tpm_backend_init(TPMBackend *s, TPMState *state,
> @@ -187,10 +187,20 @@ static void tpm_backend_prop_set_opened(Object *obj=
,
> bool value, Error **errp)
>
>  static void tpm_backend_instance_init(Object *obj)
>  {
> +    TPMBackend *s =3D TPM_BACKEND(obj);
> +
>      object_property_add_bool(obj, "opened",
>                               tpm_backend_prop_get_opened,
>                               tpm_backend_prop_set_opened,
>                               NULL);
> +    s->id =3D NULL;
> +    s->fe_model =3D -1;
> +    s->opened =3D false;
> +    s->tpm_state =3D NULL;
> +    s->thread_pool =3D NULL;
> +    s->recv_data_callback =3D NULL;
> +    s->path =3D NULL;
> +    s->cancel_path =3D NULL;
>

I don't see much point in initializing again those fields to 0, since
object creation do it already.

>
>  }
>
> @@ -199,6 +209,8 @@ static void tpm_backend_instance_finalize(Object *obj=
)
>      TPMBackend *s =3D TPM_BACKEND(obj);
>
>      g_free(s->id);
> +    g_free(s->path);
> +    g_free(s->cancel_path);
>      tpm_backend_thread_end(s);
>  }
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 606e064..cb63079 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -418,8 +418,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts
> *opts, const char *id)
>      TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
>
>      tb->id =3D g_strdup(id);
> -    /* let frontend set the fe_model to proper value */
> -    tb->fe_model =3D -1;
>
>      if (tpm_passthrough_handle_device_opts(opts, tb)) {
>          goto err_exit;
> @@ -433,7 +431,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts
> *opts, const char *id)
>      return tb;
>
>  err_exit:
> -    g_free(tb->id);
> +    object_unref(obj);
>

ok, that's a leak fix


>
>      return NULL;
>  }
> @@ -446,10 +444,6 @@ static void tpm_passthrough_destroy(TPMBackend *tb)
>
>      qemu_close(tpm_pt->tpm_fd);
>      qemu_close(tpm_pt->cancel_fd);
> -
> -    g_free(tb->id);
> -    g_free(tb->path);
> -    g_free(tb->cancel_path);
>      g_free(tpm_pt->tpm_dev);
>  }
>
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
