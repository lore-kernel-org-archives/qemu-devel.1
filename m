Received: from eggs.gnu.org ([2001:4830:134:3::10]:33460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBbMp-0002jO-Gc
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBbMm-0007oc-BJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBbMm-0007oW-5z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:26:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<c1f2bc8f51ab57ad99e103af6b36320ba8980fe2.1495018956.git.maozy.fnst@cn.fujitsu.com>
Date: Fri, 19 May 2017 08:26:21 +0200
In-Reply-To: <c1f2bc8f51ab57ad99e103af6b36320ba8980fe2.1495018956.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Wed, 17 May 2017 19:12:24 +0800")
Message-ID: <87fug1icqa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/3] net/rocker: Plug memory leak in
 pci_rocker_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> pci_rocker_init() leaks a World when the name more than 9 chars,
> then return a negative value directly, doesn't make a correct
> cleanup. So add a new goto label to fix it.
>
> Cc: jasowang@redhat.com
> Cc: jiri@resnulli.us
> Cc: f4bug@amsat.org
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/net/rocker/rocker.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index b2b6dc7..a382a6f 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1371,7 +1371,8 @@ static int pci_rocker_init(PCIDevice *dev)
>          fprintf(stderr,
>                  "rocker: name too long; please shorten to at most %d chars\n",
>                  MAX_ROCKER_NAME_LEN);
> -        return -EINVAL;
> +        err = -EINVAL;
> +        goto err_name_too_long;
>      }
>  
>      if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
> @@ -1430,6 +1431,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  
>      return 0;
>  
> +err_name_too_long:
>  err_duplicate:
>      rocker_msix_uninit(r);
>  err_msix_init:

Reviewed-by: Markus Armbruster <armbru@redhat.com>
