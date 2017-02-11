Received: from eggs.gnu.org ([2001:4830:134:3::10]:44925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOBN-0002d1-DA
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOBK-0003BA-72
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:17:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170206233931.14921-1-f4bug@amsat.org>
	<20170206233931.14921-3-f4bug@amsat.org>
	<CAKmqyKMYmNeOOogS4+yv14M2CWTbBNtBP0jnO0DQEuScSp8eYw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0bb2d93b-09c5-83f6-dbd1-90b940e96dba@amsat.org>
Date: Sat, 11 Feb 2017 00:16:54 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMYmNeOOogS4+yv14M2CWTbBNtBP0jnO0DQEuScSp8eYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>


On 02/10/2017 07:19 PM, Alistair Francis wrote:
> On Mon, Feb 6, 2017 at 3:39 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> The register_read() function expects a bitmask argument.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> The functionality of these two patches looks good to me.
>
> I think it's weird that we convert the write function in one patch
> (when we add the function) and the read in another.
>
> I think both patches should just be squashed together. It's a pretty
> small change.
>
> Thanks,
>
> Alistair

Sure, will do in v2.

Thanks!

>
>> ---
>>  hw/core/register.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/register.c b/hw/core/register.c
>> index 12f4c1e62d..482e3f827a 100644
>> --- a/hw/core/register.c
>> +++ b/hw/core/register.c
>> @@ -213,6 +213,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
>>      RegisterInfoArray *reg_array = opaque;
>>      RegisterInfo *reg = NULL;
>>      uint64_t read_val;
>> +    uint64_t re;
>>      int i;
>>
>>      for (i = 0; i < reg_array->num_elements; i++) {
>> @@ -228,7 +229,10 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
>>          return 0;
>>      }
>>
>> -    read_val = register_read(reg, size * 8, reg_array->prefix,
>> +    /* Generate appropriate read enable mask */
>> +    re = register_enabled_mask(reg->data_size, size);
>> +
>> +    read_val = register_read(reg, re, reg_array->prefix,
>>                               reg_array->debug);
>>
>>      return extract64(read_val, 0, size * 8);
>> --
>> 2.11.0
>>
>>
