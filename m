Received: from eggs.gnu.org ([209.51.188.92]:49913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghDo9-0002M1-6K
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghDo7-0007wv-8v
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:22:09 -0500
Received: from m50-110.126.com ([123.125.50.110]:41298)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghDo3-0007kg-89
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:22:05 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-12-fli@suse.com>
	<875zv0ml13.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <402192f7-80d9-778c-2855-6b2225ef0690@126.com>
Date: Wed, 9 Jan 2019 21:21:57 +0800
MIME-Version: 1.0
In-Reply-To: <875zv0ml13.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 11/16] qemu_thread: supplement
 error handling for emulated_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Gerd Hoffmann <kraxel@redhat.com>


ÔÚ 2019/1/8 ÉÏÎç1:31, Markus Armbruster Ð´µÀ:
> Fei Li <fli@suse.com> writes:
>
>> Utilize the existed errp to propagate the error and do the
>> corresponding cleanup to replace the temporary &error_abort.
>>
>> Cc: Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   hw/usb/ccid-card-emulated.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>> index f8ff7ff4a3..9245b4fcad 100644
>> --- a/hw/usb/ccid-card-emulated.c
>> +++ b/hw/usb/ccid-card-emulated.c
>> @@ -32,7 +32,6 @@
>>   #include "qemu/thread.h"
>>   #include "qemu/main-loop.h"
>>   #include "ccid.h"
>> -#include "qapi/error.h"
>>   
>>   #define DPRINTF(card, lvl, fmt, ...) \
>>   do {\
>> @@ -544,11 +543,15 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>>           error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
>>           goto out2;
>>       }
>> -    /* TODO: let the further caller handle the error instead of abort() here */
>> -    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>> -    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>> +    if (!qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>> +                            card, QEMU_THREAD_JOINABLE, errp)) {
>> +        goto out2;
>> +    }
>> +    if (!qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
>> +                            handle_apdu_thread, card,
>> +                            QEMU_THREAD_JOINABLE, errp)) {
>> +        goto out2;
> You need to stop and join the first thread.

Thanks for pointing this out!

Have a nice day
Fei
>
>> +    }
>>   
>>   out2:
>>       clean_event_notifier(card);
