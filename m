Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dG3bL-0003lj-38
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dG3bK-0008Kw-0k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:51 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dG3bJ-0008KG-QZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:23:49 -0400
Received: by mail-it0-x230.google.com with SMTP id r63so11214363itc.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:23:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170531130609.GE16733@stefanha-x1.localdomain>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170531130609.GE16733@stefanha-x1.localdomain>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Wed, 31 May 2017 15:23:25 +0200
Message-ID: <CAJrWOzD-bVte_S7D6BGmDQ_VGqpwu5660oHMz7J2OJK0iPcvAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, May 31, 2017 at 3:06 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, May 30, 2017 at 12:07:36PM +0200, Roman Pen wrote:
>> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
>> index 6328eed26bc6..d589d8c66d5e 100644
>> --- a/util/qemu-coroutine-lock.c
>> +++ b/util/qemu-coroutine-lock.c
>> @@ -77,10 +77,20 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
>>  void qemu_co_queue_run_restart(Coroutine *co)
>>  {
>>      Coroutine *next;
>> +    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =
>> +        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
>>
>>      trace_qemu_co_queue_run_restart(co);
>> -    while ((next = QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
>> -        QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
>> +
>> +    /* Because "co" has yielded, any coroutine that we wakeup can resume it.
>> +     * If this happens and "co" terminates, co->co_queue_wakeup becomes
>> +     * invalid memory.  Therefore, use a temporary queue and do not touch
>> +     * the "co" coroutine as soon as you enter another one.
>> +     */
>> +    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
>> +
>> +    while ((next = QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
>> +        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
>>          qemu_coroutine_enter(next);
>>      }
>>  }
>
> What happens if co remains alive and qemu_coroutine_enter(next) causes
> additional coroutines to add themselves to co->co_queue_wakeup?

Yeah, I thought about it.  But according to my understanding the only
path where you add something to the tail of a queue is:

void aio_co_enter(AioContext *ctx, struct Coroutine *co)
{
...
   if (qemu_in_coroutine()) {
        Coroutine *self = qemu_coroutine_self();
        assert(self != co);
        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co,
co_queue_next); <<<< HERE

So you should be in *that* coroutine to chain other coroutines.
That means that caller of your 'co' will be responsible to complete
what it has in the list.  Something like that:


co1 YIELDED,
foreach co in co1.queue{co2}
   enter(co) -------------->  co2 does something and
                              eventually enter(co1):  -----> co1 does
something and
                                                             add co4
to the queue
                                                             terminates
                                                      <-----
                              co2 iterates over the queue of co1 and
                               foreach co in co1.queue{co4}


Sorry, the explanation is totally crap, but the key is:
caller is responsible for cleaning the queue no matter what
happens.  Sounds sane?

--
Roman


>
> I think they used to be entered but not anymore after this patch.  Not
> sure if anything depends on this behavior...
