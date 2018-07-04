Received: from eggs.gnu.org ([2001:4830:134:3::10]:55099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeFe-0005UY-6G
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeFb-0006pO-20
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:39:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faeFa-0006p9-T1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:39:02 -0400
References: <20180704033642.15996-1-caoxinhua@huawei.com>
	<CAJ+F1CKTPE+gKbR5sHvRFxcMnN4ToxxhMoQzeZVcnri+WJVyow@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98094b22-7a90-10e0-45d5-1f8ba312b1cb@redhat.com>
Date: Wed, 4 Jul 2018 11:38:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKTPE+gKbR5sHvRFxcMnN4ToxxhMoQzeZVcnri+WJVyow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-char: check errno together with ret <
 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "xinhua.Cao" <caoxinhua@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, weidong.huang@huawei.com, weifuqiang@huawei.com, QEMU <qemu-devel@nongnu.org>, king.wang@huawei.com, liuyongan@huawei.com, Gonglei <arei.gonglei@huawei.com>

On 04/07/2018 11:36, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Jul 4, 2018 at 5:36 AM, xinhua.Cao <caoxinhua@huawei.com> wrote=
:
>> In the tcp_chr_write function, we checked errno,
>> but errno was not reset before a read or write operation.
>> Therefore, this check of errno's actions is often
>> incorrect after EAGAIN has occurred.
>> we need check errno together with ret < 0.
>>
>> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
>=20
>=20
> Can you point out this is fixing commit
> 9fc53a10f81d3a9027b23fa810147d21be29e614 in commit message?

Ok, done.

Thanks,

Paolo

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
>> ---
>>  chardev/char-socket.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 17519ec..efbad6e 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -134,8 +134,11 @@ static int tcp_chr_write(Chardev *chr, const uint=
8_t *buf, int len)
>>                                          s->write_msgfds,
>>                                          s->write_msgfds_num);
>>
>> -        /* free the written msgfds in any cases other than errno=3D=3D=
EAGAIN */
>> -        if (EAGAIN !=3D errno && s->write_msgfds_num) {
>> +        /* free the written msgfds in any cases
>> +         * other than ret < 0 && errno =3D=3D EAGAIN
>> +         */
>> +        if (!(ret < 0 && EAGAIN =3D=3D errno)
>> +            && s->write_msgfds_num) {
>>              g_free(s->write_msgfds);
>>              s->write_msgfds =3D 0;
>>              s->write_msgfds_num =3D 0;
>> --
>> 2.8.3
>>
>>
>>
>=20
>=20
>=20
