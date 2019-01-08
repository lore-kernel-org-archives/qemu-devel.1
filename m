Received: from eggs.gnu.org ([209.51.188.92]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguZw-0005cm-9X
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguZu-0008G6-5x
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:50:12 -0500
Received: from m15-114.126.com ([220.181.15.114]:46626)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gguZr-00080g-71
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:50:09 -0500
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <874lakl5d2.fsf@dusky.pond.sub.org>
Date: Wed, 9 Jan 2019 00:50:01 +0800
Message-Id: <5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
Content-Type: text/plain;
	charset=utf-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Stefan Weil <sw@weilnetz.de>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:55=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> To avoid the segmentation fault in qemu_thread_join(), just directly
>> return when the QemuThread *thread failed to be created in either
>> qemu-thread-posix.c or qemu-thread-win32.c.
>>=20
>> Cc: Stefan Weil <sw@weilnetz.de>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>> util/qemu-thread-posix.c | 3 +++
>> util/qemu-thread-win32.c | 2 +-
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 39834b0551..3548935dac 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>     int err;
>>     void *ret;
>>=20
>> +    if (!thread->thread) {
>> +        return NULL;
>> +    }
>=20
> How can this happen?
I think I have answered this earlier, please check the following link to see=
 whether it helps:
http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html

Have a nice day, thanks
Fei
>=20
>>     err =3D pthread_join(thread->thread, &ret);
>>     if (err) {
>>         error_exit(err, __func__);
>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>> index 57b1143e97..ca4d5329e3 100644
>> --- a/util/qemu-thread-win32.c
>> +++ b/util/qemu-thread-win32.c
>> @@ -367,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
>>     HANDLE handle;
>>=20
>>     data =3D thread->data;
>> -    if (data->mode =3D=3D QEMU_THREAD_DETACHED) {
>> +    if (data =3D=3D NULL || data->mode =3D=3D QEMU_THREAD_DETACHED) {
>>         return NULL;
>>     }
