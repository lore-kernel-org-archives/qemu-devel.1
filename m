Received: from eggs.gnu.org ([2001:4830:134:3::10]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqJEV-0003ky-PI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqJES-00051h-K2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:22:07 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqJES-000515-FT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:22:04 -0400
Received: by mail-qt0-x241.google.com with SMTP id p55so1539512qtc.2
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:22:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170908103011.25821-1-berrange@redhat.com>
	<20170908103011.25821-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70a0110b-8295-f0d1-a69c-29d83178d6e9@amsat.org>
Date: Fri, 8 Sep 2017 10:22:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170908103011.25821-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] io: use case insensitive check for
 Connection & Upgrade websock headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>

Hi Daniel,

On 09/08/2017 07:30 AM, Daniel P. Berrange wrote:
> When checking the value of the Connection and Upgrade HTTP headers
> the websock RFC (6455) requires the comparison to be case insensitive.
> The Connection value should be an exact match not a substring.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   io/channel-websock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index aed7a6c9b3..ab332ec907 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -427,12 +427,12 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>           goto bad_request;
>       }
>   
> -    if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) {
> +    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) != 0) {

Why not use g_ascii_strcasecmp() ?

>           error_setg(errp, "No connection upgrade requested '%s'", connection);
>           goto bad_request;
>       }
>   
> -    if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
> +    if (strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) != 0) {
>           error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
>           goto bad_request;
>       }
> 
