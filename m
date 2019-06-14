Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56969C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324D021473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324D021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhy3-0007I0-G8
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbhwO-00066R-1J
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbhwM-0007sb-K5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbhwG-0007hI-Jr; Fri, 14 Jun 2019 04:52:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E386E3086208;
 Fri, 14 Jun 2019 08:51:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37B2666D31;
 Fri, 14 Jun 2019 08:51:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BDEE11386A6; Fri, 14 Jun 2019 10:51:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-3-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 10:51:40 +0200
In-Reply-To: <20190613153405.24769-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:33:52 +0200")
Message-ID: <87h88sft2b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 08:51:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 02/15] monitor: Split monitor_init in
 HMP and QMP function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Instead of mixing HMP and QMP monitors in the same function, separate
> the monitor creation function for both.
>
> While in theory, one could pass both MONITOR_USE_CONTROL and
> MONITOR_USE_READLINE before this patch and both flags would do
> something, readline support is tightly coupled with HMP: QMP never feeds
> its input to readline, and the tab completion function treats the input
> as an HMP command. Therefore, this configuration is useless.
>
> After this patch, the QMP path asserts that MONITOR_USE_READLINE is not
> set. The HMP path can be used with or without MONITOR_USE_READLINE, like
> before.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c | 89 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 9846a5623b..a70c1283b1 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -704,7 +704,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline);
>  
>  static void monitor_iothread_init(void);
>  
> -static void monitor_data_init(Monitor *mon, bool skip_flush,
> +static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>                                bool use_io_thread)
>  {
>      if (use_io_thread && !mon_iothread) {
           monitor_iothread_init();
       }
       memset(mon, 0, sizeof(Monitor));

I'd like to replace this memset() by ...

       qemu_mutex_init(&mon->mon_lock);
       qemu_mutex_init(&mon->qmp.qmp_queue_lock);
       mon->outbuf = qstring_new();
       /* Use *mon_cmds by default. */
       mon->cmd_table = mon_cmds;
> @@ -719,6 +719,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
>      mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
>      mon->qmp.qmp_requests = g_queue_new();
> +    mon->flags = flags;
>  }
>  
>  static void monitor_data_destroy(Monitor *mon)
> @@ -742,7 +743,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      Monitor *old_mon, hmp;

... hmp = {} here (moved from PATCH 04), and ...

>  
> -    monitor_data_init(&hmp, true, false);
> +    monitor_data_init(&hmp, 0, true, false);
>  
>      old_mon = cur_mon;
>      cur_mon = &hmp;
> @@ -4605,19 +4606,51 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(mon);
>  }
>  
> -void monitor_init(Chardev *chr, int flags)
> +static void monitor_init_qmp(Chardev *chr, int flags)
>  {
>      Monitor *mon = g_malloc(sizeof(*mon));

... g_malloc0() here (moved from PATCH 03), and ...

> -    bool use_readline = flags & MONITOR_USE_READLINE;
> +
> +    /* Only HMP supports readline */
> +    assert(!(flags & MONITOR_USE_READLINE));
>  
>      /* Note: we run QMP monitor in I/O thread when @chr supports that */
> -    monitor_data_init(mon, false,
> -                      (flags & MONITOR_USE_CONTROL)
> -                      && qemu_chr_has_feature(chr,
> -                                              QEMU_CHAR_FEATURE_GCONTEXT));
> +    monitor_data_init(mon, flags, false,
> +                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>  
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
> -    mon->flags = flags;
> +    qemu_chr_fe_set_echo(&mon->chr, true);
> +
> +    json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon, NULL);
> +    if (mon->use_io_thread) {
> +        /*
> +         * Make sure the old iowatch is gone.  It's possible when
> +         * e.g. the chardev is in client mode, with wait=on.
> +         */
> +        remove_fd_in_watch(chr);
> +        /*
> +         * We can't call qemu_chr_fe_set_handlers() directly here
> +         * since chardev might be running in the monitor I/O
> +         * thread.  Schedule a bottom half.
> +         */
> +        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +                                monitor_qmp_setup_handlers_bh, mon);
> +        /* The bottom half will add @mon to @mon_list */
> +    } else {
> +        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> +                                 monitor_qmp_read, monitor_qmp_event,
> +                                 NULL, mon, NULL, true);
> +        monitor_list_append(mon);
> +    }
> +}
> +
> +static void monitor_init_hmp(Chardev *chr, int flags)
> +{
> +    Monitor *mon = g_malloc(sizeof(*mon));

... and g_malloc0() here (moved from PATCH 04).

This way, the responsibility for zeroing moves just once, right when its
new owners get created.  Saves us explaining in PATCH 03+04 why we make
these changes.  They were confusing enough for me to ask for an
explanation in my review of v2.

Happy do to it in my tree.

I'd be tempted to assert(!(flags & MONITOR_USE_CONTROL)) here, and the
opposite in monitor_init_qmp(), if your PATCH 14 didn't get rid of
@flags.  Okay as it is.

> +    bool use_readline = flags & MONITOR_USE_READLINE;
> +
> +    monitor_data_init(mon, flags, false, false);
> +    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
> +
>      if (use_readline) {
>          mon->rs = readline_init(monitor_readline_printf,
>                                  monitor_readline_flush,
[...]

