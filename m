Received: from eggs.gnu.org ([209.51.188.92]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghEQU-0001gl-GD
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghEQK-00020j-1i
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:01:46 -0500
Received: from m50-110.126.com ([123.125.50.110]:43005)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghEQI-0001y8-I2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:01:35 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
	<87pnt7awhg.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <cc1bec76-7724-2d0d-733c-e84f029776e4@126.com>
Date: Wed, 9 Jan 2019 22:01:28 +0800
MIME-Version: 1.0
In-Reply-To: <87pnt7awhg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 16/16] qemu_thread_join: fix
 segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, shirley17fei@gmail.com


在 2019/1/9 上午1:29, Markus Armbruster 写道:
> fei <lifei1214@126.com> writes:
>
>>> 在 2019年1月8日，01:55，Markus Armbruster <armbru@redhat.com> 写道：
>>>
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>>> return when the QemuThread *thread failed to be created in either
>>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>>
>>>> Cc: Stefan Weil <sw@weilnetz.de>
>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>> ---
>>>> util/qemu-thread-posix.c | 3 +++
>>>> util/qemu-thread-win32.c | 2 +-
>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>> index 39834b0551..3548935dac 100644
>>>> --- a/util/qemu-thread-posix.c
>>>> +++ b/util/qemu-thread-posix.c
>>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>>      int err;
>>>>      void *ret;
>>>>
>>>> +    if (!thread->thread) {
>>>> +        return NULL;
>>>> +    }
>>> How can this happen?
>> I think I have answered this earlier, please check the following link to see whether it helps:
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html
> Thanks for the pointer.  Unfortunately, I don't understand your
> explanation.  You also wrote there "I will remove this patch in next
> version"; looks like you've since changed your mind.
Emm, issues left over from history.. The background is I was hurry to 
make those five
Reviewed-by patches be merged, including this v9 16/16 patch but not the 
real
qemu_thread_create() modification. But actually this patch is to fix the 
segmentation
fault after we modified qemu_thread_create() related functions although 
it has got a
Reviewed-by earlier. :) Thus to not make troube, I wrote the "remove..." 
sentence
to separate it from those 5 Reviewed-by patches, and were plan to send 
only four patches.
But later I got a message that these five patches are not that urgent to 
catch qemu v3.1,
thus I joined the earlier 5 R-b patches into the later v8 & v9 to have a 
better review.

Sorry for the trouble, I need to explain it without involving too much 
background..

Back at the farm: in our current qemu code, some cleanups use a loop to 
join()
the total number of threads if caller fails. This is not a problem until 
applying the
qemu_thread_create() modification. E.g. when compress_threads_save_setup()
fails while trying to create the last do_data_compress thread, 
segmentation fault
will occur when join() is called (sadly there's not enough condition to 
filter this
unsuccessful created thread) as this thread is actually not be created.

Hope the above makes it clear. :)

Have a nice day
Fei
>
> What exactly breaks if we omit this patch?  Assuming something does
> break: imagine we did omit this patch, then forgot we ever saw it, and
> now you've discovered the breakage.  Write us the bug report, complete
> with reproducer.
>
> [...]
