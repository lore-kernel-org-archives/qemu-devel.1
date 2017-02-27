Received: from eggs.gnu.org ([2001:4830:134:3::10]:57634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciRdm-0000YJ-Cb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciRdl-0003jj-4v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciRdk-0003jZ-VK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:25 -0500
Date: Mon, 27 Feb 2017 20:11:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227201119.GA25346@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485782396-22341-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485782396-22341-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] io: ignore case in WebSocket HTTP
 header #PSBM-57554
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Mon, Jan 30, 2017 at 04:19:56PM +0300, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
> 
> According to RFC7230 Section 3.2, header field name is case-insensitive.
> 
> The haystack string length is limited by 4096 bytes by
> qio_channel_websock_handshake_read().
> 
> Further, handshake_process() dups and NULL-terminates the string
> so it is safe to call non length-limited functions like strcasestr().
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index d5a4ed3..991925a 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -108,18 +108,16 @@ enum {
>  };
>  
>  static char *qio_channel_websock_handshake_entry(const char *handshake,
> -                                                 size_t handshake_len,
>                                                   const char *name)
>  {
>      char *begin, *end, *ret = NULL;
>      char *line = g_strdup_printf("%s%s: ",
>                                   QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM,
>                                   name);
> -    begin = g_strstr_len(handshake, handshake_len, line);
> +    begin = strcasestr(handshake, line);

So this turns out to break Windows builds since there's no strcasestr
on Mingw. There's no alternative that I know of in glib and I don't
fancy implementing a custom strcasestr() function. So I'm going to
drop this patch entirely, and copy you on an alternative fix that
simply converts the input data to lowercase before comparison. Would
appreciate if you can test my alternate patch with whatever client
you had problems with.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
