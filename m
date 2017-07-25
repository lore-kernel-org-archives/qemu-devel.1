Received: from eggs.gnu.org ([2001:4830:134:3::10]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1uP-0003QM-KO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da1uK-0001ab-OX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:05 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da1uK-0001Zw-IS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:00 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so49435164wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:38:00 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-13-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e12418c8-3619-7377-1f92-02f143da5367@redhat.com>
Date: Tue, 25 Jul 2017 17:37:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 12/35] vfio/platform: fix use of
 freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 24/07/2017 20:27, Philippe Mathieu-Daudé wrote:
> free the data _after_ using it.
> 
> hw/vfio/platform.c:126:29: warning: Use of memory after it is freed
>         qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>                             ^~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/vfio/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 7c09deda61..da84abf4fc 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -120,11 +120,11 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>      *pfd = event_notifier_get_fd(intp->interrupt);
>      qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
>      ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    g_free(irq_set);
>      if (ret < 0) {
>          error_report("vfio: Failed to set trigger eventfd: %m");
>          qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>      }
> +    g_free(irq_set);
>      return ret;
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
