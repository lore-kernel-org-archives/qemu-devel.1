Received: from eggs.gnu.org ([2001:4830:134:3::10]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyiN5-0004nF-CU
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyiN0-00059D-Ag
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:21:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyiN0-000590-5m
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:21:54 -0400
Date: Wed, 21 Mar 2018 18:21:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180321182135.GH3465@work-vm>
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521253498-6834-3-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1521253498-6834-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 2/4] tpm: extend TPM TIS with
 state migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

* Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> Extend the TPM TIS interface with state migration support.
>=20
> We need to synchronize with the backend thread to make sure that a command
> being processed by the external TPM emulator has completed and its
> response been received.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  hw/tpm/trace-events |  1 +
>  2 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 2ac7e74..fec3d73 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -894,9 +894,57 @@ static void tpm_tis_reset(DeviceState *dev)
>      tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
>  }
> =20
> +/* persistent state handling */
> +
> +static int tpm_tis_pre_save(void *opaque)
> +{
> +    TPMState *s =3D opaque;
> +    uint8_t locty =3D s->active_locty;
> +
> +    trace_tpm_tis_pre_save(locty, s->rw_offset);
> +
> +    if (DEBUG_TIS) {
> +        tpm_tis_dump_state(opaque, 0);
> +    }
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
> +    .name =3D "tpm-tis/locty",
> +    .version_id =3D 1,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_UINT32(state, TPMLocality),

I was a little worried with that being an enum, but I'm told
we're OK assuming enum's come out as UINT32's; so:

=66rom the migration code side,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> -    .name =3D "tpm",
> -    .unmigratable =3D 1,
> +    .name =3D "tpm-tis",
> +    .version_id =3D 1,
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
> =20
>  static Property tpm_tis_properties[] =3D {
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index c5bfbf1..25bee0c 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -50,3 +50,4 @@ tpm_tis_mmio_write_locty_seized(uint8_t locty, uint8_t =
active) "Locality %d seiz
>  tpm_tis_mmio_write_init_abort(void) "Initiating abort"
>  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
>  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to sen=
d to TPM: 0x%08x (size=3D%d)"
> +tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offse=
t =3D %u"
> --=20
> 2.5.5
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
