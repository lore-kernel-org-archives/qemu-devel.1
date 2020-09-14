Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD57C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E4F217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVtrhJlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E4F217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrm3-0002KO-1M
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHq7n-0003jn-HM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHq7k-0000mH-HR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dR5mKlxUBl8ICGo97mywt9UFXH5gdhieMP0EZ+UsmTc=;
 b=dVtrhJlrrzp1iCnTRqnS0IBDaVAuYtQ9EaZOSrMbXITOLBopGQbhL2QWZVg+0t0c/SpFP6
 cvcQjW2k3HU2UxLOb578FdNvdjNubb/4ifivm2XeRUWa3ybYN9CKf8A0YUt7PUpPeiYklm
 YH2D2py0pEXLlpebbltm5EL3irznnYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-20NR6_gDO1GZjJRTdHSo6w-1; Mon, 14 Sep 2020 11:10:23 -0400
X-MC-Unique: 20NR6_gDO1GZjJRTdHSo6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0C641091073;
 Mon, 14 Sep 2020 15:10:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4867775120;
 Mon, 14 Sep 2020 15:10:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D398D113864A; Mon, 14 Sep 2020 17:10:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-7-kwolf@redhat.com>
Date: Mon, 14 Sep 2020 17:10:16 +0200
In-Reply-To: <20200909151149.490589-7-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:42 +0200")
Message-ID: <877dswo0mf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> The correct way to set the current monitor for a coroutine handler will
> be different than for a blocking handler, so monitor_set_cur() needs to
> be called in qmp_dispatch().
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 3 ++-
>  monitor/qmp.c               | 8 +-------
>  qapi/qmp-dispatch.c         | 8 +++++++-
>  qga/main.c                  | 2 +-
>  stubs/monitor-core.c        | 5 +++++
>  tests/test-qmp-cmds.c       | 6 +++---
>  6 files changed, 19 insertions(+), 13 deletions(-)
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
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 8469970c69..922fdb5541 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -135,16 +135,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
>  
>  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>  {
> -    Monitor *old_mon;
>      QDict *rsp;
>      QDict *error;
>  
> -    old_mon = monitor_set_cur(&mon->common);
> -    assert(old_mon == NULL);
> -
> -    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
> -
> -    monitor_set_cur(NULL);
> +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);

Long line.  Happy to wrap it in my tree.  A few more in PATCH 08-11.

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
> index 3febf3b0fd..241779a1d6 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -578,7 +578,7 @@ static void process_event(void *opaque, QObject *obj, Error *err)
>      }
>  
>      g_debug("processing command");
> -    rsp = qmp_dispatch(&ga_commands, obj, false);
> +    rsp = qmp_dispatch(&ga_commands, obj, false, NULL);
>  
>  end:
>      ret = send_response(s, rsp);

I dislike how this entangles qemu-ga even more with the monitor.  But I
want to get this wrapped more than I want it to be spotless.  Perhaps I
can clean up some on top.

[...]


