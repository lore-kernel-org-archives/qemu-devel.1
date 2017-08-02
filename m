Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcycS-0004Sc-Pe
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 14:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcycS-0005jT-0V
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 14:43:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0ae749d9-e4fa-e512-a125-b48488847b5d@amsat.org>
Date: Wed, 2 Aug 2017 15:43:35 -0300
MIME-Version: 1.0
In-Reply-To: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc: fix double-free in cpu_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 08/02/2017 02:34 PM, Greg Kurz wrote:
> When running nested with KVM PR, ppc_set_compat() fails and QEMU crashes
> because of "double free or corruption (!prev)". The crash happens because
> error_report_err() has already called error_free().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/ppc/machine.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index f578156dd411..abe0a1cdf021 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -239,7 +239,6 @@ static int cpu_post_load(void *opaque, int version_id)
>           ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
> -            error_free(local_err);
>               return -1;
>           }
>       } else
> 
> 
