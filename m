Received: from eggs.gnu.org ([2001:4830:134:3::10]:43817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSh7t-0001cx-1w
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSh7p-0001Uz-5u
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:38:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48162 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSh7n-0001Th-40
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:38:25 -0500
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-3-fli@suse.com>
	<a4a3753d-8986-85c4-f098-395bc4379506@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <088f213c-0fe8-8444-6311-8fbcfc80da30@suse.com>
Date: Fri, 30 Nov 2018 19:38:16 +0800
MIME-Version: 1.0
In-Reply-To: <a4a3753d-8986-85c4-f098-395bc4379506@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/5] qemu_thread_join: fix segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org



On 11/29/2018 10:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fei,
>
> On 28/11/18 11:33, Fei Li wrote:
>> To avoid the segmentation fault in qemu_thread_join(), just directly
>> return when the QemuThread *thread failed to be created in either
>> qemu-thread-posix.c or qemu-thread-win32.c.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>   util/qemu-thread-posix.c | 3 +++
>>   util/qemu-thread-win32.c | 2 +-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 865e476df5..b9ab5a4711 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -558,6 +558,9 @@ void *qemu_thread_join(QemuThread *thread)
>>       int err;
>>       void *ret;
>>  =20
>> +    if (!thread->thread) {
>> +        return NULL;
>> +    }
>>       err =3D pthread_join(thread->thread, &ret);
>>       if (err) {
>>           error_exit(err, __func__);
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index 4a363ca675..1a27e1cf6f 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -366,7 +366,7 @@ void *qemu_thread_join(QemuThread *thread)
>>       HANDLE handle;
>>  =20
>>       data =3D thread->data;
>> -    if (data->mode =3D=3D QEMU_THREAD_DETACHED) {
>> +    if (data =3D=3D NULL || data->mode =3D=3D QEMU_THREAD_DETACHED) {
> Isn't it a way to hide a problem from the caller?
>
> qemu_thread_create() always initializes thread->data.
>
> If the thread doesn't exist you shouldn't try to join() it.
>
> If you try to fix a bug, I'd use here:
>
>         assert(thread->data);
>
> Regards,
>
> Phil.
Emm, this patch is actually should not be abstracted separately...
It should be along with the "[PATCH RFC v7 9/9] qemu_thread_create:
propagate errors to callers to check."

For the 9/9 patch, when qemu_thread_create() fails, we would like
the callers to handle the error instead of directly abort in order to rob=
ust
our qemu code (e.g. do not let qemu crash when fails to hot-plug a cpu).
And only within that patch, we need to check whether the thread has been
created: if not just return NULL, which means no handling for that thread=
.
This is because for many cleanups, we just use a loop to join() all the
thread_count. e.g. when compress_threads_save_setup() fails while
trying to create the second/third do_data_compress thread. (Supposing
there are more than three compress threads).

I will remove this patch in next version. Thanks for pointing this out. :=
)

Have a nice day
Fei
>
>>           return NULL;
>>       }
>>  =20
>>
>
