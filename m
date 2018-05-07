Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfPz-0001p5-5U
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfPw-000348-22
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:39:03 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:49916)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfPv-00033t-MQ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:38:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:38:57 +1000
From: geoff@hostfission.com
In-Reply-To: <20180507123453.2ef3zk54d7tqii3e@sirius.home.kraxel.org>
References: <fcafae5827cc7fab7b98b9afaf73e08a@hostfission.com>
	<20180507123453.2ef3zk54d7tqii3e@sirius.home.kraxel.org>
Message-ID: <a853e908526da003d76a1c871bcf576a@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ps2: Fix mouse stream corruption due
 to lost data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 2018-05-07 22:34, Gerd Hoffmann wrote:
>> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
>> index 6edf046820..011290920f 100644
>> --- a/hw/input/ps2.c
>> +++ b/hw/input/ps2.c
>> @@ -192,12 +192,50 @@ void ps2_queue(PS2State *s, int b)
>>  {
>>      PS2Queue *q = &s->queue;
>> 
>> -    if (q->count >= PS2_QUEUE_SIZE - 1)
>> +    if (q->count == PS2_QUEUE_SIZE)
>> +    {
>> +        printf("Warning! PS2 Queue Overflow!\n");
>>          return;
>> +    }
> 
> Leftover debug printf?

Correct :), I will remove it.

> 
>> +void ps2_raise(PS2State *s)
>> +{
>> +    s->update_irq(s->update_arg, 1);
>> +}
>> +
>> +void ps2_queue_raise(PS2State *s, int b)
>> +{
>> +    ps2_queue(s, b);
>> +    s->update_irq(s->update_arg, 1);
>> +}
> 
> I'd suggest to keep the ps2_queue() name.  Makes the patch much smaller
> and easier to review.  Factor out the code to actually queue things to
> a new ps2_queue_noirq() function.
> 
>> +void ps2_queue_bytes(PS2State *s, const int length, ...)

Ack.

> 
> I'd prefer to not use vaargs here as gcc can't check the arguments 
> then.
> Suggest to just have ps2_queue_{2,3,4}() helpers instead to queue
> multibyte messages.

Ack.

> 
> cheers,
>   Gerd

Thanks,
   Geoff
