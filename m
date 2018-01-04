Received: from eggs.gnu.org ([2001:4830:134:3::10]:36613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Nh-0003zI-Pt
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Mv-00045X-PV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:28:37 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8Mv-00044I-H3
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:27:49 -0500
Received: by mail-qt0-x242.google.com with SMTP id g9so2482801qth.9
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 08:27:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1f048cb-b718-4019-f289-d6e2449aa03c@amsat.org>
Date: Thu, 4 Jan 2018 13:27:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/18] mips: fix potential fopen(NULL,
 ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

Hi Marc-André,

On 01/04/2018 01:05 PM, Marc-André Lureau wrote:
> Spotted thanks to ASAN.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/nvram/ds1225y.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
> index 57d5ab2154..ad7345f288 100644
> --- a/hw/nvram/ds1225y.c
> +++ b/hw/nvram/ds1225y.c
> @@ -80,7 +80,7 @@ static int nvram_post_load(void *opaque, int version_id)
>      }
>  

More diffstats, but this let the code simpler imho:

   if (s->filename) {

>      /* Write back nvram contents */
> -    s->file = fopen(s->filename, "wb");
> +    s->file = s->filename ? fopen(s->filename, "wb") : NULL;
>      if (s->file) {
>          /* Write back contents, as 'wb' mode cleaned the file */
>          if (fwrite(s->contents, s->chip_size, 1, s->file) != 1) {

       ...

   }

> @@ -126,7 +126,7 @@ static int nvram_sysbus_initfn(SysBusDevice *dev)
>      sysbus_init_mmio(dev, &s->iomem);
>  
>      /* Read current file */
> -    file = fopen(s->filename, "rb");
> +    file = s->filename ? fopen(s->filename, "rb") : NULL;
>      if (file) {
>          /* Read nvram contents */
>          if (fread(s->contents, s->chip_size, 1, file) != 1) {
> 

ditto.
