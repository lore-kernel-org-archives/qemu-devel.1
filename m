Received: from eggs.gnu.org ([2001:4830:134:3::10]:40282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWd7y-0001It-0q
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWd7n-00061L-4k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:10:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWd7m-0005yk-Jl
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:10:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so13036988wra.6
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 00:10:38 -0800 (PST)
References: <20181211072649.20700-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef32bf31-f3be-8c14-9d6f-618c47d2b206@redhat.com>
Date: Tue, 11 Dec 2018 09:10:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181211072649.20700-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb-audio: ignore usb packages with wrong
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 12/11/18 8:26 AM, Gerd Hoffmann wrote:
> usb packets with no payload (zero length) seem to happen in practice for
> whatever reason.  Add a check and skip the packet then, otherwise we'll
> trigger an assert.
> 
> Reported-by: Leonardo Soares Müller <leozinho29_eu@hotmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/dev-audio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index ee43e4914d..28ac7c5165 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -321,6 +321,9 @@ static int streambuf_put(struct streambuf *buf, USBPacket *p)
>      if (!free) {
>          return 0;
>      }
> +    if (p->iov.size != USBAUDIO_PACKET_SIZE) {
> +        return 0;
> +    }
>      assert(free >= USBAUDIO_PACKET_SIZE);
>      usb_packet_copy(p, buf->data + (buf->prod % buf->size),
>                      USBAUDIO_PACKET_SIZE);
> 
