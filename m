Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv4L7-0007Sz-2c
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv4L3-0007IG-00
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:33:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fv4L2-0007I1-MR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:33:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB8A228214
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 17:33:03 +0000 (UTC)
Date: Wed, 29 Aug 2018 14:33:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180829173301.GC17213@habkost.net>
References: <1535464093-3648-1-git-send-email-imammedo@redhat.com>
	<1535553121-80352-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535553121-80352-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl:c: make sure that sockets are
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
Cc: qemu-devel@nongnu.org, drjones@redhat.com

On Wed, Aug 29, 2018 at 04:32:01PM +0200, Igor Mammedov wrote:
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

We already have a "max_cpus = qemu_opt_get_number(...)" line in
this function[1]:

        /* compute missing values, prefer sockets over cores over threads */
        if (cpus == 0 || sockets == 0) {
            sockets = sockets > 0 ? sockets : 1;
            cores = cores > 0 ? cores : 1;
            threads = threads > 0 ? threads : 1;
            if (cpus == 0) {
                cpus = cores * threads * sockets;
            }
        } else if (cores == 0) {
            [...]
        } else if (threads == 0) {
            [...]
        } else if (sockets * cores * threads < cpus) {
            [...]
        }

        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus); /* [1] */

        /* [2] */

        if (max_cpus < cpus) {
            error_report("maxcpus must be equal to or greater than smp");
            exit(1);
        }

Why not move the sockets == 0 check to [2]?


> +                sockets = !sockets ? max_cpus / (cores * threads) : sockets;

The two patches in this thread make QEMU print a warning on a
case that was never documented as invalid/deprecated: maxcpus now
needs to be a multiple of cores*threads.

However, the error message doesn't make it obvious:

  $ ./x86_64-softmmu/qemu-system-x86_64 -smp 7,cores=3
  qemu-system-x86_64: warning: Invalid CPU topology deprecated: sockets (2) * cores (3) * threads (1) != maxcpus (7)

I think this would make more sense:

  $ ./x86_64-softmmu/qemu-system-x86_64 -smp 7,cores=3
  qemu-system-x86_64: warning: Invalid CPU topology deprecated: maxcpus (7) is not a multiple of cores (3) * threads (1)


>              }
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> -- 
> 2.7.4
> 

-- 
Eduardo
