Received: from eggs.gnu.org ([209.51.188.92]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGJ2-00026N-Ug
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGIw-0004Fy-0K
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:02:12 -0500
Received: from m15-113.126.com ([220.181.15.113]:38523)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ghGIv-0003oG-BW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:02:05 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87k1jddf8y.fsf@dusky.pond.sub.org>
Date: Thu, 10 Jan 2019 00:01:16 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C50541D1-BAAA-4D90-BCE9-42FEAA9D320D@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-14-fli@suse.com>
	<87k1jddf8y.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 13/16] qemu_thread: supplement
 error handling for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=889=E6=97=A5=EF=BC=8C23:26=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> Update qemu_thread_create()'s callers by
>> - setting an error on qemu_thread_create() failure for callers that
>>  set an error on failure;
>> - reporting the error and returning failure for callers that return
>>  an error code on failure;
>> - reporting the error and setting some state for callers that just
>>  report errors and choose not to continue on.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
> [...]
>> diff --git a/migration/ram.c b/migration/ram.c
>> index eed1daf302..1e24a78eaa 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
> [...]
>> @@ -3625,6 +3637,7 @@ static void compress_threads_load_cleanup(void)
>> static int compress_threads_load_setup(QEMUFile *f)
>> {
>>     int i, thread_count;
>> +    Error *local_err =3D NULL;
>>=20
>>     if (!migrate_use_compression()) {
>>         return 0;
>> @@ -3646,10 +3659,13 @@ static int compress_threads_load_setup(QEMUFile *=
f)
>>         qemu_cond_init(&decomp_param[i].cond);
>>         decomp_param[i].done =3D true;
>>         decomp_param[i].quit =3D false;
>> -        /* TODO: let the further caller handle the error instead of abor=
t() */
>> -        qemu_thread_create(decompress_threads + i, "decompress",
>> -                           do_data_decompress, decomp_param + i,
>> -                           QEMU_THREAD_JOINABLE, &error_abort);
>> +        if (!qemu_thread_create(decompress_threads + i, "decompress",
>> +                                do_data_decompress, decomp_param + i,
>> +                                QEMU_THREAD_JOINABLE, &local_err)) {
>> +            error_reportf_err(local_err,
>> +                              "failed to create do_data_decompress: ");
>> +            goto exit;
>=20
> Broken error handling, see my review of PATCH 16.
Yep, seems both the compress_threads_save_setup() and compress_threads_load_=
setup() have such problem.

>=20
>> +        }
>>     }
>>     return 0;
>> exit:
> [...]
