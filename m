Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0705DC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F252081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr13HCk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F252081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlmc-0005T2-OI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irl4U-0003kJ-KE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irl4P-0008IW-2Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:59:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irl4O-0008ID-UB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579103940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5B2FOk5JbfZww1pkRhtaI1Pzqe2jy5gvmcLFwVqugbI=;
 b=fr13HCk15/VBaVW1jSvrkYT2T2gzR/qO9ANgyntXYQAoNH7oac07WnZ9Ve9fmBZSOFlYvc
 SQcWIqalornYNvkNKf9lz34D6Y4/BOHmTHnB+TkeiA+DUFUDyiOPDK+ZgbIAaDG7IJ2s9i
 8pbvWCcAjwfTmwbkAwL/LaRIHJTbRTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-kaHkRLA_MHOauUTzvRYgeg-1; Wed, 15 Jan 2020 10:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FCC118AA256;
 Wed, 15 Jan 2020 15:58:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5265119757;
 Wed, 15 Jan 2020 15:58:52 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:58:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200115155850.GG5505@linux.fritz.box>
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-2-kwolf@redhat.com>
 <875zhc9360.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <875zhc9360.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kaHkRLA_MHOauUTzvRYgeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.01.2020 um 15:59 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This patch adds a new 'coroutine' flag to QMP command definitions that
