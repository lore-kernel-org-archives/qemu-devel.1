Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYq9h-0006nn-4c
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYq9c-0001FD-8T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:57:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYq9c-0001DO-1u
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 909AC72642
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:57:23 +0000 (UTC)
Date: Fri, 29 Jun 2018 17:57:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629095718.GJ2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org> <20180627115919.GC2516@xz-mi>
	<87po0b48i9.fsf@dusky.pond.sub.org>
	<20180628120044.GF3513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628120044.GF3513@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] your mail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 01:00:44PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 28, 2018 at 10:31:42AM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >=20
> > > On Tue, Jun 26, 2018 at 07:21:49PM +0200, Markus Armbruster wrote:
> > >> I fooled around a bit, and I think there are a few lose ends.
> > [...]
> > >> Talking to a QMP monitor that supports OOB:
> > >>=20
> > >>     $ socat UNIX:test-qmp READLINE,history=3D$HOME/.qmp_history,pr=
ompt=3D'QMP> '
> > >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major=
": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
> > >>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": tr=
ue } }
> > >>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' i=
s unexpected"}}
> > >>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable":=
 ["oob"] } }
> > >>     {"return": {}}
> > >>     QMP> { "execute": "query-qmp-schema" }
> > >>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capab=
ility requires that every command contains an 'id' field"}}
> > >>=20
> > >> Why does every command require 'id'?
> >=20
> > Why am I asking?  Requiring 'id' is rather onerous when you play with
> > QMP by hand.
> >=20
> > > The COMMAND_DROPPED event is one reason, as you mentioned in the ot=
her
> > > thread. Meanwhile as long as we have OOB command it means that we c=
an
> > > have more than one commands running in parallel, then it's a must t=
hat
> > > we can mark that out in the response to mark out which command we a=
re
> > > replying to.
> >=20
> > Without OOB, the client can match response to command, because it'll
> > receive responses in command issue order.
> >=20
> > Example 1: after sending
> >=20
> >     { "execute": "cmd1", ... }
> >     { "execute": "cmd2", ... }
> >     { "execute": "cmd3", ... }
> >=20
> > the client will receive three responses, first one is cmd1's, second =
one
> > is cmd2's, third one is cmd3's.
> >=20
> > With OOB, we have to independent command streams, in-band and
> > out-of-band.  Each separate stream's responses arrive in-order, but t=
he
> > two streams may be interleaved.
> >=20
> > Example 2: after sending
> >=20
> >     { "execute": "cmd1", ... }
> >     { "execute": "cmd2", ... }
> >     { "execute": "cmd3", ... }
> >     { "execute": "oob1", "control": { "run-oob": true }, ... }
> >     { "execute": "oob2", "control": { "run-oob": true }, ... }
> >     { "execute": "oob3", "control": { "run-oob": true }, ... }
> >=20
> > the client will receive six responses: cmd1's before cmd2's before
> > cmd3's, and oob1's before oob2's before oob3's.
>=20
> I thought the intention was that oob1, oob2, and oob3 are defined
> to return in any order. It just happens that we only hve a single
> oob processing stream right now, but we may have more in future.

Exactly.

>=20
> > If the client sends "id" with each command, it can match responses to
> > commands by id.
> >=20
> > But that's not the only way to match.  Imagine the client had a perfe=
ct
> > oracle to tell it whether a response is in-band or out-of-band.  Then
> > matching can work pretty much as in example 1: the first in-band
> > response is cmd1's, the second one is cmd2's, and the third one is
> > cmd3's; the first out-of-band response is oob1's, the second one is
> > oob2's and the third one is oob3's.
>=20
> Not if oob1/2/3 can retunr in any order in future, which I think we
> should be allowing fore.
>=20
> IMHO 'id' should be mandatory for oob usage.
>=20
> > Possible solutions other than requiring "id":
> >=20
> > 1. Make out-of-band responses recognizable
> >=20
> >    Just like we copy "id" to the response, we could copy "run-oob", o=
r
> >    maybe "control".
> >=20
> >    Solves the "match response to command" problem, doesn't solve the
> >    "match COMMAND_DROPPED event to command" problem.
> >=20
> >    Permit me a digression.  "control": { "run-oob": true } is awfully
> >    verbose.  Back when we hashed out the OOB design, I proposed to us=
e
> >    "exec-oob" instead of "execute" to run a command OOB.  I missed wh=
en
> >    that morphed into flag "run-oob" wrapped in object "control".  Was=
 it
> >    in response to reviewer feedback?  Can you give me a pointer?

It's me who proposed this, not from any reviewer's feedback.  It just
happened that no one was against it.

> >=20
> >    The counterpart to "exec-oob" would be "return-oob" and "error-oob=
".
> >    Hmm.
>=20
> I do prefer the less verbose proposal too.

But frankly speaking I still prefer current way.  QMP is majorly for
clients (computer programs) rather than users to use it.  Comparing to
verbosity, I would care more about coherency for how we define the
interface.  Say, OOB execution is still one way to execute a command,
so naturally it should still be using the same way that we execute a
QMP command, we just need some extra fields to tell the server that
"this message is more urgent than the other ones".

If we are discussing HMP interfaces, I'll have the same preference
with both of you to consider more about whether it's user-friendly or
not.  But now we are talking about QMP, then I'll prefer "control".

In the future, it's also possible to add some more sub-fields into the
"control" field.  When that happens, do we want to introduce another
standalone wording for that?  I would assume the answer is no.

>=20
> > 2. Do nothing; it's the client's problem
> >=20
> >    If the client needs to match responses and events to commands, it
> >    should use the feature that was expressly designed for helping wit=
h
> >    that: "id".
> >=20
> >    Note that QMP's initial design assumed asynchronous commands,
> >    i.e. respones that may arrive in any order.  Nevertheless, it did =
not
> >    require "id".  Same reasoning: if the client needs to match, it ca=
n
> >    use "id".
>=20
> IMHO we should just mandate 'id' when using "exec-oob", as it is
> conceptually broken to use OOB without a way to match responses.
> We don't want clients relying on all OOB replies coming in sequence
> now, and then breaking when we allow multiple OOB processing threads.
> That would require us to add a eec-oob-no-really-i-mean-it command
> to allow overlapping OOB responses later.

Agreed, again.

Thanks,

--=20
Peter Xu
