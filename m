Received: from eggs.gnu.org ([2001:4830:134:3::10]:48396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU3jg-0003K3-EO
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU3ja-0004vT-0V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:59:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gU3jU-0004nP-19
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:58:58 -0500
References: <20181204035347.6148-1-jasowang@redhat.com>
	<20181204035347.6148-3-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2d10c49-ccb5-4709-94ad-e04cc702c62a@redhat.com>
Date: Tue, 4 Dec 2018 06:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181204035347.6148-3-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5 for 3.1 2/5] net: hub: suppress warnings
 of no host network for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, eblake@redhat.com

On 2018-12-04 04:53, Jason Wang wrote:
> If we want to qtest through hub, it would be much more simpler and
> safer to configure the hub without host network. So silent this
> warnings for qtest.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hub.c b/net/hub.c
> index 78b671ed95..5795a678ed 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -20,6 +20,7 @@
>  #include "hub.h"
>  #include "qemu/iov.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/qtest.h"
>  
>  /*
>   * A hub broadcasts incoming packets to all its ports except the source port.
> @@ -346,7 +347,7 @@ void net_hub_check_clients(void)
>          if (has_host_dev && !has_nic) {
>              warn_report("hub %d with no nics", hub->id);
>          }
> -        if (has_nic && !has_host_dev) {
> +        if (has_nic && !has_host_dev && !qtest_enabled()) {
>              warn_report("hub %d is not connected to host network", hub->id);
>          }
>      }

Sounds fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
