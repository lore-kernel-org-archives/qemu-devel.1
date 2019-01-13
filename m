Received: from eggs.gnu.org ([209.51.188.92]:54725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gihwI-0003zt-5i
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gihwH-0002wM-BN
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:44:42 -0500
Received: from m50-112.126.com ([123.125.50.112]:50932)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gihwF-0002rx-4G
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:44:41 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <f5631b6b-d313-88dc-f80a-890c26f109e4@126.com>
Date: Sun, 13 Jan 2019 23:44:28 +0800
MIME-Version: 1.0
In-Reply-To: <87a7kcml5i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Jiri Slaby <jslaby@suse.cz>


在 2019/1/8 上午1:29, Markus Armbruster 写道:
> Fei Li <fli@suse.com> writes:
>
>> Utilize the existed errp to propagate the error instead of the
>> temporary &error_abort.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   hw/misc/edu.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index 3f4ba7ded3..011fe6e0b7 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -356,9 +356,10 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>>   
>>       qemu_mutex_init(&edu->thr_mutex);
>>       qemu_cond_init(&edu->thr_cond);
>> -    /* TODO: let the further caller handle the error instead of abort() here */
>> -    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
>> -                       edu, QEMU_THREAD_JOINABLE, &error_abort);
>> +    if (!qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
>> +                            edu, QEMU_THREAD_JOINABLE, errp)) {
>> +        return;
> You need to clean up everything that got initialized so far.  You might
> want to call qemu_thread_create() earlier so you have less to clean up.

Just to make sure about how to do the cleanup. I notice that in device_set_realized(),
the current code does not call "dc->unrealize(dev, NULL);" when dc->realize() fails.

         if (dc->realize) {
             dc->realize(dev, &local_err);
         }

         if (local_err != NULL) {
             goto fail;
         }

Is this on purpose? (Maybe due to some devices' realize() do their own cleanup
when fails? Sorry for the unsure, it is such a common function that I did not
check all. :( ) Or else, I prefer to do the cleanup in a unified manner, e.g. call "dc->unrealize(dev, NULL);" which is the pci_qdev_unrealize() for pci devices.

Have a nice day
Fei
