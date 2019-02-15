Received: from eggs.gnu.org ([209.51.188.92]:34411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gucj2-0003Jr-K4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gucis-0002W1-7L
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:36:10 -0500
Received: from m50-110.126.com ([123.125.50.110]:33283)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gucio-0002NF-SJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:36:05 -0500
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-7-lifei1214@126.com>
	<87bm3v7j7o.fsf@dusky.pond.sub.org>
	<80d9a956-2bfe-694e-7b9c-9501ae2ac6f7@126.com>
	<87womfptom.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <41ef1228-4ea5-ae07-712d-036c019fb374@126.com>
Date: Fri, 15 Feb 2019 20:35:10 +0800
MIME-Version: 1.0
In-Reply-To: <87womfptom.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Christophe Fergeau <cfergeau@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com


在 2019/2/4 下午9:30, Markus Armbruster 写道:
> Fei Li <lifei1214@126.com> writes:
>
>> 在 2019/2/1 下午9:04, Markus Armbruster 写道:
>>> Fei Li <lifei1214@126.com> writes:
>>>
>>>> From: Fei Li <fli@suse.com>
>>>>
>>>> Utilize the existed errp to propagate the error and do the
>>>> corresponding cleanup to replace the temporary &error_abort.
>>>>
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>> ---
>>>>    hw/usb/ccid-card-emulated.c | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>>>> index 0b170f6328..19b4b9a8fa 100644
>>>> --- a/hw/usb/ccid-card-emulated.c
>>>> +++ b/hw/usb/ccid-card-emulated.c
>>>> @@ -544,11 +544,16 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>>>>            error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
>>>>            goto out2;
>>>>        }
>>>> -    /* TODO: let the further caller handle the error instead of abort() here */
>>>> -    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>>>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>>>> -    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
>>>> -                       card, QEMU_THREAD_JOINABLE, &error_abort);
>>>> +    if (qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
>>>> +                           card, QEMU_THREAD_JOINABLE, errp) < 0) {
>>>> +        goto out2;
>>>> +    }
>>>> +    if (qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
>>>> +                           handle_apdu_thread, card,
>>>> +                           QEMU_THREAD_JOINABLE, errp) < 0) {
>>>> +        qemu_thread_join(&card->event_thread_id);
>>> What makes event_thread terminate here?
>>>
>>> I'm asking because if it doesn't, the join will hang.
>> Oops, my neglect..  Could we add a
>> `qemu_thread_cancel(card->event_thread_id);` here
>> before the join()?
> pthread_cancel() is difficult to use correctly, and we don't use it in
> QEMU so far.  Instead, we tell threads to stop, e.g. by setting a flag
> the thread checks in its main loop, and making sure the thread actually
> loops in bounded time.  How to best achieve that for this thread I don't
> know.  Christophe, Marc-André, can you help?
Hi, Christophe, Marc-André,
Would you like to share your views and give some suggestions? :)
That would be very helpful, thanks a lot!

Have a nice day
Fei
