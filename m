Received: from eggs.gnu.org ([2001:4830:134:3::10]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxw38-0005lI-Rn
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxw35-0004N4-KY
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxw35-0004Mr-EP
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:13:51 -0400
References: <20170926122427.GC4115@localhost.localdomain>
	<20170926130028.12471-1-ehabkost@redhat.com>
	<890a01d9-d7a0-6afd-ffac-5c8f2425570f@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9f89dc4-35fc-7d27-6ec7-d131d4be5b06@redhat.com>
Date: Fri, 29 Sep 2017 16:13:04 +0200
MIME-Version: 1.0
In-Reply-To: <890a01d9-d7a0-6afd-ffac-5c8f2425570f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iothread: Make iothread_stop() idempotent
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 29/09/2017 15:47, Christian Borntraeger wrote:
> Is anybody going to pick this up? upstream qemu is still happily filling
> up my disk with coredumps on exit.

I can, but I'll only send the pull request next Monday, probably.

Paolo

> On 09/26/2017 03:00 PM, Eduardo Habkost wrote:
>> Currently, iothread_stop_all() makes all iothread objects unsafe
>> to be destroyed, because qemu_thread_join() ends up being called
>> twice.
>>
>> To fix this, make iothread_stop() idempotent by checking
>> thread->stopped.
>>
>> Fixes the following crash:
>>
>>   qemu-system-x86_64 -object iothread,id=iothread0 -monitor stdio -display none
>>   QEMU 2.10.50 monitor - type 'help' for more information
>>   (qemu) quit
>>   qemu: qemu_thread_join: No such process
>>   Aborted (core dumped)
>>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  iothread.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/iothread.c b/iothread.c
>> index 44c8944dc4..59d0850988 100644
>> --- a/iothread.c
>> +++ b/iothread.c
>> @@ -85,7 +85,7 @@ static int iothread_stop(Object *object, void *opaque)
>>      IOThread *iothread;
>>
>>      iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
>> -    if (!iothread || !iothread->ctx) {
>> +    if (!iothread || !iothread->ctx || iothread->stopping) {
>>          return 0;
>>      }
>>      iothread->stopping = true;
>>
> 
