Received: from eggs.gnu.org ([209.51.188.92]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghFik-0003Dk-3q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghFii-0007Jo-PI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:24:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghFii-0007JN-Gy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:24:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
	<87pnt7awhg.fsf@dusky.pond.sub.org>
	<cc1bec76-7724-2d0d-733c-e84f029776e4@126.com>
Date: Wed, 09 Jan 2019 16:24:36 +0100
In-Reply-To: <cc1bec76-7724-2d0d-733c-e84f029776e4@126.com> (Fei Li's message
	of "Wed, 9 Jan 2019 22:01:28 +0800")
Message-ID: <87o98pdfbf.fsf@dusky.pond.sub.org>
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
To: Fei Li <lifei1214@126.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> =E5=9C=A8 2019/1/9 =E4=B8=8A=E5=8D=881:29, Markus Armbruster =E5=86=99=E9=
=81=93:
>> fei <lifei1214@126.com> writes:
>>
>>>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:55=EF=BC=8CMark=
us Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>
>>>> Fei Li <fli@suse.com> writes:
>>>>
>>>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>>>> return when the QemuThread *thread failed to be created in either
>>>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>>>
>>>>> Cc: Stefan Weil <sw@weilnetz.de>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>>> ---
>>>>> util/qemu-thread-posix.c | 3 +++
>>>>> util/qemu-thread-win32.c | 2 +-
>>>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>>>> index 39834b0551..3548935dac 100644
>>>>> --- a/util/qemu-thread-posix.c
>>>>> +++ b/util/qemu-thread-posix.c
>>>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>>>      int err;
>>>>>      void *ret;
>>>>>
>>>>> +    if (!thread->thread) {
>>>>> +        return NULL;
>>>>> +    }
>>>> How can this happen?
>>> I think I have answered this earlier, please check the following link t=
o see whether it helps:
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html
>> Thanks for the pointer.  Unfortunately, I don't understand your
>> explanation.  You also wrote there "I will remove this patch in next
>> version"; looks like you've since changed your mind.
> Emm, issues left over from history.. The background is I was hurry to
> make those five
> Reviewed-by patches be merged, including this v9 16/16 patch but not
> the real
> qemu_thread_create() modification. But actually this patch is to fix
> the segmentation
> fault after we modified qemu_thread_create() related functions
> although it has got a
> Reviewed-by earlier. :) Thus to not make troube, I wrote the
> "remove..." sentence
> to separate it from those 5 Reviewed-by patches, and were plan to send
> only four patches.
> But later I got a message that these five patches are not that urgent
> to catch qemu v3.1,
> thus I joined the earlier 5 R-b patches into the later v8 & v9 to have
> a better review.
>
> Sorry for the trouble, I need to explain it without involving too much
> background..
>
> Back at the farm: in our current qemu code, some cleanups use a loop
> to join()
> the total number of threads if caller fails. This is not a problem
> until applying the
> qemu_thread_create() modification. E.g. when compress_threads_save_setup()
> fails while trying to create the last do_data_compress thread,
> segmentation fault
> will occur when join() is called (sadly there's not enough condition
> to filter this
> unsuccessful created thread) as this thread is actually not be created.
>
> Hope the above makes it clear. :)

Alright, let's have a look at compress_threads_save_setup():

    static int compress_threads_save_setup(void)
    {
        int i, thread_count;

        if (!migrate_use_compression()) {
            return 0;
        }
        thread_count =3D migrate_compress_threads();
        compress_threads =3D g_new0(QemuThread, thread_count);
        comp_param =3D g_new0(CompressParam, thread_count);
        qemu_cond_init(&comp_done_cond);
        qemu_mutex_init(&comp_done_lock);
        for (i =3D 0; i < thread_count; i++) {
            comp_param[i].originbuf =3D g_try_malloc(TARGET_PAGE_SIZE);
            if (!comp_param[i].originbuf) {
                goto exit;
            }

            if (deflateInit(&comp_param[i].stream,
                            migrate_compress_level()) !=3D Z_OK) {
                g_free(comp_param[i].originbuf);
                goto exit;
            }

            /* comp_param[i].file is just used as a dummy buffer to save da=
ta,
             * set its ops to empty.
             */
            comp_param[i].file =3D qemu_fopen_ops(NULL, &empty_ops);
            comp_param[i].done =3D true;
            comp_param[i].quit =3D false;
            qemu_mutex_init(&comp_param[i].mutex);
            qemu_cond_init(&comp_param[i].cond);
            qemu_thread_create(compress_threads + i, "compress",
                               do_data_compress, comp_param + i,
                               QEMU_THREAD_JOINABLE);
        }
        return 0;

    exit:
        compress_threads_save_cleanup();
        return -1;
    }

At label exit, we have @i threads, all fully initialized.  That's an
invariant.

compress_threads_save_cleanup() finds the threads to clean up by
checking comp_param[i].file:

    static void compress_threads_save_cleanup(void)
    {
        int i, thread_count;

        if (!migrate_use_compression() || !comp_param) {
            return;
        }

        thread_count =3D migrate_compress_threads();
        for (i =3D 0; i < thread_count; i++) {
            /*
             * we use it as a indicator which shows if the thread is
             * properly init'd or not
             */
--->        if (!comp_param[i].file) {
--->            break;
--->        }

            qemu_mutex_lock(&comp_param[i].mutex);
            comp_param[i].quit =3D true;
            qemu_cond_signal(&comp_param[i].cond);
            qemu_mutex_unlock(&comp_param[i].mutex);

            qemu_thread_join(compress_threads + i);
            qemu_mutex_destroy(&comp_param[i].mutex);
            qemu_cond_destroy(&comp_param[i].cond);
            deflateEnd(&comp_param[i].stream);
            g_free(comp_param[i].originbuf);
            qemu_fclose(comp_param[i].file);
            comp_param[i].file =3D NULL;
        }
        qemu_mutex_destroy(&comp_done_lock);
        qemu_cond_destroy(&comp_done_cond);
        g_free(compress_threads);
        g_free(comp_param);
        compress_threads =3D NULL;
        comp_param =3D NULL;
    }

Due to the invariant, a comp_param[i] with a null .file doesn't need
*any* cleanup.

To maintain the invariant, compress_threads_save_setup() carefully
cleans up any partial initializations itself before a goto exit.  Since
the code is arranged smartly, the only such cleanup is the
g_free(comp_param[i].originbuf) before the second goto exit.

Your PATCH 13 adds a third goto exit, but neglects to clean up partial
initializations.  Breaks the invariant.

I see two sane solutions:

1. compress_threads_save_setup() carefully cleans up partial
   initializations itself.  compress_threads_save_cleanup() copes only
   with fully initialized comp_param[i].  This is how things work before
   your series.

2. compress_threads_save_cleanup() copes with partially initialized
   comp_param[i], i.e. does the right thing for each goto exit in
   compress_threads_save_setup().  compress_threads_save_setup() doesn't
   clean up partial initializations.

Your PATCH 13 together with the fixup PATCH 16 does

3. A confusing mix of the two.

Don't.

> Have a nice day
> Fei
>>
>> What exactly breaks if we omit this patch?  Assuming something does
>> break: imagine we did omit this patch, then forgot we ever saw it, and
>> now you've discovered the breakage.  Write us the bug report, complete
>> with reproducer.
>>
>> [...]
