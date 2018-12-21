Received: from eggs.gnu.org ([2001:4830:134:3::10]:39517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gaMaE-0004m9-Mb
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gaMaB-00073k-PI
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:19:26 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gaMa9-0006xd-OP
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:19:22 -0500
Received: by mail-wr1-f41.google.com with SMTP id u4so5631040wrp.3
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:19:18 -0800 (PST)
References: <20181221134115.27973-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <009f5d95-c968-6f3f-93c2-32300ee7e5e1@redhat.com>
Date: Fri, 21 Dec 2018 16:19:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181221134115.27973-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/usb: fix mistaken de-initialization of
 CCID state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org

On 12/21/18 2:41 PM, Daniel P. Berrangé wrote:
> In previous commit:
> 
>   commit 7dea29e4af17fc1d27478de9f8ea38144deac54a
>   Author: Li Qiang <liq3ea@gmail.com>
>   Date:   Fri Oct 19 03:50:36 2018 -0700
> 
>     hw: ccid-card-emulated: cleanup resource when realize in error path
> 
> The emulated_realize method was changed so that it jumps to a cleanup
> label to de-initialize state upon error. This change failed to ensure
> the success path exited the method before this point though. So the
> mutexes are always destroyed even in normal operation. The result is
> as crashtastic as expected:
> 
> $ qemu-system-x86_64 -usb -device usb-ccid,id=ccid0 -device ccid-card-emulated,backend=nss-emulated,id=smartcard0,bus=ccid0.0
> qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> Aborted (core dumped)
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>

Fixes: 7dea29e4af1

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/usb/ccid-card-emulated.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 25976ed84f..e0457d305b 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -549,6 +549,8 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
>      qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
>                         card, QEMU_THREAD_JOINABLE);
>  
> +    return;
> +
>  out2:
>      clean_event_notifier(card);
>  out1:
> 
