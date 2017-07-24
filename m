Received: from eggs.gnu.org ([2001:4830:134:3::10]:42001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlGn-0008Md-Mo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlGj-0000oy-Jp
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:52:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-33-f4bug@amsat.org>
	<CAFEAcA9d5SE-+=YxJ_dwjvkpxs2R0QJszESExGoG2y+Bnyk2aA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30a8ec15-315a-9bb4-5d7e-5c6b8da4e129@amsat.org>
Date: Mon, 24 Jul 2017 18:51:56 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9d5SE-+=YxJ_dwjvkpxs2R0QJszESExGoG2y+Bnyk2aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 32/35] timer/pxa2xx: silent
 warning about out-of-bound memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/24/2017 06:01 PM, Peter Maydell wrote:
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Unlikely to happen.
>>
>> hw/timer/pxa2xx_timer.c:145:19: warning: Out of bound memory access (accessed memory precedes memory block)
>>          counter = counters[n];
>>                    ^~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/timer/pxa2xx_timer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
>> index 68ba5a70b3..d47f463636 100644
>> --- a/hw/timer/pxa2xx_timer.c
>> +++ b/hw/timer/pxa2xx_timer.c
>> @@ -139,7 +139,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
>>       if (s->tm4[n].control & (1 << 7))
>>           counter = n;
>>       else
>> -        counter = counters[n];
>> +        counter = counters[n & 7];
>>
>>       if (!s->tm4[counter].freq) {
>>           timer_del(s->tm4[n].tm.qtimer);
>> --
> 
> This looks rather odd, because we use a mask to guard
> the counters[] array index, but we do an access into
> another 8-element array with n both immediately
> above and immediately below that.
> 
> It's not actually possible to call this function
> with n not between 0 and 7 -- if the static
> analyser can't figure that out does adding an
> assert at the top of the function help it out?

Yep, I'm keeping patches with "static analyzer hints" for 2.11 unless 
there is interest in having them in 2.10 (this patch now included in 
that 2.11 series).

Thanks,

Phil.
