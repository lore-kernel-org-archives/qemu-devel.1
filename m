Received: from eggs.gnu.org ([209.51.188.92]:34263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghClx-0006id-Si
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghClw-0003oU-Ry
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:15:49 -0500
Date: Wed, 9 Jan 2019 13:15:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <6c6cdb4b-b15c-0152-2cfe-4ac813d15111@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1901091306020.28696@zero.eik.bme.hu>
References: <cover.1546532844.git.balaton@eik.bme.hu>
	<a977bd81f7c1f2896837671545fbb01ebf286f4a.1546532844.git.balaton@eik.bme.hu>
	<6c6cdb4b-b15c-0152-2cfe-4ac813d15111@redhat.com>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1901091307230.28696@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] smbus: Add a helper to generate SPD
 EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 9 Jan 2019, Philippe Mathieu-Daud=E9 wrote:
> On 1/3/19 5:27 PM, BALATON Zoltan wrote:
>> There are several boards with SPD EEPROMs that are now using
>> duplicated or slightly different hard coded data. Add a helper to
>> generate SPD data for a memory module of given type and size that
>> could be used by these boards (either as is or with further changes if
>> needed) which should help cleaning this up and avoid further duplicati=
on.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v3: Fixed a tab indent
>> v2: Added errp parameter to pass errors back to caller
>>
>>  hw/i2c/smbus_eeprom.c  | 130 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/i2c/smbus.h |   3 ++
>>  2 files changed, 133 insertions(+)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index f18aa3de35..bef24a1ca4 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
[...]
>> +
>> +    spd =3D g_malloc0(256);
>
> I think this buffer is eeprom-dependant, not SPD related.

This function is called spd_data_generate(). It specifically generates SP=
D=20
EEPROM data and nothing else. as you see below data is hardcoded so would=
=20
not work for other EEPROMs (the first two bytes even specify EEPROM size,=
=20
hence I don't think size needs to be passed as a parameter.

> Wouldn't it be cleaner to pass the (previously created) buffer as
> argument such:
>
>  /* return true on success */
>  bool spd_data_fill(void *buf, size_t bufsize,
>                     enum sdram_type type, ram_addr_t ram_size,
>                     Error **errp);

It could take a previously created buffer but it's simpler this way and=20
one less error to handle by the caller so I don't like adding two more=20
parameters for this.

> or return something else like ssize_t.

Again, the current version is simpler IMO so while this aims to be generi=
c=20
to be used by other boards but still not completely generic for all kinds=
=20
of EEPROMs. Just for SPD EEPROMs commonly found on SDR, DDR and DDR2=20
memory modules. Anything else (even DDR3) is too dissimilar so those will=
=20
need another function not this one.

Regards,
BALATON Zoltan

>
>> +    spd[0] =3D 128;   /* data bytes in EEPROM */
>> +    spd[1] =3D 8;     /* log2 size of EEPROM */
>> +    spd[2] =3D type;
>> +    spd[3] =3D 13;    /* row address bits */
>> +    spd[4] =3D 10;    /* column address bits */
>> +    spd[5] =3D (type =3D=3D DDR2 ? nbanks - 1 : nbanks);
>> +    spd[6] =3D 64;    /* module data width */
>> +                    /* reserved / data width high */
>> +    spd[8] =3D 4;     /* interface voltage level */
>> +    spd[9] =3D 0x25;  /* highest CAS latency */
>> +    spd[10] =3D 1;    /* access time */
>> +                    /* DIMM configuration 0 =3D non-ECC */
>> +    spd[12] =3D 0x82; /* refresh requirements */
>> +    spd[13] =3D 8;    /* primary SDRAM width */
>> +                    /* ECC SDRAM width */
>> +    spd[15] =3D (type =3D=3D DDR2 ? 0 : 1); /* reserved / delay for r=
andom col rd */
>> +    spd[16] =3D 12;   /* burst lengths supported */
>> +    spd[17] =3D 4;    /* banks per SDRAM device */
>> +    spd[18] =3D 12;   /* ~CAS latencies supported */
>> +    spd[19] =3D (type =3D=3D DDR2 ? 0 : 1); /* reserved / ~CS latenci=
es supported */
>> +    spd[20] =3D 2;    /* DIMM type / ~WE latencies */
>> +                    /* module features */
>> +                    /* memory chip features */
>> +    spd[23] =3D 0x12; /* clock cycle time @ medium CAS latency */
>> +                    /* data access time */
>> +                    /* clock cycle time @ short CAS latency */
>> +                    /* data access time */
>> +    spd[27] =3D 20;   /* min. row precharge time */
>> +    spd[28] =3D 15;   /* min. row active row delay */
>> +    spd[29] =3D 20;   /* min. ~RAS to ~CAS delay */
>> +    spd[30] =3D 45;   /* min. active to precharge time */
>> +    spd[31] =3D density;
>> +    spd[32] =3D 20;   /* addr/cmd setup time */
>> +    spd[33] =3D 8;    /* addr/cmd hold time */
>> +    spd[34] =3D 20;   /* data input setup time */
>> +    spd[35] =3D 8;    /* data input hold time */
>> +
>> +    /* checksum */
>> +    for (i =3D 0; i < 63; i++) {
>> +        spd[63] +=3D spd[i];
>> +    }
>> +    return spd;
>> +}
>> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
>> index d8b1b9ee81..d3dd0fcb14 100644
>> --- a/include/hw/i2c/smbus.h
>> +++ b/include/hw/i2c/smbus.h
>> @@ -93,4 +93,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t ad=
dress, uint8_t *eeprom_buf);
>>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>>                         const uint8_t *eeprom_spd, int size);
>>
>> +enum sdram_type { SDR =3D 0x4, DDR =3D 0x7, DDR2 =3D 0x8 };
>> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size, Err=
or **errp);
>> +
>>  #endif
>>
>
>
