Received: from eggs.gnu.org ([2001:4830:134:3::10]:36270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cl2iE-0005Nk-OO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cl2iA-0004Op-PX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:10:46 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cl2iA-0004Ol-L0
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 19:10:42 -0500
Received: by mail-qk0-x244.google.com with SMTP id n141so24912647qke.3
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 16:10:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170306223054.25666-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01052592-5c40-8dc6-da15-5376a6ee8354@amsat.org>
Date: Mon, 6 Mar 2017 21:10:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170306223054.25666-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hi Vladimir,

On 03/06/2017 07:30 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Comparison symbol is misused. It may lead to memory corruption.
> Introduced in commit 7d3123e.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
> [eblake: add CVE details]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-André Lureau <address@hidden>
> ---
>
> This one still hasn't been merged in; sending separately since the
> rest of my NBD series is now 2.10 material:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04528.html
>
>  nbd/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 5c9dee3..165b33e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
>      char small[1024];
>      char *buffer;
>
> -    buffer = sizeof(small) < size ? small : g_malloc(MIN(65536, size));
> +    buffer = sizeof(small) > size ? small : g_malloc(MIN(65536, size));

here ">=" seems correct/safe.
(if size is 1024, use small stack buffer too).

>      while (size > 0) {
>          ssize_t count = read_sync(ioc, buffer, MIN(65536, size));
>
