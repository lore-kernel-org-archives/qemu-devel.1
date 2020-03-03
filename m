Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E6AC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905532083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsDLKPcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905532083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95vN-0004qe-R4
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j95uf-0004IO-B6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j95ud-0007oH-Tr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:40:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j95ud-0007nz-PD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583235635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS6CxKbzGsSgZasokz8UQiYNK7AZ+8nxe2CrxIXEyRM=;
 b=PsDLKPcXIzVdku6XIiGV/gx2IN6WPAewCTC1XaXDA1ZKmkSlTQ6Wb2MQ4gqzz4qijVYuDe
 +fhZOJMYZJIJ0ZkmPf49g+Gy0yFPZI+pQb8WfLYLRkzpu4s8E1fkU9FQQWmjOBmlBrbh5A
 8xlMjVO6qLRjJ/Kkl+IyS9i4Br+0kVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-GMIMMTtSM_61vbaI9ex0Mw-1; Tue, 03 Mar 2020 06:40:34 -0500
X-MC-Unique: GMIMMTtSM_61vbaI9ex0Mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E77901937FC1;
 Tue,  3 Mar 2020 11:40:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-229.ams2.redhat.com [10.36.117.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E71B98D579;
 Tue,  3 Mar 2020 11:40:31 +0000 (UTC)
Date: Tue, 3 Mar 2020 12:40:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200303114030.GC5733@linux.fritz.box>
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-2-kwolf@redhat.com>
 <87tv35dfjh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tv35dfjh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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

Am 03.03.2020 um 09:10 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This patch adds a new 'coroutine' flag to QMP command definitions that
> > tells the QMP dispatcher that the command handler is safe to be run in =
a
> > coroutine.
> >
> > The documentation of the new flag pretends that this flag is already
> > used as intended, which it isn't yet after this patch. We'll implement
> > this in another patch in this series.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt            | 11 +++++++++++
> >  include/qapi/qmp/dispatch.h             |  1 +
> >  tests/test-qmp-cmds.c                   |  4 ++++
> >  scripts/qapi/commands.py                | 10 +++++++---
> >  scripts/qapi/doc.py                     |  2 +-
> >  scripts/qapi/expr.py                    | 10 ++++++++--
> >  scripts/qapi/introspect.py              |  2 +-
> >  scripts/qapi/schema.py                  |  9 ++++++---
> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
> >  tests/Makefile.include                  |  1 +
> >  tests/qapi-schema/oob-coroutine.err     |  2 ++
> >  tests/qapi-schema/oob-coroutine.json    |  2 ++
> >  tests/qapi-schema/oob-coroutine.out     |  0
> >  tests/qapi-schema/qapi-schema-test.json |  1 +
> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
> >  15 files changed, 51 insertions(+), 13 deletions(-)
> >  create mode 100644 tests/qapi-schema/oob-coroutine.err
> >  create mode 100644 tests/qapi-schema/oob-coroutine.json
> >  create mode 100644 tests/qapi-schema/oob-coroutine.out
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> > index 59d6973e1e..df01bd852b 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -457,6 +457,7 @@ Syntax:
> >                  '*gen': false,
> >                  '*allow-oob': true,
> >                  '*allow-preconfig': true,
> > +                '*coroutine': true,
> >                  '*if': COND,
> >                  '*features': FEATURES }
> > =20
> > @@ -581,6 +582,16 @@ before the machine is built.  It defaults to false=
.  For example:
> >  QMP is available before the machine is built only when QEMU was
> >  started with --preconfig.
> > =20
> > +Member 'coroutine' tells the QMP dispatcher whether the command handle=
r
> > +is safe to be run in a coroutine.  It defaults to false.  If it is tru=
e,
> > +the command handler is called from coroutine context and may yield whi=
le
> > +waiting for an external event (such as I/O completion) in order to avo=
id
> > +blocking the guest and other background operations.
> > +
> > +It is an error to specify both 'coroutine': true and 'allow-oob': true
> > +for a command.  (We don't currently have a use case for both together =
and
> > +without a use case, it's not entirely clear what the semantics should =
be.)
>=20
> The parenthesis is new since v4.  I like its contents.  I'm not fond of
> putting complete sentences in parenthesis.  I'll drop them, if you don't
> mind.

You asked this already in the discussion for v4. Yes, I still agree.

> > +
> >  The optional 'if' member specifies a conditional.  See "Configuring
> >  the schema" below for more on this.
> > =20
> [...]
> > diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> > index d7a289eded..95cc006cae 100644
> > --- a/scripts/qapi/expr.py
> > +++ b/scripts/qapi/expr.py
> > @@ -89,10 +89,16 @@ def check_flags(expr, info):
> >          if key in expr and expr[key] is not False:
> >              raise QAPISemError(
> >                  info, "flag '%s' may only use false value" % key)
> > -    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
> > +    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
> >          if key in expr and expr[key] is not True:
> >              raise QAPISemError(
> >                  info, "flag '%s' may only use true value" % key)
> > +    if 'allow-oob' in expr and 'coroutine' in expr:
> > +        # This is not necessarily a fundamental incompatibility, but w=
e don't
> > +        # have a use case and the desired semantics isn't obvious. The=
 simplest
> > +        # solution is to forbid it until we get a use case for it.
>=20
> Appreciated.  I'll word-wrap, if you don't mind.

I still don't agree with comment line width being smaller than code line
width, and think it's in disagreement with CODING_STYLE, but if you
can't help it, adjust the formatting however you like.

> > +        raise QAPISemError(info, "flags 'allow-oob' and 'coroutine' "
> > +                                 "are incompatible")
> > =20
> > =20
> >  def check_if(expr, info, source):
> > @@ -344,7 +350,7 @@ def check_exprs(exprs):
> >                         ['command'],
> >                         ['data', 'returns', 'boxed', 'if', 'features',
> >                          'gen', 'success-response', 'allow-oob',
> > -                        'allow-preconfig'])
> > +                        'allow-preconfig', 'coroutine'])
> >              normalize_members(expr.get('data'))
> >              check_command(expr, info)
> >          elif meta =3D=3D 'event':
> [...]
>=20
> R-by stands.

Kevin


