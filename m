Received: from eggs.gnu.org ([209.51.188.92]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghDKD-0000Y4-Cf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghDGT-0006Di-AY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:47:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghDGL-0006D2-Nd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:47:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so7552665wrp.3
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 04:47:13 -0800 (PST)
References: <cover.1546532844.git.balaton@eik.bme.hu>
	<a977bd81f7c1f2896837671545fbb01ebf286f4a.1546532844.git.balaton@eik.bme.hu>
	<6c6cdb4b-b15c-0152-2cfe-4ac813d15111@redhat.com>
	<alpine.BSF.2.21.9999.1901091306020.28696@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d2644929-3e7e-af15-9256-342a09b4f63c@redhat.com>
Date: Wed, 9 Jan 2019 13:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901091306020.28696@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>

On 1/9/19 1:15 PM, BALATON Zoltan wrote:
> On Wed, 9 Jan 2019, Philippe Mathieu-Daudé wrote:
>> On 1/3/19 5:27 PM, BALATON Zoltan wrote:
>>> There are several boards with SPD EEPROMs that are now using
>>> duplicated or slightly different hard coded data. Add a helper to
>>> generate SPD data for a memory module of given type and size that
>>> could be used by these boards (either as is or with further changes if
>>> needed) which should help cleaning this up and avoid further
>>> duplication.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v3: Fixed a tab indent
>>> v2: Added errp parameter to pass errors back to caller
>>>
>>>  hw/i2c/smbus_eeprom.c  | 130
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/i2c/smbus.h |   3 ++
>>>  2 files changed, 133 insertions(+)
>>>
>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>>> index f18aa3de35..bef24a1ca4 100644
>>> --- a/hw/i2c/smbus_eeprom.c
>>> +++ b/hw/i2c/smbus_eeprom.c
> [...]
>>> +
>>> +    spd = g_malloc0(256);
>>
>> I think this buffer is eeprom-dependant, not SPD related.
> 
> This function is called spd_data_generate(). It specifically generates
> SPD EEPROM data and nothing else. as you see below data is hardcoded so
> would not work for other EEPROMs (the first two bytes even specify
> EEPROM size, hence I don't think size needs to be passed as a parameter.

Well this is why worried me at first, because you alloc 256 bytes ...

> 
>> Wouldn't it be cleaner to pass the (previously created) buffer as
>> argument such:
>>
>>  /* return true on success */
>>  bool spd_data_fill(void *buf, size_t bufsize,
>>                     enum sdram_type type, ram_addr_t ram_size,
>>                     Error **errp);
> 
> It could take a previously created buffer but it's simpler this way and
> one less error to handle by the caller so I don't like adding two more
> parameters for this.
> 
>> or return something else like ssize_t.
> 
> Again, the current version is simpler IMO so while this aims to be
> generic to be used by other boards but still not completely generic for
> all kinds of EEPROMs. Just for SPD EEPROMs commonly found on SDR, DDR
> and DDR2 memory modules. Anything else (even DDR3) is too dissimilar so
> those will need another function not this one.
> 
> Regards,
> BALATON Zoltan
> 
>>
>>> +    spd[0] = 128;   /* data bytes in EEPROM */

... for a 128 bytes EEPROM.

Maybe we can find a compromise at a quick fix with:

  /* no other size currently supported */
  static const size_t spd_eeprom_size = 128;

  spd = g_malloc0(spd_eeprom_size);
  ...

  spd[0] = spd_eeprom_size;
  spd[1] = 1 + ctzl(spd_eeprom_size);

>>> +    spd[1] = 8;     /* log2 size of EEPROM */
>>> +    spd[2] = type;
>>> +    spd[3] = 13;    /* row address bits */
>>> +    spd[4] = 10;    /* column address bits */
>>> +    spd[5] = (type == DDR2 ? nbanks - 1 : nbanks);
>>> +    spd[6] = 64;    /* module data width */
>>> +                    /* reserved / data width high */
>>> +    spd[8] = 4;     /* interface voltage level */
>>> +    spd[9] = 0x25;  /* highest CAS latency */
>>> +    spd[10] = 1;    /* access time */
>>> +                    /* DIMM configuration 0 = non-ECC */
>>> +    spd[12] = 0x82; /* refresh requirements */
>>> +    spd[13] = 8;    /* primary SDRAM width */
>>> +                    /* ECC SDRAM width */
>>> +    spd[15] = (type == DDR2 ? 0 : 1); /* reserved / delay for random
>>> col rd */
>>> +    spd[16] = 12;   /* burst lengths supported */
>>> +    spd[17] = 4;    /* banks per SDRAM device */
>>> +    spd[18] = 12;   /* ~CAS latencies supported */
>>> +    spd[19] = (type == DDR2 ? 0 : 1); /* reserved / ~CS latencies
>>> supported */
>>> +    spd[20] = 2;    /* DIMM type / ~WE latencies */
>>> +                    /* module features */
>>> +                    /* memory chip features */
>>> +    spd[23] = 0x12; /* clock cycle time @ medium CAS latency */
>>> +                    /* data access time */
>>> +                    /* clock cycle time @ short CAS latency */
>>> +                    /* data access time */
>>> +    spd[27] = 20;   /* min. row precharge time */
>>> +    spd[28] = 15;   /* min. row active row delay */
>>> +    spd[29] = 20;   /* min. ~RAS to ~CAS delay */
>>> +    spd[30] = 45;   /* min. active to precharge time */
>>> +    spd[31] = density;
>>> +    spd[32] = 20;   /* addr/cmd setup time */
>>> +    spd[33] = 8;    /* addr/cmd hold time */
>>> +    spd[34] = 20;   /* data input setup time */
>>> +    spd[35] = 8;    /* data input hold time */
>>> +
>>> +    /* checksum */
>>> +    for (i = 0; i < 63; i++) {
>>> +        spd[63] += spd[i];
>>> +    }
>>> +    return spd;
>>> +}
>>> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
>>> index d8b1b9ee81..d3dd0fcb14 100644
>>> --- a/include/hw/i2c/smbus.h
>>> +++ b/include/hw/i2c/smbus.h
>>> @@ -93,4 +93,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t
>>> address, uint8_t *eeprom_buf);
>>>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>>>                         const uint8_t *eeprom_spd, int size);
>>>
>>> +enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
>>> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size,
>>> Error **errp);
>>> +
>>>  #endif
>>>
>>
>>
