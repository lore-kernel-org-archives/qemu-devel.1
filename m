Received: from eggs.gnu.org ([2001:4830:134:3::10]:43142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxD6Y-0006dR-Ty
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxD6U-0002lv-Nx
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:18:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxD6U-0002kt-Ix
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:18:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAE057A7EC
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 15:18:53 +0000 (UTC)
Date: Tue, 4 Sep 2018 17:18:48 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180904151848.ualq7qvcikdsomi3@kamzik.brq.redhat.com>
References: <1536067356-44609-1-git-send-email-imammedo@redhat.com>
	<1536067356-44609-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536067356-44609-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] vl:c: make sure that sockets are
 calculated correctly in '-smp X' case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, ehabkost@redhat.com

On Tue, Sep 04, 2018 at 03:22:36PM +0200, Igor Mammedov wrote:
> commit
>   (5cdc9b76e3 vl.c: Remove dead assignment)
> removed sockets calculation when 'sockets' weren't provided on CLI
> since there wasn't any users for it back then. Exiting checks
> are neither reachable
>    } else if (sockets * cores * threads < cpus) {
> or nor triggable
>    if (sockets * cores * threads > max_cpus)
> so we weren't noticing wrong topology since then, since users
> recalculate sockets adhoc on their own.
> 
> However with deprecation check it becomes noticable, for example
>   -smp 2
> will start printing warning:
>   "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * threads (1) != maxcpus (2)"
> calculating sockets if they weren't specified.
> 
> Fix it by returning back sockets calculation if it's omited on CLI.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  vl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 7fd700e..333d638 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1210,11 +1210,14 @@ static void smp_parse(QemuOpts *opts)
>  
>          /* compute missing values, prefer sockets over cores over threads */
>          if (cpus == 0 || sockets == 0) {
> -            sockets = sockets > 0 ? sockets : 1;
>              cores = cores > 0 ? cores : 1;
>              threads = threads > 0 ? threads : 1;
>              if (cpus == 0) {
> +                sockets = sockets > 0 ? sockets : 1;
>                  cpus = cores * threads * sockets;
> +            } else {
> +                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets = !sockets ? max_cpus / (cores * threads) : sockets;
>              }
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> -- 
> 2.7.4
> 
>
 
Reviewed-by: Andrew Jones <drjones@redhat.com>
