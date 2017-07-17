Received: from eggs.gnu.org ([2001:4830:134:3::10]:44300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX7i3-0002ES-Jk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX7i0-0004Wt-Ck
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dX7i0-0004WN-4W
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:13:16 -0400
Date: Mon, 17 Jul 2017 16:13:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717151306.GA26923@work-vm>
References: <1500099757-4184-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500099757-4184-1-git-send-email-wang.yi59@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

* Yi Wang (wang.yi59@zte.com.cn) wrote:
> Add [vcpu index] support for hmp command "info lapic", which is
> useful when debugging ipi and so on.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> ---
>  hmp-commands-info.hx  | 6 +++---
>  target/i386/monitor.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 07500ef..8ad2f81 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -115,9 +115,9 @@ ETEXI
>  #if defined(TARGET_I386)
>      {
>          .name       = "lapic",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show local apic state",
> +        .args_type  = "vcpu:i?",
> +        .params     = "[vcpu index]",
> +        .help       = "show local apic state (default vcpu 0)",

Normally I think the syntax for the help is 
(vcpu: vCPU to read, default is 0)"

>          .cmd        = hmp_info_local_apic,
>      },
>  #endif
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 77ead60..ca0abc1 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -632,8 +632,13 @@ const MonitorDef *target_monitor_defs(void)
>  
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>  {
> -    CPUState *cs = mon_get_cpu();
> +    int index = qdict_get_try_int(qdict, "vcpu", 0);
> +    CPUState *cs;
> +    if (monitor_set_cpu(index) < 0) {
> +        monitor_printf(mon, "invalid CPU index\n");
> +    }

That's setting the CPU so that subsequent commands that don't
specify the CPU will change - that's probably not what you want.
So I suspect you should probably use qemu_get_cpu(index)  to get
the CPU you want which doesn't change the currently selected CPU.

So the question then is what do you want to happen when the
parameter isn't specified.  The current behaviour is to give you
the *current* CPU but you're changing that to give vCPU 0
by default.

So I think you could change this to:

  if (qdict_haskey(qdict, "vcpu")) {
      int index = qdict_get_try_int(qdict, "vcpu", 0);
      cs = qemu_get_cpu(index);
  } else {
      cs = monitor_get_cpu();
  }

That keeps the current behaviour with no parameter, and
doesn't change the currently selected CPU when you use the
extra parameter.

Dave
> +    cs = mon_get_cpu();
>      if (!cs) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
