Received: from eggs.gnu.org ([2001:4830:134:3::10]:58883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1DCy-0001Kd-B8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1DCv-0002bn-8D
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:41:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f1DCv-0002bQ-2q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:41:49 -0400
Received: by mail-it0-f66.google.com with SMTP id c1-v6so4202508itj.1
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 08:41:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 17:41:47 +0200
Message-ID: <CAMxuvaxDVJxH0BwdtdqgvCUpOzaFf_0NsjvjQnceVjeO5dDhbQ@mail.gmail.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>

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
> +            locty, s->rw_offset);
> +#ifdef DEBUG_TIS
> +    tpm_tis_dump_state(opaque, 0);
> +#endif
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
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,

I don't understand the problem there is leaving all the version fields
to 0, just like CRB.

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
> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,

same

If you remove the version fields: Reviewed-by: Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com>



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
