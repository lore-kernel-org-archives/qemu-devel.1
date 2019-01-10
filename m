Received: from eggs.gnu.org ([209.51.188.92]:34770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghWVy-0001DS-Rd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghWVx-0000J3-9C
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghWVx-0000Ij-1B
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:20:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
	<87pnt7awhg.fsf@dusky.pond.sub.org>
	<cc1bec76-7724-2d0d-733c-e84f029776e4@126.com>
	<87o98pdfbf.fsf@dusky.pond.sub.org>
	<7A219BBE-8D9D-4B40-892E-AA48D22F5967@126.com>
Date: Thu, 10 Jan 2019 10:20:33 +0100
In-Reply-To: <7A219BBE-8D9D-4B40-892E-AA48D22F5967@126.com> (fei's message of
	"Wed, 9 Jan 2019 23:57:10 +0800")
Message-ID: <87tvig7tsu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: fei <lifei1214@126.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, shirley17fei@gmail.com

fei <lifei1214@126.com> writes:

>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=889=E6=97=A5=EF=BC=8C23:24=EF=BC=8CMarkus=
 Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Fei Li <lifei1214@126.com> writes:
>>=20
>>>> =E5=9C=A8 2019/1/9 =E4=B8=8A=E5=8D=881:29, Markus Armbruster =E5=86=99=
=E9=81=93:
>>>> fei <lifei1214@126.com> writes:
>>>>=20
>>>>>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:55=EF=BC=8CMa=
rkus Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>=20
>>>>>> Fei Li <fli@suse.com> writes:
>>>>>>=20
>>>>>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>>>>>> return when the QemuThread *thread failed to be created in either
>>>>>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>>>>>=20
>>>>>>> Cc: Stefan Weil <sw@weilnetz.de>
>>>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>>>> ---
>>>>>>> util/qemu-thread-posix.c | 3 +++
>>>>>>> util/qemu-thread-win32.c | 2 +-
>>>>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>>=20
>>>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>>>> index 39834b0551..3548935dac 100644
>>>>>>> --- a/util/qemu-thread-posix.c
>>>>>>> +++ b/util/qemu-thread-posix.c
>>>>>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>>>>>     int err;
>>>>>>>     void *ret;
>>>>>>>=20
>>>>>>> +    if (!thread->thread) {
>>>>>>> +        return NULL;
>>>>>>> +    }
>>>>>> How can this happen?
>>>>> I think I have answered this earlier, please check the following link=
 to see whether it helps:
>>>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html
>>>> Thanks for the pointer.  Unfortunately, I don't understand your
>>>> explanation.  You also wrote there "I will remove this patch in next
>>>> version"; looks like you've since changed your mind.
>>> Emm, issues left over from history.. The background is I was hurry to
>>> make those five
>>> Reviewed-by patches be merged, including this v9 16/16 patch but not
>>> the real
>>> qemu_thread_create() modification. But actually this patch is to fix
>>> the segmentation
>>> fault after we modified qemu_thread_create() related functions
>>> although it has got a
>>> Reviewed-by earlier. :) Thus to not make troube, I wrote the
>>> "remove..." sentence
>>> to separate it from those 5 Reviewed-by patches, and were plan to send
>>> only four patches.
>>> But later I got a message that these five patches are not that urgent
>>> to catch qemu v3.1,
>>> thus I joined the earlier 5 R-b patches into the later v8 & v9 to have
>>> a better review.
>>>=20
>>> Sorry for the trouble, I need to explain it without involving too much
>>> background..
>>>=20
>>> Back at the farm: in our current qemu code, some cleanups use a loop
>>> to join()
>>> the total number of threads if caller fails. This is not a problem
>>> until applying the
>>> qemu_thread_create() modification. E.g. when compress_threads_save_setu=
p()
>>> fails while trying to create the last do_data_compress thread,
>>> segmentation fault
>>> will occur when join() is called (sadly there's not enough condition
>>> to filter this
>>> unsuccessful created thread) as this thread is actually not be created.
>>>=20
>>> Hope the above makes it clear. :)
>>=20
>> Alright, let's have a look at compress_threads_save_setup():
>>=20
>>    static int compress_threads_save_setup(void)
>>    {
>>        int i, thread_count;
>>=20
>>        if (!migrate_use_compression()) {
>>            return 0;
>>        }
>>        thread_count =3D migrate_compress_threads();
>>        compress_threads =3D g_new0(QemuThread, thread_count);
>>        comp_param =3D g_new0(CompressParam, thread_count);
>>        qemu_cond_init(&comp_done_cond);
>>        qemu_mutex_init(&comp_done_lock);
>>        for (i =3D 0; i < thread_count; i++) {
>>            comp_param[i].originbuf =3D g_try_malloc(TARGET_PAGE_SIZE);
>>            if (!comp_param[i].originbuf) {
>>                goto exit;
>>            }
>>=20
>>            if (deflateInit(&comp_param[i].stream,
>>                            migrate_compress_level()) !=3D Z_OK) {
>>                g_free(comp_param[i].originbuf);
>>                goto exit;
>>            }
>>=20
>>            /* comp_param[i].file is just used as a dummy buffer to save =
data,
>>             * set its ops to empty.
>>             */
>>            comp_param[i].file =3D qemu_fopen_ops(NULL, &empty_ops);
>>            comp_param[i].done =3D true;
>>            comp_param[i].quit =3D false;
>>            qemu_mutex_init(&comp_param[i].mutex);
>>            qemu_cond_init(&comp_param[i].cond);
>>            qemu_thread_create(compress_threads + i, "compress",
>>                               do_data_compress, comp_param + i,
>>                               QEMU_THREAD_JOINABLE);
>>        }
>>        return 0;
>>=20
>>    exit:
>>        compress_threads_save_cleanup();
>>        return -1;
>>    }
>>=20
>> At label exit, we have @i threads, all fully initialized.  That's an
>> invariant.
>>=20
>> compress_threads_save_cleanup() finds the threads to clean up by
>> checking comp_param[i].file:
>>=20
>>    static void compress_threads_save_cleanup(void)
>>    {
>>        int i, thread_count;
>>=20
>>        if (!migrate_use_compression() || !comp_param) {
>>            return;
>>        }
>>=20
>>        thread_count =3D migrate_compress_threads();
>>        for (i =3D 0; i < thread_count; i++) {
>>            /*
>>             * we use it as a indicator which shows if the thread is
>>             * properly init'd or not
>>             */
>> --->        if (!comp_param[i].file) {
>> --->            break;
>> --->        }
>>=20
>>            qemu_mutex_lock(&comp_param[i].mutex);
>>            comp_param[i].quit =3D true;
>>            qemu_cond_signal(&comp_param[i].cond);
>>            qemu_mutex_unlock(&comp_param[i].mutex);
>>=20
>>            qemu_thread_join(compress_threads + i);
>>            qemu_mutex_destroy(&comp_param[i].mutex);
>>            qemu_cond_destroy(&comp_param[i].cond);
>>            deflateEnd(&comp_param[i].stream);
>>            g_free(comp_param[i].originbuf);
>>            qemu_fclose(comp_param[i].file);
>>            comp_param[i].file =3D NULL;
>>        }
>>        qemu_mutex_destroy(&comp_done_lock);
>>        qemu_cond_destroy(&comp_done_cond);
>>        g_free(compress_threads);
>>        g_free(comp_param);
>>        compress_threads =3D NULL;
>>        comp_param =3D NULL;
>>    }
>>=20
>> Due to the invariant, a comp_param[i] with a null .file doesn't need
>> *any* cleanup.
>>=20
>> To maintain the invariant, compress_threads_save_setup() carefully
>> cleans up any partial initializations itself before a goto exit.  Since
>> the code is arranged smartly, the only such cleanup is the
>> g_free(comp_param[i].originbuf) before the second goto exit.
>>=20
>> Your PATCH 13 adds a third goto exit, but neglects to clean up partial
>> initializations.  Breaks the invariant.
>>=20
>> I see two sane solutions:
>>=20
>> 1. compress_threads_save_setup() carefully cleans up partial
>>   initializations itself.  compress_threads_save_cleanup() copes only
>>   with fully initialized comp_param[i].  This is how things work before
>>   your series.
>>=20
>> 2. compress_threads_save_cleanup() copes with partially initialized
>>   comp_param[i], i.e. does the right thing for each goto exit in
>>   compress_threads_save_setup().  compress_threads_save_setup() doesn't
>>   clean up partial initializations.
>>=20
>> Your PATCH 13 together with the fixup PATCH 16 does
>>=20
>> 3. A confusing mix of the two.
>>=20
>> Don't.
> Thanks for the detail analysis! :)
> Emm.. Actually I have thought to do the cleanup in the setup() function f=
or the third =E2=80=98goto exit=E2=80=99 [1],  which is a partial initializ=
ation.
> But due to the below [1] is too long and seems not neat (I notice that mo=
st cleanups for each thread are in the xxx_cleanup() function), I turned to=
 modify the join() function..=20
> Is the long [1] acceptable when the third =E2=80=98goto exit=E2=80=99 is =
called, or is there any other better way to do the cleanup?=20
>
> [1]
> qemu_mutex_lock(&comp_param[i].mutex);
>            comp_param[i].quit =3D true;
>            qemu_cond_signal(&comp_param[i].cond);
>            qemu_mutex_unlock(&comp_param[i].mutex);
>
> qemu_mutex_destroy(&comp_param[i].mutex);
>            qemu_cond_destroy(&comp_param[i].cond);
>            deflateEnd(&comp_param[i].stream);
>            g_free(comp_param[i].originbuf);
>            qemu_fclose(comp_param[i].file);
>            comp_param[i].file =3D NULL;

Have you considered creating the thread earlier, e.g. right after
initializing compression with deflateInit()?
