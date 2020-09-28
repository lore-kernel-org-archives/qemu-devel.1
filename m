Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC68C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6872076B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUb83i2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6872076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoT9-0001Uu-W0
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMoRq-0000vC-11
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMoRn-0004Ng-5J
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:23:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601281425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IiaAKfkJEexfWs5Cyv2ArfHco1q/Zx87vU19f8D4s0=;
 b=QUb83i2phdliH6Wd9AzIe5v2m3qSImWfIE5cZqnM4qR646FKNHhPjS9mDBwQ5uB44vcX5R
 0F28D36aFtK8+IvJ4kOKiN+Utcg2h+9Ux3UFM+iiPjWEl2F8Ko9BKDFFqZJAav/UOJ4kMP
 xVVQMFtohQCR/ubBqXShl2+xjnJg6Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-EbcCgGkkM6aZOPNF56Lw3w-1; Mon, 28 Sep 2020 04:23:39 -0400
X-MC-Unique: EbcCgGkkM6aZOPNF56Lw3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A01802B61;
 Mon, 28 Sep 2020 08:23:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E84A05C1BB;
 Mon, 28 Sep 2020 08:23:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F248113865F; Mon, 28 Sep 2020 10:23:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 08/13] qapi: Add a 'coroutine' flag for commands
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-9-kwolf@redhat.com>
 <87r1r4mlt5.fsf@dusky.pond.sub.org>
 <20200925153707.GG5731@linux.fritz.box>
Date: Mon, 28 Sep 2020 10:23:33 +0200
In-Reply-To: <20200925153707.GG5731@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 25 Sep 2020 17:37:07 +0200")
Message-ID: <87lfgul37e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.09.2020 um 17:15 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > This patch adds a new 'coroutine' flag to QMP command definitions that
>> > tells the QMP dispatcher that the command handler is safe to be run in=
 a
>> > coroutine.
>> >
>> > The documentation of the new flag pretends that this flag is already
>> > used as intended, which it isn't yet after this patch. We'll implement
>> > this in another patch in this series.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=83=C6=92=C3=82=C2=A9 Lureau <marcandre.lurea=
u@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.txt            | 12 ++++++++++++
>> >  include/qapi/qmp/dispatch.h             |  1 +
>> >  tests/test-qmp-cmds.c                   |  4 ++++
>> >  scripts/qapi/commands.py                | 10 +++++++---
>> >  scripts/qapi/doc.py                     |  2 +-
>> >  scripts/qapi/expr.py                    | 10 ++++++++--
>> >  scripts/qapi/introspect.py              |  2 +-
>> >  scripts/qapi/schema.py                  | 12 ++++++++----
>> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
>> >  tests/qapi-schema/meson.build           |  1 +
>> >  tests/qapi-schema/oob-coroutine.err     |  2 ++
>> >  tests/qapi-schema/oob-coroutine.json    |  2 ++
>> >  tests/qapi-schema/oob-coroutine.out     |  0
>> >  tests/qapi-schema/qapi-schema-test.json |  1 +
>> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
>> >  15 files changed, 54 insertions(+), 14 deletions(-)
>> >  create mode 100644 tests/qapi-schema/oob-coroutine.err
>> >  create mode 100644 tests/qapi-schema/oob-coroutine.json
>> >  create mode 100644 tests/qapi-schema/oob-coroutine.out
>> >
>> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.t=
xt
>> > index f3e7ced212..36daa9b5f8 100644
>> > --- a/docs/devel/qapi-code-gen.txt
>> > +++ b/docs/devel/qapi-code-gen.txt
>> > @@ -472,6 +472,7 @@ Syntax:
>> >                  '*gen': false,
>> >                  '*allow-oob': true,
>> >                  '*allow-preconfig': true,
>> > +                '*coroutine': true,
>> >                  '*if': COND,
>> >                  '*features': FEATURES }
>> > =20
>> > @@ -596,6 +597,17 @@ before the machine is built.  It defaults to fals=
e.  For example:
>> >  QMP is available before the machine is built only when QEMU was
>> >  started with --preconfig.
>> > =20
>> > +Member 'coroutine' tells the QMP dispatcher whether the command handl=
er
>> > +is safe to be run in a coroutine.
>>=20
>> We need to document what exactly makes a command handler coroutine safe
>> / unsafe.  We discussed this at some length in review of PATCH v4 1/4:
>>=20
>>     Message-ID: <874kwnvgad.fsf@dusky.pond.sub.org>
>>     https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg05015.ht=
ml
>>=20
>> I'd be willing to accept a follow-up patch, if that's more convenient
>> for you.
>
> Did we ever arrive at a conclusion for a good definition?
>
> I mean I can give a definition like "it's coroutine safe if it results
> in the right behaviour even when called in coroutine context", but
> that's not really helpful.

If an actual definition is out of reach, we should still say
*something*.  Even a mere "it's complicated" would help, because it
warns the reader he's on thin ice.

Can we give examples for "unsafe"?  You mentioned nested event loops.

> FWIW, I would also have a hard time giving a much better definition than
> this for thread safety.

For what it's worth, here's how POSIX.1-2017 defined "thread-safe":

    A thread-safe function can be safely invoked concurrently with other
    calls to the same function, or with calls to any other thread-safe
    functions, by multiple threads.  Each function defined in the System
    Interfaces volume of POSIX.1-2017 is thread-safe unless explicitly
    stated otherwise.  Examples are any "pure" function, a function
    which holds a mutex locked while it is accessing static storage, or
    objects shared among threads.

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#ta=
g_03_407

>> >                                     It defaults to false.  If it is tr=
ue,
>> > +the command handler is called from coroutine context and may yield wh=
ile
>>=20
>> Is it *always* called from coroutine context, or could it be called
>> outside coroutine context, too?  I guess the former, thanks to PATCH 10,
>> and as long as we diligently mark HMP commands that such call QMP
>> handlers, like you do in PATCH 13.
>
> Yes, it must *always* be called from coroutine context. This is the
> reason why I included HMP after all, even though I'm really mostly just
> interested in QMP.
>
>> What's the worst than can happen when we neglect to mark such an HMP
>> command?
>
> When the command handler tries to yield and it's not in coroutine
> context, it will abort(). If it never tries to yield, I think it would
> just work - but of course, the ability to yield is the only reason why
> you would want to run a command handler in a coroutine.

Let's spell this out.  After your paragraph

    Member 'coroutine' tells the QMP dispatcher whether the command handler
    is safe to be run in a coroutine.  It defaults to false.  If it is true=
,
    the command handler is called from coroutine context and may yield whil=
e
    waiting for an external event (such as I/O completion) in order to avoi=
d
    blocking the guest and other background operations.

add something like

    Since the command handler may assume coroutine-context, any callers
    other than the QMP dispatcher must also call it in coroutine
    context.  In particular, HMP commands calling such a QMP command
    handler must be marked .coroutine =3D true in hmp-commands.hx.

Patch ordering issue: this becomes possible only in PATCH 10.
Possible solutions:

* Add the last sentence only in PATCH 10.

* Write "HMP commands cannot call such a QMP command handler" in PATCH
  8, replace it in PATCH 10.

* Add a "TODO make that possible" line here, drop it in PATCH 10.

* Reorder patches.

I don't like the first one much.  Anyway, up to you.


