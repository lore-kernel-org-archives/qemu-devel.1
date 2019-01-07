Received: from eggs.gnu.org ([209.51.188.92]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggS3D-0007OZ-Nu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggS3D-0003kA-2G
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:22:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggS3C-0003i7-S7
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:22:30 -0500
Date: Mon, 7 Jan 2019 11:22:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107102218.wzzcisnfqpasqjiq@sirius.home.kraxel.org>
References: <20190103133113.49599-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103133113.49599-1-liq3ea@163.com>
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
To: Li Qiang <liq3ea@163.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Jan 03, 2019 at 05:31:13AM -0800, Li Qiang wrote:
> Spotted by Coverity: CID 1397070

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
>      }

Ok, clearly a bug.

>  #ifdef CONFIG_INOTIFY1
> @@ -682,6 +683,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
>          usb_mtp_add_child(s, o, entry->d_name);
>      }
>      closedir(dir);
> +    close(fd);

Not fully sure this is correct.

The fdopendir manpage says the app should not use fd any more after
successfully calling fdopendir(), and I assumed that includes calling
close().  But I've seen the Coverity message warning this one too, so
maybe I'm wrong ...

cheers,
  Gerd
