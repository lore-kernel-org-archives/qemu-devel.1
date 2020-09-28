Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7AFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F882078B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRjjAXDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F882078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoUA-0002sr-Cp
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMoSj-0001Ug-Pu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMoSh-0004S1-Aq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:24:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601281481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va5Yko21aZgYi0fHhb8xP7SNSYNsJ9g/+JqMJw8eyZs=;
 b=BRjjAXDn+kQ/081O3tdS82U1i2EVNUQmxRhx5dvQar+pqVM1zVauznE6GzizQHhXSg9AP7
 pXepancWtn9o/Kt2e0gqxbT4E5G0xjq+uYo7+C2zR6qhs0HVfrQjNBFhw/nUpuRfcdzBVv
 osmdai8Nzob3e8mae9EylwOQ90u4aZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-wNJCgXdjMgq3yhwrMQvJRQ-1; Mon, 28 Sep 2020 04:24:38 -0400
X-MC-Unique: wNJCgXdjMgq3yhwrMQvJRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE892802B61;
 Mon, 28 Sep 2020 08:24:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A407B7A41F;
 Mon, 28 Sep 2020 08:24:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DFAE113865F; Mon, 28 Sep 2020 10:24:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 09/13] qmp: Move dispatcher to a coroutine
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-10-kwolf@redhat.com>
 <87imcgml3w.fsf@dusky.pond.sub.org>
 <20200925153855.GH5731@linux.fritz.box>
Date: Mon, 28 Sep 2020 10:24:33 +0200
In-Reply-To: <20200925153855.GH5731@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 25 Sep 2020 17:38:55 +0200")
Message-ID: <87h7ril35q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.09.2020 um 17:30 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > This moves the QMP dispatcher to a coroutine and runs all QMP command
>> > handlers that declare 'coroutine': true in coroutine context so they
>> > can avoid blocking the main loop while doing I/O or waiting for other
>> > events.
>> >
>> > For commands that are not declared safe to run in a coroutine, the
>> > dispatcher drops out of coroutine context by calling the QMP command
>> > handler from a bottom half.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> > ---
[...]
>> > diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
>> > index 5677ba92ca..754f7b854c 100644
>> > --- a/qapi/qmp-dispatch.c
>> > +++ b/qapi/qmp-dispatch.c
[...]
>> > @@ -153,12 +181,35 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>> >          qobject_ref(args);
>> >      }
>> >  
>> > +    assert(!(oob && qemu_in_coroutine()));
>> >      assert(monitor_cur() == NULL);
>> > -    monitor_set_cur(qemu_coroutine_self(), cur_mon);
>> > -
>> > -    cmd->fn(args, &ret, &err);
>> > -
>> > -    monitor_set_cur(qemu_coroutine_self(), NULL);
>> > +    if (!!(cmd->options & QCO_COROUTINE) == qemu_in_coroutine()) {
>> > +        monitor_set_cur(qemu_coroutine_self(), cur_mon);
>> > +        cmd->fn(args, &ret, &err);
>> > +        monitor_set_cur(qemu_coroutine_self(), NULL);
>> > +    } else {
>> > +        /*
>> > +         * Not being in coroutine context implies that we're handling
>> > +         * an OOB command, which must not have QCO_COROUTINE.
>> > +         *
>> > +         * This implies that we are in coroutine context, but the
>> > +         * command doesn't have QCO_COROUTINE. We must drop out of
>> > +         * coroutine context for this one.
>> > +         */
>> 
>> I had to read this several times to get it.  The first sentence leads me
>> into coroutine context, and then the next sentence tells me the
>> opposite, throwing me into confusion.
>> 
>> Perhaps something like this:
>> 
>>            /*
>>             * Actual context doesn't match the one the command needs.
>>             * Case 1: we are in coroutine context, but command does not
>>             * have QCO_COROUTINE.  We need to drop out of coroutine
>>             * context for executing it.
>>             * Case 2: we are outside coroutine context, but command has
>>             * QCO_COROUTINE.  Can't actually happen, because we get here
>>             * outside coroutine context only when executing a command
>>             * out of band, and OOB commands never have QCO_COROUTINE.
>>             */
>
> Works for me. Can you squash this in while applying?

Sure!


