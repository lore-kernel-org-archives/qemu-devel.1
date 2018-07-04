Received: from eggs.gnu.org ([2001:4830:134:3::10]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1faXFi-0002bJ-QL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1faXFf-0001pD-Kb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:10:42 -0400
Received: from [45.249.212.35] (port=56804 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <caoxinhua@huawei.com>)
	id 1faXFf-0001gF-4q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:10:39 -0400
References: <20180702004910.13216-1-caoxinhua@huawei.com>
	<20180702150111.GI2155@stefanha-x1.localdomain>
From: xinhua.Cao <caoxinhua@huawei.com>
Message-ID: <6746e830-421b-6331-b904-41c6b309cb0a@huawei.com>
Date: Wed, 4 Jul 2018 10:10:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180702150111.GI2155@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com, weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com



=E5=9C=A8 2018/7/2 23:01, Stefan Hajnoczi =E5=86=99=E9=81=93:
> On Mon, Jul 02, 2018 at 08:49:10AM +0800, xinhua.Cao wrote:
>> In the tcp_chr_write function, we checked errno,
>> but errno was not reset before a read or write operation.
>> Therefore, this check of errno's actions is often
>> incorrect after EAGAIN has occurred.
>> We reset errno before reading and writing to
>> ensure the correctness of errno's judgment
>>
>> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
>> ---
>>   chardev/char-fe.c | 1 +
>>   chardev/char.c    | 2 ++
>>   2 files changed, 3 insertions(+)
> The C11x standard "7.4 Errors <errno.h>" says that errno "is never set
> to zero by any library function".  Please follow the errno usage
> convention described in the C standard.
yes, I know that errno must be used after a negative return value.
 =C2=A0But if you check the return value in tcp_chr_write,
the logic is a bit more complicated. So I reset the errno in the outer=20
layer.
I will check the return value at tcp_chr_write at v2 patch.
> Instead of making functions called by tcp_chr_write() clear errno,
> please fix tcp_chr_write() so that errno is only accessed when ret < 0.
>
> Thanks,
> Stefan
