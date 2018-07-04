Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fafh2-0004vK-5K
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fafgz-0007GO-G1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fafgz-0007GG-Bm
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704033642.15996-1-caoxinhua@huawei.com>
Date: Wed, 04 Jul 2018 13:11:23 +0200
In-Reply-To: <20180704033642.15996-1-caoxinhua@huawei.com> (xinhua Cao's
	message of "Wed, 4 Jul 2018 11:36:42 +0800")
Message-ID: <8736wzgsro.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "xinhua.Cao" <caoxinhua@huawei.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com, weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com

xinhua.Cao <caoxinhua@huawei.com> writes:

> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> we need check errno together with ret < 0.
>
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
> ---
>  chardev/char-socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 17519ec..efbad6e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,11 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
>  
> -        /* free the written msgfds in any cases other than errno==EAGAIN */
> -        if (EAGAIN != errno && s->write_msgfds_num) {
> +        /* free the written msgfds in any cases
> +         * other than ret < 0 && errno == EAGAIN
> +         */
> +        if (!(ret < 0 && EAGAIN == errno)
> +            && s->write_msgfds_num) {
>              g_free(s->write_msgfds);
>              s->write_msgfds = 0;
>              s->write_msgfds_num = 0;

The comment feels pretty worthless to me.
