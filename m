Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEofo-0003ON-TV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEofn-0002bv-RY
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:47:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEofn-0002bL-Jj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:47:35 -0500
Received: by mail-wm0-x243.google.com with SMTP id n74so20175251wmi.1
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 19:47:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d670c086-f0f8-8906-795e-80345ec8475a@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKE1-ApZ9MF2njB-0yiaszqJFZPVTfGQHg0YYgsuhwhnw@mail.gmail.com>
	<d670c086-f0f8-8906-795e-80345ec8475a@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Nov 2017 04:47:33 +0100
Message-ID: <CAJ+F1C+4Ab_+DpUNbEf+kZPZ=T26tA0tNxQD4JWpc1+mmiKK-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 1/3] tpm_emulator: Add a
 caching layer for the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi

On Wed, Nov 15, 2017 at 2:16 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 11/14/2017 06:40 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi
>>
>> On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> Add a caching layer for the TPM established flag so that we don't
>>> need to go to the emulator every time the flag is read by accessing
>>> the REG_ACCESS register.
>>
>> What's the impact? Isn't this just a "small" optimization? Iotw, why
>> is this for-2.11?
>
>
> The TIS has a register that contains this flag and that's being polled qu=
ite
> frequently. So it generates a lot of traffic to the emulator. This cachin=
g
> layer gets rid of most of the traffic.

I didn't notice any problem when doing my tests, I guess Amarnath
niether. perhaps it's best to delay for after 2.11.

>    Stefan
>
>
>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>
>>> v1->v2:
>>>   - move the caching to the backend layer since detecting the
>>>     TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
>>>     here.
>>> ---
>>>   hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
>>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>>> index e1a6810..b293db7 100644
>>> --- a/hw/tpm/tpm_emulator.c
>>> +++ b/hw/tpm/tpm_emulator.c
>>> @@ -73,6 +73,9 @@ typedef struct TPMEmulator {
>>>       Error *migration_blocker;
>>>
>>>       QemuMutex mutex;
>>> +
>>> +    unsigned int established_flag:1;
>>> +    unsigned int established_flag_cached:1;
>>>   } TPMEmulator;
>>>
>>>
>>> @@ -287,16 +290,22 @@ static bool
>>> tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>>       ptm_est est;
>>>
>>> -    DPRINTF("%s", __func__);
>>> +    if (tpm_emu->established_flag_cached) {
>>> +        return tpm_emu->established_flag;
>>> +    }
>>> +
>>>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
>>>                                0, sizeof(est)) < 0) {
>>>           error_report("tpm-emulator: Could not get the TPM established
>>> flag: %s",
>>>                        strerror(errno));
>>>           return false;
>>>       }
>>> -    DPRINTF("established flag: %0x", est.u.resp.bit);
>>> +    DPRINTF("got established flag: %0x", est.u.resp.bit);
>>> +
>>> +    tpm_emu->established_flag_cached =3D 1;
>>> +    tpm_emu->established_flag =3D (est.u.resp.bit !=3D 0);
>>>
>>> -    return (est.u.resp.bit !=3D 0);
>>> +    return tpm_emu->established_flag;
>>>   }
>>>
>>>   static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>>> @@ -327,6 +336,8 @@ static int
>>> tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>>>           return -1;
>>>       }
>>>
>>> +    tpm_emu->established_flag_cached =3D 0;
>>> +
>>>       return 0;
>>>   }
>>>
>>> --
>>> 2.5.5
>>>
>>
>>
>



--=20
Marc-Andr=C3=A9 Lureau
