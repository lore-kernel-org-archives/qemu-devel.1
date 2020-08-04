Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FF5207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arxCvQlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FF5207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wq1-00033i-2O
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2wpC-0001pj-46
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:17:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2wpA-000680-8U
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 09:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596547067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JqmRDZ3cfRuAilP3ocSx9YQpytNp9Hpz31o2cnpyhTw=;
 b=arxCvQlQNmeLNPAk36efI5bejPFg35BCZgX09mIgTkhnM5JHZy+jsn/RT2hrJb68QSm4sJ
 1z8ityKDyhT7cHT0nRmmpP5O2FDUH3R5kL+UYfnfsqPmi7RmVGhI2CizHMY6s6vC/t4mFq
 qIN5nSZLH6t61AJyXgDYjKXg1k4LCgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-sr3-gTN7NHiD8Xp3Af1Beg-1; Tue, 04 Aug 2020 09:17:43 -0400
X-MC-Unique: sr3-gTN7NHiD8Xp3Af1Beg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE01780BCB3;
 Tue,  4 Aug 2020 13:17:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A5425D9CC;
 Tue,  4 Aug 2020 13:17:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01B471141D60; Tue,  4 Aug 2020 15:17:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 05/12] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-6-kwolf@redhat.com>
Date: Tue, 04 Aug 2020 15:17:39 +0200
In-Reply-To: <20200528153742.274164-6-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 28 May 2020 17:37:35 +0200")
Message-ID: <877dueble4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

> The correct way to set the current monitor for a coroutine handler is
> different that for a blocking handler, so monitor_set_cur() can only be

will be different

> called in qmp_dispatch().

needs to be called in

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 3 ++-
>  monitor/qmp.c               | 7 +------
>  qapi/qmp-dispatch.c         | 8 +++++++-
>  qga/main.c                  | 2 +-
>  stubs/monitor-core.c        | 4 ++++
>  tests/test-qmp-cmds.c       | 6 +++---
>  6 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 5a9cf82472..0c2f467028 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -14,6 +14,7 @@
>  #ifndef QAPI_QMP_DISPATCH_H
>  #define QAPI_QMP_DISPATCH_H
>  
> +#include "monitor/monitor.h"
>  #include "qemu/queue.h"
>  
>  typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
> @@ -49,7 +50,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
>  bool qmp_has_success_response(const QmpCommand *cmd);
>  QDict *qmp_error_response(Error *err);
>  QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
> -                    bool allow_oob);
> +                    bool allow_oob, Monitor *cur_mon);
>  bool qmp_is_oob(const QDict *dict);
>  
>  typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);

Tying dispatch to the current monitor when two out of three users don't
have a monitor is ugly.  Let's not worry about that now.

> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index a04c512e3a..922fdb5541 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -138,12 +138,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>      QDict *rsp;
>      QDict *error;
>  
> -    assert(monitor_cur() == NULL);
> -    monitor_set_cur(&mon->common);
> -
> -    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
> -
> -    monitor_set_cur(NULL);
> +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);

Long line.

>  
>      if (mon->commands == &qmp_cap_negotiation_commands) {
>          error = qdict_get_qdict(rsp, "error");
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 79347e0864..2fdbc0fba4 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -89,7 +89,7 @@ bool qmp_is_oob(const QDict *dict)
>  }
>  
>  QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
> -                    bool allow_oob)
> +                    bool allow_oob, Monitor *cur_mon)
>  {
>      Error *err = NULL;
>      bool oob;
> @@ -152,7 +152,13 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>          args = qdict_get_qdict(dict, "arguments");
>          qobject_ref(args);
>      }
> +
> +    assert(monitor_cur() == NULL);
> +    monitor_set_cur(cur_mon);
> +
>      cmd->fn(args, &ret, &err);
> +
> +    monitor_set_cur(NULL);
>      qobject_unref(args);
>      if (err) {
>          /* or assert(!ret) after reviewing all handlers: */
> diff --git a/qga/main.c b/qga/main.c
> index f0e454f28d..1042c4e7d3 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -574,7 +574,7 @@ static void process_event(void *opaque, QObject *obj, Error *err)
>      }
>  
>      g_debug("processing command");
> -    rsp = qmp_dispatch(&ga_commands, obj, false);
> +    rsp = qmp_dispatch(&ga_commands, obj, false, NULL);
>  
>  end:
>      ret = send_response(s, rsp);
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 0cd2d864b2..e493df1027 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -8,6 +8,10 @@ Monitor *monitor_cur(void)
>      return NULL;
>  }
>  
> +void monitor_set_cur(Monitor *mon)
> +{
> +}
> +
>  void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>  {
>  }
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index d12ff47e26..5f1b245e19 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -152,7 +152,7 @@ static QObject *do_qmp_dispatch(bool allow_oob, const char *template, ...)
>      req = qdict_from_vjsonf_nofail(template, ap);
>      va_end(ap);
>  
> -    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
> +    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob, NULL);
>      g_assert(resp);
>      ret = qdict_get(resp, "return");
>      g_assert(ret);
> @@ -175,7 +175,7 @@ static void do_qmp_dispatch_error(bool allow_oob, ErrorClass cls,
>      req = qdict_from_vjsonf_nofail(template, ap);
>      va_end(ap);
>  
> -    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
> +    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob, NULL);
>      g_assert(resp);
>      error = qdict_get_qdict(resp, "error");
>      g_assert(error);
> @@ -231,7 +231,7 @@ static void test_dispatch_cmd_success_response(void)
>      QDict *resp;
>  
>      qdict_put_str(req, "execute", "cmd-success-response");
> -    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
> +    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false, NULL);
>      g_assert_null(resp);
>      qobject_unref(req);
>  }

This works because qmp_dispatch() doesn't bother to check its @mon
argument is sane, and the test's commands don't use monitor_cur().


