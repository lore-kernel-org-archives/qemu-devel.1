Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5560BC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18636206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18636206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawVq-0007M9-Cd
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hawUZ-00068p-FT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hawUX-0007mj-FL
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hawUR-0007is-4n; Wed, 12 Jun 2019 02:12:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 146F13082E69;
 Wed, 12 Jun 2019 06:12:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86AF739B9;
 Wed, 12 Jun 2019 06:12:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 18FB21138648; Wed, 12 Jun 2019 08:12:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-3-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 08:12:00 +0200
In-Reply-To: <20190611134043.9524-3-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:34 +0200")
Message-ID: <87imtbuybz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 06:12:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/11] monitor: Split monitor_init in
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
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 86 +++++++++++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 70ce9e8a77..bb23cc0450 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -702,7 +702,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline);
>  
>  static void monitor_iothread_init(void);
>  
> -static void monitor_data_init(Monitor *mon, bool skip_flush,
> +static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>                                bool use_io_thread)
>  {
>      if (use_io_thread && !mon_iothread) {
> @@ -717,6 +717,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
>      mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
>      mon->qmp.qmp_requests = g_queue_new();
> +    mon->flags = flags;
>  }
>  
>  static void monitor_data_destroy(Monitor *mon)
> @@ -740,7 +741,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      Monitor *old_mon, hmp;
>  
> -    monitor_data_init(&hmp, true, false);
> +    monitor_data_init(&hmp, 0, true, false);
>  
>      old_mon = cur_mon;
>      cur_mon = &hmp;

Explicit initialization replaced implicit zero-initialization.  Okay.

> @@ -4603,19 +4604,48 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(mon);
>  }
>  
> -void monitor_init(Chardev *chr, int flags)
> +static void monitor_init_qmp(Chardev *chr, int flags)
>  {
>      Monitor *mon = g_malloc(sizeof(*mon));
> -    bool use_readline = flags & MONITOR_USE_READLINE;
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
> +    bool use_readline = flags & MONITOR_USE_READLINE;
> +
> +    monitor_data_init(mon, flags, false, false);
> +    qemu_chr_fe_init(&mon->chr, chr, &error_abort);
> +
>      if (use_readline) {
>          mon->rs = readline_init(monitor_readline_printf,
>                                  monitor_readline_flush,
> @@ -4624,36 +4654,18 @@ void monitor_init(Chardev *chr, int flags)
>          monitor_read_command(mon, 0);
>      }
>  
> -    if (monitor_is_qmp(mon)) {
> -        qemu_chr_fe_set_echo(&mon->chr, true);
> -        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
> -                                 mon, NULL);
> -        if (mon->use_io_thread) {
> -            /*
> -             * Make sure the old iowatch is gone.  It's possible when
> -             * e.g. the chardev is in client mode, with wait=on.
> -             */
> -            remove_fd_in_watch(chr);
> -            /*
> -             * We can't call qemu_chr_fe_set_handlers() directly here
> -             * since chardev might be running in the monitor I/O
> -             * thread.  Schedule a bottom half.
> -             */
> -            aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> -                                    monitor_qmp_setup_handlers_bh, mon);
> -            /* The bottom half will add @mon to @mon_list */
> -            return;
> -        } else {
> -            qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> -                                     monitor_qmp_read, monitor_qmp_event,
> -                                     NULL, mon, NULL, true);
> -        }
> +    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
> +                             monitor_event, NULL, mon, NULL, true);
> +    monitor_list_append(mon);
> +}
> +
> +void monitor_init(Chardev *chr, int flags)
> +{
> +    if (flags & MONITOR_USE_CONTROL) {
> +        monitor_init_qmp(chr, flags);
>      } else {
> -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
> -                                 monitor_event, NULL, mon, NULL, true);
> +        monitor_init_hmp(chr, flags);
>      }
> -
> -    monitor_list_append(mon);
>  }
>  
>  void monitor_cleanup(void)

This part of the diff is hard to read.  I'm inserting a no-op patch just
for review: make two identical copies of monitor_init() called
monitor_init_qmp() and monitor_init_hmp(), have monitor_init() call them
depending on MONITOR_USE_CONTROL.  Rebasing this patch on top of that
yields a more readable git-diff -w (readable for me, YMMV):

| @@ -4606,28 +4607,15 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
|  static void monitor_init_qmp(Chardev *chr, int flags)
|  {
|      Monitor *mon = g_malloc(sizeof(*mon));
| -    bool use_readline = flags & MONITOR_USE_READLINE;

See below.

|  
|      /* Note: we run QMP monitor in I/O thread when @chr supports that */
| -    monitor_data_init(mon, false,
| -                      (flags & MONITOR_USE_CONTROL)
| -                      && qemu_chr_has_feature(chr,
| -                                              QEMU_CHAR_FEATURE_GCONTEXT));
| +    monitor_data_init(mon, flags, false,
| +                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));

Partially evaluated: flags & MONITOR_USE_CONTROL is true.  Good.

|  
|      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
| -    mon->flags = flags;

Moved into monitor_data_init().  Good.

