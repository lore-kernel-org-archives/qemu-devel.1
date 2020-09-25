Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BCFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AA720878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzsWpxTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AA720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpRs-0005Pv-Ql
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpPU-0004Bo-Vv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLpPQ-0004YC-Dp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:13:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601046790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QNY9oZqINRbEYxaYshvrO7yiTKjFTGGUUuYD/umxpj4=;
 b=gzsWpxTq96IcqMwO9VtDfgDxQNZSKMYGnN3jNpL5vV1Qmr3tQuhc7B4zWcQq0EanpJNy20
 wsgMBUtG16mAeQDqsVYqKeT8d4T71oYEy44W9SJQQ33mzKZpNk1KO8wtI53dpagVbi2Ydw
 Ts8GYBexukFcMAw3YT+0fGYKQc4CEak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-e_7NhI3lO7q4bWU5DvQqDQ-1; Fri, 25 Sep 2020 11:13:08 -0400
X-MC-Unique: e_7NhI3lO7q4bWU5DvQqDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27268AD6B9;
 Fri, 25 Sep 2020 15:13:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFAE955772;
 Fri, 25 Sep 2020 15:13:05 +0000 (UTC)
Date: Fri, 25 Sep 2020 17:13:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
Message-ID: <20200925151304.GE5731@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-7-kwolf@redhat.com>
 <877dswo0mf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877dswo0mf.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 14.09.2020 um 17:10 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > The correct way to set the current monitor for a coroutine handler will
> > be different than for a blocking handler, so monitor_set_cur() needs to
> > be called in qmp_dispatch().
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/qapi/qmp/dispatch.h | 3 ++-
> >  monitor/qmp.c               | 8 +-------
> >  qapi/qmp-dispatch.c         | 8 +++++++-
> >  qga/main.c                  | 2 +-
> >  stubs/monitor-core.c        | 5 +++++
> >  tests/test-qmp-cmds.c       | 6 +++---
> >  6 files changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index 5a9cf82472..0c2f467028 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -14,6 +14,7 @@
> >  #ifndef QAPI_QMP_DISPATCH_H
> >  #define QAPI_QMP_DISPATCH_H
> >  
> > +#include "monitor/monitor.h"
> >  #include "qemu/queue.h"
> >  
> >  typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
> > @@ -49,7 +50,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
> >  bool qmp_has_success_response(const QmpCommand *cmd);
> >  QDict *qmp_error_response(Error *err);
> >  QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
> > -                    bool allow_oob);
> > +                    bool allow_oob, Monitor *cur_mon);
> >  bool qmp_is_oob(const QDict *dict);
> >  
> >  typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 8469970c69..922fdb5541 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -135,16 +135,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
> >  
> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> >  {
> > -    Monitor *old_mon;
> >      QDict *rsp;
> >      QDict *error;
> >  
> > -    old_mon = monitor_set_cur(&mon->common);
> > -    assert(old_mon == NULL);
> > -
> > -    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
> > -
> > -    monitor_set_cur(NULL);
> > +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
> 
> Long line.  Happy to wrap it in my tree.  A few more in PATCH 08-11.

It's 79 characters. Should be fine even with your local deviation from
the coding style to require less than that for comments?

Kevin


