Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emikO-0001VV-47
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emikJ-0006by-61
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:20:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emikI-0006bj-Mo
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:20:22 -0500
Date: Fri, 16 Feb 2018 16:20:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180216162019.GB22220@work-vm>
References: <20180213125143.23488-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213125143.23488-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor.c: Fix infinite loop in monitor's
 auto-complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, t.pagef.lt@gmail.com
Cc: kwolf@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Reported-by: Dimitris Karagkasidis <t.pagef.lt@gmail.com>
> Fixes: 48fe86f6400574165979e0db6f5937ad487b6888
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued.

> ---
>  monitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 0c0faec0a4..bec484440f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3696,7 +3696,7 @@ static void monitor_find_completion_by_table(Monitor *mon,
>  {
>      const char *cmdname;
>      int i;
> -    const char *ptype, *str, *name;
> +    const char *ptype, *old_ptype, *str, *name;
>      const mon_cmd_t *cmd;
>      BlockBackend *blk = NULL;
>  
> @@ -3741,7 +3741,9 @@ static void monitor_find_completion_by_table(Monitor *mon,
>              }
>          }
>          str = args[nb_args - 1];
> -        while (*ptype == '-' && ptype[1] != '\0') {
> +        old_ptype = NULL;
> +        while (*ptype == '-' && old_ptype != ptype) {
> +            old_ptype = ptype;
>              ptype = next_arg_type(ptype);
>          }
>          switch(*ptype) {
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
