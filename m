Received: from eggs.gnu.org ([2001:4830:134:3::10]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWcHu-0004Ol-Dk
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 01:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWcHr-0006FP-8P
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 01:40:14 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dWcHq-0006DN-Jj
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 01:40:11 -0400
References: <20170715132841.9865-1-hpoussin@reactos.org>
	<20170715132841.9865-5-hpoussin@reactos.org>
	<3f675ff1-e6ce-a6b2-f63c-4b063871a215@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <5dfb4f95-6557-d42e-6779-90f679b3d701@reactos.org>
Date: Sun, 16 Jul 2017 07:39:45 +0200
MIME-Version: 1.0
In-Reply-To: <3f675ff1-e6ce-a6b2-f63c-4b063871a215@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] vvfat: initialize memory after
 allocating it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Le 16/07/2017 à 00:24, Philippe Mathieu-Daudé a écrit :
> Hi Hervé,
>
> On 07/15/2017 10:28 AM, Hervé Poussineau wrote:
>> This prevents some host to guest memory content leaks.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
>>
>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>   block/vvfat.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index afc6170a69..7340decef3 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -115,6 +115,7 @@ static inline int array_ensure_allocated(array_t* array, int index)
>>           array->pointer = g_realloc(array->pointer, new_size);
>>           if (!array->pointer)
>>               return -1;
>
> isn't it safer:
>
> if (likely(new_size > array->size)) {

Not really, because the code is:
     if((index + 1) * array->item_size > array->size) {
         int new_size = (index + 32) * array->item_size;
         array->pointer = g_realloc(array->pointer, new_size);
         if (!array->pointer)
             return -1;
         array->size = new_size;
         array->next = index + 1;
     }

array->size is the size (in bytes) of the previous array.
new_size is (index + 32) * item_size
And, due to the "if", we know that (index + 1) * item_size > array->size.
So, new_size > array->size.

>
>> +        memset(array->pointer + array->size, 0, new_size - array->size);
>
> }
>
> ?
>
>>           array->size = new_size;
>>           array->next = index + 1;
>>       }
>>
>
> Regards,
>
> Phil.
>
