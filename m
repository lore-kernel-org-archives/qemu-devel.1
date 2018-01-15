Received: from eggs.gnu.org ([2001:4830:134:3::10]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1eb9X1-00055q-5w
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1eb9Ww-0005pn-5I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:51 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1eb9Wv-0005pW-TJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:30:46 -0500
Received: by mail-lf0-x244.google.com with SMTP id f3so14441635lfe.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:30:45 -0800 (PST)
References: <4692971516029191@web59g.yandex.ru>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <f9e196c1-72ba-a332-ef05-b764f57d79f5@gmail.com>
Date: Mon, 15 Jan 2018 19:30:42 +0100
MIME-Version: 1.0
In-Reply-To: <4692971516029191@web59g.yandex.ru>
Content-Language: pl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] m25p80: prevent buffer overflow during
 erasing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksey Kuleshov <rndfax@yandex.ru>, qemu-devel <qemu-devel@nongnu.org>

W dniu 15.01.2018 o 16:13, Aleksey Kuleshov pisze:
> memset is not checked, so it's possible to go beyond the storage.
> Add checks and truncate requested length.
>
> Signed-off-by: Aleksey Kuleshov <rndfax@yandex.ru>

Acked-by: Marcin Krzemiński<mar.krzeminski@gmail.com>

> ---
>   hw/block/m25p80.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index ea142160b3..18ec501912 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -539,6 +539,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>       uint32_t len;
>       uint8_t capa_to_assert = 0;
>   
> +    assert(0 <= offset && offset < s->size);
> +
>       switch (cmd) {
>       case ERASE_4K:
>       case ERASE4_4K:
> @@ -581,6 +583,14 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
>           return;
>       }
> +
> +    if (offset + len > s->size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                            "M25P80: trying to erase beyond the flash size! "
> +                            "Truncating the length...\n");
> +        len = s->size - offset;
> +    }
> +
>       memset(s->storage + offset, 0xff, len);
>       flash_sync_area(s, offset, len);
>   }
