Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0891C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB7F20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoWM/+WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB7F20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4mg-0006ui-OL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1is4lW-0006Om-3M
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1is4lP-00049r-Ct
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:00:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1is4lP-00049A-2g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579179641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXWlouky4ORxByPAUWqE6mCWeloi7kmcDshrdpZDC1I=;
 b=YoWM/+WKw2Fg9dvMV9dzTpaS9RRaQ+gisv/wsvHW5CYqjLEaVWK8C21UBoLa/GzWEImDPD
 blasDgXKqLGfMR6/S293wx5OLrbL921YgSIK8vCc4BtaMLiB6JNZeaQrgvLZnHoSyXVg3y
 uKGrUlSHQCqt92Q/MFnr2Zi4KgU56Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-CR7QKMPBPrqX8jAZjK_cpQ-1; Thu, 16 Jan 2020 08:00:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F872800EBF;
 Thu, 16 Jan 2020 13:00:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E038120C;
 Thu, 16 Jan 2020 13:00:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F1671138600; Thu, 16 Jan 2020 14:00:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-2-kwolf@redhat.com>
 <875zhc9360.fsf@dusky.pond.sub.org>
 <20200115155850.GG5505@linux.fritz.box>
Date: Thu, 16 Jan 2020 14:00:15 +0100
In-Reply-To: <20200115155850.GG5505@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 15 Jan 2020 16:58:50 +0100")
Message-ID: <871rrzy2sg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CR7QKMPBPrqX8jAZjK_cpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.01.2020 um 15:59 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > This patch adds a new 'coroutine' flag to QMP command definitions that
>> > tells the QMP dispatcher that the command handler is safe to be run in=
 a
>> > coroutine.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/qapi-schema/qapi-schema-test.json |  1 +
>> >  docs/devel/qapi-code-gen.txt            |  4 ++++
>> >  include/qapi/qmp/dispatch.h             |  1 +
>> >  tests/test-qmp-cmds.c                   |  4 ++++
>> >  scripts/qapi/commands.py                | 17 +++++++++++------
>> >  scripts/qapi/doc.py                     |  2 +-
>> >  scripts/qapi/expr.py                    |  4 ++--
>> >  scripts/qapi/introspect.py              |  2 +-
>> >  scripts/qapi/schema.py                  |  9 ++++++---
>> >  tests/qapi-schema/qapi-schema-test.out  |  2 ++
>> >  tests/qapi-schema/test-qapi.py          |  7 ++++---
>> >  11 files changed, 37 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-sche=
ma/qapi-schema-test.json
>> > index 9abf175fe0..1a850fe171 100644
>> > --- a/tests/qapi-schema/qapi-schema-test.json
>> > +++ b/tests/qapi-schema/qapi-schema-test.json
>> > @@ -147,6 +147,7 @@
>> >    'returns': 'UserDefTwo' }
>> > =20
>> >  { 'command': 'cmd-success-response', 'data': {}, 'success-response': =
false }
>> > +{ 'command': 'coroutine-cmd', 'data': {}, 'coroutine': true }
>> > =20
>> >  # Returning a non-dictionary requires a name from the whitelist
>> >  { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
>> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.t=
xt
>> > index 45c93a43cc..753f6711d3 100644
>> > --- a/docs/devel/qapi-code-gen.txt
>> > +++ b/docs/devel/qapi-code-gen.txt
>> > @@ -457,6 +457,7 @@ Syntax:
>> >                  '*gen': false,
>> >                  '*allow-oob': true,
>> >                  '*allow-preconfig': true,
>> > +                '*coroutine': true,
>> >                  '*if': COND,
>> >                  '*features': FEATURES }
>> > =20
>> > @@ -581,6 +582,9 @@ before the machine is built.  It defaults to false=
.  For example:
>> >  QMP is available before the machine is built only when QEMU was
>> >  started with --preconfig.
>> > =20
>> > +Member 'coroutine' tells the QMP dispatcher whether the command handl=
er
>> > +is safe to be run in a coroutine. It defaults to false.
>>=20
>> Two spaces after sentence-ending period, for consistency with the rest
>> of the file.
>
> Ok.
>
>> As discussed in review of prior versions, coroutine-safety is an
>> implementation detail that should not be exposed to management
>> applications.  Therefore, we want a flag, not a feature.
>>=20
>> As far as I can tell, the new flag has no effect until PATCH 3 puts it
>> to use.  That's okay.
>>=20
>> The doc update tells us when we may say 'coroutine': true, namely when
>> the handler function is coroutine-safe.  It doesn't quite tell us what
>> difference it makes, or rather will make after PATCH 3.  I think it
>> should.
>
> Fair requirement. Can I describe it as if patch 3 were already in? That
> is, the documentation says that the handler _will_ be run in a coroutine
> rather than _may_ run it in a coroutine?

