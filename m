Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7889BC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C670420739
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTbRJqnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C670420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYOJ-0001Gp-Uz
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNYNh-0000mm-N4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNYNf-0002VA-3l
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:26:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601457994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Xf/n/WEFYhjbBOz8l2e9+B5j7Cjk8nj5BgQNNWtZWw=;
 b=BTbRJqnreh/0I77BBDWVVmg8pexx2PwevrbI+EqKhm+FugWJiRpvMsyV7wgaRAcg2/eKHg
 zFrzqO/6z6LrnoafRfI0lPW/knhVoLy6wlUKF2u3s1rDF3xLWk0XSb68MVaETnYHqm4hTN
 Qx0pzwMXEUsaMce7RCskITZjbv4WKC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-cDLE_wOlMJekLu1x21XVaw-1; Wed, 30 Sep 2020 05:26:30 -0400
X-MC-Unique: cDLE_wOlMJekLu1x21XVaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208CB1074651;
 Wed, 30 Sep 2020 09:26:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC59510013C0;
 Wed, 30 Sep 2020 09:26:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57747113864A; Wed, 30 Sep 2020 11:26:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-7-kwolf@redhat.com>
 <877dswo0mf.fsf@dusky.pond.sub.org>
 <20200925151304.GE5731@linux.fritz.box>
 <87ft72i0v8.fsf@dusky.pond.sub.org>
 <20200928143052.GH5451@linux.fritz.box>
Date: Wed, 30 Sep 2020 11:26:24 +0200
In-Reply-To: <20200928143052.GH5451@linux.fritz.box> (Kevin Wolf's message of
 "Mon, 28 Sep 2020 16:30:52 +0200")
Message-ID: <87h7rfehtr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.09.2020 um 13:42 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 14.09.2020 um 17:10 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> 
>> >> > The correct way to set the current monitor for a coroutine handler will
>> >> > be different than for a blocking handler, so monitor_set_cur() needs to
>> >> > be called in qmp_dispatch().
>> >> >
>> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> >> > ---
>> >> >  include/qapi/qmp/dispatch.h | 3 ++-
>> >> >  monitor/qmp.c               | 8 +-------
>> >> >  qapi/qmp-dispatch.c         | 8 +++++++-
>> >> >  qga/main.c                  | 2 +-
>> >> >  stubs/monitor-core.c        | 5 +++++
>> >> >  tests/test-qmp-cmds.c       | 6 +++---
>> >> >  6 files changed, 19 insertions(+), 13 deletions(-)
>> >> >
>> >> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
>> >> > index 5a9cf82472..0c2f467028 100644
>> >> > --- a/include/qapi/qmp/dispatch.h
>> >> > +++ b/include/qapi/qmp/dispatch.h
>> >> > @@ -14,6 +14,7 @@
>> >> >  #ifndef QAPI_QMP_DISPATCH_H
>> >> >  #define QAPI_QMP_DISPATCH_H
>> >> >  
>> >> > +#include "monitor/monitor.h"
>> >> >  #include "qemu/queue.h"
>> >> >  
>> >> >  typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
>> >> > @@ -49,7 +50,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
>> >> >  bool qmp_has_success_response(const QmpCommand *cmd);
>> >> >  QDict *qmp_error_response(Error *err);
>> >> >  QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>> >> > -                    bool allow_oob);
>> >> > +                    bool allow_oob, Monitor *cur_mon);
>> >> >  bool qmp_is_oob(const QDict *dict);
>> >> >  
>> >> >  typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);
>> >> > diff --git a/monitor/qmp.c b/monitor/qmp.c
>> >> > index 8469970c69..922fdb5541 100644
>> >> > --- a/monitor/qmp.c
>> >> > +++ b/monitor/qmp.c
>> >> > @@ -135,16 +135,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
>> >> >  
>> >> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>> >> >  {
>> >> > -    Monitor *old_mon;
>> >> >      QDict *rsp;
>> >> >      QDict *error;
>> >> >  
>> >> > -    old_mon = monitor_set_cur(&mon->common);
>> >> > -    assert(old_mon == NULL);
>> >> > -
>> >> > -    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
>> >> > -
>> >> > -    monitor_set_cur(NULL);
>> >> > +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
>> >> 
>> >> Long line.  Happy to wrap it in my tree.  A few more in PATCH 08-11.
>> >
>> > It's 79 characters. Should be fine even with your local deviation from
>> > the coding style to require less than that for comments?
>> 
>> Let me rephrase my remark.
>> 
>> For me,
>> 
>>     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
>>                        &mon->common);
>> 
>> is significantly easier to read than
>> 
>>     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
>
> I guess this is highly subjective. I find wrapped lines harder to read.
> For answering subjective questions like this, we generally use the
> coding style document.
>
> Anyway, I guess following an idiosyncratic coding style that is
> different from every other subsystem in QEMU is possible (if
> inconvenient) if I know what it is.

The applicable coding style document is PEP 8.

> My problem is more that I don't know what the exact rules are. Can they
> only be figured out experimentally by submitting patches and seeing
> whether you like them or not?

PEP 8:

    A style guide is about consistency.  Consistency with this style
    guide is important.  Consistency within a project is more important.
    Consistency within one module or function is the most important.

In other words, you should make a reasonable effort to blend in.

>> Would you mind me wrapping this line in my tree?
>
> I have no say in this subsystem and I take it that you want all code to
> look as if you had written it yourself, so do as you wish.

I'm refusing the bait.

> But I understand that I'll have to respin anyway, so if you could
> explain what you're after, I might be able to apply the rules for the
> next version of the series.

First, PEP 8 again:

    Limit all lines to a maximum of 79 characters.

    For flowing long blocks of text with fewer structural restrictions
    (docstrings or comments), the line length should be limited to 72
    characters.

Second, an argument we two had on this list, during review of a prior
version of this patch series, talking about C:

    Legibility.  Humans tend to have trouble following long lines with
    their eyes (I sure do).  Typographic manuals suggest to limit
    columns to roughly 60 characters for exactly that reason[*].

    Code is special.  It's typically indented, and long identifiers push
    it further to the right, function arguments in particular.  We
    compromised at 80 columns.

    [...]

    [*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style

The width of the line not counting indentation matters for legibility.

The line I flagged as long is 75 characters wide not counting
indentation.  That's needlessly hard to read for me.

PEP 8's line length limit is a *limit*, not a sacred right to push right
to the limit.

Since I get to read this code a lot, I've taken care to avoid illegibly
wide lines, and I've guided contributors to blend in.


