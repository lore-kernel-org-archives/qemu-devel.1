Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0V3x-0003Bm-7W
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0V3u-0003hO-2g
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1g0V3t-0003gp-QE
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:05:49 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081950.3228.68987.stgit@pasha-VirtualBox>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
Date: Thu, 13 Sep 2018 13:05:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180912081950.3228.68987.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net



On 09/12/2018 04:19 AM, Pavel Dovgalyuk wrote:
> This patch makes IDE trim BH deterministic, because it affects
> the device state. Therefore its invocation should be replayed
> instead of running at the random moment.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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

Just passing by: Why do we need to change this call, but nothing else in
IDE?

I don't mind conceptually, but it's odd to me that of all the calls I
make in this emulator that change state somewhere that this is the only
one you need to hijack for the replay feature.

Is this a necessarily complete change?

--js
