Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFBAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0020873
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPx4edGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43791 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93G4-0002i5-3X
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j93FR-0002C4-3c
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j93FP-00026C-Pd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:49:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j93FP-00025x-MM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583225391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPU1eKYuYL+VPBCcEIaJZwb7kwnd0JYQQtfq5zdvvBQ=;
 b=DPx4edGVX7NZ3vZ73tmeLpuZuTl68TG3PZl6qo4Sw0Zo/GBiRme46wtitWl3sIj/cavca0
 qSbVpJRR/3esLQgod3moAKFMB9rHQoOTG24843pv2hOOMiNzkZRd8mEgCsqPs9bNZK4frz
 +mZH7x5kEgdrPRZtjdri/G1aycpZrcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-bAL6pesSPMGxuwZwhQt-Tg-1; Tue, 03 Mar 2020 03:49:47 -0500
X-MC-Unique: bAL6pesSPMGxuwZwhQt-Tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E0D1005516;
 Tue,  3 Mar 2020 08:49:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7699B27198;
 Tue,  3 Mar 2020 08:49:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05D7E11386A6; Tue,  3 Mar 2020 09:49:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
Date: Tue, 03 Mar 2020 09:49:44 +0100
In-Reply-To: <20200218154036.28562-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 18 Feb 2020 16:40:35 +0100")
Message-ID: <87o8tdddqv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.
>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h |   1 +
>  monitor/monitor-internal.h  |   6 +-
>  monitor/monitor.c           |  55 +++++++++++++---
>  monitor/qmp.c               | 122 +++++++++++++++++++++++++++---------
>  qapi/qmp-dispatch.c         |  44 ++++++++++++-
>  qapi/qmp-registry.c         |   3 +
>  util/aio-posix.c            |   7 ++-
>  7 files changed, 196 insertions(+), 42 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index d6ce9efc8e..6812e49b5f 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -30,6 +30,7 @@ typedef enum QmpCommandOptions
>  typedef struct QmpCommand
>  {
>      const char *name;
> +    /* Runs in coroutine context if QCO_COROUTINE is set */
>      QmpCommandFunc *fn;
>      QmpCommandOptions options;
>      QTAILQ_ENTRY(QmpCommand) node;
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 3e6baba88f..f8123b151a 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -155,7 +155,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
> =20
>  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
>  extern IOThread *mon_iothread;
> -extern QEMUBH *qmp_dispatcher_bh;
> +extern Coroutine *qmp_dispatcher_co;
> +extern bool qmp_dispatcher_co_shutdown;
> +extern bool qmp_dispatcher_co_busy;
>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
> @@ -173,7 +175,7 @@ void monitor_fdsets_cleanup(void);
> =20
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
> -void monitor_qmp_bh_dispatcher(void *data);
> +void coroutine_fn monitor_qmp_dispatcher_co(void *data);
> =20
>  int get_monitor_def(int64_t *pval, const char *name);
>  void help_cmd(Monitor *mon, const char *name);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c1a6c4460f..72d57b5cd2 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -53,8 +53,32 @@ typedef struct {
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
> =20
> -/* Bottom half to dispatch the requests received from I/O thread */
> -QEMUBH *qmp_dispatcher_bh;
> +/* Coroutine to dispatch the requests received from I/O thread */
> +Coroutine *qmp_dispatcher_co;
> +
> +/* Set to true when the dispatcher coroutine should terminate */
> +bool qmp_dispatcher_co_shutdown;
> +
> +/*
> + * qmp_dispatcher_co_busy is used for synchronisation between the
> + * monitor thread and the main thread to ensure that the dispatcher
> + * coroutine never gets scheduled a second time when it's already
> + * scheduled (scheduling the same coroutine twice is forbidden).
> + *
> + * It is true if the coroutine is active and processing requests.
> + * Additional requests may then be pushed onto a mon->qmp_requests,
> + * and @qmp_dispatcher_co_shutdown may be set without further ado.
> + * @qmp_dispatcher_co_busy must not be woken up in this case.
> + *
> + * If false, you also have to set @qmp_dispatcher_co_busy to true and
> + * wake up @qmp_dispatcher_co after pushing the new requests.

Also after setting @qmp_dispatcher_co_shutdown, right?

Happy to tweak the comment without a respin.

> + *
> + * The coroutine will automatically change this variable back to false
> + * before it yields.  Nobody else may set the variable to false.
> + *
> + * Access must be atomic for thread safety.
> + */
> +bool qmp_dispatcher_co_busy;
> =20
>  /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
>  QemuMutex monitor_lock;
[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


