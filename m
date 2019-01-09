Received: from eggs.gnu.org ([209.51.188.92]:45926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghIPj-0007MT-3Q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghIMH-0005gM-PR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:13:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghIMH-0005gB-Gd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:13:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so8686881wmd.0
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:13:41 -0800 (PST)
References: <cover.1546532844.git.balaton@eik.bme.hu>
	<a977bd81f7c1f2896837671545fbb01ebf286f4a.1546532844.git.balaton@eik.bme.hu>
	<6c6cdb4b-b15c-0152-2cfe-4ac813d15111@redhat.com>
	<alpine.BSF.2.21.9999.1901091306020.28696@zero.eik.bme.hu>
	<d2644929-3e7e-af15-9256-342a09b4f63c@redhat.com>
	<alpine.BSF.2.21.9999.1901091819280.41593@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1901091904200.41593@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fe44d7c-c4ff-d861-42a7-26bdea349fc5@redhat.com>
Date: Wed, 9 Jan 2019 19:13:38 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901091904200.41593@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/6] smbus: Add a helper to
 generate SPD EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 1/9/19 7:05 PM, BALATON Zoltan wrote:
> On Wed, 9 Jan 2019, BALATON Zoltan wrote:
>> On Wed, 9 Jan 2019, Philippe Mathieu-Daudé wrote:
>>> On 1/9/19 1:15 PM, BALATON Zoltan wrote:
>>>> On Wed, 9 Jan 2019, Philippe Mathieu-Daudé wrote:
>>>>> On 1/3/19 5:27 PM, BALATON Zoltan wrote:
>>>>>> There are several boards with SPD EEPROMs that are now using
>>>>>> duplicated or slightly different hard coded data. Add a helper to
>>>>>> generate SPD data for a memory module of given type and size that
>>>>>> could be used by these boards (either as is or with further
>>>>>> changes if
>>>>>> needed) which should help cleaning this up and avoid further
>>>>>> duplication.
>>>>>>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>> v3: Fixed a tab indent
>>>>>> v2: Added errp parameter to pass errors back to caller
>>>>>>
>>>>>> ?hw/i2c/smbus_eeprom.c? | 130
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>> ?include/hw/i2c/smbus.h |?? 3 ++
>>>>>> ?2 files changed, 133 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>>>>>> index f18aa3de35..bef24a1ca4 100644
>>>>>> --- a/hw/i2c/smbus_eeprom.c
>>>>>> +++ b/hw/i2c/smbus_eeprom.c
>>>> [...]
>>>>>> +
>>>>>> +??? spd = g_malloc0(256);
>>>>>
>>>>> I think this buffer is eeprom-dependant, not SPD related.
>>>>
>>>> This function is called spd_data_generate(). It specifically generates
>>>> SPD EEPROM data and nothing else. as you see below data is hardcoded so
>>>> would not work for other EEPROMs (the first two bytes even specify
>>>> EEPROM size, hence I don't think size needs to be passed as a
>>>> parameter.
>>>
>>> Well this is why worried me at first, because you alloc 256 bytes ...
>>>
>>>>
>>>>> Wouldn't it be cleaner to pass the (previously created) buffer as
>>>>> argument such:
>>>>>
>>>>> ?/* return true on success */
>>>>> ?bool spd_data_fill(void *buf, size_t bufsize,
>>>>> ??????????????????? enum sdram_type type, ram_addr_t ram_size,
>>>>> ??????????????????? Error **errp);
>>>>
>>>> It could take a previously created buffer but it's simpler this way and
>>>> one less error to handle by the caller so I don't like adding two more
>>>> parameters for this.
>>>>
>>>>> or return something else like ssize_t.
>>>>
>>>> Again, the current version is simpler IMO so while this aims to be
>>>> generic to be used by other boards but still not completely generic for
>>>> all kinds of EEPROMs. Just for SPD EEPROMs commonly found on SDR, DDR
>>>> and DDR2 memory modules. Anything else (even DDR3) is too dissimilar so
>>>> those will need another function not this one.
>>>>
>>>> Regards,
>>>> BALATON Zoltan
>>>>
>>>>>
>>>>>> +??? spd[0] = 128;?? /* data bytes in EEPROM */
>>>
>>> ... for a 128 bytes EEPROM.
>>
>> No, I allocate 256 bytes for a 256 bytes EEPROM of which the first 128
>> bytes are containing SPD data as described in for example:
>>
>> https://en.wikipedia.org/wiki/Serial_presence_detect
>>
>> This also matches the previous code that allocated 256 bytes (and
>> still does, see smbus_eeprom_init() function just above this one).
>>
>>> Maybe we can find a compromise at a quick fix with:
>>>
>>>  /* no other size currently supported */
>>>  static const size_t spd_eeprom_size = 128;
>>>
>>>  spd = g_malloc0(spd_eeprom_size);
>>>  ...
>>>
>>>  spd[0] = spd_eeprom_size;
>>>  spd[1] = 1 + ctzl(spd_eeprom_size);
>>
>> This does not match static SPD data currently in the code elsewhere
>> which all start with 128, 8,... so I'm not sure some firmware would
>> dislike a non-usual eeprom with 128, 4. My intention was to remove
>> static SPD data that's present elsewhere and replace it with nearly
>> identical data generated by this function. The data also has to match
>> what's normally found on real hardware so maybe try dumping data from
>> some memory modules and check what they have and if your suggestion is
>> common then we could go with that otherwise I'd rather waste 128 bytes
>> (or half a kilobyte for 4 modules) than get compatibility problems due
>> to presenting unusual data to firmwares and other guest software that
>> parse SPD data.
>>
>> Unless someone else also thinks it's a good idea to go with unusual
>> SPD data to save a few bytes.
> 
> Even then it would not work. Whole smbus_eeprom.c seems to have EEPROM
> size == 256 hardcoded all over the place, so...

Yes, this 'device' needs love^H^H^H^Hcleanup.

Thanks for the info you provided.

Regards,

Phil.
