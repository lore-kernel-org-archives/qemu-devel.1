Received: from eggs.gnu.org ([2001:4830:134:3::10]:39347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ecCPp-0000eH-Bg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ecCPm-000774-9I
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ecCPm-00076H-2X
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:47:42 -0500
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-7-f4bug@amsat.org>
	<16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2ee34e45-eeec-48e7-3f1f-a5e798a0fc4e@redhat.com>
Date: Thu, 18 Jan 2018 17:47:34 +0200
MIME-Version: 1.0
In-Reply-To: <16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 06/16] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 18/01/2018 17:44, Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/18/2018 09:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/sd/sdhci.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index f9264d3be5..08b85558f1 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1174,12 +1174,19 @@ static inline unsigned int sdhci_get_fifolen(S=
DHCIState *s)
>>       }
>>   }
>>  =20
>> +static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp=
)
>> +{
>> +    if (s->capareg =3D=3D UINT64_MAX) {
>> +        s->capareg =3D SDHC_CAPAB_REG_DEFAULT;
>> +    }
>> +}
>> +
>>   /* --- qdev common --- */
>>  =20
>>   #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>> -    /* Capabilities registers provide information on supported featur=
es
>> -     * of this specific host controller implementation */ \
>> -    DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEF=
AULT), \
>> +    /* deprecated: Capabilities registers provide information on supp=
orted
>> +     * features of this specific host controller implementation */ \
>> +    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
>>       DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
>>  =20
>>   static void sdhci_initfn(SDHCIState *s)
>> @@ -1204,6 +1211,10 @@ static void sdhci_uninitfn(SDHCIState *s)
>>  =20
>>   static void sdhci_common_realize(SDHCIState *s, Error **errp)
>>   {
>> +    sdhci_init_readonly_registers(s, errp);
>> +    if (errp && *errp) {
>

Hi Phillipe,

> Paolo said this is wrong (as in bad pattern?).
>=20
> I will respin probably using 'bool sdhci_init_readonly_registers()' ins=
tead.
>=20

I always use the explanations in include/qapi/error.h
as guidelines.

Thanks,
Marcel

>> +        return;
>> +    }
>>       s->buf_maxsz =3D sdhci_get_fifolen(s);
>>       s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>>  =20
>>
