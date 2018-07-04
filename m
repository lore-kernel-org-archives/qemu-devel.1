Received: from eggs.gnu.org ([2001:4830:134:3::10]:58493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1faZAE-0003NO-4c
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1faZA9-0000oh-7A
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:13:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2633 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <caoxinhua@huawei.com>)
	id 1faZA8-0000jC-PJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:13:05 -0400
References: <20180702004910.13216-1-caoxinhua@huawei.com>
	<75a4e7db-594c-10e1-761a-38325bffa887@redhat.com>
From: xinhua.Cao <caoxinhua@huawei.com>
Message-ID: <c2d4bcb2-fd04-48fa-18dd-1a8df1b07058@huawei.com>
Date: Wed, 4 Jul 2018 12:12:40 +0800
MIME-Version: 1.0
In-Reply-To: <75a4e7db-594c-10e1-761a-38325bffa887@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-char: reset errno before qemu char
 write or read action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com



=E5=9C=A8 2018/7/2 16:46, Paolo Bonzini =E5=86=99=E9=81=93:
> On 02/07/2018 02:49, xinhua.Cao wrote:
>> In the tcp_chr_write function, we checked errno,
>> but errno was not reset before a read or write operation.
>> Therefore, this check of errno's actions is often
>> incorrect after EAGAIN has occurred.
>> We reset errno before reading and writing to
>> ensure the correctness of errno's judgment
> You should explain why this is a problem, because all the places you
> modified are checking that the read or write has returned -1.  In that
> case, errno must have been modified and it is unnecessary to write 0.
>
> Thanks,
>
> Paolo
We found this problem on qemu-2.6. At that time,
we backport the patch 9fc53a10 to qemu-2.6 and
found that when the virtual machine was started,
the fds of the ovs process increased a lot.
we check tcp_chr_write function, it is found
that errno is not reset. Therefore, when errno is
set to EAGAIN, write_msgfds will not be free subsequently.
In the qemu-2.6 version, another free write_msgfds is in vhost_user_write=
.
Vhost_user_write in qemu-2.6 check fd_num before calling=20
qemu_chr_fe_set_msgfds.
fd_num is 0 in many cases, so it won't be cleaned up here.
There have been a lot of cases of sending fds to ovs.

Thanks,

xinhua.Cao
>
>> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
>> ---
>>   chardev/char-fe.c | 1 +
>>   chardev/char.c    | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>> index b1f228e..d96ca6f 100644
>> --- a/chardev/char-fe.c
>> +++ b/chardev/char-fe.c
>> @@ -69,6 +69,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *b=
uf, int len)
>>  =20
>>       while (offset < len) {
>>       retry:
>> +        errno =3D 0;
>>           res =3D CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
>>                                                     len - offset);
>>           if (res =3D=3D -1 && errno =3D=3D EAGAIN) {
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 76d866e..3387442 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -85,6 +85,7 @@ static void qemu_chr_write_log(Chardev *s, const uin=
t8_t *buf, size_t len)
>>  =20
>>       while (done < len) {
>>       retry:
>> +        errno =3D 0;
>>           ret =3D write(s->logfd, buf + done, len - done);
>>           if (ret =3D=3D -1 && errno =3D=3D EAGAIN) {
>>               g_usleep(100);
>> @@ -109,6 +110,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>>       qemu_mutex_lock(&s->chr_write_lock);
>>       while (*offset < len) {
>>       retry:
>> +        errno =3D 0;
>>           res =3D cc->chr_write(s, buf + *offset, len - *offset);
>>           if (res < 0 && errno =3D=3D EAGAIN && write_all) {
>>               g_usleep(100);
>>
>
> .
>
