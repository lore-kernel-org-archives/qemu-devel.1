Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF0C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E87A20661
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2YSPvW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E87A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqxFw-0005F2-QS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iqxFH-0004ny-RM
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iqxFF-00014v-GC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:46:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iqxFF-00013O-0K
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578912411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucOMsypwDg5H3XYYfZIDXqal+gTOGJv14zU4zenaHgo=;
 b=J2YSPvW4av9+8IQRKF8UKzalrbyBYv9TbWoHyb3pI41byYoqjkogDYCzL6d8k64mo0MjKQ
 0Sc3pw69w0H6VMb6XMfermGJ19b5CKFr3xCdk8N8eWkXJ8oa0Bml0son0nwNhFx2i8cC9+
 Og3sXdMn+4cH64hVFJ2RWLEL6quD31I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-wb_fZN1GMuyKNHp6yNk17A-1; Mon, 13 Jan 2020 05:46:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846FA107ACE8;
 Mon, 13 Jan 2020 10:46:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EB7819C6A;
 Mon, 13 Jan 2020 10:46:46 +0000 (UTC)
Date: Mon, 13 Jan 2020 11:46:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200113104644.GD5549@linux.fritz.box>
References: <20200109183545.27452-1-kwolf@redhat.com>
 <20200109183545.27452-2-kwolf@redhat.com>
 <947485af-1862-2834-7a0f-f8db811268d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <947485af-1862-2834-7a0f-f8db811268d5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wb_fZN1GMuyKNHp6yNk17A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.01.2020 um 20:00 hat Eric Blake geschrieben:
> On 1/9/20 12:35 PM, Kevin Wolf wrote:
> > This patch adds a new 'coroutine' flag to QMP command definitions that
> > tells the QMP dispatcher than the command handler is safe to be run in =
a
>=20
> s/than/that/

Thanks. If this remains the only change, I hope Markus can fix it while
applying the patch.

> > coroutine.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qapi-schema/qapi-schema-test.json |  1 +
> >   docs/devel/qapi-code-gen.txt            |  4 ++++
> >   include/qapi/qmp/dispatch.h             |  1 +
> >   tests/test-qmp-cmds.c                   |  4 ++++
> >   scripts/qapi/commands.py                | 17 +++++++++++------
> >   scripts/qapi/doc.py                     |  2 +-
> >   scripts/qapi/expr.py                    |  4 ++--
> >   scripts/qapi/introspect.py              |  2 +-
> >   scripts/qapi/schema.py                  |  9 ++++++---
> >   tests/qapi-schema/qapi-schema-test.out  |  2 ++
> >   tests/qapi-schema/test-qapi.py          |  7 ++++---
> >   11 files changed, 37 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 9abf175fe0..55f596dbaa 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -147,6 +147,7 @@
> >     'returns': 'UserDefTwo' }
> >   { 'command': 'cmd-success-response', 'data': {}, 'success-response': =
false }
> > +{ 'command': 'coroutine_cmd', 'data': {}, 'coroutine': true }
>=20
> Not user-visible (it's the testsuite), but why not follow our naming
> convention of 'coroutine-cmd'?

I just copied and modified the simplest example from a few lines above:

    { 'command': 'user_def_cmd', 'data': {} }

The command names in the test schema seem to follow no particular style,
there are even some CamelCaseCommands. But if I have to respin, I can
change it.

> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -457,6 +457,7 @@ Syntax:
> >                   '*gen': false,
> >                   '*allow-oob': true,
> >                   '*allow-preconfig': true,
> > +                '*coroutine': true,
> >                   '*if': COND,
> >                   '*features': FEATURES }
> > @@ -581,6 +582,9 @@ before the machine is built.  It defaults to false.=
  For example:
> >   QMP is available before the machine is built only when QEMU was
> >   started with --preconfig.
> > +Member 'coroutine' tells the QMP dispatcher whether the command handle=
r
> > +is safe to be run in a coroutine. It defaults to false.
> > +
> >   The optional 'if' member specifies a conditional.  See "Configuring
>=20
> Maybe "The optional 'coroutine' member tells..." for symmetry with the ne=
xt
> paragraph.

Starting with 'Member ...' seems to be what is done for most other
options. I phrased it this way specifically for consistency.

> > +++ b/scripts/qapi/commands.py
> > @@ -15,6 +15,7 @@ See the COPYING file in the top-level directory.
> >   from qapi.common import *
> >   from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifconte=
xt
> > +from typing import List
> >   def gen_command_decl(name, arg_type, boxed, ret_type):
> > @@ -194,8 +195,9 @@ out:
> >       return ret
> > -def gen_register_command(name, success_response, allow_oob, allow_prec=
onfig):
> > -    options =3D []
> > +def gen_register_command(name: str, success_response: bool, allow_oob:=
 bool,
> > +                         allow_preconfig: bool, coroutine: bool) -> st=
r:
> > +    options =3D [] # type: List[str]
>=20
> Aha - now that we require python 3, you're going to exploit it ;)

Of course. :-)

I was hoping that I could get the type checker to tell me if I forgot to
change one of the callers, but that doesn't really work until we add
type annotations to the callers as well. I'm going to send a separate
series to do a little more about type checking.

> > +++ b/scripts/qapi/introspect.py
> > @@ -212,7 +212,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
> >       def visit_command(self, name, info, ifcond, arg_type, ret_type, g=
en,
> >                         success_response, boxed, allow_oob, allow_preco=
nfig,
> > -                      features):
> > +                      coroutine, features):
> >           arg_type =3D arg_type or self._schema.the_empty_object_type
> >           ret_type =3D ret_type or self._schema.the_empty_object_type
> >           obj =3D {'arg-type': self._use_type(arg_type),
>=20
> I'm assuming the new flag is internal only, and doesn't affect behavior s=
een
> by the user, and thus nothing to change in the introspection output.

Yes. The result would hopefully be visible to the user (the guest
doesn't hang any more where it used to hang), but that's just a bug fix
and nothing that would require a change in the way a client uses QMP.

Kevin


