Received: from eggs.gnu.org ([2001:4830:134:3::10]:56673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gT9Ih-000085-JU
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gT9Ie-0001Qz-FD
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:43:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gT9Ie-0001Ql-9L
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:43:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so8220452wrb.2
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 09:43:28 -0800 (PST)
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-16-minyard@acm.org>
	<CAFEAcA8OuW0o5KmGLPuQB149yXowdb=8DyW5oe1yfjE4H--sPg@mail.gmail.com>
	<874bc3cf-825f-7fc5-efed-a39acf1789fa@acm.org>
	<CAFEAcA-hayNK33Aty4GHwV=izK_G--swGUNtoiTVorC_i6LTag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa3413b3-96e2-6203-fffc-e49e00d84508@redhat.com>
Date: Sat, 1 Dec 2018 18:43:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hayNK33Aty4GHwV=izK_G--swGUNtoiTVorC_i6LTag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] hw/i2c/smbus_eeprom: Create at
 most SMBUS_EEPROM_MAX EEPROMs on a SMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 1/12/18 12:57, Peter Maydell wrote:
> On Fri, 30 Nov 2018 at 20:47, Corey Minyard <minyard@acm.org> wrote:
>>
>> On 11/30/18 11:39 AM, Peter Maydell wrote:
>>> On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>        /* XXX: make this persistent */
>>>> -    uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
>>>> +    eeprom_buf = g_malloc0(nb_eeprom * SMBUS_EEPROM_SIZE);
>>> So if we allocate N buffers as the caller requests, what
>>> is the thing that means that more than 8 won't work ?
>>>
>>> We've now changed from allocating always 8 lots of
>>> the EEPROM size to possibly allocating fewer than that.
>>> How does the code in the device know what the size
>>> of the buffer we're passing as the "data" property is
>>> now? We don't pass it the number of EEPROMs as a property.
>>
>> It doesn't have to.  Each EEPROM is 256 bytes and that's all the data
>> it has.
>>
>> But this whole thing is confusing, I agree.  The more I look at this
>> particular file, the less I like it.  But the caller is basically saying:
>> "I need N EEPROMs, here's the initialization data".  That's not
>> really very flexible, IMHO the EEPROM devices should be created
>> individually using standard qemu methods.
> 
> Oh, yes, I see now. We pass in a block of N * 256 bytes, and
> the function then hands a pointer to offsets 0, 256, ...
> to each device it creates.
> 
> I definitely don't see why we need to say "only a maximum of
> 8" now, though -- where does that limit come from? If we
> get passed in an arbitrary number of EEPROMs X, and we allocate
> 256 * X bytes, and create X devices which each get one slice of
> the buffer, what goes wrong when X > 8 ?
> 
>> I'm tempted to rewrite this whole thing to make it cleaner.
> 
> It's certainly pretty awkward code. I think personally given
> this patchset is already pretty big I'd go for getting it into
> master first and then doing a followup with further cleanup.

As suggested Peter, I'd drop this patch (in favor of a later clean
rewrite) and simply add an assert().

Regards,

Phil.
