Received: from eggs.gnu.org ([2001:4830:134:3::10]:49646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2Kpg-0001fY-Rk
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2Kod-0007HP-UV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:30:12 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2Kod-0007H9-NP
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:29:07 -0400
Received: by mail-qt0-x241.google.com with SMTP id y45so3311389qty.1
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:29:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171011153843.9876-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c1b51df-68dd-a848-af36-cab7ef7114c3@amsat.org>
Date: Wed, 11 Oct 2017 14:29:03 -0300
MIME-Version: 1.0
In-Reply-To: <20171011153843.9876-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] io: fix mem leak in websock error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Hi Daniel,

On 10/11/2017 12:38 PM, Daniel P. Berrange wrote:
> Coverity pointed out the 'date' is not free()d in the error
> path
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index aa35ef3274..a1c10ab719 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -355,6 +355,7 @@ static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
>                              QIO_CHANNEL_WEBSOCK_GUID_LEN,
>                              &accept,
>                              errp) < 0) {
> +        g_free(date);

It looks cleaner to only call qio_channel_websock_date_str() before to
use date, which is _after_ qcrypto_hash_base64() might fails.

>          qio_channel_websock_handshake_send_res_err(
>              ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR);
>          return;
    }

+   date = qio_channel_websock_date_str();
    qio_channel_websock_handshake_send_res(
        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);

    g_free(date);
    g_free(accept);
}
