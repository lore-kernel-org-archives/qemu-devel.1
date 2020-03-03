Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4A02083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKCeK7E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4A02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95qw-0000zM-Ol
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j95q9-0000Cm-C9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j95q7-00062g-Cg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:35:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j95q7-00062U-8n
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583235354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRK1aQtSYpnyfkWqATXYcYl+BjWSam/eH1537URhl8g=;
 b=WKCeK7E6FvgXCJ4As4z98uvSFWb4xu6hd5Tc16AVR4jugQKsy2IBSplK6gRkilhfKtJL5T
 1/lXmLH5bV+uqbHf/wEeeR+qORLd3ISSOoUiQFRXlvwBC37nuhUK61UKnqj5eW8CTQBPqg
 fQ2z4bAqRzeoDbHv5bJznDoCRTMeM5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-NatgYmfVOVykz1JbQLdXdg-1; Tue, 03 Mar 2020 06:35:51 -0500
X-MC-Unique: NatgYmfVOVykz1JbQLdXdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E681C800D4E;
 Tue,  3 Mar 2020 11:35:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-229.ams2.redhat.com [10.36.117.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C6C60C05;
 Tue,  3 Mar 2020 11:35:48 +0000 (UTC)
Date: Tue, 3 Mar 2020 12:35:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200303113547.GB5733@linux.fritz.box>
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
 <87o8tdddqv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8tdddqv.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Am 03.03.2020 um 09:49 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > handlers that declare 'coroutine': true in coroutine context so they
> > can avoid blocking the main loop while doing I/O or waiting for other
> > events.
> >
> > For commands that are not declared safe to run in a coroutine, the
> > dispatcher drops out of coroutine context by calling the QMP command
> > handler from a bottom half.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/qapi/qmp/dispatch.h |   1 +
> >  monitor/monitor-internal.h  |   6 +-
> >  monitor/monitor.c           |  55 +++++++++++++---
> >  monitor/qmp.c               | 122 +++++++++++++++++++++++++++---------
> >  qapi/qmp-dispatch.c         |  44 ++++++++++++-
> >  qapi/qmp-registry.c         |   3 +
> >  util/aio-posix.c            |   7 ++-
> >  7 files changed, 196 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index d6ce9efc8e..6812e49b5f 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -30,6 +30,7 @@ typedef enum QmpCommandOptions
> >  typedef struct QmpCommand
> >  {
> >      const char *name;
> > +    /* Runs in coroutine context if QCO_COROUTINE is set */
> >      QmpCommandFunc *fn;
> >      QmpCommandOptions options;
> >      QTAILQ_ENTRY(QmpCommand) node;
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 3e6baba88f..f8123b151a 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -155,7 +155,9 @@ static inline bool monitor_is_qmp(const Monitor *mo=
n)
> > =20
> >  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> >  extern IOThread *mon_iothread;
> > -extern QEMUBH *qmp_dispatcher_bh;
> > +extern Coroutine *qmp_dispatcher_co;
> > +extern bool qmp_dispatcher_co_shutdown;
> > +extern bool qmp_dispatcher_co_busy;
> >  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >  extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> > @@ -173,7 +175,7 @@ void monitor_fdsets_cleanup(void);
> > =20
> >  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
> >  void monitor_data_destroy_qmp(MonitorQMP *mon);
> > -void monitor_qmp_bh_dispatcher(void *data);
> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data);
> > =20
> >  int get_monitor_def(int64_t *pval, const char *name);
> >  void help_cmd(Monitor *mon, const char *name);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index c1a6c4460f..72d57b5cd2 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -53,8 +53,32 @@ typedef struct {
> >  /* Shared monitor I/O thread */
> >  IOThread *mon_iothread;
> > =20
> > -/* Bottom half to dispatch the requests received from I/O thread */
> > -QEMUBH *qmp_dispatcher_bh;
> > +/* Coroutine to dispatch the requests received from I/O thread */
> > +Coroutine *qmp_dispatcher_co;
> > +
> > +/* Set to true when the dispatcher coroutine should terminate */
> > +bool qmp_dispatcher_co_shutdown;
> > +
> > +/*
> > + * qmp_dispatcher_co_busy is used for synchronisation between the
> > + * monitor thread and the main thread to ensure that the dispatcher
> > + * coroutine never gets scheduled a second time when it's already
> > + * scheduled (scheduling the same coroutine twice is forbidden).
> > + *
> > + * It is true if the coroutine is active and processing requests.
> > + * Additional requests may then be pushed onto a mon->qmp_requests,
> > + * and @qmp_dispatcher_co_shutdown may be set without further ado.
> > + * @qmp_dispatcher_co_busy must not be woken up in this case.
> > + *
> > + * If false, you also have to set @qmp_dispatcher_co_busy to true and
> > + * wake up @qmp_dispatcher_co after pushing the new requests.
>=20
> Also after setting @qmp_dispatcher_co_shutdown, right?
>=20
> Happy to tweak the comment without a respin.

I understood a shutdown request as just another kind of request, but if
you want the comment to be more detailed, feel free.

Kevin


