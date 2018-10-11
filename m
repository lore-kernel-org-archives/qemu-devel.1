Received: from eggs.gnu.org ([2001:4830:134:3::10]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAZc5-0001bQ-Bu
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAZc1-0005iZ-J9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:58:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAZbz-0005hY-KN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:58:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so9358770wrd.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 04:58:39 -0700 (PDT)
References: <20181011112436.9305-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
Date: Thu, 11 Oct 2018 13:58:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181011112436.9305-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: check buffer size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Gerd Hoffmann <kraxel@redhat.com>, Arash TC <tohidi.arash@gmail.com>

Cc'ing Paolo & Marc-André.

On 11/10/2018 13:24, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading virtual smart card data, if buffer 'size' is negative
> it would lead to memory corruption errors. Add check to avoid it.

The IOReadHandler does not have documentation.

 typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);

Why is the 'size' argument signed? Does it makes sens to call it with a
negative value?

Thanks,

Phil.

> 
> Reported-by: Arash TC <tohidi.arash@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/usb/ccid-card-passthru.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 0a6c657228..63ed78f4c6 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -275,6 +275,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>      PassthruState *card = opaque;
>      VSCMsgHeader *hdr;
>  
> +    assert(0 <= size && size < VSCARD_IN_SIZE);
>      if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
>          error_report("no room for data: pos %u +  size %d > %" PRId64 "."
>                       " dropping connection.",
> 
