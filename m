Received: from eggs.gnu.org ([2001:4830:134:3::10]:46555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT6M-0007FO-SA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT6H-0000VP-TO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eCT6H-0000Ul-JC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:13 -0500
Date: Wed, 8 Nov 2017 17:21:10 +0100
From: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20171108162110.GC13150@boraha>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-2-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1510016336-4086-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] tpm: Move getting TPM buffer size to
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com

On Mon, Nov 06, 2017 at 07:58:52PM -0500, Stefan Berger wrote:
> Rather than setting the size of the TPM buffer in the front-end,
> query the backend for the size of the buffer. In this patch we
> just move the hard-coded buffer size of 4096 to the backends.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  backends/tpm.c               |  9 +++++++++
>  hw/tpm/tpm_emulator.c        |  6 ++++++
>  hw/tpm/tpm_passthrough.c     |  6 ++++++
>  hw/tpm/tpm_tis.c             | 12 +++++++-----
>  include/sysemu/tpm_backend.h | 11 +++++++++++
>  5 files changed, 39 insertions(+), 5 deletions(-)
>=20
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 7777467..e7d0f9a 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -139,6 +139,15 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend =
*s)
>      return k->get_tpm_version(s);
>  }
> =20
> +uint32_t tpm_backend_get_buffer_size(TPMBackend *s)

We have a slight preference for size_t in qemu (even if underlying
protocol uses u32)

> +{
> +    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> +
> +    assert(k->get_buffer_size);


No need to have assert here to be consitent with qemu code, however it
is nice to have a comment on the interface declaration instead.

(I considered all function pointers mandatory unless explicitely
marked optional, as in "tpm-be: update optional function pointers")

> +
> +    return k->get_buffer_size(s);
> +}
> +
>  TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
>  {
>      TPMInfo *info =3D g_new0(TPMInfo, 1);
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 24cb611..5a6107e 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -356,6 +356,11 @@ static TPMVersion tpm_emulator_get_tpm_version(TPM=
Backend *tb)
>      return tpm_emu->tpm_version;
>  }
> =20
> +static uint32_t tpm_emulator_get_buffer_size(TPMBackend *tb)
> +{
> +    return 4096;
> +}
> +
>  static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>  {
>      Error *err =3D NULL;
> @@ -556,6 +561,7 @@ static void tpm_emulator_class_init(ObjectClass *kl=
ass, void *data)
>      tbc->get_tpm_established_flag =3D tpm_emulator_get_tpm_established=
_flag;
>      tbc->reset_tpm_established_flag =3D tpm_emulator_reset_tpm_establi=
shed_flag;
>      tbc->get_tpm_version =3D tpm_emulator_get_tpm_version;
> +    tbc->get_buffer_size =3D tpm_emulator_get_buffer_size;
>      tbc->get_tpm_options =3D tpm_emulator_get_tpm_options;
> =20
>      tbc->handle_request =3D tpm_emulator_handle_request;
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 73554aa..7ff9249 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -199,6 +199,11 @@ static TPMVersion tpm_passthrough_get_tpm_version(=
TPMBackend *tb)
>      return tpm_pt->tpm_version;
>  }
> =20
> +static uint32_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
> +{
> +    return 4096;
> +}
> +
>  /*
>   * Unless path or file descriptor set has been provided by user,
>   * determine the sysfs cancel file following kernel documentation
> @@ -354,6 +359,7 @@ static void tpm_passthrough_class_init(ObjectClass =
*klass, void *data)
>      tbc->reset_tpm_established_flag =3D
>          tpm_passthrough_reset_tpm_established_flag;
>      tbc->get_tpm_version =3D tpm_passthrough_get_tpm_version;
> +    tbc->get_buffer_size =3D tpm_passthrough_get_buffer_size;
>      tbc->get_tpm_options =3D tpm_passthrough_get_tpm_options;
>      tbc->handle_request =3D tpm_passthrough_handle_request;
>  }
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index cc32fcd..a3df40f 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -88,6 +88,8 @@ typedef struct TPMState {
> =20
>      TPMBackend *be_driver;
>      TPMVersion be_tpm_version;
> +
> +    uint32_t be_buffer_size;
>  } TPMState;
> =20
>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -977,10 +979,9 @@ static int tpm_tis_do_startup_tpm(TPMState *s)
>      return tpm_backend_startup_tpm(s->be_driver);
>  }
> =20
> -static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb)
> +static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
> +                                   uint32_t wanted_size)
>  {
> -    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
> -
>      if (sb->size !=3D wanted_size) {
>          sb->buffer =3D g_realloc(sb->buffer, wanted_size);
>          sb->size =3D wanted_size;
> @@ -1007,6 +1008,7 @@ static void tpm_tis_reset(DeviceState *dev)
>      int c;
> =20
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> +    s->be_buffer_size =3D tpm_backend_get_buffer_size(s->be_driver);
> =20
>      tpm_backend_reset(s->be_driver);
> =20
> @@ -1033,9 +1035,9 @@ static void tpm_tis_reset(DeviceState *dev)
>          s->loc[c].state =3D TPM_TIS_STATE_IDLE;
> =20
>          s->loc[c].w_offset =3D 0;
> -        tpm_tis_realloc_buffer(&s->loc[c].w_buffer);
> +        tpm_tis_realloc_buffer(&s->loc[c].w_buffer, s->be_buffer_size)=
;
>          s->loc[c].r_offset =3D 0;
> -        tpm_tis_realloc_buffer(&s->loc[c].r_buffer);
> +        tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size)=
;
>      }
> =20
>      tpm_tis_do_startup_tpm(s);
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 590e8b4..d23cef2 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -80,6 +80,7 @@ struct TPMBackendClass {
>      int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
> =20
>      TPMVersion (*get_tpm_version)(TPMBackend *t);
> +    uint32_t (*get_buffer_size)(TPMBackend *t);
> =20
>      TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
> =20
> @@ -183,6 +184,16 @@ int tpm_backend_reset_tpm_established_flag(TPMBack=
end *s, uint8_t locty);
>  TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
> =20
>  /**
> + * tpm_backend_get_buffer_size:
> + * @s: the backend to call into
> + *
> + * Get the TPM's buffer size.
> + *
> + * Returns buffer size.
> + */
> +uint32_t tpm_backend_get_buffer_size(TPMBackend *s);
> +
> +/**
>   * tpm_backend_query_tpm:
>   * @s: the backend
>   *
> --=20
> 2.5.5
>=20
>=20

Looks good to me otherwise,

Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
