Received: from eggs.gnu.org ([2001:4830:134:3::10]:37145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edfPo-00074z-3H
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1edfPm-00034b-HG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:57:48 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1edfPm-000345-7v
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:57:46 -0500
Received: by mail-wr0-x244.google.com with SMTP id g21so9426499wrb.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:57:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8cbe6eed-169d-2158-4d7b-20a1360a0864@linux.vnet.ibm.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-5-marcandre.lureau@redhat.com>
	<f2ecf612-8538-f8d1-ffd8-f875aa453c42@amsat.org>
	<3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
	<CAMxuvaxyBmEEnk_dtFR4qbk_-95ROnR6o-3gR7U=HNJAhV5DdA@mail.gmail.com>
	<6cb2b88f-0c8b-4bab-c8fc-018dd0cbc662@linux.vnet.ibm.com>
	<CAMxuvazYZZwzSBPvbmKLPv_YG2uYPkPA1meiYoMkizegEozC_g@mail.gmail.com>
	<8cbe6eed-169d-2158-4d7b-20a1360a0864@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2018 17:57:43 +0100
Message-ID: <CAJ+F1CKitsfZiTKBi1YooqkLCN1RxHCwBMQYS1W7hsPKB6fKLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Jan 22, 2018 at 4:47 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 01/22/2018 10:08 AM, Marc-Andre Lureau wrote:
>>
>> Hi
>>
>> On Sun, Jan 21, 2018 at 11:01 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> On 01/21/2018 02:24 PM, Marc-Andre Lureau wrote:
>>>>
>>>> Hi
>>>>
>>>> On Sun, Jan 21, 2018 at 6:46 AM, Stefan Berger
>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>>
>>>>> On 01/20/2018 07:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>
>>>>>> On 01/19/2018 11:11 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>>>>>
>>>>>>> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
>>>>>>> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
>>>>>>> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 =
v22.
>>>>>>>
>>>>>>> The PTP allows device implementation to switch between TIS and CRB
>>>>>>> model at run time, but given that CRB is a simpler device to
>>>>>>> implement, I chose to implement it as a different device.
>>>>>>>
>>>>>>> The device doesn't implement other locality than 0 for now (my lapt=
op
>>>>>>> TPM doesn't either, so I assume this isn't so bad)
>>>>>>>
>>>>>>> The command/reply memory region is statically allocated after the C=
RB
>>>>>>> registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
>>>>>>> wonder if the BIOS could or should allocate it instead, or what siz=
e
>>>>>>> to use, again this seems to fit well expectations)
>>>>>>>
>>>>>>> The PTP doesn't specify a particular bus to put the device. So I
>>>>>>> added
>>>>>>> it on the system bus directly, so it could hopefully be used easily
>>>>>>> on
>>>>>>> a different platform than x86. Currently, it fails to init on piix,
>>>>>>> because error_on_sysbus_device() check. The check may be changed in=
 a
