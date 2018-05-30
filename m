Received: from eggs.gnu.org ([2001:4830:134:3::10]:57511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNrI8-0006U8-2k
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNrI3-0002XW-DV
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:56:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNrI3-0002X5-9f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:56:43 -0400
Date: Wed, 30 May 2018 10:56:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180530025637.GB25245@xz-mi>
References: <20180529025240.520-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529025240.520-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wangxinxin.wang@huawei.com

On Tue, May 29, 2018 at 10:52:40AM +0800, linzhecheng wrote:
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 159e69c3b1..17519ec589 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
>  
> -        /* free the written msgfds, no matter what */
> -        if (s->write_msgfds_num) {
> +        /* free the written msgfds in any cases other than errno==EAGAIN */
> +        if (EAGAIN != errno && s->write_msgfds_num) {

This makes sense to me.

Meanwhile this reminds me that we didn't release the fds in
tcp_chr_disconnect().  I'm thinking whether we should do that no
matter what.  E.g., what if we set_msgfds() then another operation
instead of write() failed?

Then here we can only release the msgfds when write succeeded...

  if (ret >= 0 && s->write_msgfds_num) {
 
...as long as we'll also cleanup the msgfds in tcp_chr_disconnect()
always.

I'll see how Marc-Andre and Paolo see this though.

Thanks,

>              g_free(s->write_msgfds);
>              s->write_msgfds = 0;
>              s->write_msgfds_num = 0;
> -- 
> 2.12.2.windows.2
> 
> 
> 

-- 
Peter Xu
