Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1csKj9-0002Si-0p
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 22:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1csKj5-000703-Ty
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 22:49:51 -0400
Received: from [45.249.212.189] (port=2877 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1csKiI-0006XA-08
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 22:49:47 -0400
References: <1490579897-3793-1-git-send-email-wang.guang55@zte.com.cn>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58D87D5E.8000101@huawei.com>
Date: Mon, 27 Mar 2017 10:47:59 +0800
MIME-Version: 1.0
In-Reply-To: <1490579897-3793-1-git-send-email-wang.guang55@zte.com.cn>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: Fix colo hang in
 socket_accept_incoming_migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guang Wang <wang.guang55@zte.com.cn>
Cc: berrange@redhat.com, dgilbert@redhat.com, xuquan8@huawei.com, zhangchen.fnst@cn.fujitsu.com, eblake@redhat.com, qemu-devel@nongnu.org

Hi,

It seems that there is no difference from your previous version.
You don't have to re-send it if there are no changes.
This patch has been reviewed, so you can just wait until maintainers process it :)

Thanks.

On 2017/3/27 9:58, Guang Wang wrote:
> From: Wang guang <wang.guang55@zte.com.cn>
>
> The channel socket was initialized manually,
> but forgot to set QIO_CHANNEL_FEATURE_SHUTDOWN.
> Thus, the colo_process_incoming_thread would hang at recvmsg.
> This patch just call qio_channel_socket_new to get channel,
> Which set QIO_CHANNEL_FEATURE_SHUTDOWN already.
>
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   io/channel-socket.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index f546c68..64b36f5 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -331,16 +331,10 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>   {
>       QIOChannelSocket *cioc;
>   
> -    cioc = QIO_CHANNEL_SOCKET(object_new(TYPE_QIO_CHANNEL_SOCKET));
> -    cioc->fd = -1;
> +    cioc = qio_channel_socket_new();
>       cioc->remoteAddrLen = sizeof(ioc->remoteAddr);
>       cioc->localAddrLen = sizeof(ioc->localAddr);
>   
> -#ifdef WIN32
> -    QIO_CHANNEL(cioc)->event = CreateEvent(NULL, FALSE, FALSE, NULL);
> -#endif
> -
> -
>    retry:
>       trace_qio_channel_socket_accept(ioc);
>       cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