> > tells the QMP dispatcher that the command handler is safe to be run in =
a
> > coroutine.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/qapi-schema/qapi-schema-test.json |  1 +
> >  docs/devel/qapi-code-gen.txt            |  4 ++++
> >  include/qapi/qmp/dispatch.h             |  1 +
> >  tests/test-qmp-cmds.c                   |  4 ++++
> >  scripts/qapi/commands.py                | 17 +++++++++++------
> >  scripts/qapi/doc.py                     |  2 +-
> >  scripts/qapi/expr.py                    |  4 ++--
> >  scripts/qapi/introspect.py              |  2 +-
> >  scripts/qapi/schema.py                  |  9 ++++++---
> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
> >  11 files changed, 37 insertions(+), 16 deletions(-)
> >
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 9abf175fe0..1a850fe171 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -147,6 +147,7 @@
> >    'returns': 'UserDefTwo' }
> > =20
> >  { 'command': 'cmd-success-response', 'data': {}, 'success-response': f=
alse }
> > +{ 'command': 'coroutine-cmd', 'data': {}, 'coroutine': true }
> > =20
> >  # Returning a non-dictionary requires a name from the whitelist
> >  { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> > index 45c93a43cc..753f6711d3 100644
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
> > @@ -581,6 +582,9 @@ before the machine is built.  It defaults to false.=
  For example:
> >  QMP is available before the machine is built only when QEMU was
> >  started with --preconfig.
> > =20
> > +Member 'coroutine' tells the QMP dispatcher whether the command handle=
r
> > +is safe to be run in a coroutine. It defaults to false.
>=20
> Two spaces after sentence-ending period, for consistency with the rest
> of the file.

Ok.

> As discussed in review of prior versions, coroutine-safety is an
> implementation detail that should not be exposed to management
> applications.  Therefore, we want a flag, not a feature.
>=20
> As far as I can tell, the new flag has no effect until PATCH 3 puts it
> to use.  That's okay.
>=20
> The doc update tells us when we may say 'coroutine': true, namely when
> the handler function is coroutine-safe.  It doesn't quite tell us what
> difference it makes, or rather will make after PATCH 3.  I think it
> should.

Fair requirement. Can I describe it as if patch 3 were already in? That
is, the documentation says that the handler _will_ be run in a coroutine
rather than _may_ run it in a coroutine?

> In review of a prior version, Marc-Andr=E9 wondered whether keeping
> allow-oob and coroutine separate makes sense.  Recall qapi-code-gen.txt:
>=20
>     An OOB-capable command handler must satisfy the following conditions:
>=20
>     - It terminates quickly.
>     - It does not invoke system calls that may block.
>     - It does not access guest RAM that may block when userfaultfd is
>       enabled for postcopy live migration.
>     - It takes only "fast" locks, i.e. all critical sections protected by
>       any lock it takes also satisfy the conditions for OOB command
>       handler code.
>=20
>     The restrictions on locking limit access to shared state.  Such acces=
s
>     requires synchronization, but OOB commands can't take the BQL or any
>     other "slow" lock.
>=20
> Kevin, does this rule out coroutine use?

Not strictly, though I also can't think of a case where you would want
to use a coroutine with these requirements.

If I understand correctly, OOB-capable commands can be run either OOB
with 'exec-oob' or like normal commands with 'execute'. If an OOB
handler is marked as coroutine-safe, 'execute' will run it in a
coroutine (and the restriction above don't apply) and 'exec-oob' will
run it outside of coroutine context.

I have no idea if we will eventually get a case where the command wants
to behave different between the two modes and actually has use for a
coroutine. I hope not.

But using two bools rather than a single enum keeps the code simple and
leaves us all options open if it turns out that we do have a use case.

> > +
> >  The optional 'if' member specifies a conditional.  See "Configuring
> >  the schema" below for more on this.
> > =20
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index 9aa426a398..d6ce9efc8e 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -24,6 +24,7 @@ typedef enum QmpCommandOptions
> >      QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
> >      QCO_ALLOW_OOB             =3D  (1U << 1),
> >      QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
> > +    QCO_COROUTINE             =3D  (1U << 3),
> >  } QmpCommandOptions;
> > =20
> >  typedef struct QmpCommand
> > diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> > index 27b0afe55a..e2f71e42a1 100644
> > --- a/tests/test-qmp-cmds.c
> > +++ b/tests/test-qmp-cmds.c
> > @@ -34,6 +34,10 @@ void qmp_cmd_success_response(Error **errp)
> >  {
> >  }
> > =20
> > +void qmp_coroutine_cmd(Error **errp)
> > +{
> > +}
> > +
> >  Empty2 *qmp_user_def_cmd0(Error **errp)
> >  {
> >      return g_new0(Empty2, 1);
> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> > index ab98e504f3..97e51401f1 100644
> > --- a/scripts/qapi/commands.py
> > +++ b/scripts/qapi/commands.py
> > @@ -15,6 +15,7 @@ See the COPYING file in the top-level directory.
> > =20
> >  from qapi.common import *
> >  from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontex=
t
> > +from typing import List
> > =20
> > =20
> >  def gen_command_decl(name, arg_type, boxed, ret_type):
> > @@ -194,8 +195,9 @@ out:
> >      return ret
> > =20
> > =20
> > -def gen_register_command(name, success_response, allow_oob, allow_prec=
onfig):
> > -    options =3D []
> > +def gen_register_command(name: str, success_response: bool, allow_oob:=
 bool,
> > +                         allow_preconfig: bool, coroutine: bool) -> st=
r:
> > +    options =3D [] # type: List[str]
>=20
> Not sure such isolated type hints make sense.  I'd welcome patches to
> explore systematic use of type hints.  Suggest to start with just one
> module, so we can gauge effort and benefit before we jump in whole hog.

Any documentation is better than no documentation, imho.

If you insist, I'll remove the type hints, but finding the origin of
values passed as parameters to find out what type they are is a very
common activity for me when touching the QAPI code. Doing that every
time from scratch is not a good use of my time.

> > =20
> >      if not success_response:
> >          options +=3D ['QCO_NO_SUCCESS_RESP']
> > @@ -203,18 +205,20 @@ def gen_register_command(name, success_response, =
allow_oob, allow_preconfig):
> >          options +=3D ['QCO_ALLOW_OOB']
> >      if allow_preconfig:
> >          options +=3D ['QCO_ALLOW_PRECONFIG']
> > +    if coroutine:
> > +        options +=3D ['QCO_COROUTINE']
> > =20
> >      if not options:
> >          options =3D ['QCO_NO_OPTIONS']
> > =20
> > -    options =3D " | ".join(options)
> > +    options_str =3D " | ".join(options)
> > =20
> >      ret =3D mcgen('''
> >      qmp_register_command(cmds, "%(name)s",
> >                           qmp_marshal_%(c_name)s, %(opts)s);
> >  ''',
> >                  name=3Dname, c_name=3Dc_name(name),
> > -                opts=3Doptions)
> > +                opts=3Doptions_str)
> >      return ret
> > =20
> > =20
>=20
> Some extra churn due to type hints here.  Distracting.  Suggest not to
> mix adding type hints to existing code with feature work.

If you would be open for a compromise, I could leave options
unannotated, but keep the typed parameter list.

Kevin


