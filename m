Received: from eggs.gnu.org ([2001:4830:134:3::10]:56288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egNMJ-0005KY-Fx
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egNMG-0004go-C6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:17:23 -0500
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:37559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egNMG-0004gY-7h
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:17:20 -0500
Received: by mail-qt0-x232.google.com with SMTP id d54so15656781qtd.4
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 20:17:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180130035827.2360-1-programmingkidx@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d5b6458d-2479-bad2-01fe-87b3a120ff4c@amsat.org>
Date: Tue, 30 Jan 2018 01:17:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180130035827.2360-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Only print unknown command message in
 debug mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi John,

On 01/30/2018 12:58 AM, John Arbuckle wrote:
> After using QEMU with the sb16 sound card I would see all these messages about some numbered command not being understood. It became annoying after a while to always see this message, so this patch changes things so that the message is only printed when DEBUG is defined. 
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  hw/audio/sb16.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 6ab2f6f89a..45b679c4df 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -632,7 +632,7 @@ static void command (SB16State *s, uint8_t cmd)
>      return;
>  
>   warn:
> -    dolog ("warning: command %#x,%d is not truly understood yet\n",
> +    ldebug("warning: command %#x,%d is not truly understood yet\n",
>             cmd, s->needed_bytes);

While changing this file can you use the latest logging API? such:

     qemu_log_mask(LOG_UNIMP, "unimplemented command 0x%02x (size:%d)",
                   cmd, s->needed_bytes);

So one can enable this log level at runtime (with "-d unimp"), the
#define DEBUG is compile time (require a rebuild).

>      goto exit;
>  
> 
