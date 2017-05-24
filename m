Received: from eggs.gnu.org ([2001:4830:134:3::10]:50281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE7-0006pr-12
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE6-00056w-9t
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:51 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOE6-00056q-5C
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:50 -0400
Received: by mail-oi0-x244.google.com with SMTP id w138so30972098oiw.3
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 21:48:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<d2b35b6077ffe9072f2b5924b02a75751ffc6031.1495508197.git.maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a8c4063-9af0-738d-74e2-04b31b2d962d@amsat.org>
Date: Wed, 24 May 2017 01:48:47 -0300
MIME-Version: 1.0
In-Reply-To: <d2b35b6077ffe9072f2b5924b02a75751ffc6031.1495508197.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4] net/rocker: Plug memory leak in
 pci_rocker_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, jasowang@redhat.com, jiri@resnulli.us

On 05/23/2017 01:04 AM, Mao Zhongyi wrote:
> pci_rocker_init() leaks a World when the name more than 9 chars,
> then return a negative value directly, doesn't make a correct
> cleanup. So add a new goto label to fix it.
>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/rocker/rocker.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index d01ba9d..6d44f37 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1357,7 +1357,8 @@ static int pci_rocker_init(PCIDevice *dev)
>          fprintf(stderr,
>                  "rocker: name too long; please shorten to at most %d chars\n",
>                  MAX_ROCKER_NAME_LEN);
> -        return -EINVAL;
> +        err = -EINVAL;
> +        goto err_name_too_long;
>      }
>
>      if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
> @@ -1416,6 +1417,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      return 0;
>
> +err_name_too_long:
>  err_duplicate:
>      rocker_msix_uninit(r);
>  err_msix_init:
>
