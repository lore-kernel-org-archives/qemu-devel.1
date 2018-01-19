Received: from eggs.gnu.org ([2001:4830:134:3::10]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecXz4-00043z-Jt
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecXz3-0005y8-Pu
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:49:34 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ecXz3-0005xf-Ia
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:49:33 -0500
Received: by mail-wm0-x243.google.com with SMTP id 141so4019895wme.3
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:49:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b6e8f769-9e6d-1b40-93d0-36ab094e3ed5@linux.vnet.ibm.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-6-marcandre.lureau@redhat.com>
	<b6e8f769-9e6d-1b40-93d0-36ab094e3ed5@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 19 Jan 2018 15:49:31 +0100
Message-ID: <CAJ+F1CLqMJFz6DH-uedhu=CbY2NK1VNAb+WkodYfXo8FSh5p+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Jan 19, 2018 at 3:46 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> We need to synchronize with the backend thread to make sure that a comma=
nd
>> being processed by the external TPM emulator has completed and its
>> response been received. In case the bottom half did not run, we run the
>> function it is supposed to run.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> [ Marc-Andr=C3=A9 - drop memory_region_get_ram_ptr(cmdmem) copy as it
>>    should be migrated already ]
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> I think we need to delay this until the PPI device has been added since t=
his
> will extend the state of the CRB.
>

That makes sense, I'll hand it back to you then :)

>
>
>> ---
>>   hw/tpm/tpm_crb.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index 908ca18d92..63d53384c5 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -257,9 +257,39 @@ static enum TPMVersion tpm_crb_get_version(TPMIf *t=
i)
>>       return tpm_backend_get_tpm_version(s->tpmbe);
>>   }
>>
>> +/* persistent state handling */
>> +
>> +static int tpm_crb_pre_save(void *opaque)
>> +{
>> +    CRBState *s =3D opaque;
>> +
>> +    tpm_backend_finish_sync(s->tpmbe);
>> +
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_tpm_crb =3D {
>>       .name =3D "tpm-crb",
>> -    .unmigratable =3D 1,
>> +    .pre_save  =3D tpm_crb_pre_save,
>> +    .fields      =3D (VMStateField[]) {
>> +        VMSTATE_UINT32(regs.loc_state.reg, CRBState),
>> +        VMSTATE_UINT32(regs.loc_ctrl, CRBState),
>> +        VMSTATE_UINT32(regs.loc_sts.reg, CRBState),
>> +        VMSTATE_UINT64(regs.intf_id.reg, CRBState),
>> +        VMSTATE_UINT64(regs.ctrl_ext, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_req, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_sts.reg, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_cancel, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_start, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_int_enable, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_int_sts, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_cmd_size, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_cmd_pa_low, CRBState),
>> +        VMSTATE_UINT32(regs.ctrl_rsp_size, CRBState),
>> +        VMSTATE_UINT64(regs.ctrl_rsp_pa, CRBState),
>> +
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>>   };
>>
>>   static Property tpm_crb_properties[] =3D {
>
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
