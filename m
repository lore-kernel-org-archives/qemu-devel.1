Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CDC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8242073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlKfiKp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8242073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMQ4-00036F-5o
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isMOh-0001ld-O0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isMOa-0001h7-Hr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:50:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isMOa-0001fW-D6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579247419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJWel5rZleDlaMI+PLm+4JPYvSlWaiJDJfASWgLM4uY=;
 b=SlKfiKp8RyoZ3ubr5ZCTo6CUpY4yXP596yvr/YzwbElSNi146NZAmMsLgxsznNkrNkFYZr
 dPFn2nP5YO+dOI1J2yMEJNQ2o7FAWUBBelc0JazMiNjsKlVJsH97+fS2zUh61FA1B0FJ6d
 LHxk8xtk+m78PBVf5V8pGWOfilzEFOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-GAYkg0NDOouAu1FlbdYIFQ-1; Fri, 17 Jan 2020 02:50:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCB21800D4F;
 Fri, 17 Jan 2020 07:50:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F9AA5D9CD;
 Fri, 17 Jan 2020 07:50:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B93E41138600; Fri, 17 Jan 2020 08:50:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-2-kwolf@redhat.com>
 <875zhc9360.fsf@dusky.pond.sub.org>
 <20200115155850.GG5505@linux.fritz.box>
 <871rrzy2sg.fsf@dusky.pond.sub.org>
Date: Fri, 17 Jan 2020 08:50:12 +0100
In-Reply-To: <871rrzy2sg.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 16 Jan 2020 14:00:15 +0100")
Message-ID: <87wo9qo72j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GAYkg0NDOouAu1FlbdYIFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 15.01.2020 um 15:59 hat Markus Armbruster geschrieben:
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>=20
>>> > This patch adds a new 'coroutine' flag to QMP command definitions tha=
t
>>> > tells the QMP dispatcher that the command handler is safe to be run i=
n a
>>> > coroutine.
>>> >
>>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> > ---
>>> >  tests/qapi-schema/qapi-schema-test.json |  1 +
>>> >  docs/devel/qapi-code-gen.txt            |  4 ++++
>>> >  include/qapi/qmp/dispatch.h             |  1 +
>>> >  tests/test-qmp-cmds.c                   |  4 ++++
>>> >  scripts/qapi/commands.py                | 17 +++++++++++------
>>> >  scripts/qapi/doc.py                     |  2 +-
>>> >  scripts/qapi/expr.py                    |  4 ++--
>>> >  scripts/qapi/introspect.py              |  2 +-
>>> >  scripts/qapi/schema.py                  |  9 ++++++---
>>> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
>>> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
>>> >  11 files changed, 37 insertions(+), 16 deletions(-)
>>> >
>>> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-sch=
ema/qapi-schema-test.json
>>> > index 9abf175fe0..1a850fe171 100644
>>> > --- a/tests/qapi-schema/qapi-schema-test.json
>>> > +++ b/tests/qapi-schema/qapi-schema-test.json
>>> > @@ -147,6 +147,7 @@
>>> >    'returns': 'UserDefTwo' }
>>> > =20
>>> >  { 'command': 'cmd-success-response', 'data': {}, 'success-response':=
 false }
