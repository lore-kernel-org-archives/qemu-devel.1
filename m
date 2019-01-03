Received: from eggs.gnu.org ([208.118.235.92]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3J7-0003fY-Lt
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3J2-0003hU-Lv
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf3J2-0003hM-Fn
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:45:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so30285031wmd.4
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:45:04 -0800 (PST)
References: <20190103133113.49599-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c26ddf38-15e9-8fe8-382c-1388c134a149@redhat.com>
Date: Thu, 3 Jan 2019 14:45:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190103133113.49599-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb: dev-mtp: close fd in
 usb_mtp_object_readdir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, kraxel@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Michael Hanselmann <public@hansmi.ch>

On 1/3/19 2:31 PM, Li Qiang wrote:
> Spotted by Coverity: CID 1397070

Closing a CVE to open a CID :)

Fixes: bab9df35ce

> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/usb/dev-mtp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index b19b576278..666bafd9e8 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -666,6 +666,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
>      }
>      dir = fdopendir(fd);
>      if (!dir) {
> +        close(fd);
>          return;

This or:

           goto cleanup_fd;

>      }
>  #ifdef CONFIG_INOTIFY1
> @@ -682,6 +683,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
>          usb_mtp_add_child(s, o, entry->d_name);
>      }
>      closedir(dir);

And:

cleanup_fd:

> +    close(fd);
>  }
>  
>  /* ----------------------------------------------------------------------- */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
