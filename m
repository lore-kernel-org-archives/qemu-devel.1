Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdar-0007UF-Jn
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdab-0008Jf-TU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:58:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdab-0008JF-OC
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:58:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-3-cota@braap.org>
Date: Tue, 14 Aug 2018 18:03:32 +0200
In-Reply-To: <20180813171132.21939-3-cota@braap.org> (Emilio G. Cota's message
	of "Mon, 13 Aug 2018 13:11:31 -0400")
Message-ID: <87o9e5rl4b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

"Emilio G. Cota" <cota@braap.org> writes:

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

I think "info sync-profile" would be clearer.

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

Please explain briefly why you think this command is not going to be
useful in QMP.  Recommend to do that right in your commit message.  For
instance, you could argue that the information provided is useful only
to developers, and developers are just fine with getting it from HMP
"info sync".

However, if we expect developers to further process the data, providing
it as JSON (via QMP) makes sense, because is saves them the trouble of
parsing your (undocumented) HMP output format.

If we decide we want to provide the functionality in QMP, I can help you
with the necessary code changes.
