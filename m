Received: from eggs.gnu.org ([2001:4830:134:3::10]:51677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkRaI-0008Ee-Rl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkRaC-0003GN-V2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkRaC-0003GA-Lb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:04:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-8-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 11:04:09 +0200
In-Reply-To: <20170822132255.23945-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:08 +0200")
Message-ID: <87a82q7j06.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/54] tpm: simplify driver registration
 & lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@us.ibm.com

Note: cc'ing the code's author.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Make be_drivers[n] match order of TpmType enum.
>
> Use qapi_enum_parse() in tpm_get_backend_driver.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/tpm_backend.h |  2 +-
>  tpm.c                        | 42 ++++++++++++--------------------------=
----
>  2 files changed, 13 insertions(+), 31 deletions(-)

Before the patch, we have a strict separation between enum TpmModel /
tpm_models[] and enum TpmType / be_drivers[]:

* TpmModel may have any number of members.  It just happens to have one.

* Same for TpmType.

* tpm_models[] may have any number of elements.  It just happens to have
  the same number of elements as TpmModel has members.

  If it had more, they'd be wasted: tpm_register_model() can't use more
  than one per TpmModel member.  If it had fewer, tpm_register_model()
  could fail.  Its caller ignores failure.

* be_drivers[] is different: tpm_register_driver() happily adds drivers
  as long as be_drivers[] has space.  Its caller ignores failure.

  If you register more than one with a given TpmType,
  tpm_driver_find_by_type(), tpm_get_backend_driver() will find only the
  one one that registered first.  tpm_display_backend_drivers() happily
  shows all of them.

* The order of TpmModel members and tpm_models[] elements is
  independent.  The former is fixed in the QAPI schema, the latter is
  determined by registration order, which is unspecified.

  Corollary: using a TpmModel to subscript tpm_models[] is wrong.
=20=20
* Same for TpmType and be_drivers[]: using a TpmType to subscript
  be_drivers[] is wrong.

Hard to tell whether this is / has become more a case of overengineering
or more a case of under-make-sense-ing.

> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index b58f52d39f..1d21c6b19b 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -227,6 +227,6 @@ TPMBackend *qemu_find_tpm(const char *id);
>=20=20
>  const TPMDriverOps *tpm_get_backend_driver(const char *type);
>  int tpm_register_model(enum TpmModel model);
> -int tpm_register_driver(const TPMDriverOps *tdo);
> +void tpm_register_driver(const TPMDriverOps *tdo);
>=20=20
>  #endif
> diff --git a/tpm.c b/tpm.c
> index c3b731b3f2..f175661bfe 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -26,9 +26,8 @@ static QLIST_HEAD(, TPMBackend) tpm_backends =3D
>=20=20
>=20=20
>  #define TPM_MAX_MODELS      1
> -#define TPM_MAX_DRIVERS     1
>=20=20
> -static TPMDriverOps const *be_drivers[TPM_MAX_DRIVERS] =3D {
> +static TPMDriverOps const *be_drivers[TPM_TYPE__MAX] =3D {
>      NULL,
>  };
>=20=20
> @@ -64,31 +63,18 @@ static bool tpm_model_is_registered(enum TpmModel mod=
el)
>=20=20
>  const TPMDriverOps *tpm_get_backend_driver(const char *type)
>  {
> -    int i;
> +    int i =3D qapi_enum_parse(TpmType_lookup, type, TPM_TYPE__MAX, -1, N=
ULL);
>=20=20
> -    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
> -        if (!strcmp(TpmType_lookup[be_drivers[i]->type], type)) {
> -            return be_drivers[i];
> -        }
> -    }
> -
> -    return NULL;
> +    return i >=3D 0 ? be_drivers[i] : NULL;
>  }
>=20=20
>  #ifdef CONFIG_TPM
>=20=20
> -int tpm_register_driver(const TPMDriverOps *tdo)
> +void tpm_register_driver(const TPMDriverOps *tdo)
>  {
> -    int i;
> +    assert(!be_drivers[tdo->type]);
>=20=20
> -    for (i =3D 0; i < TPM_MAX_DRIVERS; i++) {
> -        if (!be_drivers[i]) {
> -            be_drivers[i] =3D tdo;
> -            return 0;
> -        }
> -    }
> -    error_report("Could not register TPM driver");
> -    return 1;
> +    be_drivers[tdo->type] =3D tdo;
>  }
>=20=20
>  /*
> @@ -101,9 +87,12 @@ static void tpm_display_backend_drivers(void)
>=20=20
>      fprintf(stderr, "Supported TPM types (choose only one):\n");
>=20=20
> -    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
> +    for (i =3D 0; i < TPM_TYPE__MAX; i++) {
> +        if (be_drivers[i] =3D=3D NULL) {
> +            continue;
> +        }
>          fprintf(stderr, "%12s   %s\n",
> -                qapi_enum_lookup(TpmType_lookup, be_drivers[i]->type),
> +                qapi_enum_lookup(TpmType_lookup, i),
>                  be_drivers[i]->desc());
>      }
>      fprintf(stderr, "\n");
> @@ -241,14 +230,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const =
char *optarg)
>=20=20
>  static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
>  {
> -    int i;
> -
> -    for (i =3D 0; i < TPM_MAX_DRIVERS && be_drivers[i] !=3D NULL; i++) {
> -        if (be_drivers[i]->type =3D=3D type) {
> -            return be_drivers[i];
> -        }
> -    }
> -    return NULL;
> +    return be_drivers[type];
>  }
>=20=20
>  static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)

You kill the separation of TpmType and be_drivers[]: TpmType values
become valid subscripts of be_drivers[].  Good!

You don't touch TpmModel and tpm_models[].  Half of the mess remains in
place to confuse the next reader (it certainly confused me, thus the
long "before the patch" treatise).  Not wrong, therefore

Reviewed-by: Markus Armbruster <armbru@redhat.com>

but could you complete the cleanup job?  Pretty-please?

Also: since I wrote the "before the patch" treatise already, could (some
of) it be worked into the commit message?
