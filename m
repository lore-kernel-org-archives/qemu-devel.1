Received: from eggs.gnu.org ([2001:4830:134:3::10]:60929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0R03-0000eZ-IT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0Qzz-0004Bo-Jw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:13:19 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0Qzz-0004BL-E4
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:13:15 -0400
Received: by mail-qk0-x243.google.com with SMTP id d206so7409495qkb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 05:13:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<1522047629-27658-3-git-send-email-jasowang@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <34b37cfb-2a0a-e9af-e504-4ff962ec1987@amsat.org>
Date: Mon, 26 Mar 2018 09:13:11 -0300
MIME-Version: 1.0
In-Reply-To: <1522047629-27658-3-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/2] net/vde: print error on vde_open()
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Julia Suvorova <jusual@mail.ru>

Hi Jason,

On 03/26/2018 04:00 AM, Jason Wang wrote:
> From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>

This doesn't look right, shouldn't it be Julia Suvorova <jusual@mail.ru>?

> 
> Despite the fact that now when the initialization of vde fails, qemu
> does not end silently, no informative error is printed. The patch
> generates an error and pushes it through the calling function.
> 
> Related bug: https://bugs.launchpad.net/qemu/+bug/676029
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/vde.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vde.c b/net/vde.c
> index e50e5d6..99189cc 100644
> --- a/net/vde.c
> +++ b/net/vde.c
> @@ -30,6 +30,7 @@
>  #include "qemu-common.h"
>  #include "qemu/option.h"
>  #include "qemu/main-loop.h"
> +#include "qapi/error.h"
>  
>  typedef struct VDEState {
>      NetClientState nc;
> @@ -76,7 +77,7 @@ static NetClientInfo net_vde_info = {
>  
>  static int net_vde_init(NetClientState *peer, const char *model,
>                          const char *name, const char *sock,
> -                        int port, const char *group, int mode)
> +                        int port, const char *group, int mode, Error **errp)
>  {
>      NetClientState *nc;
>      VDEState *s;
> @@ -92,6 +93,7 @@ static int net_vde_init(NetClientState *peer, const char *model,
>  
>      vde = vde_open(init_sock, (char *)"QEMU", &args);
>      if (!vde){
> +        error_setg_errno(errp, errno, "Could not open vde");
>          return -1;
>      }
>  
> @@ -112,7 +114,6 @@ static int net_vde_init(NetClientState *peer, const char *model,
>  int net_init_vde(const Netdev *netdev, const char *name,
>                   NetClientState *peer, Error **errp)
>  {
> -    /* FIXME error_setg(errp, ...) on failure */
>      const NetdevVdeOptions *vde;
>  
>      assert(netdev->type == NET_CLIENT_DRIVER_VDE);
> @@ -120,7 +121,7 @@ int net_init_vde(const Netdev *netdev, const char *name,
>  
>      /* missing optional values have been initialized to "all bits zero" */
>      if (net_vde_init(peer, "vde", name, vde->sock, vde->port, vde->group,
> -                     vde->has_mode ? vde->mode : 0700) == -1) {
> +                     vde->has_mode ? vde->mode : 0700, errp) == -1) {
>          return -1;
>      }
>  
> 
