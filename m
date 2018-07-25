Received: from eggs.gnu.org ([2001:4830:134:3::10]:42521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fiIv7-0005n0-Kj
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fiIv4-0004Eq-L1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fiIv4-0004Dc-DI
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so7219467wrr.8
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 05:29:29 -0700 (PDT)
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121655.12867.68682.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0859020-9b10-84e7-baa4-f47f7fdb43ff@redhat.com>
Date: Wed, 25 Jul 2018 14:29:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180725121655.12867.68682.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 22/24] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 25/07/2018 14:16, Pavel Dovgalyuk wrote:
> This patch makes IDE trim BH deterministic, because it affects
> the device state. Therefore its invocation should be replayed
> instead of running at the random moment.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  hw/ide/core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 2c62efc..04e22e7 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
> +#include "sysemu/replay.h"
>  
>  #include "hw/ide/internal.h"
>  #include "trace.h"
> @@ -479,7 +480,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>  done:
>      iocb->aiocb = NULL;
>      if (iocb->bh) {
> -        qemu_bh_schedule(iocb->bh);
> +        replay_bh_schedule_event(iocb->bh);
>      }
>  }
>  
> 
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
