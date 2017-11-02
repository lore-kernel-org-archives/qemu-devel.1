Received: from eggs.gnu.org ([2001:4830:134:3::10]:38016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEYn-0005VP-KS
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEYi-0006ch-Nb
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:25:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:56980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAEYi-0006bS-FG
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:25:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id z28so5958310qtz.13
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 05:25:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171102093625.32342-1-ppandit@redhat.com>
	<f96b7ffe-83d3-f328-cf74-e05a0acb65ec@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <daab1313-a255-c355-004e-756504ca7eb3@amsat.org>
Date: Thu, 2 Nov 2017 09:25:15 -0300
MIME-Version: 1.0
In-Reply-To: <f96b7ffe-83d3-f328-cf74-e05a0acb65ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: restrict port92 register value to 2
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Niu Guoxiang <niuguoxiang@huawei.com>

Hi Prasad,

On 11/02/2017 06:37 AM, Paolo Bonzini wrote:
> On 02/11/2017 10:36, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Port 92 configuration register holds an 8-bit value. Of 8-bits,
>> bits 0-1 are used and 2-7 are reserved. Restrict the supplied
>> value to 2 bits.
> 
> This patch is not necessary.  "Do nothing and just report back the value
> that was written" is an okay implementation of reserved bits.
> 
> Paolo
> 
> 
>> Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/i386/pc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 05985d4927..883384a599 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -515,6 +515,7 @@ static void port92_write(void *opaque, hwaddr addr, uint64_t val,
>>      Port92State *s = opaque;
>>      int oldval = s->outport;
>>  
>> +    val &= 0x03;
>>      DPRINTF("port92: write 0x%02" PRIx64 "\n", val);

You might want to report a guest error instead:

        if (val & ~3) {
            qemu_log_mask(LOG_GUEST_ERROR,
                "port92: bits 2-7 are reserved "
                "(wrote 0x%02" PRIx64 ")\n", val);
        }

>>      s->outport = val;
>>      qemu_set_irq(s->a20_out, (val >> 1) & 1);
