Received: from eggs.gnu.org ([2001:4830:134:3::10]:54435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erhBQ-000634-Qd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erhBP-0007Uu-RN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:40:56 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1erhBP-0007UB-Iy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:40:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so1873329wmt.5
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 01:40:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 2 Mar 2018 10:40:53 +0100
Message-ID: <CAJ+F1CJH95NmOa2VRdLxSNgbpdy6TEm5DoFBZmZruiS2zoFO-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] tpm: extend TPM TIS with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Mar 1, 2018 at 8:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Extend the TPM TIS interface with state migration support.
>
> We need to synchronize with the backend thread to make sure that a comman=
d
> being processed by the external TPM emulator has completed and its
> response been received.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 834eef7..5016d28 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -902,9 +902,61 @@ static void tpm_tis_reset(DeviceState *dev)
>      tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
>  }
>
> +/* persistent state handling */
> +
> +static int tpm_tis_pre_save(void *opaque)
> +{
> +    TPMState *s =3D opaque;
> +    uint8_t locty =3D s->active_locty;
> +
> +    DPRINTF("tpm_tis: suspend: locty =3D %d : rw_offset =3D %u\n",

suspend -> pre_save ?

> +            locty, s->rw_offset);
> +#ifdef DEBUG_TIS
> +    tpm_tis_dump_state(opaque, 0);
> +#endif

To avoid dead code, you could write:

if (DEBUG_TIS) {
...
}


> +
> +    /*
> +     * Synchronize with backend completion.
> +     */
> +    tpm_backend_finish_sync(s->be_driver);
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_locty =3D {
> +    .name =3D "loc",

I would use a more descriptive name, such as "tpm-tis/locty"

> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,

It's the first version, make it all 0.

> +    .minimum_version_id_old =3D 0,

not needed

> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_UINT32(state, TPMLocality),
> +        VMSTATE_UINT32(inte, TPMLocality),
> +        VMSTATE_UINT32(ints, TPMLocality),
> +        VMSTATE_UINT8(access, TPMLocality),
> +        VMSTATE_UINT32(sts, TPMLocality),
> +        VMSTATE_UINT32(iface_id, TPMLocality),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
>  static const VMStateDescription vmstate_tpm_tis =3D {
>      .name =3D "tpm",

It's time to use a more specific name "tpm-tis" ?

> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,

It's the first version, make it all 0.

> +    .minimum_version_id_old =3D 0,

not needed

> +    .pre_save  =3D tpm_tis_pre_save,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BUFFER(buffer, TPMState),
> +        VMSTATE_UINT16(rw_offset, TPMState),
> +        VMSTATE_UINT8(active_locty, TPMState),
> +        VMSTATE_UINT8(aborting_locty, TPMState),
> +        VMSTATE_UINT8(next_locty, TPMState),
> +
> +        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 1,
> +                             vmstate_locty, TPMLocality),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
>  };
>
>  static Property tpm_tis_properties[] =3D {
> --
> 2.5.5
>
>

looks good otherwise

--=20
Marc-Andr=C3=A9 Lureau
