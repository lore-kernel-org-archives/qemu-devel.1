Received: from eggs.gnu.org ([2001:4830:134:3::10]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08F3-0002V0-50
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08Ez-0006KA-1b
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g08Ey-0006Jw-Sx
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FE6E40216EB
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:43:44 +0000 (UTC)
References: <1536769155-269737-1-git-send-email-imammedo@redhat.com>
	<1536769155-269737-3-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d6727a7-8c84-95bf-ac5e-d65aa9f18296@redhat.com>
Date: Wed, 12 Sep 2018 11:43:40 -0500
MIME-Version: 1.0
In-Reply-To: <1536769155-269737-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH v7 2/2] vl:c: make sure that
 sockets are calculated correctly in '-smp X' case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, ehabkost@redhat.com

On 9/12/18 11:19 AM, Igor Mammedov wrote:
> commit
>    (5cdc9b76e3 vl.c: Remove dead assignment)
> removed sockets calculation when 'sockets' weren't provided on CLI
> since there wasn't any users for it back then. Exiting checks
> are neither reachable
>     } else if (sockets * cores * threads < cpus) {
> or nor triggable

s/triggable/triggerable/

>     if (sockets * cores * threads > max_cpus)
> so we weren't noticing wrong topology since then, since users
> recalculate sockets adhoc on their own.
> 
> However with deprecation check it becomes noticable, for example
>    -smp 2
> will start printing warning:
>    "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * threads (1) != maxcpus (2)"
> calculating sockets if they weren't specified.
> 
> Fix it by returning back sockets calculation if it's omited on CLI.

s/omited/omitted/

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>   vl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 7fd700e..9e56696 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1210,11 +1210,14 @@ static void smp_parse(QemuOpts *opts)
>   
>           /* compute missing values, prefer sockets over cores over threads */
>           if (cpus == 0 || sockets == 0) {
> -            sockets = sockets > 0 ? sockets : 1;
>               cores = cores > 0 ? cores : 1;
>               threads = threads > 0 ? threads : 1;
>               if (cpus == 0) {
> +                sockets = sockets > 0 ? sockets : 1;
>                   cpus = cores * threads * sockets;
> +            } else {
> +                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets = max_cpus / (cores * threads);
>               }
>           } else if (cores == 0) {
>               threads = threads > 0 ? threads : 1;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
