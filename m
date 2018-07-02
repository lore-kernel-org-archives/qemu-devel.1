Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZxSs-0001Uj-0l
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZxSo-0005zD-65
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:57:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fZxSo-0005z2-1q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:57:50 -0400
References: <20180702004910.13216-1-caoxinhua@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc41d8c5-f8cc-90ab-f6fe-064ff071116e@redhat.com>
Date: Mon, 2 Jul 2018 06:57:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180702004910.13216-1-caoxinhua@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "xinhua.Cao" <caoxinhua@huawei.com>, pbonzini@redhat.com, marcandre.lureau@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, weifuqiang@huawei.com, king.wang@huawei.com, arei.gonglei@huawei.com, liuyongan@huawei.com, qemu-devel@nongnu.org

On 07/01/2018 07:49 PM, xinhua.Cao wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> We reset errno before reading and writing to
> ensure the correctness of errno's judgment
> 
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
> ---
>   chardev/char-fe.c | 1 +
>   chardev/char.c    | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index b1f228e..d96ca6f 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -69,6 +69,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>   
>       while (offset < len) {
>       retry:
> +        errno = 0;
>           res = CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
>                                                     len - offset);
>           if (res == -1 && errno == EAGAIN) {

NACK.  read() is guaranteed to have set errno if res is -1, and we don't 
check errno unless we first checked that res was -1.  Thus, the EAGAIN 
check is not confused by a stale errno value.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