| -    if (use_readline) {
| -        mon->rs = readline_init(monitor_readline_printf,
| -                                monitor_readline_flush,
| -                                mon,
| -                                monitor_find_completion);
| -        monitor_read_command(mon, 0);
| -    }

Deleting readline support here is not a regression, because nothing ever
passes MONITOR_USE_READLINE along with MONITOR_USE_CONTROL.  We use only
three of the four cases:

* Neither flag: gdbstub.c (I have no idea why and how this uses the
  monitor code, and why it doesn't use readline)

* Just MONITOR_USE_READLINE:

  - vl.c on behalf of -mon mode=readline,... and its various sugared
    forms

  - chardev/char.c for implicit mux monitor (you don't want to know)

* Just MONITOR_USE_CONTROL:

  - vl.c on behalf of -mon mode=control,... and its various sugared
    forms

QMP with readline could perhaps be convenient for testing.  I use
socat's READLINE address type myself.

Speaking of odd flag combinations: MONITOR_USE_PRETTY is silently
ignored unless MONITOR_USE_CONTROL.

Deleting the unused (and untried) code to use QMP with readline is fine
with me, but please document MONITOR_USE_READLINE is silently ignored
with MONITOR_USE_CONTROL, or replace all the flags by an enumeration of
the actual cases: HMP without readline, HMP with readline, QMP, pretty
QMP.

| -
| -    if (monitor_is_qmp(mon)) {
|      qemu_chr_fe_set_echo(&mon->chr, true);
| -        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
| -                                 mon, NULL);
| +
| +    json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon, NULL);

Partially evaluated: monitor_is_qmp(mon) is true.  Good.

Keep the line break, please.

|      if (mon->use_io_thread) {
|          /*
|           * Make sure the old iowatch is gone.  It's possible when
| @@ -4642,33 +4630,22 @@ static void monitor_init_qmp(Chardev *chr, int flags)
|          aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
|                                  monitor_qmp_setup_handlers_bh, mon);
|          /* The bottom half will add @mon to @mon_list */
| -            return;
|      } else {
|          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
|                                   monitor_qmp_read, monitor_qmp_event,
|                                   NULL, mon, NULL, true);
| -        }
| -    } else {

This else belongs to if (!monitor_is_qmp(mon)).  Good.

| -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
| -                                 monitor_event, NULL, mon, NULL, true);
| -    }
| -
|          monitor_list_append(mon);
|      }
| +}

You simplified

       if (mon->use_io_thread) {
           ...
           /* The bottom half will add @mon to @mon_list */
           return;
       } else {
           ...
       }

       monitor_list_append(mon);

to
           
       if (mon->use_io_thread) {
           ...
           /* The bottom half will add @mon to @mon_list */
       } else {
           ...
           monitor_list_append(mon);
       }

Good.

|  
|  static void monitor_init_hmp(Chardev *chr, int flags)
|  {
|      Monitor *mon = g_malloc(sizeof(*mon));
|      bool use_readline = flags & MONITOR_USE_READLINE;
|  
| -    /* Note: we run QMP monitor in I/O thread when @chr supports that */
| -    monitor_data_init(mon, false,
| -                      (flags & MONITOR_USE_CONTROL)
| -                      && qemu_chr_has_feature(chr,
| -                                              QEMU_CHAR_FEATURE_GCONTEXT));
| -
| +    monitor_data_init(mon, flags, false, false);

Partially evaluated: flags & MONITOR_USE_CONTROL is false.  Good.

|      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
| -    mon->flags = flags;
| +

Moved into monitor_data_init().  Good.

|      if (use_readline) {
|          mon->rs = readline_init(monitor_readline_printf,
|                                  monitor_readline_flush,
| @@ -4677,35 +4654,8 @@ static void monitor_init_hmp(Chardev *chr, int flags)
|          monitor_read_command(mon, 0);
|      }
|  
| -    if (monitor_is_qmp(mon)) {
| -        qemu_chr_fe_set_echo(&mon->chr, true);
| -        json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
| -                                 mon, NULL);
| -        if (mon->use_io_thread) {
| -            /*
| -             * Make sure the old iowatch is gone.  It's possible when
| -             * e.g. the chardev is in client mode, with wait=on.
| -             */
| -            remove_fd_in_watch(chr);
| -            /*
| -             * We can't call qemu_chr_fe_set_handlers() directly here
| -             * since chardev might be running in the monitor I/O
| -             * thread.  Schedule a bottom half.
| -             */
| -            aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
| -                                    monitor_qmp_setup_handlers_bh, mon);
| -            /* The bottom half will add @mon to @mon_list */
| -            return;
| -        } else {
| -            qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
| -                                     monitor_qmp_read, monitor_qmp_event,
| -                                     NULL, mon, NULL, true);
| -        }
| -    } else {
|      qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
|                               monitor_event, NULL, mon, NULL, true);
| -    }
| -

Partially evaluated: monitor_is_qmp(mon) is false.  Good.

|      monitor_list_append(mon);
|  }
|  

Duplicates qemu_chr_fe_init(&mon->chr, chr, &error_abort).  Quite
tolerable.

Much clearer overall.

