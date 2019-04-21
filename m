Received: from eggs.gnu.org ([209.51.188.92]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9Tp-0001fr-Ik
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9Tn-00045C-Qt
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9Tn-00044D-LP
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so11300984wmf.2
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:13:47 -0700 (PDT)
References: <20190420191425.7d1dab82@luklap>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0116ac4a-c9e9-e23e-8002-06d9ef4c6819@redhat.com>
Date: Sun, 21 Apr 2019 12:13:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190420191425.7d1dab82@luklap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: "Zhang, Chen" <chen.zhang@intel.com>

On 4/20/19 7:14 PM, Lukas Straub wrote:
> From: Lukas Straub <lukasstraub2@web.de>
> Because event_unhandled_count may be accessed concurrently, it needs
> to be protected by taking the lock. However the assert is outside the
> lock, probably causing it to read garbage and aborting Qemu erroneously.
> 
> The Bug only happens when running Qemu in COLO mode.
> 
> This Patch fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1824622
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
>          break;
>      }
> 
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);
> --
> 2.20.1
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
