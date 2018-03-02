Received: from eggs.gnu.org ([2001:4830:134:3::10]:33685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1erlJo-0001Zj-9p
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1erlJj-00076u-B9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:05:52 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quan.xu0@gmail.com>) id 1erlJj-00076R-5X
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:05:47 -0500
Received: by mail-ot0-x243.google.com with SMTP id g97so8778736otg.13
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:05:46 -0800 (PST)
References: <CABkJTM4RL4cZ0euYX7d8xPd7ozrN76nr0rafut0LBJmZWFD+Vw@mail.gmail.com>
	<CAJ+F1C+6Gt-STfZhsRsr-q9YeMOP5jyRiQ73OuhO9Uz+QE3fGQ@mail.gmail.com>
From: Quan Xu <quan.xu0@gmail.com>
Message-ID: <08491061-f3fc-5a68-8ab5-5a2f13dcfebd@gmail.com>
Date: Fri, 2 Mar 2018 22:05:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+6Gt-STfZhsRsr-q9YeMOP5jyRiQ73OuhO9Uz+QE3fGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] input: free InputEvent when it can't be
 inserted into a full kdb queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?B?55Sw5q6/6Iej?= <dianchen.tdc@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, icymemo@gmail.com



On 2017/12/06 17:46, Marc-André Lureau wrote:
> Hi
>
> On Wed, Dec 6, 2017 at 3:29 AM, 田殿臣 <dianchen.tdc@gmail.com> wrote:
>>  From e8c03f405c2112428e79bb82064c7b7743d0cc86 Mon Sep 17 00:00:00 2001
>> From: Tian Dianchen <dianchen.tdc@gmail.com>
>> Date: Tue, 5 Dec 2017 14:03:53 +0800
>> Subject: [PATCH] input: free InputEvent when it can't be inserted into a
>> full
>>   kdb queue
>>
>> When the kdb queue is full, the evt can't be placed in it, so it should
>> be released to free the memory.
>>
>> Impact: Without this limit vnc clients can exhaust host memory by keep
>> sending keyboard events when kdb queue is full.
> You may add "Leak introduced in commit fa18f36a461984eae50ab957e47ec78dae3c14fc"
>
>> Reviewed-by: Zhang Chao <icymemo@gmail.com>
>> Reviewed-by: Quan Xu <quan.xu0@gmail.com>
>> Signed-off-by: Tian Dianchen <dianchen.tdc@gmail.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>

Lureau, thanks for your review.. this patch seems still not in master tree.. could you help me commit it?

thanks,
Quan



>> ---
>>   ui/input.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/ui/input.c b/ui/input.c
>> index 3e2d324..e5b78aa 100644
>> --- a/ui/input.c
>> +++ b/ui/input.c
>> @@ -421,6 +421,8 @@ void qemu_input_event_send_key(QemuConsole *src,
>> KeyValue *key, bool down)
>>       } else if (queue_count < queue_limit) {
>>           qemu_input_queue_event(&kbd_queue, src, evt);
>>           qemu_input_queue_sync(&kbd_queue);
>> +    } else {
>> +        qapi_free_InputEvent(evt);
>>       }
>>   }
>>
>> --
>> 1.8.3.1
>
>