Your choice.  If you choose to pretend PATCH 3 was in, have your commit
message point that out.

>> In review of a prior version, Marc-Andr=C3=A9 wondered whether keeping
>> allow-oob and coroutine separate makes sense.  Recall qapi-code-gen.txt:
>>=20
>>     An OOB-capable command handler must satisfy the following conditions=
:
>>=20
>>     - It terminates quickly.
>>     - It does not invoke system calls that may block.
>>     - It does not access guest RAM that may block when userfaultfd is
>>       enabled for postcopy live migration.
>>     - It takes only "fast" locks, i.e. all critical sections protected b=
y
>>       any lock it takes also satisfy the conditions for OOB command
>>       handler code.
>>=20
>>     The restrictions on locking limit access to shared state.  Such acce=
ss
>>     requires synchronization, but OOB commands can't take the BQL or any
>>     other "slow" lock.
>>=20
>> Kevin, does this rule out coroutine use?
>
> Not strictly, though I also can't think of a case where you would want
> to use a coroutine with these requirements.
>
> If I understand correctly, OOB-capable commands can be run either OOB
> with 'exec-oob' or like normal commands with 'execute'.

Correct.

>                                                         If an OOB
> handler is marked as coroutine-safe, 'execute' will run it in a
> coroutine (and the restriction above don't apply) and 'exec-oob' will
> run it outside of coroutine context.

Let me convince myself you're right.

Cases before this series:

(exec) execute, allow-oob does not matter

    Run in main loop bottom half monitor_qmp_bh_dispatcher(), outside
    coroutine context, scheduled by handle_qmp_command()

(err1) exec-oob, QMP_CAPABILITY_OOB off, allow-oob does not matter

  Error

(err2) exec-oob, QMP_CAPABILITY_OOB on, allow-oob: false

  Error

(exec-oob) exec-oob, QMP_CAPABILITY_OOB on, allow-oob: true

  Run in iothread / handle_qmp_command(), outside coroutine context

Peeking ahead to PATCH 3...  it split cases (exec):

(exec-co): execute, allow-oob does not matter, coroutine: true

  Run in main loop coroutine qmp_dispatcher_co(), in coroutine context,
  woken up by handle_qmp_command()

(exec): execute, allow-oob does not matter, coroutine: false

  Run in main loop bottom half do_qmp_dispatch_bh(), outside coroutine
  context, scheduled by qmp_dispatcher_co()

It appears not to touch case exec-oob.  Thus, coroutine: true has no
effect when the command is executed with exec-oob.

Looks like you're right :)

> I have no idea if we will eventually get a case where the command wants
> to behave different between the two modes and actually has use for a
> coroutine. I hope not.
>
> But using two bools rather than a single enum keeps the code simple and
> leaves us all options open if it turns out that we do have a use case.

I can buy the argument "the two are conceptually orthogonal, although we
don't haven't found a use for one of the four cases".

Let's review the four combinations of the two flags once more:

* allow-oob: false, coroutine: false

  Handler runs in main loop, outside coroutine context.  Okay.

* allow-oob: false, coroutine: true

  Handler runs in main loop, in coroutine context.  Okay.

* allow-oob: true, coroutine: false

  Handler may run in main loop or in iothread, outside coroutine
  context.  Okay.

* allow-oob: true, coroutine: true

  Handler may run (in main loop, in coroutine context) or (in iothread,
  outside coroutine context).  This "in coroutine context only with
  execute, not with exec-oob" behavior is a bit surprising.

  We could document it, noting that it may change to always run in
  coroutine context.  Or we simply reject this case as "not
  implemented".  Since we have no uses, I'm leaning towards reject.  One
  fewer case to test then.

>> > +
>> >  The optional 'if' member specifies a conditional.  See "Configuring
>> >  the schema" below for more on this.
>> > =20
>> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
>> > index 9aa426a398..d6ce9efc8e 100644
>> > --- a/include/qapi/qmp/dispatch.h
>> > +++ b/include/qapi/qmp/dispatch.h
>> > @@ -24,6 +24,7 @@ typedef enum QmpCommandOptions
>> >      QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
>> >      QCO_ALLOW_OOB             =3D  (1U << 1),
>> >      QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
>> > +    QCO_COROUTINE             =3D  (1U << 3),
>> >  } QmpCommandOptions;
>> > =20
>> >  typedef struct QmpCommand
>> > diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
>> > index 27b0afe55a..e2f71e42a1 100644
>> > --- a/tests/test-qmp-cmds.c
>> > +++ b/tests/test-qmp-cmds.c
>> > @@ -34,6 +34,10 @@ void qmp_cmd_success_response(Error **errp)
>> >  {
>> >  }
>> > =20
>> > +void qmp_coroutine_cmd(Error **errp)
>> > +{
>> > +}
>> > +
>> >  Empty2 *qmp_user_def_cmd0(Error **errp)
>> >  {
>> >      return g_new0(Empty2, 1);
>> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> > index ab98e504f3..97e51401f1 100644
>> > --- a/scripts/qapi/commands.py
>> > +++ b/scripts/qapi/commands.py
>> > @@ -15,6 +15,7 @@ See the COPYING file in the top-level directory.
>> > =20
>> >  from qapi.common import *
>> >  from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifconte=
xt
>> > +from typing import List
>> > =20
>> > =20
>> >  def gen_command_decl(name, arg_type, boxed, ret_type):
>> > @@ -194,8 +195,9 @@ out:
>> >      return ret
>> > =20
>> > =20
>> > -def gen_register_command(name, success_response, allow_oob, allow_pre=
config):
>> > -    options =3D []
>> > +def gen_register_command(name: str, success_response: bool, allow_oob=
: bool,
>> > +                         allow_preconfig: bool, coroutine: bool) -> s=
tr:
>> > +    options =3D [] # type: List[str]

One more: this is a PEP 484 type hint.  With Python 3, we can use PEP
526 instead:

          options: List[str] =3D []

I think we should.

>>=20
>> Not sure such isolated type hints make sense.  I'd welcome patches to
>> explore systematic use of type hints.  Suggest to start with just one
>> module, so we can gauge effort and benefit before we jump in whole hog.
>
> Any documentation is better than no documentation, imho.

Inconsistent or grossly incomplete documentation can be worse than no
documentation.

> If you insist, I'll remove the type hints, but finding the origin of
> values passed as parameters to find out what type they are is a very
> common activity for me when touching the QAPI code. Doing that every
> time from scratch is not a good use of my time.

Understand, and I therefore support the idea of exploring use of type
hints.  I'd rather not mix it up with other work, though.

>> > =20
>> >      if not success_response:
>> >          options +=3D ['QCO_NO_SUCCESS_RESP']
>> > @@ -203,18 +205,20 @@ def gen_register_command(name, success_response,=
 allow_oob, allow_preconfig):
>> >          options +=3D ['QCO_ALLOW_OOB']
>> >      if allow_preconfig:
>> >          options +=3D ['QCO_ALLOW_PRECONFIG']
>> > +    if coroutine:
>> > +        options +=3D ['QCO_COROUTINE']
>> > =20
>> >      if not options:
>> >          options =3D ['QCO_NO_OPTIONS']
>> > =20
>> > -    options =3D " | ".join(options)
>> > +    options_str =3D " | ".join(options)
>> > =20
>> >      ret =3D mcgen('''
>> >      qmp_register_command(cmds, "%(name)s",
>> >                           qmp_marshal_%(c_name)s, %(opts)s);
>> >  ''',
>> >                  name=3Dname, c_name=3Dc_name(name),
>> > -                opts=3Doptions)
>> > +                opts=3Doptions_str)
>> >      return ret
>> > =20
>> > =20
>>=20
>> Some extra churn due to type hints here.  Distracting.  Suggest not to
>> mix adding type hints to existing code with feature work.
>
> If you would be open for a compromise, I could leave options
> unannotated, but keep the typed parameter list.

Keeping just the function annotation is much less distracting.  I can't
reject that with a "separate patches for separate things" argument.

I'd still prefer not to, because:

* If we do add systematic type hints in the near future, then delaying
  this one until then shouldn't hurt your productivity.

* If we don't, this lone one won't help your productivity much, but
  it'll look out of place.

I really don't want us to add type hints as we go, because such
open-ended "while we touch it anyway" conversions take forever and a
day.  Maximizes the confusion integral over time.


