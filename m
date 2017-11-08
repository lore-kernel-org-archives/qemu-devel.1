Received: from eggs.gnu.org ([2001:4830:134:3::10]:47095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT7k-0008Vu-I6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT7f-0001Iq-Ip
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eCT7f-0001IT-8G
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:22:39 -0500
Date: Wed, 8 Nov 2017 17:22:31 +0100
From: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20171108162231.GE13150@boraha>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-5-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1510016336-4086-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] tpm: tpm_emulator: get and set buffer
 size of device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, amarnath.valluri@intel.com

On Mon, Nov 06, 2017 at 07:58:55PM -0500, Stefan Berger wrote:
> Convert the tpm_emulator backend to get the current buffer size
> of the external device and set it to the buffer size that the
> frontend (TIS) requests.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  backends/tpm.c               |  4 +--
>  hw/tpm/tpm_emulator.c        | 79 ++++++++++++++++++++++++++++++++++++=
+++++---
>  hw/tpm/tpm_ioctl.h           | 28 +++++++++++++++-
>  hw/tpm/tpm_tis.c             |  6 ++--
>  include/sysemu/tpm_backend.h |  6 ++--
>  5 files changed, 111 insertions(+), 12 deletions(-)
>=20
> diff --git a/backends/tpm.c b/backends/tpm.c
> index e7d0f9a..f024c27 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -68,7 +68,7 @@ int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Err=
or **errp)
>      return 0;
>  }
> =20
> -int tpm_backend_startup_tpm(TPMBackend *s)
> +int tpm_backend_startup_tpm(TPMBackend *s, uint32_t buffersize)
>  {
>      int res =3D 0;
>      TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> @@ -79,7 +79,7 @@ int tpm_backend_startup_tpm(TPMBackend *s)
>      s->thread_pool =3D g_thread_pool_new(tpm_backend_worker_thread, s,=
 1, TRUE,
>                                         NULL);
> =20
> -    res =3D k->startup_tpm ? k->startup_tpm(s) : 0;
> +    res =3D k->startup_tpm ? k->startup_tpm(s, buffersize) : 0;
> =20
>      s->had_startup_error =3D (res !=3D 0);
> =20
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 5a6107e..a16de7a 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -232,13 +232,14 @@ static int tpm_emulator_check_caps(TPMEmulator *t=
pm_emu)
>      switch (tpm_emu->tpm_version) {
>      case TPM_VERSION_1_2:
>          caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTA=
BLISHED |
> -               PTM_CAP_SET_LOCALITY | PTM_CAP_SET_DATAFD;
> +               PTM_CAP_SET_LOCALITY | PTM_CAP_SET_DATAFD | PTM_CAP_STO=
P |
> +               PTM_CAP_SET_BUFFERSIZE;
>          tpm =3D "1.2";
>          break;
>      case TPM_VERSION_2_0:
>          caps =3D PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTA=
BLISHED |
>                 PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED |
> -               PTM_CAP_SET_DATAFD;
> +               PTM_CAP_SET_DATAFD | PTM_CAP_STOP | PTM_CAP_SET_BUFFERS=
IZE;
>          tpm =3D "2";
>          break;
>      case TPM_VERSION_UNSPEC:
> @@ -255,12 +256,76 @@ static int tpm_emulator_check_caps(TPMEmulator *t=
pm_emu)
>      return 0;
>  }
> =20
> -static int tpm_emulator_startup_tpm(TPMBackend *tb)
> +static int tpm_emulator_stop_tpm(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> +    ptm_res res;
> +
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0, sizeof(res)) =
< 0) {
> +        error_report("tpm-emulator: Could not stop TPM: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    res =3D be32_to_cpu(res);
> +    if (res) {
> +        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", re=
s);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_set_buffer_size(TPMBackend *tb,
> +                                        uint32_t wanted_size,
> +                                        uint32_t *actual_size)
> +{
> +    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> +    ptm_setbuffersize psbs;
> +
> +    if (tpm_emulator_stop_tpm(tb) < 0) {
> +        return -1;
> +    }
> +
> +    psbs.u.req.buffersize =3D cpu_to_be32(wanted_size);
> +
> +    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
> +                             sizeof(psbs.u.req), sizeof(psbs.u.resp)) =
< 0) {
> +        error_report("tpm-emulator: Could not set buffer size: %s",
> +                     strerror(errno));
> +        return -1;
> +    }
> +
> +    psbs.u.resp.tpm_result =3D be32_to_cpu(psbs.u.resp.tpm_result);
> +    if (psbs.u.resp.tpm_result !=3D 0) {
> +        error_report("tpm-emulator: TPM result for set buffer size : 0=
x%x",
> +                     psbs.u.resp.tpm_result);
> +        return -1;
> +    }
> +
> +    if (actual_size) {
> +        *actual_size =3D be32_to_cpu(psbs.u.resp.buffersize);
> +    }
> +
> +    DPRINTF("buffer size: %u, min: %u, max: %u\n",
> +            be32_to_cpu(psbs.u.resp.buffersize),
> +            be32_to_cpu(psbs.u.resp.minsize),
> +            be32_to_cpu(psbs.u.resp.maxsize));
> +
> +    return 0;
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb, uint32_t buffersiz=
e)
>  {
>      TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>      ptm_init init;
>      ptm_res res;
> =20
> +    if (buffersize !=3D 0 &&
> +        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
> +        goto err_exit;
> +    }
> +
>      DPRINTF("%s", __func__);
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>                               sizeof(init)) < 0) {
> @@ -358,7 +423,13 @@ static TPMVersion tpm_emulator_get_tpm_version(TPM=
Backend *tb)
> =20
>  static uint32_t tpm_emulator_get_buffer_size(TPMBackend *tb)
>  {
> -    return 4096;
> +    uint32_t actual_size;
> +
> +    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
> +        return 4096;
> +    }
> +
> +    return actual_size;
>  }
> =20
>  static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
> diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
> index 33564b1..54c8d34 100644
> --- a/hw/tpm/tpm_ioctl.h
> +++ b/hw/tpm/tpm_ioctl.h
> @@ -169,6 +169,28 @@ struct ptm_getconfig {
>  #define PTM_CONFIG_FLAG_FILE_KEY        0x1
>  #define PTM_CONFIG_FLAG_MIGRATION_KEY   0x2
> =20
> +/*
> + * PTM_SET_BUFFERSIZE: Set the buffer size to be used by the TPM.
> + * A 0 on input queries for the current buffer size. Any other
> + * number will try to set the buffer size. The returned number is
> + * the buffer size that will be used, which can be larger than the
> + * requested one, if it was below the minimum, or smaller than the
> + * requested one, if it was above the maximum.
> + */
> +struct ptm_setbuffersize {
> +    union {
> +        struct {
> +            uint32_t buffersize; /* 0 to query for current buffer size=
 */
> +        } req; /* request */
> +        struct {
> +            ptm_res tpm_result;
> +            uint32_t buffersize; /* buffer size in use */
> +            uint32_t minsize; /* min. supported buffer size */
> +            uint32_t maxsize; /* max. supported buffer size */
> +        } resp; /* response */
> +    } u;
> +};
> +
> =20
>  typedef uint64_t ptm_cap;
>  typedef struct ptm_est ptm_est;
> @@ -179,6 +201,7 @@ typedef struct ptm_init ptm_init;
>  typedef struct ptm_getstate ptm_getstate;
>  typedef struct ptm_setstate ptm_setstate;
>  typedef struct ptm_getconfig ptm_getconfig;
> +typedef struct ptm_setbuffersize ptm_setbuffersize;
> =20
>  /* capability flags returned by PTM_GET_CAPABILITY */
>  #define PTM_CAP_INIT               (1)
> @@ -194,6 +217,7 @@ typedef struct ptm_getconfig ptm_getconfig;
>  #define PTM_CAP_STOP               (1 << 10)
>  #define PTM_CAP_GET_CONFIG         (1 << 11)
>  #define PTM_CAP_SET_DATAFD         (1 << 12)
> +#define PTM_CAP_SET_BUFFERSIZE     (1 << 13)
> =20
>  enum {
>      PTM_GET_CAPABILITY     =3D _IOR('P', 0, ptm_cap),
> @@ -212,6 +236,7 @@ enum {
>      PTM_STOP               =3D _IOR('P', 13, ptm_res),
>      PTM_GET_CONFIG         =3D _IOR('P', 14, ptm_getconfig),
>      PTM_SET_DATAFD         =3D _IOR('P', 15, ptm_res),
> +    PTM_SET_BUFFERSIZE     =3D _IOWR('P', 16, ptm_setbuffersize),
>  };
> =20
>  /*
> @@ -240,7 +265,8 @@ enum {
>      CMD_SET_STATEBLOB,
>      CMD_STOP,
>      CMD_GET_CONFIG,
> -    CMD_SET_DATAFD
> +    CMD_SET_DATAFD,
> +    CMD_SET_BUFFERSIZE,
>  };
> =20
>  #endif /* _TPM_IOCTL_H */
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index a3df40f..8d7310e 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -974,9 +974,9 @@ static const MemoryRegionOps tpm_tis_memory_ops =3D=
 {
>      },
>  };
> =20
> -static int tpm_tis_do_startup_tpm(TPMState *s)
> +static int tpm_tis_do_startup_tpm(TPMState *s, uint32_t buffersize)
>  {
> -    return tpm_backend_startup_tpm(s->be_driver);
> +    return tpm_backend_startup_tpm(s->be_driver, buffersize);
>  }
> =20
>  static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
> @@ -1040,7 +1040,7 @@ static void tpm_tis_reset(DeviceState *dev)
>          tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size)=
;
>      }
> =20
> -    tpm_tis_do_startup_tpm(s);
> +    tpm_tis_do_startup_tpm(s, s->be_buffer_size);