>>> > +{ 'command': 'coroutine-cmd', 'data': {}, 'coroutine': true }
>>> > =20
>>> >  # Returning a non-dictionary requires a name from the whitelist
>>> >  { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
>>> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.=
txt
>>> > index 45c93a43cc..753f6711d3 100644
>>> > --- a/docs/devel/qapi-code-gen.txt
>>> > +++ b/docs/devel/qapi-code-gen.txt
>>> > @@ -457,6 +457,7 @@ Syntax:
>>> >                  '*gen': false,
>>> >                  '*allow-oob': true,
>>> >                  '*allow-preconfig': true,
>>> > +                '*coroutine': true,
>>> >                  '*if': COND,
>>> >                  '*features': FEATURES }
>>> > =20
>>> > @@ -581,6 +582,9 @@ before the machine is built.  It defaults to fals=
e.  For example:
>>> >  QMP is available before the machine is built only when QEMU was
>>> >  started with --preconfig.
>>> > =20
>>> > +Member 'coroutine' tells the QMP dispatcher whether the command hand=
ler
>>> > +is safe to be run in a coroutine. It defaults to false.
>>>=20
>>> Two spaces after sentence-ending period, for consistency with the rest
>>> of the file.
>>
>> Ok.
>>
>>> As discussed in review of prior versions, coroutine-safety is an
>>> implementation detail that should not be exposed to management
>>> applications.  Therefore, we want a flag, not a feature.
>>>=20
>>> As far as I can tell, the new flag has no effect until PATCH 3 puts it
>>> to use.  That's okay.
>>>=20
>>> The doc update tells us when we may say 'coroutine': true, namely when
>>> the handler function is coroutine-safe.  It doesn't quite tell us what
>>> difference it makes, or rather will make after PATCH 3.  I think it
>>> should.
>>
>> Fair requirement. Can I describe it as if patch 3 were already in? That
>> is, the documentation says that the handler _will_ be run in a coroutine
>> rather than _may_ run it in a coroutine?
>
> Your choice.  If you choose to pretend PATCH 3 was in, have your commit
> message point that out.
>
>>> In review of a prior version, Marc-Andr=C3=A9 wondered whether keeping
>>> allow-oob and coroutine separate makes sense.  Recall qapi-code-gen.txt=
:
>>>=20
>>>     An OOB-capable command handler must satisfy the following condition=
s:
>>>=20
>>>     - It terminates quickly.
>>>     - It does not invoke system calls that may block.
>>>     - It does not access guest RAM that may block when userfaultfd is
>>>       enabled for postcopy live migration.
>>>     - It takes only "fast" locks, i.e. all critical sections protected =
by
>>>       any lock it takes also satisfy the conditions for OOB command
>>>       handler code.
>>>=20
>>>     The restrictions on locking limit access to shared state.  Such acc=
ess
>>>     requires synchronization, but OOB commands can't take the BQL or an=
y
>>>     other "slow" lock.
>>>=20
>>> Kevin, does this rule out coroutine use?
>>
>> Not strictly, though I also can't think of a case where you would want
>> to use a coroutine with these requirements.
>>
>> If I understand correctly, OOB-capable commands can be run either OOB
>> with 'exec-oob' or like normal commands with 'execute'.
>
> Correct.
>
>>                                                         If an OOB
>> handler is marked as coroutine-safe, 'execute' will run it in a
>> coroutine (and the restriction above don't apply) and 'exec-oob' will
>> run it outside of coroutine context.
>
> Let me convince myself you're right.
>
> Cases before this series:
>
> (exec) execute, allow-oob does not matter
>
>     Run in main loop bottom half monitor_qmp_bh_dispatcher(), outside
>     coroutine context, scheduled by handle_qmp_command()
>
> (err1) exec-oob, QMP_CAPABILITY_OOB off, allow-oob does not matter
>
>   Error
>
> (err2) exec-oob, QMP_CAPABILITY_OOB on, allow-oob: false
>
>   Error
>
> (exec-oob) exec-oob, QMP_CAPABILITY_OOB on, allow-oob: true
>
>   Run in iothread / handle_qmp_command(), outside coroutine context
>
> Peeking ahead to PATCH 3...  it split cases (exec):
>
> (exec-co): execute, allow-oob does not matter, coroutine: true
>
>   Run in main loop coroutine qmp_dispatcher_co(), in coroutine context,
>   woken up by handle_qmp_command()
>
> (exec): execute, allow-oob does not matter, coroutine: false
>
>   Run in main loop bottom half do_qmp_dispatch_bh(), outside coroutine
>   context, scheduled by qmp_dispatcher_co()
>
> It appears not to touch case exec-oob.  Thus, coroutine: true has no
> effect when the command is executed with exec-oob.

Looking at PATCH 3 again, I got temporarily confused again.  Let me
spell things out even more, to improve my chances at staying not
confused...

To effect the split of (exec), you rewrite bottom half
monitor_qmp_bh_dispatcher() as coroutine monitor_qmp_dispatcher_co(),
then have do_qmp_dispatch() either call the the handler directly, or
schedule it to run in a bottom half.  Cases:

(exec-co): handle_qmp_command() sends the command to coroutine
monitor_qmp_dispatcher_co(), which calls monitor_qmp_dispatch(), which
runs the handler, in coroutine context, in the main loop.

(exec): Likewise, except monitor_qmp_dispatch() schedules the handler to
run in a bottom half, outside coroutine context, in the main loop.

(exec-oob): handle_qmp_command() runs monitor_qmp_dispatch(), which runs
the handler, outside coroutine context, in the iothread.

> Looks like you're right :)

[...]


