Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkpil-0003Lg-4J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkpij-0004gZ-PZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:50:42 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:33916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkpij-0004gR-Dz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:50:41 -0400
Received: by mail-vk0-x242.google.com with SMTP id t126so872312vkb.1
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:50:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-5-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-5-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 12:50:40 +0200
Message-ID: <CAJ+F1CKu0ewTNa2n3hY5h-n756xRDZUk4gy8y0eAGiOjVH29dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/16] tpm: Clean up model registration &
 lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@us.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Aug 24, 2017 at 10:45 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> We have a strict separation between enum TpmModel and tpm_models[]:
>
> * TpmModel may have any number of members.  It just happens to have one.
>
> * tpm_register_model() uses the first empty slot in tmp_models[].
>
>   If you register more than tpm_models[] has space,
>   tpn_register_model() fails.  Its caller silently ignores the
>   failure.

tpm_

>
>   Register the same TpmModel more than once has no effect other than
>   wasting tpm_models[] slots: tpm_model_is_registered() is happy with
>   the first one it finds.
>
> Since we only ever register one model, and tpm_models[] has space for
> just that one, this contraption even works.
>
> Turn tpm_models[] into a straight map from enum TpmType to bool.  Much
> simpler.
>
> Cc: Stefan Berger <stefanb@us.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/sysemu/tpm_backend.h |  2 +-
>  tpm.c                        | 37 +++++--------------------------------
>  2 files changed, 6 insertions(+), 33 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index 1d21c6b..b0a9731 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -226,7 +226,7 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)=
;
>  TPMBackend *qemu_find_tpm(const char *id);
>
>  const TPMDriverOps *tpm_get_backend_driver(const char *type);
> -int tpm_register_model(enum TpmModel model);
> +void tpm_register_model(enum TpmModel model);
>  void tpm_register_driver(const TPMDriverOps *tdo);
>
>  #endif
> diff --git a/tpm.c b/tpm.c
> index 6f39ec9..7635fc7 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -24,39 +24,12 @@
>  static QLIST_HEAD(, TPMBackend) tpm_backends =3D
>      QLIST_HEAD_INITIALIZER(tpm_backends);
>
> -
> -#define TPM_MAX_MODELS      1
> -
>  static TPMDriverOps const *be_drivers[TPM_TYPE__MAX];
> +static bool tpm_models[TPM_MODEL__MAX];
>
> -static enum TpmModel tpm_models[TPM_MAX_MODELS] =3D {
> -    TPM_MODEL__MAX,
> -};
> -
> -int tpm_register_model(enum TpmModel model)
> +void tpm_register_model(enum TpmModel model)
>  {
> -    int i;
> -
> -    for (i =3D 0; i < TPM_MAX_MODELS; i++) {
> -        if (tpm_models[i] =3D=3D TPM_MODEL__MAX) {
> -            tpm_models[i] =3D model;
> -            return 0;
> -        }
> -    }
> -    error_report("Could not register TPM model");
> -    return 1;
> -}
> -
> -static bool tpm_model_is_registered(enum TpmModel model)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < TPM_MAX_MODELS; i++) {
> -        if (tpm_models[i] =3D=3D model) {
> -            return true;
> -        }
> -    }
> -    return false;
> +    tpm_models[model] =3D true;

Ah, no need for an assert() here indeed (it took me a minute).

>  }
>
>  const TPMDriverOps *tpm_get_backend_driver(const char *type)
> @@ -270,7 +243,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
>      TPMInfoList *info, *head =3D NULL, *cur_item =3D NULL;
>
>      QLIST_FOREACH(drv, &tpm_backends, list) {
> -        if (!tpm_model_is_registered(drv->fe_model)) {
> +        if (!tpm_models[drv->fe_model]) {
>              continue;
>          }
>          info =3D g_new0(TPMInfoList, 1);
> @@ -317,7 +290,7 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
>      TpmModelList *head =3D NULL, *prev =3D NULL, *cur_item;
>
>      for (i =3D 0; i < TPM_MODEL__MAX; i++) {
> -        if (!tpm_model_is_registered(i)) {
> +        if (!tpm_models[i]) {
>              continue;
>          }
>          cur_item =3D g_new0(TpmModelList, 1);
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
