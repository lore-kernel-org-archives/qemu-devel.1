Received: from eggs.gnu.org ([2001:4830:134:3::10]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEmJW-0004tS-45
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEmJS-00019m-TT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:16:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEmJS-00018m-Kt
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:16:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAF1F0gF038018
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:16:15 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e89j44wen-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:16:15 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 18:16:14 -0700
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKE1-ApZ9MF2njB-0yiaszqJFZPVTfGQHg0YYgsuhwhnw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 20:16:12 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKE1-ApZ9MF2njB-0yiaszqJFZPVTfGQHg0YYgsuhwhnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d670c086-f0f8-8906-795e-80345ec8475a@linux.vnet.ibm.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 11/14/2017 06:40 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Add a caching layer for the TPM established flag so that we don't
>> need to go to the emulator every time the flag is read by accessing
>> the REG_ACCESS register.
> What's the impact? Isn't this just a "small" optimization? Iotw, why
> is this for-2.11?

The TIS has a register that contains this flag and that's being polled=20
quite frequently. So it generates a lot of traffic to the emulator. This=20
caching layer gets rid of most of the traffic.

    Stefan

>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> v1->v2:
>>   - move the caching to the backend layer since detecting the
>>     TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
>>     here.
>> ---
>>   hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> index e1a6810..b293db7 100644
>> --- a/hw/tpm/tpm_emulator.c
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -73,6 +73,9 @@ typedef struct TPMEmulator {
>>       Error *migration_blocker;
>>
>>       QemuMutex mutex;
>> +
>> +    unsigned int established_flag:1;
>> +    unsigned int established_flag_cached:1;
>>   } TPMEmulator;
>>
>>
>> @@ -287,16 +290,22 @@ static bool tpm_emulator_get_tpm_established_fla=
g(TPMBackend *tb)
>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>       ptm_est est;
>>
>> -    DPRINTF("%s", __func__);
>> +    if (tpm_emu->established_flag_cached) {
>> +        return tpm_emu->established_flag;
>> +    }
>> +
>>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
>>                                0, sizeof(est)) < 0) {
>>           error_report("tpm-emulator: Could not get the TPM establishe=
d flag: %s",
>>                        strerror(errno));
>>           return false;
>>       }
>> -    DPRINTF("established flag: %0x", est.u.resp.bit);
>> +    DPRINTF("got established flag: %0x", est.u.resp.bit);
>> +
>> +    tpm_emu->established_flag_cached =3D 1;
>> +    tpm_emu->established_flag =3D (est.u.resp.bit !=3D 0);
>>
>> -    return (est.u.resp.bit !=3D 0);
>> +    return tpm_emu->established_flag;
>>   }
>>
>>   static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>> @@ -327,6 +336,8 @@ static int tpm_emulator_reset_tpm_established_flag=
(TPMBackend *tb,
>>           return -1;
>>       }
>>
>> +    tpm_emu->established_flag_cached =3D 0;
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.5.5
>>
>
>
