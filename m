Received: from eggs.gnu.org ([209.51.188.92]:53023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjd4N-0003Jb-N7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjd4J-00020d-84
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:44:51 -0500
Received: from m50-110.126.com ([123.125.50.110]:48129)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gjd4C-0001lq-Gr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:44:43 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<f5631b6b-d313-88dc-f80a-890c26f109e4@126.com>
	<878sznquv6.fsf@dusky.pond.sub.org>
	<8504f713-0334-62b2-c462-4bdcb3c83caf@126.com>
	<871s5ejd1r.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <eb144f57-2641-47fc-8c40-334f2a5fd60b@126.com>
Date: Wed, 16 Jan 2019 12:43:50 +0800
MIME-Version: 1.0
In-Reply-To: <871s5ejd1r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org, shirley17fei@gmail.com


在 2019/1/15 下午8:55, Markus Armbruster 写道:
> Fei Li <lifei1214@126.com> writes:
>
>> 在 2019/1/14 下午8:36, Markus Armbruster 写道:
>>> Fei Li <lifei1214@126.com> writes:
>>>
>>>> Just to make sure about how to do the cleanup. I notice that in device_set_realized(),
>>>> the current code does not call "dc->unrealize(dev, NULL);" when dc->realize() fails.
>> Sorry that I am still uncertain.. I guess the code below I pasted was
>> misleading,
>> actually I want to stress the *dc->unrealize() is not called when
>> dc->realize() fails*
>> and the incomplete below "goto fail" does not include the dc->unrealize(),
>> but instead the dc->unrealize() is included in later
>> child_realize_fail: & post_realize_fail:.
>>
>>
>> Emm, IMHO, I think when dc->realize() fails, the dc->unrealize() is
>> either should be
>> called in the common function: device_set_realized() in a unified way,
>> that is
>>
>>          if (local_err != NULL) {
>> +          if (dc->unrealize) {
>> +              dc->unrealize(dev, local_err);
>> +          }
>>              goto fail;
>>          }
>>
>> or do the unrealize() locally for each device earlier when
>> dc->realize() fails.
>>
>> But I checked several dc->realize() function, they did not call unrealize()
>> when fails. Besides, it may mean verbose code if unrealize() locally.
>> Thus I think the above way is the right way to do the cleanup when
>> realize() fails.
> The realize() method is specified to either succeed completely or fail
> completely, i.e. fail and do nothing.  The "either succeed completely or
> fail completely" aspect of the specification is sane and perfectly
> ordinary.
>
> How a concrete implementation accomplishes "fail completely" is up to
> the implementation.
>
> An implementation may choose to structure its FOO_realize() and
> FOO_unrealize() in a way that lets FOO_realize() call FOO_unrealize() to
> clean up on failure.
>
> An implementation may also choose to clean up differently.
>
> This freedom of choice is by design.
>
> Changing the specification now would involve auditing and updating all
> realize() and unrealize() methods.  Not going to happen without an
> extremely compelling reason.

Ok, now I see. Thanks for the detail explanation. :)

Will add the cleanup in the next version.

Have a nice day
Fei
>>>>           if (dc->realize) {
>>>>               dc->realize(dev, &local_err);
>>>>           }
>>>>
>>>>           if (local_err != NULL) {
>>>>               goto fail;
>>>>           }
>>>>
>>>> Is this on purpose? (Maybe due to some devices' realize() do their own cleanup
>>>> when fails? Sorry for the unsure, it is such a common function that I did not
>>>> check all. :( ) Or else, I prefer to do the cleanup in a unified manner, e.g. call "dc->unrealize(dev, NULL);" which is the pci_qdev_unrealize() for pci devices.
>>> Yes, this is on purpose.
>>>
>>> When a realize() method fails, it must revert everything it has done so
>>> far.  Results in sane "either succeed completely, or fail and do
>>> nothing" semantics.
>> Have a nice day, thanks
>>
>> Fei
