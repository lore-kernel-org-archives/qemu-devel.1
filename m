Received: from eggs.gnu.org ([2001:4830:134:3::10]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCnQX-0005u2-RG
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCnQT-0002ar-4J
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:03:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCnQS-0002aZ-Rq
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:03:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA9E2lMT080787
	for <qemu-devel@nongnu.org>; Thu, 9 Nov 2017 09:03:23 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e4n77tqxp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 09:03:21 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 9 Nov 2017 07:03:10 -0700
References: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJsVUrbXg0E0CGPcba+=_kbZkKsry_n9Xa2e=X_9uwL+g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 9 Nov 2017 09:03:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJsVUrbXg0E0CGPcba+=_kbZkKsry_n9Xa2e=X_9uwL+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8d7fae4f-005c-c62a-55bc-0f7e82037178@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tpm_emulator: Add a caching layer for
 the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 11/09/2017 07:07 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Nov 8, 2017 at 9:37 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Add a caching layer for the TPM established flag so that we don't
>> need to go to the emulator every time the flag is read by accessing
>> the REG_ACCESS register.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> v1->v2:
>>   - move the caching to the backend layer since detecting the
>>     TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
>>     here.
> What about the HASH_START? Is this not supported by qemu TIS? Is the
> function gone or done differently with TPM2 or CRB?

Afaik, HASH_START would need emulation of CPU instructions to initiate=20
it. Reading this flag from the device is there primarily for=20
completeness reasons.

     Stefan

>
>> ---
>>   hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> index 9aaec8e..507e2cb 100644
>> --- a/hw/tpm/tpm_emulator.c
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -71,6 +71,9 @@ typedef struct TPMEmulator {
>>       ptm_cap caps; /* capabilities of the TPM */
>>       uint8_t cur_locty_number; /* last set locality */
>>       Error *migration_blocker;
>> +
>> +    unsigned int established_flag:1;
>> +    unsigned int established_flag_cached:1;
>>   } TPMEmulator;
>>
>>
>> @@ -277,16 +280,22 @@ static bool tpm_emulator_get_tpm_established_fla=
g(TPMBackend *tb)
>>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>>       ptm_est est;
>>
>> -    DPRINTF("%s", __func__);
>> +    if (tpm_emu->established_flag_cached) {
>> +        return tpm_emu->established_flag;
>> +    }
>> +
>>       if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLIS=
HED, &est,
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
>> @@ -317,6 +326,8 @@ static int tpm_emulator_reset_tpm_established_flag=
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
>>
>
>