It is a bit convoluted: get the buffer size from the backend to give
it back to startup, perhaps use 0/default value to make it more
explicit it doesn't intend to change it.

>  }
> =20
>  static const VMStateDescription vmstate_tpm_tis =3D {
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index d23cef2..3978d98 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -66,7 +66,7 @@ struct TPMBackendClass {
>      TPMBackend *(*create)(QemuOpts *opts);
> =20
>      /* start up the TPM on the backend - optional */
> -    int (*startup_tpm)(TPMBackend *t);
> +    int (*startup_tpm)(TPMBackend *t, uint32_t buffersize);
> =20
>      /* optional */
>      void (*reset)(TPMBackend *t);
> @@ -111,10 +111,12 @@ int tpm_backend_init(TPMBackend *s, TPMIf *tpmif,=
 Error **errp);
>  /**
>   * tpm_backend_startup_tpm:
>   * @s: the backend whose TPM support is to be started
> + * @buffersize: the buffer size the TPM is supposed to use,
> + *              0 to leave it as-is
>   *
>   * Returns 0 on success.
>   */
> -int tpm_backend_startup_tpm(TPMBackend *s);
> +int tpm_backend_startup_tpm(TPMBackend *s, uint32_t buffersize);
> =20
>  /**
>   * tpm_backend_had_startup_error:
> --=20
> 2.5.5
>=20
>=20

looks ok overall,

Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
