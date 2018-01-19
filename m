Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecXwj-0002pI-Lr
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecXwf-0004Te-Nf
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:47:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ecXwf-0004TO-Eh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:47:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JEiwvb143617
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:47:03 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkh29mn3k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:47:03 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 07:47:02 -0700
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-6-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 09:46:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180119141105.29095-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b6e8f769-9e6d-1b40-93d0-36ab094e3ed5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tpm: extend TPM CRB with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> We need to synchronize with the backend thread to make sure that a comm=
and
> being processed by the external TPM emulator has completed and its
> response been received. In case the bottom half did not run, we run the
> function it is supposed to run.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> [ Marc-Andr=C3=A9 - drop memory_region_get_ram_ptr(cmdmem) copy as it
>    should be migrated already ]
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I think we need to delay this until the PPI device has been added since=20
this will extend the state of the CRB.


> ---
>   hw/tpm/tpm_crb.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 908ca18d92..63d53384c5 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -257,9 +257,39 @@ static enum TPMVersion tpm_crb_get_version(TPMIf *=
ti)
>       return tpm_backend_get_tpm_version(s->tpmbe);
>   }
>
> +/* persistent state handling */
> +
> +static int tpm_crb_pre_save(void *opaque)
> +{
> +    CRBState *s =3D opaque;
> +
> +    tpm_backend_finish_sync(s->tpmbe);
> +
> +    return 0;
> +}
> +
>   static const VMStateDescription vmstate_tpm_crb =3D {
>       .name =3D "tpm-crb",
> -    .unmigratable =3D 1,
> +    .pre_save  =3D tpm_crb_pre_save,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_UINT32(regs.loc_state.reg, CRBState),
> +        VMSTATE_UINT32(regs.loc_ctrl, CRBState),
> +        VMSTATE_UINT32(regs.loc_sts.reg, CRBState),
> +        VMSTATE_UINT64(regs.intf_id.reg, CRBState),
> +        VMSTATE_UINT64(regs.ctrl_ext, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_req, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_sts.reg, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_cancel, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_start, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_int_enable, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_int_sts, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_cmd_size, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_cmd_pa_low, CRBState),
> +        VMSTATE_UINT32(regs.ctrl_rsp_size, CRBState),
> +        VMSTATE_UINT64(regs.ctrl_rsp_pa, CRBState),
> +
> +        VMSTATE_END_OF_LIST(),
> +    }
>   };
>
>   static Property tpm_crb_properties[] =3D {
