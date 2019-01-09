Received: from eggs.gnu.org ([209.51.188.92]:40079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGU4-0007Xo-7y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGU3-0002i4-7k
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:13:36 -0500
Received: from m15-111.126.com ([220.181.15.111]:59282)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGU0-0002dc-5c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:13:33 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87k1jgjpzd.fsf@dusky.pond.sub.org>
Date: Thu, 10 Jan 2019 00:13:19 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDD42565-9FDA-4EA0-9BF1-03ABB807D078@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-16-fli@suse.com>
	<87k1jgjpzd.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 15/16] qemu_thread: supplement
 error handling for touch_all_pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C02:13=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> Supplement the error handling for touch_all_pages: add an Error
>> parameter for it to propagate the error to its caller to do the
>> handling in case it fails.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>> util/oslib-posix.c | 25 ++++++++++++++++---------
>> 1 file changed, 16 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 251e2f1aea..afc1d99093 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -431,15 +431,17 @@ static inline int get_memset_num_threads(int smp_cp=
us)
>> }
>>=20
>> static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages=
,
>> -                            int smp_cpus)
>> +                            int smp_cpus, Error **errp)
>> {
>>     size_t numpages_per_thread;
>>     size_t size_per_thread;
>>     char *addr =3D area;
>>     int i =3D 0;
>> +    int started_thread =3D 0;
>>=20
>>     memset_thread_failed =3D false;
>>     memset_num_threads =3D get_memset_num_threads(smp_cpus);
>> +    started_thread =3D memset_num_threads;
>>     memset_thread =3D g_new0(MemsetThread, memset_num_threads);
>>     numpages_per_thread =3D (numpages / memset_num_threads);
>>     size_per_thread =3D (hpagesize * numpages_per_thread);
>> @@ -448,14 +450,18 @@ static bool touch_all_pages(char *area, size_t hpag=
esize, size_t numpages,
>>         memset_thread[i].numpages =3D (i =3D=3D (memset_num_threads - 1))=
 ?
>>                                     numpages : numpages_per_thread;
>>         memset_thread[i].hpagesize =3D hpagesize;
>> -        /* TODO: let the callers handle the error instead of abort() her=
e */
>> -        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>> -                           do_touch_pages, &memset_thread[i],
>> -                           QEMU_THREAD_JOINABLE, &error_abort);
>> +        if (!qemu_thread_create(&memset_thread[i].pgthread, "touch_pages=
",
>> +                                do_touch_pages, &memset_thread[i],
>> +                                QEMU_THREAD_JOINABLE, errp)) {
>> +            memset_thread_failed =3D true;
>> +            started_thread =3D i;
>> +            goto out;
>=20
> break rather than goto, please.
Ok
>=20
>> +        }
>>         addr +=3D size_per_thread;
>>         numpages -=3D numpages_per_thread;
>>     }
>> -    for (i =3D 0; i < memset_num_threads; i++) {
>> +out:
>> +    for (i =3D 0; i < started_thread; i++) {
>>         qemu_thread_join(&memset_thread[i].pgthread);
>>     }
>=20
> I don't like how @started_thread is computed.  The name suggests it's
> the number of threads started so far.  That's the case when you
> initialize it to zero.  But then you immediately set it to
> memset_thread().  It again becomes the case only when you break the loop
> on error, or when you complete it successfully.
>=20
> There's no need for @started_thread, since the number of threads created
> is readily available as @i:
>=20
>       memset_num_threads =3D i;
Thanks for this wonderful suggestion! This helps a lot! ;)
>       for (i =3D 0; i < memset_num_threads; i++) {
>           qemu_thread_join(&memset_thread[i].pgthread);
>       }
>=20
> Rest of the function:
>=20
>>     g_free(memset_thread);
>       memset_thread =3D NULL;
>=20
>       return memset_thread_failed;
>   }
>=20
> If do_touch_pages() set memset_thread_failed(), we return false without
> setting an error.  I believe you should
>=20
>       if (memset_thread_failed) {
>           error_setg(errp, "os_mem_prealloc: Insufficient free host memory=
 "
>               "pages available to allocate guest RAM");
>           return false;
>       }
>       return true;
>=20
Ok
> here, and ...
>=20
>> @@ -471,6 +477,7 @@ void os_mem_prealloc(int fd, char *area, size_t memor=
y, int smp_cpus,
>>     struct sigaction act, oldact;
>>     size_t hpagesize =3D qemu_fd_getpagesize(fd);
>>     size_t numpages =3D DIV_ROUND_UP(memory, hpagesize);
>> +    Error *local_err =3D NULL;
>>=20
>>     memset(&act, 0, sizeof(act));
>>     act.sa_handler =3D &sigbus_handler;
>> @@ -484,9 +491,9 @@ void os_mem_prealloc(int fd, char *area, size_t memor=
y, int smp_cpus,
>>     }
>>=20
>>     /* touch pages simultaneously */
>> -    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
>> -        error_setg(errp, "os_mem_prealloc: Insufficient free host memory=
 "
>> -            "pages available to allocate guest RAM");
>> +    if (touch_all_pages(area, hpagesize, numpages, smp_cpus, &local_err)=
) {
>> +        error_propagate_prepend(errp, local_err, "os_mem_prealloc: Insuf=
ficient"
>> +            " free host memory pages available to allocate guest RAM: ")=
;
>>     }
>=20
> ... not mess with the error message here, i.e.
>=20
>       touch_all_pages(area, hpagesize, numpages, smp_cpus), errp);
Ok, will amend this in the next version.=20

Have a nice day, thanks again
Fei
>=20
>>=20
>>     ret =3D sigaction(SIGBUS, &oldact, NULL);
