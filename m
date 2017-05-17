Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2el-00030Y-RR
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2eh-0000bn-Sy
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:22:39 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2eh-0000be-Nl
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:22:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so2433895qte.0
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:22:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<c1f2bc8f51ab57ad99e103af6b36320ba8980fe2.1495018956.git.maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e8882a9-d442-b306-3468-8a2f1b33f424@amsat.org>
Date: Wed, 17 May 2017 14:22:27 -0300
MIME-Version: 1.0
In-Reply-To: <c1f2bc8f51ab57ad99e103af6b36320ba8980fe2.1495018956.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com

Hi Mao,

On 05/17/2017 08:12 AM, Mao Zhongyi wrote:
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

While here can you update fprintf -> qemu_log_mask?

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
>
