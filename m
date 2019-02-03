Received: from eggs.gnu.org ([209.51.188.92]:40473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqC2X-0006hq-DB
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 02:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqC2W-0001O8-Lc
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 02:18:05 -0500
Received: from m50-112.126.com ([123.125.50.112]:55085)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gqC2V-0001J3-EA
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 02:18:04 -0500
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-7-lifei1214@126.com>
	<87bm3v7j7o.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <80d9a956-2bfe-694e-7b9c-9501ae2ac6f7@126.com>
Date: Sun, 3 Feb 2019 15:17:52 +0800
MIME-Version: 1.0
In-Reply-To: <87bm3v7j7o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 06/11] qemu_thread: supplement
 error handling for emulated_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Gerd Hoffmann <kraxel@redhat.com>


在 2019/2/1 下午9:04, Markus Armbruster 写道:
> Fei Li <lifei1214@126.com> writes:
>
>> From: Fei Li <fli@suse.com>
>>
>> Utilize the existed errp to propagate the error and do the
>> corresponding cleanup to replace the temporary &error_abort.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   hw/usb/ccid-card-emulated.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>> index 0b170f6328..19b4b9a8fa 100644
>> --- a/hw/usb/ccid-card-emulated.c
>> +++ b/hw/usb/ccid-card-emulated.c
>> @@ -544,11 +544,16 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>>           error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
>>           goto out2;
>>       }
>> -    /* TODO: let the further caller handle the error instead of abort() here */
>> -    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>> -    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>> +    if (qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>> +                           card, QEMU_THREAD_JOINABLE, errp) < 0) {
>> +        goto out2;
>> +    }
>> +    if (qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
>> +                           handle_apdu_thread, card,
>> +                           QEMU_THREAD_JOINABLE, errp) < 0) {
>> +        qemu_thread_join(&card->event_thread_id);
> What makes event_thread terminate here?
>
> I'm asking because if it doesn't, the join will hang.
Oops, my neglect..  Could we add a 
`qemu_thread_cancel(card->event_thread_id);` here
before the join()?


Have a nice day, thanks
Fei
>
>> +        goto out2;
>> +    }
>>   
>>       return;
