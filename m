Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1b0z-0007WP-17
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1b0y-0007w8-2o
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:07:05 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:53321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1b0x-0007uu-RZ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:07:04 -0400
Received: by mail-wm0-x235.google.com with SMTP id p9so11950284wmc.3
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 10:07:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <944288fa-05f1-7ed1-b35d-f7010d28d4c9@linux.vnet.ibm.com>
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAMxuvaxDVJxH0BwdtdqgvCUpOzaFf_0NsjvjQnceVjeO5dDhbQ@mail.gmail.com>
	<944288fa-05f1-7ed1-b35d-f7010d28d4c9@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Mar 2018 19:07:01 +0200
Message-ID: <CAJ+F1CLvt9Uirf+DmF7KQLA0-eN5cHzd=ar8igMmJ5ZGi3cpVQ@mail.gmail.com>
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

On Thu, Mar 29, 2018 at 1:56 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 03/28/2018 11:41 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi
>>
>> On Thu, Mar 1, 2018 at 8:59 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> +
>>> +static const VMStateDescription vmstate_locty =3D {
>>> +    .name =3D "loc",
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 0,
>>> +    .minimum_version_id_old =3D 0,
>>
>> I don't understand the problem there is leaving all the version fields
>> to 0, just like CRB.
>>
>>> +    .fields      =3D (VMStateField[]) {
>>> +        VMSTATE_UINT32(state, TPMLocality),
>>> +        VMSTATE_UINT32(inte, TPMLocality),
>>> +        VMSTATE_UINT32(ints, TPMLocality),
>>> +        VMSTATE_UINT8(access, TPMLocality),
>>> +        VMSTATE_UINT32(sts, TPMLocality),
>>> +        VMSTATE_UINT32(iface_id, TPMLocality),
>>> +        VMSTATE_END_OF_LIST(),
>>> +    }
>>> +};
>>> +
>>>   static const VMStateDescription vmstate_tpm_tis =3D {
>>>       .name =3D "tpm",
>>> -    .unmigratable =3D 1,
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 0,
>>> +    .minimum_version_id_old =3D 0,
>>
>> same
>>
>> If you remove the version fields: Reviewed-by: Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com>
>
>
> This is the error I got when setting .version_id =3D 0 (on both) and doin=
g a
> localhost migration
>
> qemu-system-x86_64: Missing section footer for tpm-tis
> qemu-system-x86_64: load of migration failed: Invalid argument

It's clearly not the most friendly error message, but I debugged it,
you just have to specify the right version for VMSTATE_STRUCT_ARRAY:
0.
        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 0,
                             vmstate_locty, TPMLocality),

Then it all works with version 0 (or default value)

thanks
>
> It must have something to do with the nesting invoked by
> VMSTATE_STRUCT_ARRAY(loc,...) below.
>
>
>
>
>>
>>
>>
>>> +    .pre_save  =3D tpm_tis_pre_save,
>>> +    .fields =3D (VMStateField[]) {
>>> +        VMSTATE_BUFFER(buffer, TPMState),
>>> +        VMSTATE_UINT16(rw_offset, TPMState),
>>> +        VMSTATE_UINT8(active_locty, TPMState),
>>> +        VMSTATE_UINT8(aborting_locty, TPMState),
>>> +        VMSTATE_UINT8(next_locty, TPMState),
>>> +
>>> +        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 1,
>>> +                             vmstate_locty, TPMLocality),
>>> +
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>>   };
>>>
>>>   static Property tpm_tis_properties[] =3D {
>>> --
>>> 2.5.5
>>>
>
>



--=20
Marc-Andr=C3=A9 Lureau
