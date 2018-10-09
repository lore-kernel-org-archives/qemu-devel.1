Received: from eggs.gnu.org ([2001:4830:134:3::10]:45039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9pva-0007Gl-7Z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9pvX-00042N-Hn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:11:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9pvX-00040n-A3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:11:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id 61-v6so1361278wrb.6
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-19-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-19-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:11:31 +0400
Message-ID: <CAJ+F1CK3h9PDQ-k-v65dGBEfs=MiCPgot9_gvPGB4czN70x8pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/31] qom: Clean up error reporting in
 user_creatable_add_opts_foreach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Oct 8, 2018 at 9:39 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  user_creatable_add_opts_foreach() does that, and then
> fails without setting an error.  Its caller main(), via
> qemu_opts_foreach(), is fine with it, but clean it up anyway.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qemu-io.c               |  8 +++-----
>  qemu-nbd.c              |  8 +++-----
>  qom/object_interfaces.c |  4 +---
>  vl.c                    | 16 ++++++----------
>  4 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/qemu-io.c b/qemu-io.c
> index 13829f5e21..6df7731af4 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -620,11 +620,9 @@ int main(int argc, char **argv)
>          exit(1);
>      }
>
> -    if (qemu_opts_foreach(&qemu_object_opts,
> -                          user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(&qemu_object_opts,
> +                      user_creatable_add_opts_foreach,
> +                      NULL, &error_fatal);
>
>      if (!trace_init_backends()) {
>          exit(1);
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 7874bc973c..ca7109652e 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -766,11 +766,9 @@ int main(int argc, char **argv)
>          exit(EXIT_FAILURE);
>      }
>
> -    if (qemu_opts_foreach(&qemu_object_opts,
> -                          user_creatable_add_opts_foreach,
> -                          NULL, NULL)) {
> -        exit(EXIT_FAILURE);
> -    }
> +    qemu_opts_foreach(&qemu_object_opts,
> +                      user_creatable_add_opts_foreach,
> +                      NULL, &error_fatal);
>
>      if (!trace_init_backends()) {
>          exit(1);
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 72b97a8bed..4052d6c4a7 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -143,7 +143,6 @@ int user_creatable_add_opts_foreach(void *opaque, Qem=
uOpts *opts, Error **errp)
>  {
>      bool (*type_predicate)(const char *) =3D opaque;
>      Object *obj =3D NULL;
> -    Error *err =3D NULL;
>      const char *type;
>
>      type =3D qemu_opt_get(opts, "qom-type");
> @@ -152,9 +151,8 @@ int user_creatable_add_opts_foreach(void *opaque, Qem=
uOpts *opts, Error **errp)
>          return 0;
>      }
>
> -    obj =3D user_creatable_add_opts(opts, &err);
> +    obj =3D user_creatable_add_opts(opts, errp);
>      if (!obj) {
> -        error_report_err(err);
>          return -1;
>      }
>      object_unref(obj);
> diff --git a/vl.c b/vl.c
> index 7ce8299d9d..b8576f8f10 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4181,11 +4181,9 @@ int main(int argc, char **argv, char **envp)
>      page_size_init();
>      socket_init();
>
> -    if (qemu_opts_foreach(qemu_find_opts("object"),
> -                          user_creatable_add_opts_foreach,
> -                          object_create_initial, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("object"),
> +                      user_creatable_add_opts_foreach,
> +                      object_create_initial, &error_fatal);
>
>      if (qemu_opts_foreach(qemu_find_opts("chardev"),
>                            chardev_init_func, NULL, NULL)) {
> @@ -4316,11 +4314,9 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>
> -    if (qemu_opts_foreach(qemu_find_opts("object"),
> -                          user_creatable_add_opts_foreach,
> -                          object_create_delayed, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("object"),
> +                      user_creatable_add_opts_foreach,
> +                      object_create_delayed, &error_fatal);
>
>      if (tpm_init() < 0) {
>          exit(1);
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
