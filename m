Received: from eggs.gnu.org ([2001:4830:134:3::10]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIIs-0008Lc-Jg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIIo-0008CB-Lb
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJIIo-0008BC-I5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12AB779D36
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:46:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-4-peterx@redhat.com>
Date: Thu, 17 May 2018 14:46:36 +0200
In-Reply-To: <20180509041734.14135-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 9 May 2018 12:17:33 +0800")
Message-ID: <87zi0ylaab.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.

Appreciated!

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index d6c3c08932..ae5bca9d7c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -207,7 +207,7 @@ struct Monitor {
>      int suspend_cnt;            /* Needs to be accessed atomically */
>      bool skip_flush;
>      bool use_io_thr;
> -    ReadLineState *rs;
> +    ReadLineState *rs;   /* Only used in parser, so no lock needed. */

Pardon the ignorant question: why does "only used in parser" imply "no
lock needed"?

>      MonitorQMP qmp;
>      gchar *mon_cpu_path;
>      BlockCompletionFunc *password_completion_cb;
> @@ -1313,7 +1313,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>      cur_mon->qmp.commands = &qmp_commands;
>  }
>  
> -/* set the current CPU defined by the user */
> +/* set the current CPU defined by the user.  BQL needed. */

It's okay to start a comment containing a phrase with a lower case
letter, but you're turning this one into two sentences, and sentences
start in upper case.  Can touch up on commit.

"BQL needed" is okay, just a bit terse; I'd write "Caller must hold
BQL".  Could change that, too.

>  int monitor_set_cpu(int cpu_index)
>  {
>      CPUState *cpu;
> @@ -1327,6 +1327,7 @@ int monitor_set_cpu(int cpu_index)
>      return 0;
>  }
>  
> +/* BQL neeeded. */

Likewise.

>  static CPUState *mon_get_cpu_sync(bool synchronize)
>  {
>      CPUState *cpu;
