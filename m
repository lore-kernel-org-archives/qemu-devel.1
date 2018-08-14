Received: from eggs.gnu.org ([2001:4830:134:3::10]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpVrp-0000vk-FD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpVrm-000789-C5
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:43:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fpVrm-00077f-55
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:43:54 -0400
Date: Tue, 14 Aug 2018 10:43:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180814094347.GE2580@work-vm>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-3-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171132.21939-3-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] monitor: show sync profiling info with
 'info sync'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

* Emilio G. Cota (cota@braap.org) wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  monitor.c            |  7 +++++++
>  hmp-commands-info.hx | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index 77861e96af..66d8d85b97 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1454,6 +1454,13 @@ static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  }
>  #endif
>  
> +static void hmp_info_sync(Monitor *mon, const QDict *qdict)
> +{
> +    int64_t max = qdict_get_try_int(qdict, "max", 10);
> +
> +    qsp_report((FILE *)mon, monitor_fprintf, max);
> +}
> +
>  static void hmp_info_history(Monitor *mon, const QDict *qdict)
>  {
>      int i;
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 70639f656a..56a3249bad 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -297,6 +297,22 @@ STEXI
>  @item info opcount
>  @findex info opcount
>  Show dynamic compiler opcode counters
> +ETEXI
> +
> +    {
> +        .name       = "sync",
> +        .args_type  = "max:i?",
> +        .params     = "[max]",
> +        .help       = "show sync profiling info for "
> +	              "up to max entries (default: 10). "
> +		      "Entries are sorted by wait time.",
> +        .cmd        = hmp_info_sync,
> +    },
> +
> +STEXI
> +@item info sync
> +@findex sync
> +Show sync profiling info.
>  ETEXI
>  
>      {

As long as this is just for devs I'm OK with this from the HMP side;
however, if you want to automate the display or wire it to other
tools then you should probably wire it up via QMP.

Dave

> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