>>>>>>> near future, see discussion on the qemu-devel ML.
>>>>>>>
>>>>>>> Tested with some success with Linux upstream and Windows 10, seabio=
s
>>>>>>> &
>>>>>>> modified ovmf. The device is recognized and correctly transmit
>>>>>>> command/response with passthrough & emu. However, we are missing PP=
I
>>>>>>> ACPI part atm.
>>>>>>>
>>>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>>> ---
>>>>>>>     qapi/tpm.json                      |   5 +-
>>>>>>>     include/hw/acpi/tpm.h              |  72 ++++++++
>>>>>>>     include/sysemu/tpm.h               |   3 +
>>>>>>>     hw/i386/acpi-build.c               |  34 +++-
>>>>>>>     hw/tpm/tpm_crb.c                   | 327
>>>>>>> +++++++++++++++++++++++++++++++++++++
>>>>>>>     default-configs/i386-softmmu.mak   |   1 +
>>>>>>>     default-configs/x86_64-softmmu.mak |   1 +
>>>>>>>     hw/tpm/Makefile.objs               |   1 +
>>>>>>>     8 files changed, 434 insertions(+), 10 deletions(-)
>>>>>>>     create mode 100644 hw/tpm/tpm_crb.c
>>>>>>>
>>>>>>> diff --git a/qapi/tpm.json b/qapi/tpm.json
>>>>>>> index 7093f268fb..d50deef5e9 100644
>>>>>>> --- a/qapi/tpm.json
>>>>>>> +++ b/qapi/tpm.json
>>>>>>> @@ -11,10 +11,11 @@
>>>>>>>     # An enumeration of TPM models
>>>>>>>     #
>>>>>>>     # @tpm-tis: TPM TIS model
>>>>>>> +# @tpm-crb: TPM CRB model (since 2.12)
>>>>>>>     #
>>>>>>>     # Since: 1.5
>>>>>>>     ##
>>>>>>> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
>>>>>>> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
>>>>>>>       ##
>>>>>>>     # @query-tpm-models:
>>>>>>> @@ -28,7 +29,7 @@
>>>>>>>     # Example:
>>>>>>>     #
>>>>>>>     # -> { "execute": "query-tpm-models" }
>>>>>>> -# <- { "return": [ "tpm-tis" ] }
>>>>>>> +# <- { "return": [ "tpm-tis", "tpm-crb" ] }
>>>>>>>     #
>>>>>>>     ##
>>>>>>>     { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
>>>>>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>>>>>> index 6d516c6a7f..b0048515fa 100644
>>>>>>> --- a/include/hw/acpi/tpm.h
>>>>>>> +++ b/include/hw/acpi/tpm.h
>>>>>>> @@ -16,11 +16,82 @@
>>>>>>>     #ifndef HW_ACPI_TPM_H
>>>>>>>     #define HW_ACPI_TPM_H
>>>>>>>     +#include "qemu/osdep.h"
>>>>>>> +
>>>>>>>     #define TPM_TIS_ADDR_BASE           0xFED40000
>>>>>>>     #define TPM_TIS_ADDR_SIZE           0x5000
>>>>>>>       #define TPM_TIS_IRQ                 5
>>>>>>>     +struct crb_regs {
>>>>>>> +    union {
>>>>>>> +        uint32_t reg;
>>>>>>> +        struct {
>>>>>>> +            unsigned tpm_established:1;
>>>>>>> +            unsigned loc_assigned:1;
>>>>>>> +            unsigned active_locality:3;
>>>>>>> +            unsigned reserved:2;
>>>>>>> +            unsigned tpm_reg_valid_sts:1;
>>>>>>> +        } bits;
>>>>>>
>>>>>> I suppose this is little-endian layout, so this won't work on
>>>>>> big-endian
>>>>>> hosts.
>>>>>>
>>>>>> Can you add a qtest?
>>>>>>
>>>>>>> +    } loc_state;
>>>>>>> +    uint32_t reserved1;
>>>>>>> +    uint32_t loc_ctrl;
>>>>>>> +    union {
>>>>>>> +        uint32_t reg;
>>>>>>> +        struct {
>>>>>>> +            unsigned granted:1;
>>>>>>> +            unsigned been_seized:1;
>>>>>>> +        } bits;
>>>>>>
>>>>>>
>>>>>> This is unclear where you expect those bits (right/left aligned).
>>>>>>
>>>>>> Can you add an unnamed field to be more explicit?
>>>>>>
>>>>>> i.e. without using struct if left alignment expected:
>>>>>>
>>>>>>               unsigned granted:1, been_seized:1, :30;
>>>>>
>>>>>
>>>>>
>>>>> I got rid of all the bitfields and this patch here makes it work on a
>>>>> ppc64
>>>>> big endian and also x86_64 host:
>>>>>
>>>>>
>>>>>
>>>>> https://github.com/stefanberger/qemu-tpm/commit/28fc07f0d931416898619=
0effd6d72d9fd3972dd
>>>>>
>>>> Thank you Stefan! I am all for squashing this fix to the patch. You
>>>> should then add your signed-off to the commit.
>>>
>>>
>>> I'll do that.
>>>
>>> The TIS is an ISA Device and the CRB is similar. Considering the
>>
>> How much similarity is there between TIS and CRB is there? The two
>> devices look quite different to me, CRB is way simpler it seems. Or is
>> the CRB implementation just lacking many bells and whistles that TIS
>> has? Should we consider merging CRB in TIS?
>
>
> That is the question. It would be a pain for users to have to choose the
> interface. Basically TIS and CRB can be implemented in a single device an=
d
> let the software choose the interface following flags that are set by the
> interface advertising whether it offers TIS and/or CRB. Maybe we could ke=
ep
> the CRB code in a separate file and, upon choosing the CRB interface call
> into CRB functions rather than TIS functions.

Afaik, most people want to use TPM2, either with Linux or Windows, and
CRB fits that job better at least on Windows. So unless TPM 1.2 and
legacy OS is required, I would recommend to use CRB only.

If there is a need to grow dynamic TIS/CRB switching, I would teach
the existing TIS device to call into CRB, as you proposed. In the
meantime, I think it's best to have a simple CRB-only device that is
known to work with latest Linux & Windows.




--=20
Marc-Andr=C3=A9 Lureau
