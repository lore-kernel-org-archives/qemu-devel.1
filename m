Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC5C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4D6208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4D6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKDt-0000YE-03
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZIgu-0005Rt-VE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZIgq-0002pV-VI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:30:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZIgg-0002M1-BE; Fri, 07 Jun 2019 13:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDB51B59AD;
 Fri,  7 Jun 2019 17:29:53 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25AAB6AD21;
 Fri,  7 Jun 2019 17:29:51 +0000 (UTC)
Date: Fri, 7 Jun 2019 18:29:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607172948.GU2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-11-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 07 Jun 2019 17:29:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] monitor: Split out monitor/core.c
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Move the monitor core infrastructure from monitor/misc.c to
> monitor/core.c. This is code that can be shared for all targets, so
> compile it only once.
> 
> What remains in monitor/misc.c after this patch is mostly monitor
> command implementations and code that requires a system emulator or is
> even target-dependent.
> 
> The amount of function and particularly extern variables in
> monitor_int.h is probably a bit larger than it needs to be, but this way
> no non-trivial code modifications are needed. The interfaces between all
> monitor parts can be cleaned up later.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

OK, but can you call it anything other than core.* - I regularly end up
deleting things like that!

Other than that,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/monitor/monitor.h |   1 +
>  monitor/monitor_int.h     |   1 +
>  monitor/core.c            | 604 ++++++++++++++++++++++++++++++++++++++
>  monitor/misc.c            | 567 +----------------------------------
>  monitor/Makefile.objs     |   2 +-
>  5 files changed, 608 insertions(+), 567 deletions(-)
>  create mode 100644 monitor/core.c
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 8547529e49..b9f8d175ed 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -20,6 +20,7 @@ typedef struct MonitorHMP MonitorHMP;
>  bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
> +void monitor_init_globals_core(void);
>  void monitor_init(Chardev *chr, int flags);
>  void monitor_init_qmp(Chardev *chr, int flags);
>  void monitor_init_hmp(Chardev *chr, int flags);
> diff --git a/monitor/monitor_int.h b/monitor/monitor_int.h
> index 8c5d95f942..1a7af6a223 100644
> --- a/monitor/monitor_int.h
> +++ b/monitor/monitor_int.h
> @@ -190,6 +190,7 @@ extern mon_cmd_t mon_cmds[];
>  int monitor_puts(Monitor *mon, const char *str);
>  void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>                         bool use_io_thread);
> +void monitor_data_destroy(Monitor *mon);
>  int monitor_can_read(void *opaque);
>  void monitor_list_append(Monitor *mon);
>  void monitor_fdsets_cleanup(void);
> diff --git a/monitor/core.c b/monitor/core.c
> new file mode 100644
> index 0000000000..1cea56054b
> --- /dev/null
> +++ b/monitor/core.c
> @@ -0,0 +1,604 @@
> +/*
> + * QEMU monitor
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor_int.h"
> +
> +#include "qapi/error.h"
> +#include "qapi/qapi-emit-events.h"
> +#include "qapi/qmp/qstring.h"
> +
> +#include "qemu/option.h"
> +#include "sysemu/qtest.h"
> +
> +#include "trace-root.h"
> +
> +/*
> + * To prevent flooding clients, events can be throttled. The
> + * throttling is calculated globally, rather than per-Monitor
> + * instance.
> + */
> +typedef struct MonitorQAPIEventState {
> +    QAPIEvent event;    /* Throttling state for this event type and... */
> +    QDict *data;        /* ... data, see qapi_event_throttle_equal() */
> +    QEMUTimer *timer;   /* Timer for handling delayed events */
> +    QDict *qdict;       /* Delayed event (if any) */
> +} MonitorQAPIEventState;
> +
> +typedef struct {
> +    int64_t rate;       /* Minimum time (in ns) between two events */
> +} MonitorQAPIEventConf;
> +
> +/* Shared monitor I/O thread */
> +IOThread *mon_iothread;
> +
> +/* Bottom half to dispatch the requests received from I/O thread */
> +QEMUBH *qmp_dispatcher_bh;
> +
> +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> +QemuMutex monitor_lock;
> +static GHashTable *monitor_qapi_event_state;
> +
> +MonitorList mon_list;
> +int mon_refcount;
> +static bool monitor_destroyed;
> +
> +/**
> + * Is @mon is using readline?
> + * Note: not all HMP monitors use readline, e.g., gdbserver has a
> + * non-interactive HMP monitor, so readline is not used there.
> + */
> +static inline bool monitor_uses_readline(const Monitor *mon)
> +{
> +    return mon->flags & MONITOR_USE_READLINE;
> +}
> +
> +static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
> +{
> +    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
> +}
> +
> +static void monitor_flush_locked(Monitor *mon);
> +
> +static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
> +                                  void *opaque)
> +{
> +    Monitor *mon = opaque;
> +
> +    qemu_mutex_lock(&mon->mon_lock);
> +    mon->out_watch = 0;
> +    monitor_flush_locked(mon);
> +    qemu_mutex_unlock(&mon->mon_lock);
> +    return FALSE;
> +}
> +
> +/* Caller must hold mon->mon_lock */
> +static void monitor_flush_locked(Monitor *mon)
> +{
> +    int rc;
> +    size_t len;
> +    const char *buf;
> +
> +    if (mon->skip_flush) {
> +        return;
> +    }
> +
> +    buf = qstring_get_str(mon->outbuf);
> +    len = qstring_get_length(mon->outbuf);
> +
> +    if (len && !mon->mux_out) {
> +        rc = qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
> +        if ((rc < 0 && errno != EAGAIN) || (rc == len)) {
> +            /* all flushed or error */
> +            qobject_unref(mon->outbuf);
> +            mon->outbuf = qstring_new();
> +            return;
> +        }
> +        if (rc > 0) {
> +            /* partial write */
> +            QString *tmp = qstring_from_str(buf + rc);
> +            qobject_unref(mon->outbuf);
> +            mon->outbuf = tmp;
> +        }
> +        if (mon->out_watch == 0) {
> +            mon->out_watch =
> +                qemu_chr_fe_add_watch(&mon->chr, G_IO_OUT | G_IO_HUP,
> +                                      monitor_unblocked, mon);
> +        }
> +    }
> +}
> +
> +void monitor_flush(Monitor *mon)
> +{
> +    qemu_mutex_lock(&mon->mon_lock);
> +    monitor_flush_locked(mon);
> +    qemu_mutex_unlock(&mon->mon_lock);
> +}
> +
> +/* flush at every end of line */
> +int monitor_puts(Monitor *mon, const char *str)
> +{
> +    int i;
> +    char c;
> +
> +    qemu_mutex_lock(&mon->mon_lock);
> +    for (i = 0; str[i]; i++) {
> +        c = str[i];
> +        if (c == '\n') {
> +            qstring_append_chr(mon->outbuf, '\r');
> +        }
> +        qstring_append_chr(mon->outbuf, c);
> +        if (c == '\n') {
> +            monitor_flush_locked(mon);
> +        }
> +    }
> +    qemu_mutex_unlock(&mon->mon_lock);
> +
> +    return i;
> +}
> +
> +int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +{
> +    char *buf;
> +    int n;
> +
> +    if (!mon)
> +        return -1;
> +
> +    if (monitor_is_qmp(mon)) {
> +        return -1;
> +    }
> +
> +    buf = g_strdup_vprintf(fmt, ap);
> +    n = monitor_puts(mon, buf);
> +    g_free(buf);
> +    return n;
> +}
> +
> +int monitor_printf(Monitor *mon, const char *fmt, ...)
> +{
> +    int ret;
> +
> +    va_list ap;
> +    va_start(ap, fmt);
> +    ret = monitor_vprintf(mon, fmt, ap);
> +    va_end(ap);
> +    return ret;
> +}
> +
> +
> +static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> +    /* Limit guest-triggerable events to 1 per second */
> +    [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
> +};
> +
> +/*
> + * Return the clock to use for recording an event's time.
> + * It's QEMU_CLOCK_REALTIME, except for qtests it's
> + * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
> + * Beware: result is invalid before configure_accelerator().
> + */
> +static inline QEMUClockType monitor_get_event_clock(void)
> +{
> +    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
> +}
> +
> +/*
> + * Broadcast an event to all monitors.
> + * @qdict is the event object.  Its member "event" must match @event.
> + * Caller must hold monitor_lock.
> + */
> +static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
> +{
> +    Monitor *mon;
> +    MonitorQMP *qmp_mon;
> +
> +    trace_monitor_protocol_event_emit(event, qdict);
> +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        if (!monitor_is_qmp(mon)) {
> +            continue;
> +        }
> +
> +        qmp_mon = container_of(mon, MonitorQMP, common);
> +        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
> +            qmp_send_response(qmp_mon, qdict);
> +        }
> +    }
> +}
> +
> +static void monitor_qapi_event_handler(void *opaque);
> +
> +/*
> + * Queue a new event for emission to Monitor instances,
> + * applying any rate limiting if required.
> + */
> +static void
> +monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
> +{
> +    MonitorQAPIEventConf *evconf;
> +    MonitorQAPIEventState *evstate;
> +
> +    assert(event < QAPI_EVENT__MAX);
> +    evconf = &monitor_qapi_event_conf[event];
> +    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> +
> +    qemu_mutex_lock(&monitor_lock);
> +
> +    if (!evconf->rate) {
> +        /* Unthrottled event */
> +        monitor_qapi_event_emit(event, qdict);
> +    } else {
> +        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
> +        MonitorQAPIEventState key = { .event = event, .data = data };
> +
> +        evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
> +        assert(!evstate || timer_pending(evstate->timer));
> +
> +        if (evstate) {
> +            /*
> +             * Timer is pending for (at least) evconf->rate ns after
> +             * last send.  Store event for sending when timer fires,
> +             * replacing a prior stored event if any.
> +             */
> +            qobject_unref(evstate->qdict);
> +            evstate->qdict = qobject_ref(qdict);
> +        } else {
> +            /*
> +             * Last send was (at least) evconf->rate ns ago.
> +             * Send immediately, and arm the timer to call
> +             * monitor_qapi_event_handler() in evconf->rate ns.  Any
> +             * events arriving before then will be delayed until then.
> +             */
> +            int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> +
> +            monitor_qapi_event_emit(event, qdict);
> +
> +            evstate = g_new(MonitorQAPIEventState, 1);
> +            evstate->event = event;
> +            evstate->data = qobject_ref(data);
> +            evstate->qdict = NULL;
> +            evstate->timer = timer_new_ns(monitor_get_event_clock(),
> +                                          monitor_qapi_event_handler,
> +                                          evstate);
> +            g_hash_table_add(monitor_qapi_event_state, evstate);
> +            timer_mod_ns(evstate->timer, now + evconf->rate);
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&monitor_lock);
> +}
> +
> +void qapi_event_emit(QAPIEvent event, QDict *qdict)
> +{
> +    /*
> +     * monitor_qapi_event_queue_no_reenter() is not reentrant: it
> +     * would deadlock on monitor_lock.  Work around by queueing
> +     * events in thread-local storage.
> +     * TODO: remove this, make it re-enter safe.
> +     */
> +    typedef struct MonitorQapiEvent {
> +        QAPIEvent event;
> +        QDict *qdict;
> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> +    } MonitorQapiEvent;
> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
> +    static __thread bool reentered;
> +    MonitorQapiEvent *ev;
> +
> +    if (!reentered) {
> +        QSIMPLEQ_INIT(&event_queue);
> +    }
> +
> +    ev = g_new(MonitorQapiEvent, 1);
> +    ev->qdict = qobject_ref(qdict);
> +    ev->event = event;
> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> +    if (reentered) {
> +        return;
> +    }
> +
> +    reentered = true;
> +
> +    while ((ev = QSIMPLEQ_FIRST(&event_queue)) != NULL) {
> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
> +        monitor_qapi_event_queue_no_reenter(ev->event, ev->qdict);
> +        qobject_unref(ev->qdict);
> +        g_free(ev);
> +    }
> +
> +    reentered = false;
> +}
> +
> +/*
> + * This function runs evconf->rate ns after sending a throttled
> + * event.
> + * If another event has since been stored, send it.
> + */
> +static void monitor_qapi_event_handler(void *opaque)
> +{
> +    MonitorQAPIEventState *evstate = opaque;
> +    MonitorQAPIEventConf *evconf = &monitor_qapi_event_conf[evstate->event];
> +
> +    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict);
> +    qemu_mutex_lock(&monitor_lock);
> +
> +    if (evstate->qdict) {
> +        int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> +
> +        monitor_qapi_event_emit(evstate->event, evstate->qdict);
> +        qobject_unref(evstate->qdict);
> +        evstate->qdict = NULL;
> +        timer_mod_ns(evstate->timer, now + evconf->rate);
> +    } else {
> +        g_hash_table_remove(monitor_qapi_event_state, evstate);
> +        qobject_unref(evstate->data);
> +        timer_free(evstate->timer);
> +        g_free(evstate);
> +    }
> +
> +    qemu_mutex_unlock(&monitor_lock);
> +}
> +
> +static unsigned int qapi_event_throttle_hash(const void *key)
> +{
> +    const MonitorQAPIEventState *evstate = key;
> +    unsigned int hash = evstate->event * 255;
> +
> +    if (evstate->event == QAPI_EVENT_VSERPORT_CHANGE) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "id"));
> +    }
> +
> +    if (evstate->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "node-name"));
> +    }
> +
> +    return hash;
> +}
> +
> +static gboolean qapi_event_throttle_equal(const void *a, const void *b)
> +{
> +    const MonitorQAPIEventState *eva = a;
> +    const MonitorQAPIEventState *evb = b;
> +
> +    if (eva->event != evb->event) {
> +        return FALSE;
> +    }
> +
> +    if (eva->event == QAPI_EVENT_VSERPORT_CHANGE) {
> +        return !strcmp(qdict_get_str(eva->data, "id"),
> +                       qdict_get_str(evb->data, "id"));
> +    }
> +
> +    if (eva->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> +        return !strcmp(qdict_get_str(eva->data, "node-name"),
> +                       qdict_get_str(evb->data, "node-name"));
> +    }
> +
> +    return TRUE;
> +}
> +
> +int monitor_suspend(Monitor *mon)
> +{
> +    if (monitor_is_hmp_non_interactive(mon)) {
> +        return -ENOTTY;
> +    }
> +
> +    atomic_inc(&mon->suspend_cnt);
> +
> +    if (mon->use_io_thread) {
> +        /*
> +         * Kick I/O thread to make sure this takes effect.  It'll be
> +         * evaluated again in prepare() of the watch object.
> +         */
> +        aio_notify(iothread_get_aio_context(mon_iothread));
> +    }
> +
> +    trace_monitor_suspend(mon, 1);
> +    return 0;
> +}
> +
> +static void monitor_accept_input(void *opaque)
> +{
> +    Monitor *mon = opaque;
> +
> +    qemu_chr_fe_accept_input(&mon->chr);
> +}
> +
> +void monitor_resume(Monitor *mon)
> +{
> +    if (monitor_is_hmp_non_interactive(mon)) {
> +        return;
> +    }
> +
> +    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
> +        AioContext *ctx;
> +
> +        if (mon->use_io_thread) {
> +            ctx = iothread_get_aio_context(mon_iothread);
> +        } else {
> +            ctx = qemu_get_aio_context();
> +        }
> +
> +        if (!monitor_is_qmp(mon)) {
> +            MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +            assert(hmp_mon->rs);
> +            readline_show_prompt(hmp_mon->rs);
> +        }
> +
> +        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
> +    }
> +
> +    trace_monitor_suspend(mon, -1);
> +}
> +
> +int monitor_can_read(void *opaque)
> +{
> +    Monitor *mon = opaque;
> +
> +    return !atomic_mb_read(&mon->suspend_cnt);
> +}
> +
> +void monitor_list_append(Monitor *mon)
> +{
> +    qemu_mutex_lock(&monitor_lock);
> +    /*
> +     * This prevents inserting new monitors during monitor_cleanup().
> +     * A cleaner solution would involve the main thread telling other
> +     * threads to terminate, waiting for their termination.
> +     */
> +    if (!monitor_destroyed) {
> +        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +        mon = NULL;
> +    }
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    if (mon) {
> +        monitor_data_destroy(mon);
> +        g_free(mon);
> +    }
> +}
> +
> +static void monitor_iothread_init(void)
> +{
> +    mon_iothread = iothread_create("mon_iothread", &error_abort);
> +}
> +
> +void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> +                       bool use_io_thread)
> +{
> +    if (use_io_thread && !mon_iothread) {
> +        monitor_iothread_init();
> +    }
> +    memset(mon, 0, sizeof(Monitor));
> +    qemu_mutex_init(&mon->mon_lock);
> +    mon->outbuf = qstring_new();
> +    mon->skip_flush = skip_flush;
> +    mon->use_io_thread = use_io_thread;
> +    mon->flags = flags;
> +}
> +
> +void monitor_data_destroy(Monitor *mon)
> +{
> +    g_free(mon->mon_cpu_path);
> +    qemu_chr_fe_deinit(&mon->chr, false);
> +    if (monitor_is_qmp(mon)) {
> +        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
> +        monitor_data_destroy_qmp(qmp_mon);
> +    } else {
> +        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +        readline_free(hmp_mon->rs);
> +    }
> +    qobject_unref(mon->outbuf);
> +    qemu_mutex_destroy(&mon->mon_lock);
> +}
> +
> +void monitor_init(Chardev *chr, int flags)
> +{
> +    if (flags & MONITOR_USE_CONTROL) {
> +        monitor_init_qmp(chr, flags);
> +    } else {
> +        monitor_init_hmp(chr, flags);
> +    }
> +}
> +
> +void monitor_cleanup(void)
> +{
> +    /*
> +     * We need to explicitly stop the I/O thread (but not destroy it),
> +     * clean up the monitor resources, then destroy the I/O thread since
> +     * we need to unregister from chardev below in
> +     * monitor_data_destroy(), and chardev is not thread-safe yet
> +     */
> +    if (mon_iothread) {
> +        iothread_stop(mon_iothread);
> +    }
> +
> +    /* Flush output buffers and destroy monitors */
> +    qemu_mutex_lock(&monitor_lock);
> +    monitor_destroyed = true;
> +    while (!QTAILQ_EMPTY(&mon_list)) {
> +        Monitor *mon = QTAILQ_FIRST(&mon_list);
> +        QTAILQ_REMOVE(&mon_list, mon, entry);
> +        /* Permit QAPI event emission from character frontend release */
> +        qemu_mutex_unlock(&monitor_lock);
> +        monitor_flush(mon);
> +        monitor_data_destroy(mon);
> +        qemu_mutex_lock(&monitor_lock);
> +        g_free(mon);
> +    }
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> +    qemu_bh_delete(qmp_dispatcher_bh);
> +    qmp_dispatcher_bh = NULL;
> +    if (mon_iothread) {
> +        iothread_destroy(mon_iothread);
> +        mon_iothread = NULL;
> +    }
> +}
> +
> +static void monitor_qapi_event_init(void)
> +{
> +    monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
> +                                                qapi_event_throttle_equal);
> +}
> +
> +void monitor_init_globals_core(void)
> +{
> +    monitor_qapi_event_init();
> +    qemu_mutex_init(&monitor_lock);
> +
> +    /*
> +     * The dispatcher BH must run in the main loop thread, since we
> +     * have commands assuming that context.  It would be nice to get
> +     * rid of those assumptions.
> +     */
> +    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
> +                                   monitor_qmp_bh_dispatcher,
> +                                   NULL);
> +}
> +
> +QemuOptsList qemu_mon_opts = {
> +    .name = "mon",
> +    .implied_opt_name = "chardev",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_mon_opts.head),
> +    .desc = {
> +        {
> +            .name = "mode",
> +            .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "chardev",
> +            .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "pretty",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 408d11e1fe..1f60f31c95 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -117,43 +117,13 @@ struct MonFdset {
>      QLIST_ENTRY(MonFdset) next;
>  };
>  
> -/*
> - * To prevent flooding clients, events can be throttled. The
> - * throttling is calculated globally, rather than per-Monitor
> - * instance.
> - */
> -typedef struct MonitorQAPIEventState {
> -    QAPIEvent event;    /* Throttling state for this event type and... */
> -    QDict *data;        /* ... data, see qapi_event_throttle_equal() */
> -    QEMUTimer *timer;   /* Timer for handling delayed events */
> -    QDict *qdict;       /* Delayed event (if any) */
> -} MonitorQAPIEventState;
> -
> -typedef struct {
> -    int64_t rate;       /* Minimum time (in ns) between two events */
> -} MonitorQAPIEventConf;
> -
> -/* Shared monitor I/O thread */
> -IOThread *mon_iothread;
> -
> -/* Bottom half to dispatch the requests received from I/O thread */
> -QEMUBH *qmp_dispatcher_bh;
> -
>  /* QMP checker flags */
>  #define QMP_ACCEPT_UNKNOWNS 1
>  
> -/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> -QemuMutex monitor_lock;
> -static GHashTable *monitor_qapi_event_state;
> -MonitorList mon_list;
> -static bool monitor_destroyed;
> -
>  /* Protects mon_fdsets */
>  static QemuMutex mon_fdsets_lock;
>  static QLIST_HEAD(, MonFdset) mon_fdsets;
>  
> -int mon_refcount;
> -
>  static mon_cmd_t info_cmds[];
>  
>  __thread Monitor *cur_mon;
> @@ -161,32 +131,6 @@ __thread Monitor *cur_mon;
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque);
>  
> -/**
> - * Is @mon is using readline?
> - * Note: not all HMP monitors use readline, e.g., gdbserver has a
> - * non-interactive HMP monitor, so readline is not used there.
> - */
> -static inline bool monitor_uses_readline(const Monitor *mon)
> -{
> -    return mon->flags & MONITOR_USE_READLINE;
> -}
> -
> -static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
> -{
> -    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
> -}
> -
> -/*
> - * Return the clock to use for recording an event's time.
> - * It's QEMU_CLOCK_REALTIME, except for qtests it's
> - * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
> - * Beware: result is invalid before configure_accelerator().
> - */
> -static inline QEMUClockType monitor_get_event_clock(void)
> -{
> -    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
> -}
> -
>  /**
>   * Is the current monitor, if any, a QMP monitor?
>   */
> @@ -220,355 +164,6 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>  }
>  
>  
> -static void monitor_flush_locked(Monitor *mon);
> -
> -static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
> -                                  void *opaque)
> -{
> -    Monitor *mon = opaque;
> -
> -    qemu_mutex_lock(&mon->mon_lock);
> -    mon->out_watch = 0;
> -    monitor_flush_locked(mon);
> -    qemu_mutex_unlock(&mon->mon_lock);
> -    return FALSE;
> -}
> -
> -/* Caller must hold mon->mon_lock */
> -static void monitor_flush_locked(Monitor *mon)
> -{
> -    int rc;
> -    size_t len;
> -    const char *buf;
> -
> -    if (mon->skip_flush) {
> -        return;
> -    }
> -
> -    buf = qstring_get_str(mon->outbuf);
> -    len = qstring_get_length(mon->outbuf);
> -
> -    if (len && !mon->mux_out) {
> -        rc = qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
> -        if ((rc < 0 && errno != EAGAIN) || (rc == len)) {
> -            /* all flushed or error */
> -            qobject_unref(mon->outbuf);
> -            mon->outbuf = qstring_new();
> -            return;
> -        }
> -        if (rc > 0) {
> -            /* partial write */
> -            QString *tmp = qstring_from_str(buf + rc);
> -            qobject_unref(mon->outbuf);
> -            mon->outbuf = tmp;
> -        }
> -        if (mon->out_watch == 0) {
> -            mon->out_watch =
> -                qemu_chr_fe_add_watch(&mon->chr, G_IO_OUT | G_IO_HUP,
> -                                      monitor_unblocked, mon);
> -        }
> -    }
> -}
> -
> -void monitor_flush(Monitor *mon)
> -{
> -    qemu_mutex_lock(&mon->mon_lock);
> -    monitor_flush_locked(mon);
> -    qemu_mutex_unlock(&mon->mon_lock);
> -}
> -
> -/* flush at every end of line */
> -int monitor_puts(Monitor *mon, const char *str)
> -{
> -    int i;
> -    char c;
> -
> -    qemu_mutex_lock(&mon->mon_lock);
> -    for (i = 0; str[i]; i++) {
> -        c = str[i];
> -        if (c == '\n') {
> -            qstring_append_chr(mon->outbuf, '\r');
> -        }
> -        qstring_append_chr(mon->outbuf, c);
> -        if (c == '\n') {
> -            monitor_flush_locked(mon);
> -        }
> -    }
> -    qemu_mutex_unlock(&mon->mon_lock);
> -
> -    return i;
> -}
> -
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> -{
> -    char *buf;
> -    int n;
> -
> -    if (!mon)
> -        return -1;
> -
> -    if (monitor_is_qmp(mon)) {
> -        return -1;
> -    }
> -
> -    buf = g_strdup_vprintf(fmt, ap);
> -    n = monitor_puts(mon, buf);
> -    g_free(buf);
> -    return n;
> -}
> -
> -int monitor_printf(Monitor *mon, const char *fmt, ...)
> -{
> -    int ret;
> -
> -    va_list ap;
> -    va_start(ap, fmt);
> -    ret = monitor_vprintf(mon, fmt, ap);
> -    va_end(ap);
> -    return ret;
> -}
> -
> -static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> -    /* Limit guest-triggerable events to 1 per second */
> -    [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> -    [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
> -    [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
> -    [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> -    [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> -    [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
> -};
> -
> -/*
> - * Broadcast an event to all monitors.
> - * @qdict is the event object.  Its member "event" must match @event.
> - * Caller must hold monitor_lock.
> - */
> -static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
> -{
> -    Monitor *mon;
> -    MonitorQMP *qmp_mon;
> -
> -    trace_monitor_protocol_event_emit(event, qdict);
> -    QTAILQ_FOREACH(mon, &mon_list, entry) {
> -        if (!monitor_is_qmp(mon)) {
> -            continue;
> -        }
> -
> -        qmp_mon = container_of(mon, MonitorQMP, common);
> -        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
> -            qmp_send_response(qmp_mon, qdict);
> -        }
> -    }
> -}
> -
> -static void monitor_qapi_event_handler(void *opaque);
> -
> -/*
> - * Queue a new event for emission to Monitor instances,
> - * applying any rate limiting if required.
> - */
> -static void
> -monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
> -{
> -    MonitorQAPIEventConf *evconf;
> -    MonitorQAPIEventState *evstate;
> -
> -    assert(event < QAPI_EVENT__MAX);
> -    evconf = &monitor_qapi_event_conf[event];
> -    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> -
> -    qemu_mutex_lock(&monitor_lock);
> -
> -    if (!evconf->rate) {
> -        /* Unthrottled event */
> -        monitor_qapi_event_emit(event, qdict);
> -    } else {
> -        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
> -        MonitorQAPIEventState key = { .event = event, .data = data };
> -
> -        evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
> -        assert(!evstate || timer_pending(evstate->timer));
> -
> -        if (evstate) {
> -            /*
> -             * Timer is pending for (at least) evconf->rate ns after
> -             * last send.  Store event for sending when timer fires,
> -             * replacing a prior stored event if any.
> -             */
> -            qobject_unref(evstate->qdict);
> -            evstate->qdict = qobject_ref(qdict);
> -        } else {
> -            /*
> -             * Last send was (at least) evconf->rate ns ago.
> -             * Send immediately, and arm the timer to call
> -             * monitor_qapi_event_handler() in evconf->rate ns.  Any
> -             * events arriving before then will be delayed until then.
> -             */
> -            int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> -
> -            monitor_qapi_event_emit(event, qdict);
> -
> -            evstate = g_new(MonitorQAPIEventState, 1);
> -            evstate->event = event;
> -            evstate->data = qobject_ref(data);
> -            evstate->qdict = NULL;
> -            evstate->timer = timer_new_ns(monitor_get_event_clock(),
> -                                          monitor_qapi_event_handler,
> -                                          evstate);
> -            g_hash_table_add(monitor_qapi_event_state, evstate);
> -            timer_mod_ns(evstate->timer, now + evconf->rate);
> -        }
> -    }
> -
> -    qemu_mutex_unlock(&monitor_lock);
> -}
> -
> -void qapi_event_emit(QAPIEvent event, QDict *qdict)
> -{
> -    /*
> -     * monitor_qapi_event_queue_no_reenter() is not reentrant: it
> -     * would deadlock on monitor_lock.  Work around by queueing
> -     * events in thread-local storage.
> -     * TODO: remove this, make it re-enter safe.
> -     */
> -    typedef struct MonitorQapiEvent {
> -        QAPIEvent event;
> -        QDict *qdict;
> -        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> -    } MonitorQapiEvent;
> -    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
> -    static __thread bool reentered;
> -    MonitorQapiEvent *ev;
> -
> -    if (!reentered) {
> -        QSIMPLEQ_INIT(&event_queue);
> -    }
> -
> -    ev = g_new(MonitorQapiEvent, 1);
> -    ev->qdict = qobject_ref(qdict);
> -    ev->event = event;
> -    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> -    if (reentered) {
> -        return;
> -    }
> -
> -    reentered = true;
> -
> -    while ((ev = QSIMPLEQ_FIRST(&event_queue)) != NULL) {
> -        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
> -        monitor_qapi_event_queue_no_reenter(ev->event, ev->qdict);
> -        qobject_unref(ev->qdict);
> -        g_free(ev);
> -    }
> -
> -    reentered = false;
> -}
> -
> -/*
> - * This function runs evconf->rate ns after sending a throttled
> - * event.
> - * If another event has since been stored, send it.
> - */
> -static void monitor_qapi_event_handler(void *opaque)
> -{
> -    MonitorQAPIEventState *evstate = opaque;
> -    MonitorQAPIEventConf *evconf = &monitor_qapi_event_conf[evstate->event];
> -
> -    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict);
> -    qemu_mutex_lock(&monitor_lock);
> -
> -    if (evstate->qdict) {
> -        int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
> -
> -        monitor_qapi_event_emit(evstate->event, evstate->qdict);
> -        qobject_unref(evstate->qdict);
> -        evstate->qdict = NULL;
> -        timer_mod_ns(evstate->timer, now + evconf->rate);
> -    } else {
> -        g_hash_table_remove(monitor_qapi_event_state, evstate);
> -        qobject_unref(evstate->data);
> -        timer_free(evstate->timer);
> -        g_free(evstate);
> -    }
> -
> -    qemu_mutex_unlock(&monitor_lock);
> -}
> -
> -static unsigned int qapi_event_throttle_hash(const void *key)
> -{
> -    const MonitorQAPIEventState *evstate = key;
> -    unsigned int hash = evstate->event * 255;
> -
> -    if (evstate->event == QAPI_EVENT_VSERPORT_CHANGE) {
> -        hash += g_str_hash(qdict_get_str(evstate->data, "id"));
> -    }
> -
> -    if (evstate->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> -        hash += g_str_hash(qdict_get_str(evstate->data, "node-name"));
> -    }
> -
> -    return hash;
> -}
> -
> -static gboolean qapi_event_throttle_equal(const void *a, const void *b)
> -{
> -    const MonitorQAPIEventState *eva = a;
> -    const MonitorQAPIEventState *evb = b;
> -
> -    if (eva->event != evb->event) {
> -        return FALSE;
> -    }
> -
> -    if (eva->event == QAPI_EVENT_VSERPORT_CHANGE) {
> -        return !strcmp(qdict_get_str(eva->data, "id"),
> -                       qdict_get_str(evb->data, "id"));
> -    }
> -
> -    if (eva->event == QAPI_EVENT_QUORUM_REPORT_BAD) {
> -        return !strcmp(qdict_get_str(eva->data, "node-name"),
> -                       qdict_get_str(evb->data, "node-name"));
> -    }
> -
> -    return TRUE;
> -}
> -
> -static void monitor_qapi_event_init(void)
> -{
> -    monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
> -                                                qapi_event_throttle_equal);
> -}
> -
> -static void monitor_iothread_init(void);
> -
> -void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> -                       bool use_io_thread)
> -{
> -    if (use_io_thread && !mon_iothread) {
> -        monitor_iothread_init();
> -    }
> -    memset(mon, 0, sizeof(Monitor));
> -    qemu_mutex_init(&mon->mon_lock);
> -    mon->outbuf = qstring_new();
> -    mon->skip_flush = skip_flush;
> -    mon->use_io_thread = use_io_thread;
> -    mon->flags = flags;
> -}
> -
> -static void monitor_data_destroy(Monitor *mon)
> -{
> -    g_free(mon->mon_cpu_path);
> -    qemu_chr_fe_deinit(&mon->chr, false);
> -    if (monitor_is_qmp(mon)) {
> -        MonitorQMP *qmp_mon = container_of(mon, MonitorQMP, common);
> -        monitor_data_destroy_qmp(qmp_mon);
> -    } else {
> -        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> -        readline_free(hmp_mon->rs);
> -    }
> -    qobject_unref(mon->outbuf);
> -    qemu_mutex_destroy(&mon->mon_lock);
> -}
> -
>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>                                  int64_t cpu_index, Error **errp)
>  {
> @@ -2738,13 +2333,6 @@ void loadvm_completion(ReadLineState *rs, int nb_args, const char *str)
>      }
>  }
>  
> -int monitor_can_read(void *opaque)
> -{
> -    Monitor *mon = opaque;
> -
> -    return !atomic_mb_read(&mon->suspend_cnt);
> -}
> -
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> @@ -2755,60 +2343,6 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
>      monitor_resume(&mon->common);
>  }
>  
> -int monitor_suspend(Monitor *mon)
> -{
> -    if (monitor_is_hmp_non_interactive(mon)) {
> -        return -ENOTTY;
> -    }
> -
> -    atomic_inc(&mon->suspend_cnt);
> -
> -    if (mon->use_io_thread) {
> -        /*
> -         * Kick I/O thread to make sure this takes effect.  It'll be
> -         * evaluated again in prepare() of the watch object.
> -         */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> -    }
> -
> -    trace_monitor_suspend(mon, 1);
> -    return 0;
> -}
> -
> -static void monitor_accept_input(void *opaque)
> -{
> -    Monitor *mon = opaque;
> -
> -    qemu_chr_fe_accept_input(&mon->chr);
> -}
> -
> -void monitor_resume(Monitor *mon)
> -{
> -    if (monitor_is_hmp_non_interactive(mon)) {
> -        return;
> -    }
> -
> -    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
> -        AioContext *ctx;
> -
> -        if (mon->use_io_thread) {
> -            ctx = iothread_get_aio_context(mon_iothread);
> -        } else {
> -            ctx = qemu_get_aio_context();
> -        }
> -
> -        if (!monitor_is_qmp(mon)) {
> -            MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> -            assert(hmp_mon->rs);
> -            readline_show_prompt(hmp_mon->rs);
> -        }
> -
> -        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
> -    }
> -
> -    trace_monitor_suspend(mon, -1);
> -}
> -
>  static int
>  compare_mon_cmd(const void *a, const void *b)
>  {
> @@ -2828,27 +2362,12 @@ static void sortcmdlist(void)
>      qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
>  }
>  
> -static void monitor_iothread_init(void)
> -{
> -    mon_iothread = iothread_create("mon_iothread", &error_abort);
> -}
> -
>  void monitor_init_globals(void)
>  {
> +    monitor_init_globals_core();
>      monitor_init_qmp_commands();
> -    monitor_qapi_event_init();
>      sortcmdlist();
> -    qemu_mutex_init(&monitor_lock);
>      qemu_mutex_init(&mon_fdsets_lock);
> -
> -    /*
> -     * The dispatcher BH must run in the main loop thread, since we
> -     * have commands assuming that context.  It would be nice to get
> -     * rid of those assumptions.
> -     */
> -    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
> -                                   monitor_qmp_bh_dispatcher,
> -                                   NULL);
>  }
>  
>  /*
> @@ -2873,90 +2392,6 @@ int error_vprintf_unless_qmp(const char *fmt, va_list ap)
>      return -1;
>  }
>  
> -void monitor_list_append(Monitor *mon)
> -{
> -    qemu_mutex_lock(&monitor_lock);
> -    /*
> -     * This prevents inserting new monitors during monitor_cleanup().
> -     * A cleaner solution would involve the main thread telling other
> -     * threads to terminate, waiting for their termination.
> -     */
> -    if (!monitor_destroyed) {
> -        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> -        mon = NULL;
> -    }
> -    qemu_mutex_unlock(&monitor_lock);
> -
> -    if (mon) {
> -        monitor_data_destroy(mon);
> -        g_free(mon);
> -    }
> -}
> -
> -void monitor_init(Chardev *chr, int flags)
> -{
> -    if (flags & MONITOR_USE_CONTROL) {
> -        monitor_init_qmp(chr, flags);
> -    } else {
> -        monitor_init_hmp(chr, flags);
> -    }
> -}
> -
> -void monitor_cleanup(void)
> -{
> -    /*
> -     * We need to explicitly stop the I/O thread (but not destroy it),
> -     * clean up the monitor resources, then destroy the I/O thread since
> -     * we need to unregister from chardev below in
> -     * monitor_data_destroy(), and chardev is not thread-safe yet
> -     */
> -    if (mon_iothread) {
> -        iothread_stop(mon_iothread);
> -    }
> -
> -    /* Flush output buffers and destroy monitors */
> -    qemu_mutex_lock(&monitor_lock);
> -    monitor_destroyed = true;
> -    while (!QTAILQ_EMPTY(&mon_list)) {
> -        Monitor *mon = QTAILQ_FIRST(&mon_list);
> -        QTAILQ_REMOVE(&mon_list, mon, entry);
> -        /* Permit QAPI event emission from character frontend release */
> -        qemu_mutex_unlock(&monitor_lock);
> -        monitor_flush(mon);
> -        monitor_data_destroy(mon);
> -        qemu_mutex_lock(&monitor_lock);
> -        g_free(mon);
> -    }
> -    qemu_mutex_unlock(&monitor_lock);
> -
> -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> -    qemu_bh_delete(qmp_dispatcher_bh);
> -    qmp_dispatcher_bh = NULL;
> -    if (mon_iothread) {
> -        iothread_destroy(mon_iothread);
> -        mon_iothread = NULL;
> -    }
> -}
> -
> -QemuOptsList qemu_mon_opts = {
> -    .name = "mon",
> -    .implied_opt_name = "chardev",
> -    .head = QTAILQ_HEAD_INITIALIZER(qemu_mon_opts.head),
> -    .desc = {
> -        {
> -            .name = "mode",
> -            .type = QEMU_OPT_STRING,
> -        },{
> -            .name = "chardev",
> -            .type = QEMU_OPT_STRING,
> -        },{
> -            .name = "pretty",
> -            .type = QEMU_OPT_BOOL,
> -        },
> -        { /* end of list */ }
> -    },
> -};
> -
>  HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> index 48c73eed51..c8dff5e4b5 100644
> --- a/monitor/Makefile.objs
> +++ b/monitor/Makefile.objs
> @@ -1,2 +1,2 @@
>  obj-y += misc.o
> -common-obj-y += qmp.o hmp.o
> +common-obj-y += core.o qmp.o hmp.o
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

