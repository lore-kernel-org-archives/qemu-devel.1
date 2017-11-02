Received: from eggs.gnu.org ([2001:4830:134:3::10]:51503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eALA2-0006oD-B4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAL9z-0001Qh-7c
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:28:18 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAL9z-0001QZ-3J
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:28:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id w134so715876qkb.0
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 12:28:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171031152443.3670-1-michael.nawrocki@gtri.gatech.edu>
	<8dbe8e3a-f8d4-3fb0-2ac8-e200ebde3dcb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e24381c-3621-1dcb-02fb-1dc4f15358b2@amsat.org>
Date: Thu, 2 Nov 2017 16:28:09 -0300
MIME-Version: 1.0
In-Reply-To: <8dbe8e3a-f8d4-3fb0-2ac8-e200ebde3dcb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 serial
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, Avi Kivity <avi@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Konrad Frederic <fred.konrad@greensocs.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

Hi Mike, Paolo.

>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>> index 376bd2f240..c16c19a406 100644
>> --- a/hw/char/serial.c
>> +++ b/hw/char/serial.c
>> @@ -1005,7 +1005,7 @@ static void serial_mm_write(void *opaque, hwaddr addr,
>>                              uint64_t value, unsigned size)
>>  {
>>      SerialState *s = opaque;
>> -    value &= ~0u >> (32 - (size * 8));
>> +    value &= ~((uint64_t)0) >> (64 - (size * 8));
>>      serial_ioport_write(s, addr >> s->it_shift, value, 1);
>>  }
> 
> Couldn't this be simply "value &= 255"?  Otherwise looks good.

This is not incorrect, but I don't think this is the correct fix.
Isn't it what memory::access_with_adjusted_size() is supposed to do with
.impl.max_access_size = 1?

This looks like the same issue I tried to fix here:
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02255.html

I'll try to find some time to respin the full series with tests.

>> @@ -1014,16 +1014,22 @@ static const MemoryRegionOps serial_mm_ops[3] = {
>>          .read = serial_mm_read,
>>          .write = serial_mm_write,
>>          .endianness = DEVICE_NATIVE_ENDIAN,
>> +        .valid.max_access_size = 8,
>> +        .impl.max_access_size = 8,
>>      },
>>      [DEVICE_LITTLE_ENDIAN] = {
>>          .read = serial_mm_read,
>>          .write = serial_mm_write,
>>          .endianness = DEVICE_LITTLE_ENDIAN,
>> +        .valid.max_access_size = 8,
>> +        .impl.max_access_size = 8,
>>      },
>>      [DEVICE_BIG_ENDIAN] = {
>>          .read = serial_mm_read,
>>          .write = serial_mm_write,
>>          .endianness = DEVICE_BIG_ENDIAN,
>> +        .valid.max_access_size = 8,
>> +        .impl.max_access_size = 8,
