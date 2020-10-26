Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D822464E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nqu1bXiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D822464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0e2-0003lV-Nl
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kX0J3-0001Ia-BI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kX0Is-00031G-U0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603710280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIMgvH6Rn1kk9JAkxzdoPt4tU7cF8/ZviXx5yq0tQ1I=;
 b=Nqu1bXiYc2gjAYoOF6Ya1BPP4fTSM+1P4eZTdGXPHsp7oJvPjNzYsvXX1HsAXK2GNFxRMb
 dl2ptL4opxoG7Wy0IdNLVIPu3Og+RE7teZBEFEDxY6Hb/UOBxgZMVF9L8+hQQuK9tmC9zD
 Sfo3+J9TlrNWDbNO4iylgoXhrVzl4zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-aiPsZYKGNdqAxZUEeu68DA-1; Mon, 26 Oct 2020 07:04:35 -0400
X-MC-Unique: aiPsZYKGNdqAxZUEeu68DA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3282B835B50;
 Mon, 26 Oct 2020 11:04:34 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-58.ams2.redhat.com [10.36.114.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 891D110013D0;
 Mon, 26 Oct 2020 11:04:29 +0000 (UTC)
Date: Mon, 26 Oct 2020 12:04:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/6] qapi: Remove wrapper struct for simple unions
Message-ID: <20201026110427.GB22200@merkur.fritz.box>
References: <20201023161312.460406-1-kwolf@redhat.com>
 <20201023161312.460406-4-kwolf@redhat.com>
 <87d016fyx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87d016fyx2.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.10.2020 um 10:16 hat Markus Armbruster geschrieben:
> I apologize for writing so much.  It's the only way I know to figure out
> how things work.
> 
> This may feel like I'm trying to shoot down your patch.  I'm not!  I'm
> merely trying to understand and maybe improve it.  I'd love to get rid
> of implicit wrapper objects, actually.  They complicate things in
> places.  More on that below.
> 
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Variants of simple unions are always contained in a wrapper object
> > called 'data' that serves no real use.
> 
> Not quite.
> 
> Two aspects: on the wire, and in C.  Which aspect this patch is about
> is not clear to me at this point.

After the first sentence, maybe it shouldn't be. I'm only starting to
describe the problem, not what the patch does to solve it. :-)

But to clarify, this patch aims to leave the wire protocol unchanged and
remove the indirection only internally.

> 1. One the wire
> 
> qapi-code-gen.txt documents:
> 
>     A simple union can always be re-written as a flat union where the base
>     class has a single member named 'type', and where each branch of the
>     union has a struct with a single member named 'data'.  That is,
> 
>      { 'union': 'Simple', 'data': { 'one': 'str', 'two': 'int' } }
> 
>     is identical on the wire to:
> 
>      { 'enum': 'Enum', 'data': ['one', 'two'] }
>      { 'struct': 'Branch1', 'data': { 'data': 'str' } }
>      { 'struct': 'Branch2', 'data': { 'data': 'int' } }
>      { 'union': 'Flat', 'base': { 'type': 'Enum' }, 'discriminator': 'type',
>        'data': { 'one': 'Branch1', 'two': 'Branch2' } }
> 
> Actual wire format:
> 
>     { "type": "one", "data": "some-string" }
>     { "type": "two", "data": 1 }
> 
> "data" does serve a use here.

Fair. This patch isn't about the wire format, but I wouldn't be
surprised if I'm talking about "variants" in other places where I should
say something like "object variants" to be more precise.

> If we change the second branch from 'int' to some complex type, say
> 
>     { 'struct': 'Object', 'data': { 'x': 'int', 'y': 'int' } }
>     { 'union': 'Simple', 'data': { 'one': 'str', 'two': 'Object' } }
> 
>     { 'struct': 'Branch2', 'data': { 'data': 'Object' } }
> 
> we get
> 
>     { "type": "one", "data": "some-string" }
>     { "type": "two", "data": { "x": 1, "y": 2 } }
> 
> where the "data" wrapper is indeed pointless for branch "two".  We can
> get rid of it by replacing the equivalent flat union by
> 
>     { 'union': 'Flatter', 'base': { 'type': 'Enum' }, 'discriminator': 'type',
>       'data': { 'one': 'Branch1', 'two': 'Object' } }
> 
> to get
> 
>     { "type": "one", "data": "some-string" }
>     { "type": "two", "x": 1, "y": 2 }
> 
> 2. In C
> 
> The C types generated for the simple union and its corresponding flat
> union are structurally equivalent (qapi-code-gen.txt doesn't document
> this, maybe it should):
> 
>     typedef enum SimpleKind {
>         SIMPLE_KIND_ONE,
>         SIMPLE_KIND_TWO,
>         SIMPLE_KIND__MAX,
>     } SimpleKind;
> 
>     struct q_obj_str_wrapper {
>         char *data;
>     };
> 
>     struct q_obj_Object_wrapper {
>         Object *data;
>     };
> 
>     struct Simple {
>         SimpleKind type;
>         union { /* union tag is @type */
>             q_obj_str_wrapper one;
>             q_obj_Object_wrapper two;
>         } u;
>     };
> 
> and
> 
>     typedef enum Enum {
>         ENUM_ONE,
>         ENUM_TWO,
>         ENUM__MAX,
>     } Enum;
> 
>     struct Branch1 {
>         char *data;
>     };
> 
>     struct Branch2 {
>         Object *data;
>     };
> 
>     struct Flat {
>         Enum type;
>         union { /* union tag is @type */
>             Branch1 one;
>             Branch2 two;
>         } u;
>     };
> 
> Here, the wrapper is pointless for both branches.
> 
> For the "flatter" flat union, we get
> 
>     struct Flatter {
>         Enum type;
>         union { /* union tag is @type */
>             Branch1 one;
>             Object two;
>         } u;
>     };
> 
> One of two pointless wrappers are gone.
> 
> >                                        When mapping a QAPI object to the
> > command line, this becomes very visible to users because they have to
> > add one or more useless 'data.' to many option names.
> 
> It's useless in QMP, too.

Not claiming otherwise.

> > As a first step towards avoiding this painful CLI experience,
> 
> It's painful in CLI when you use dotted keys syntax, because that syntax
> makes nesting painful.
> 
> I dislike pointless nesting even when the syntax makes it almost not
> painful, like in QMP.
> 
> >                                                               this gets
> > rid of the 'data' indirection internally: The QAPI parser doesn't use a
> > wrapper object as the variant type any more, so the indirection is
> > removed from the generated C types. As a result, the C type looks the
> > same for flat and simple unions now.
> 
> Really?

Only true for unions whose structure can be represented both as flat and
as simple unions. Flat unions don't allow 'str' as a variant type, so
there is no structurally equivalent flat union. (There is a flat union
that looks the same on the write, but has a wrapper object internally.)

In the future, I would like to solve this difference between flat and
simplie unions by allowing flat union variants to have non-object types,
too (allowing the simpler C code even for flat unions). We could allow
or even require setting an explicit name instead of the fixed 'data' we
use today for simple unions.

> For the simple union we now generate
> 
>     struct Simple {
>         SimpleKind type;
>         union { /* union tag is @type */
>             char *one;
>             Object two;
>         } u;
>     };
> 
> Same as what flat union?
> 
> Certainly not 'Flatter', which has branch 'one' wrapped in a struct.
> 
> The naive attempt to not wrap it
> 
>     { 'union': 'Flattest',
>       'base': { 'type': 'Enum' }, 'discriminator': 'type',
>       'data': { 'one': 'str', 'two': 'Object' } }
> 
> is invalid, because "All flat union branches must be of struct type"
> (qapi-code-gen.txt).  qapi-gen.py duly rejects it with "branch 'one'
> cannot use built-in type 'str'".  Remember, flat unions "splice in" the
> variant members on the wire.  There have to be members for that.
> 
> >                                      A large part of this patch is
> > mechanical conversion of C code to remove the 'data' indirection.
> 
> How did you do the conversion?  Coccinelle?  Regexps?  Manual until
> compiler is happy?

Manual. I considered Coccinelle, but imagined fighting with it would
take longer than just doing it myself for those few simple unions that
we have.

> > Conceptually, the important change is that variants can now have flat
> > and wrapped representations. For a transitioning period, we'll allow
> > variants to support both representations in a later patch.
> 
> Alright, now I'm confused.
> 
> What exactly is a "flat representation", and when is it used?
> 
> What's a "wrapped representation", and when is it used?
> 
> Are you talking about the internal representation,
> i.e. QAPISchemaVariant?

I'm talking about representation "on the wire" (I don't think we
generally use this term for the command line, but well...). Internal
representation is always flat after this patch.

> >                                                            Eventually,
> > the plan is to deprecate and remove wrapped representations entirely,
> > unifying simple and flat unions.
> >
> > The externally visible interfaces stay unchanged: Visitors still expect
> > the 'data' wrappers, and introspection still shows it.
> 
> Visitors are externally visible only indirectly: the QObject visitors
> determine the wire format.  But that's detail.  Perhaps:
> 
>     The wire format remains the same.  The 'data' wrappers are still
>     there, and introspection and documentation still show them.  This
>     necessitates new special cases in visit.py, introspect.py, and
>     qapidoc.py.

Ok, works for me. It's not true any more at the end of the series
depending on whether "wire format" can also mean CLI syntax, but for
this patch it's supposed to be true.

One major problem I noticed in the QAPI spec is that it's really tied to
QMP and QMP only. It doesn't know anything about the command line nor
about types that we use only internally in the C code. I felt addressing
this was out of scope for this series, though.

> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.txt           | 32 ++++++++----
> >  docs/sphinx/qapidoc.py                 | 14 +++---
> >  backends/tpm/tpm_emulator.c            |  3 +-
> >  backends/tpm/tpm_passthrough.c         |  4 +-
> >  block/crypto.c                         |  3 +-
> >  block/qcow2.c                          |  9 ++--
> >  block/vmdk.c                           | 14 ++----
> >  blockdev.c                             | 36 ++++++-------
> >  chardev/char-file.c                    |  5 +-
> >  chardev/char-mux.c                     |  5 +-
> >  chardev/char-parallel.c                |  5 +-
> >  chardev/char-pipe.c                    |  7 ++-
> >  chardev/char-ringbuf.c                 |  5 +-
> >  chardev/char-serial.c                  |  5 +-
> >  chardev/char-socket.c                  | 13 ++---
> >  chardev/char-stdio.c                   |  5 +-
> >  chardev/char-udp.c                     | 11 ++--
> >  chardev/char.c                         | 10 ++--
> >  chardev/msmouse.c                      |  4 +-
> >  chardev/spice.c                        | 10 ++--
> >  chardev/wctablet.c                     |  4 +-
> >  hw/core/numa.c                         |  6 +--
> >  hw/display/xenfb.c                     |  8 +--
> >  hw/input/hid.c                         |  8 +--
> >  hw/input/ps2.c                         |  6 +--
> >  hw/input/virtio-input-hid.c            |  8 +--
> >  hw/mem/pc-dimm.c                       | 18 +++----
> >  hw/virtio/virtio-mem-pci.c             |  3 +-
> >  hw/virtio/virtio-pmem-pci.c            |  3 +-
> >  monitor/hmp-cmds.c                     | 14 +++---
> >  qemu-keymap.c                          |  2 +-
> >  replay/replay-input.c                  | 46 +++++++----------
> >  tests/test-char.c                      | 12 ++---
> >  tests/test-clone-visitor.c             | 14 +++---
> >  tests/test-qmp-cmds.c                  |  2 +-
> >  tests/test-qobject-input-visitor.c     | 24 ++++-----
> >  tests/test-qobject-output-visitor.c    | 24 ++++-----
> >  ui/console.c                           |  5 +-
> >  ui/input-keymap.c                      | 12 ++---
> >  ui/input-legacy.c                      | 12 ++---
> >  ui/input.c                             | 43 ++++++++--------
> >  ui/spice-app.c                         |  5 +-
> >  util/qemu-sockets.c                    |  8 +--
> >  scripts/qapi/introspect.py             |  7 ++-
> >  scripts/qapi/schema.py                 | 48 ++++++++++++++----
> >  scripts/qapi/visit.py                  | 28 +++++++++++
> >  tests/qapi-schema/doc-good.out         |  8 +--
> >  tests/qapi-schema/qapi-schema-test.out | 70 +++++++-------------------
> >  48 files changed, 322 insertions(+), 326 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index c6438c6aa9..9722c1a204 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -310,7 +310,20 @@ The BRANCH's STRING name is the branch name.
> >  The BRANCH's value defines the branch's properties, in particular its
> >  type.  The form TYPE-REF is shorthand for { 'type': TYPE-REF }.
> >  
> > -A simple union type defines a mapping from automatic discriminator
> > +Each branch can have flat or wrapped representation in the Client JSON
> > +Protocol.
> > +
> > +Wrapped representation of a branch means that it is represented by a
> > +'data' member that is of the specified data type corresponding to the
> > +discriminator value.
> > +
> > +Flat representation means that the union forms a single object that
> > +contains both common members (from the base type) and the selected
> > +branch's members, without any additional nesting.  The two sets of
> > +member names must be disjoint.
> 
> You talk about representation of branches before saying anything about
> representation of unions.  But let's focus on the contents now.  How to
> best present it can wait.

Defining the branches first is intentional because the difference
between flat and simple is mostly just the representation of branches on
the wire. So it's hard to explain what the whole union looks like when
flat/wrapped representation hasn't been introduced yet.

Either way, I think this whole section is backwards. It should start
with unions in general, then flat unions, and then "simple" unions.
Fixing it should be a separate patch, either before this one or on top
of the series.

> > +
> > +A simple union type automatically contains the 'type' member as a
> > +discriminator and defines a mapping from automatic discriminator
> >  values to data types like in this example:
> >  
> >   { 'struct': 'BlockdevOptionsFile', 'data': { 'filename': 'str' } }
> > @@ -321,10 +334,8 @@ values to data types like in this example:
> >     'data': { 'file': 'BlockdevOptionsFile',
> >               'qcow2': 'BlockdevOptionsQcow2' } }
> >  
> > -In the Client JSON Protocol, a simple union is represented by an
> > -object that contains the 'type' member as a discriminator, and a
> > -'data' member that is of the specified data type corresponding to the
> > -discriminator value, as in these examples:
> > +In the Client JSON Protocol, all simple union branches have wrapped
> > +representation, as in these examples:
> >  
> >   { "type": "file", "data": { "filename": "/some/place/my-image" } }
> >   { "type": "qcow2", "data": { "backing": "/some/place/my-image",
> > @@ -344,13 +355,12 @@ object, it defines common members just like a struct type's 'data'
> >  member defines struct type members.  If it is a STRING, it names a
> >  struct type whose members are the common members.
> >  
> > -All flat union branches must be of struct type.
> > +Member 'discriminator' must name a non-optional enum-typed member of
> > +the base struct and defines the option that should server as the
> > +discrimiator.
> 
> s/server as the discrimiator/serve as discriminator/
> 
> >  
> > -In the Client JSON Protocol, a flat union is represented by an object
> > -with the common members (from the base type) and the selected branch's
> > -members.  The two sets of member names must be disjoint.  Member
> > -'discriminator' must name a non-optional enum-typed member of the base
> > -struct.
> > +All flat union branches must be of struct type.  They have always flat
> > +representation.
> 
> So, simple unions use wrapped representation, flat unions use flat
> representation, but I have to read the whole section at least twice to
> figure that out :)  Let's not worry about that now.
> 
> >  
> >  The following example enhances the above simple union example by
> >  adding an optional common member 'read-only', renaming the
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index e03abcbb95..75f6721e29 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> 
> Best to review the changes to the QAPI generator from frontend to
> backends: schema.py first, then come back here.
> 
> > @@ -183,12 +183,14 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
> >  
> >          if variants:
> >              for v in variants.variants:
> > -                if v.type.is_implicit():
> > -                    assert not v.type.base and not v.type.variants
> > -                    for m in v.type.local_members:
> > -                        term = self._nodes_for_one_member(m)
> > -                        term.extend(self._nodes_for_variant_when(variants, v))
> > -                        dlnode += self._make_dlitem(term, None)
> > +                if v.wrapped:
> > +                    term = [nodes.literal('', 'data'),
> > +                            nodes.Text(': '),
> > +                            nodes.literal('', v.type.doc_type())]
> > +                    term.extend(self._nodes_for_variant_when(variants, v))
> > +                    dlnode += self._make_dlitem(term, None)
> > +                elif v.type.is_implicit():
> > +                    assert v.type.name == 'q_empty'
> >                  else:
> >                      term = [nodes.Text('The members of '),
> >                              nodes.literal('', v.type.doc_type())]
> [...]
> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index fafec94e02..1c4e3407a3 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -188,7 +188,12 @@ const QLitObject %(c_name)s = %(c_string)s;
> >                  'variants': [self._gen_variant(v) for v in variants]}
> >  
> >      def _gen_variant(self, variant):
> > -        obj = {'case': variant.name, 'type': self._use_type(variant.type)}
> > +        if variant.wrapped:
> > +            obj = {'case': variant.name,
> > +                   'type': self._use_type(variant.wrapper_type)}
> > +        else:
> > +            obj = {'case': variant.name,
> > +                   'type': self._use_type(variant.type)}
> >          return _make_tree(obj, variant.ifcond, None)
> >  
> >      def visit_builtin_type(self, name, info, json_type):
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 720449feee..17525b4216 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -216,6 +216,11 @@ class QAPISchemaBuiltinType(QAPISchemaType):
> >          self._json_type_name = json_type
> >          self._c_type_name = c_type
> >  
> > +    def check(self, schema):
> > +        # Don't check twice, it would fail an assertion
> > +        if not self._checked:
> > +            super().check(schema)
> > +
> 
> How can this get called twice?
> 
> I'm asking because I remember the last time I cleaned up .check()
> recursion (commit f9d1743b9b0).  Just glancing at its commit message
> brings back the headache.

This doesn't seem to happen any more, I can remove this hunk. I suppose
I hadn't made the recursion in QAPISchemaVariants.check() conditional on
instanceof(..., QAPISchemaObjectType) yet.

> >      def c_name(self):
> >          return self.name
> >  
> 
> Further down in QAPISchemaObjectType:
> 
>        @property
>        def ifcond(self):
>            assert self._checked
>            if isinstance(self._ifcond, QAPISchemaType):
>                # Simple union wrapper type inherits from wrapped type;
>                # see _make_implicit_object_type()
>                return self._ifcond.ifcond
>            return self._ifcond
> 
> Is isinstance(self._ifcond, QAPISchemaType) still possible?  See
> _make_implicit_object_type() below.

If the comment describe all possibly situations, probably not?

This is a case where John's type annotations would be helpful to find
the right answer quickly.

> > @@ -593,18 +598,21 @@ class QAPISchemaVariants:
>            if self._tag_name:    # flat union
>                # branches that are not explicitly covered get an empty type
>                cases = {v.name for v in self.variants}
>                for m in self.tag_member.type.members:
>                    if m.name not in cases:
>                        v = QAPISchemaVariant(m.name, self.info,
>                                              'q_empty', m.ifcond)
> 
> Note for later: the code to create a default empty variant stays the
> same.
> 
>                        v.set_defined_in(self.tag_member.defined_in)
>                        self.variants.append(v)
>            [...]
>            for v in self.variants:
>                v.check(schema)
>                # Union names must match enum values; alternate names are
>                # checked separately. Use 'seen' to tell the two apart.
>                if seen:
>                    if v.name not in self.tag_member.type.member_names():
>                        raise QAPISemError(
>                            self.info,
> >                          "branch '%s' is not a value of %s"
> >                          % (v.name, self.tag_member.type.describe()))
> >                  if (not isinstance(v.type, QAPISchemaObjectType)
> > -                        or v.type.variants):
> > +                        or v.type.variants) and v.flat:
> >                      raise QAPISemError(
> >                          self.info,
> >                          "%s cannot use %s"
> >                          % (v.describe(self.info), v.type.describe()))
> 
> Before the patch: check branch type is an object without variants.  For
> flat unions, this is documented in qapi-code-gen.txt: "All flat union
> branches must be of struct type".  For simple unions, the wrapper types
> spliced in by the desugaring ensure this can't fail.
> 
> What the hunk does: permit arbitrary branch types when not v.flat.  To
> make sense of it, we need to understand the meaning of v.flat.  See
> below.
> 
> > -                v.type.check(schema)
> > +                if isinstance(v.type, QAPISchemaObjectType):
> > +                    v.type.check(schema)
> 
> Since we want to recurse only for object types (see commit f9d1743b9b0),
> and other types are now possible when not v.flat, the recursion now
> needs to be guarded.  Okay.

By the way, it would be good if you didn't have to know commit
f9d1743b9b0 to figure out how this is supposed to work. Docstrings in
QAPISchemaEntity would probably go a long way.

> >  
> >      def check_clash(self, info, seen):
> >          for v in self.variants:
> >              # Reset seen map for each variant, since qapi names from one
> > -            # branch do not affect another branch
> > -            v.type.check_clash(info, dict(seen))
> > +            # branch do not affect another branch.  Variants that are
> > +            # never flat don't even conflict with the base.
> 
> What do you mean by "never flat"?  Could a variant be sometimes flat?

After the next patch, variants can support both flat and wrapped
representation in the generated C code. Which one is used depends on the
Visitor configuration then. (Not in this series, but further in the
future, input visitors can be able to accept both forms, which gives us
an opportunity to deprecate the wrapped form.)

> > +            if isinstance(v.type, QAPISchemaObjectType):
> > +                v.type.check_clash(info, dict(seen) if v.flat else {})
> 
> The guard is necessary because v.type has method .check_clash() only if
> it's an object type.
> 
> .check() ensures that v.type is an object type without variants when
> v.flat.
> 
> So:
> 
> * If v.flat, no change.
> 
> * If not v.flat and v.type is an object type (possibly with variants),
>   we run its .check_clash() with an empty seen.  What does this
>   accomplish?

Checking internal consistency, I guess.

If it's necessary depends on whether something else calls check_clash(),
too. Maybe it is already called for all entities? Then this would be
unnecessary.

> * If not v.flat and v.type is not an object type, we do nothing.
> 
> >  
> >  
> >  class QAPISchemaMember:
> > @@ -705,9 +713,22 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
> >  class QAPISchemaVariant(QAPISchemaObjectTypeMember):
> >      role = 'branch'
> >  
> > -    def __init__(self, name, info, typ, ifcond=None):
> > +    def __init__(self, name, info, typ, ifcond=None, flat=True,
> > +                 wrapper_type=None):
> >          super().__init__(name, info, typ, False, ifcond)
> >  
> > +        self.flat = flat
> > +        self.wrapped = bool(wrapper_type)
> > +        self.wrapper_type = wrapper_type
> > +
> > +        # For now, unions are either flat or wrapped, never both
> > +        assert self.flat or self.wrapped
> > +        assert not (self.flat and self.wrapped)
> 
> The comment makes me expect
> 
>            assert self.flat == not self.wrapped
> 
> Moreover, .flat and .wrapped seem to be redundant with .wrapper_type.
> 
> Hmm, I see the next patch will change this again.  I'm therefore
> reserving judgement until the end of the series.
> 
> The constructor is called in three places:
> 
> * QAPISchema._make_variant(), call unchanged (see below), therefore flat
> 
> * QAPISchema._make_simple_variant(), now passes flat=False, see below
>   for details
> 
> * QAPISchemaVariants.check(), call unchanged (see below), therefore flat
> 
> > +
> > +    def check(self, schema):
> > +        super().check(schema)
> > +        if self.wrapped:
> > +            self.wrapper_type.check(schema)
> 
> Commit f9d1743b9b0: "An entity's .check() recurses into another entity's
> .check() only if the C struct generated for the former contains the C
> struct generated for the latter (pointers don't count).  This is used to
> detect "object contains itself".
> 
> Can you explain why we want to recurse here?

Because nothing else checks self.wrapper_type.

> pycodestyle-3 complains:
> 
>     scripts/qapi/schema.py:733:1: E302 expected 2 blank lines, found 1
> 
> >  class QAPISchemaCommand(QAPISchemaEntity):
> >      meta = 'command'
> > @@ -1017,14 +1038,19 @@ class QAPISchema:
> 
> Not changed:
> 
>        def _make_implicit_object_type(self, name, info, ifcond, role, members):
>            if not members:
>                return None
>            # See also QAPISchemaObjectTypeMember.describe()
>            name = 'q_obj_%s-%s' % (name, role)
>            typ = self.lookup_entity(name, QAPISchemaObjectType)
>            if typ:
>                # The implicit object type has multiple users.  This can
>                # happen only for simple unions' implicit wrapper types.
>                # Its ifcond should be the disjunction of its user's
>                # ifconds.  Not implemented.  Instead, we always pass the
>                # wrapped type's ifcond, which is trivially the same for all
>                # users.  It's also necessary for the wrapper to compile.
>                # But it's not tight: the disjunction need not imply it.  We
>                # may end up compiling useless wrapper types.
>                # TODO kill simple unions or implement the disjunction
> 
>                # pylint: disable=protected-access
>                assert (ifcond or []) == typ._ifcond
>            else:
>                self._def_entity(QAPISchemaObjectType(
>                    name, info, None, ifcond, None, None, members, None))
>            return name
> 
> Can typ still be non-None?

I don't know. I would have to understand all callers to tell. Again,
John's typing patches would make finding the answer easy.

> [...]
> >      def _make_variant(self, case, typ, ifcond, info):
> >          return QAPISchemaVariant(case, info, typ, ifcond)
> >  
> > -    def _make_simple_variant(self, case, typ, ifcond, info):
> > +    def _make_simple_variant(self, union_name, case, typ, ifcond, info):
> >          if isinstance(typ, list):
> >              assert len(typ) == 1
> >              typ = self._make_array_type(typ[0], info)
> > -        typ = self._make_implicit_object_type(
> > -            typ, info, self.lookup_type(typ),
> > -            'wrapper', [self._make_member('data', typ, None, None, info)])
> > -        return QAPISchemaVariant(case, info, typ, ifcond)
> > +
> > +        # The wrapper type is only used for introspection compatibility.
> > +        # Don't add it to the entity list of the schema.
> > +        wrapper_name = 'q_obj_%s-%s-wrapper' % (union_name, case)
> > +        wrapper_member = self._make_member('data', typ, None, None, info)
> > +        wrapper_type = QAPISchemaObjectType(wrapper_name, info, None, ifcond,
> > +                                            None, None, [wrapper_member], None)
> 
> This adds another place where we create implicit object types.  Comments
> need to be updated, e.g. in QAPISchemaObjectType.is_implicit().
> 
> > +        return QAPISchemaVariant(case, info, typ, ifcond, flat=False,
> > +                                 wrapper_type=wrapper_type)
> 
> This changes argument @typ from wrapper to wrapped type.  The wrapper is
> passed as @wrapped_type instead.
> 
> It's not the same wrapper, though.
> 
> Before the patch, we have a common q_obj_<wrapped-type>-wrapper.
> _make_implicit_object_type() creates it unless it exists already.
> 
> After the patch, we have q_obj_<union-type>-<branch-name>-wrapper.  The
> wrapper de-duplication is gone.  _make_implicit_object_type() is
> bypassed.
> 
> But is this bypass necessary?  I suspect it's to not "add it to the
> entity list of the schema".  Why not?

We don't really want it to be a type for almost all matters. For
example, having it in the entity list would generate C code that is
never used.

The only reason this type object is even created is because the
introspection code was too painful to change to work without it, and it
can't create the object locally because it would have to access private
attributes and/or methods to do so.

So pre-creating this type here is a compromise that I already dislike.
If you think it's bad, I can try and have another look at the
introspection code and if we can somehow make it work without having a
type.

But I certainly want code that wants to see this type do additional
steps, not code that wants to exclude it. It should be invisible by
default.

> If the loss of de-duplication is intentional, the commit message should
> mention it.

Not exactly intentional in the sense that it was the goal, but it
doesn't matter much either. Only the generated introspection code
becomes a bit longer.

> >  
> >      def _def_union_type(self, expr, info, doc):
> >          name = expr['union']
> > @@ -1044,7 +1070,7 @@ class QAPISchema:
> >                          for (key, value) in data.items()]
> >              members = []
> >          else:
> > -            variants = [self._make_simple_variant(key, value['type'],
> > +            variants = [self._make_simple_variant(name, key, value['type'],
> >                                                    value.get('if'), info)
> >                          for (key, value) in data.items()]
> >              enum = [{'name': v.name, 'if': v.ifcond} for v in variants]
> > diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> > index 339f152152..f72567cbcc 100644
> > --- a/scripts/qapi/visit.py
> > +++ b/scripts/qapi/visit.py
> > @@ -118,6 +118,34 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
>            for var in variants.variants:
>                case_str = c_enum_const(tag_member.type.name, var.name,
>                                        tag_member.type.prefix)
>                ret += gen_if(var.ifcond)
> 
> Before the patch, special case 'q_empty' (which has no visitor), general
> case object type.
> 
> The patch adds two more cases.
> 
> 
> This is special case 'q_empty':
> 
>                if var.type.name == 'q_empty':
>                    # valid variant and nothing to do
>                    ret += mcgen('''
>        case %(case)s:
> >          break;
> >  ''',
> >                               case=case_str)
> 
> 
> New case "not an object type":
> 
> > +            elif not isinstance(var.type, QAPISchemaObjectType):
> > +                assert not var.flat
> > +                ret += mcgen('''
> > +    case %(case)s:
> > +        return visit_type_%(c_type)s(v, "data", &obj->u.%(c_name)s, errp);
> > +''',
> > +                             case=case_str,
> > +                             c_type=var.type.c_name(), c_name=c_name(var.name))
> 
> Before the patch, we visit the implicit wrapper, using the general case
> below, i.e.
> 
>            return visit_type_q_obj_T_wrapper_members(v, &obj->u.BRANCH, errp);
> 
> visit_type_q_obj_T_members() looks like this:
> 
>        bool visit_type_q_obj_T_wrapper_members(Visitor *v, q_obj_T_wrapper *obj, Error **errp)
>        {
>            if (!visit_type_T(v, "data", &obj->data, errp)) {
>                return false;
>            }
>            return true;
>        }
> 
> The new code calls visit_type_T() directly.  The only change (I think /
> hope) is from &obj->u.BASE->data to &obj->u.BASE, which is what we want.
> 
> 
> New case "wrapped object type":
> 
> > +            elif var.wrapped:
> > +                ret += mcgen('''
> > +    case %(case)s:
> > +    {
> > +        bool ok;
> > +
> > +        if (!visit_start_struct(v, "data", NULL, 0, errp)) {
> > +            return false;
> > +        }
> > +        ok = visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp);
> > +        if (ok) {
> > +            ok = visit_check_struct(v, errp);
> > +        }
> > +        visit_end_struct(v, NULL);
> > +        return ok;
> > +    }
> > +''',
> > +                             case=case_str,
> > +                             c_type=var.type.c_name(), c_name=c_name(var.name))
> > +
> >              else:
> >                  ret += mcgen('''
> 
> To compensate for the implicit wrapper type's removal from the C type,
> we splice in a virtual struct visit.
> 
> Before the patch, we visit the implicit wrapper, using the general case
> below, i.e.
> 
>            return visit_type_q_obj_T_wrapper_members(v, &obj->u.BRANCH, errp);
> 
> visit_type_q_obj_T_members() looks like this:
> 
>        bool visit_type_q_obj_T_wrapper_members(Visitor *v, q_obj_T_wrapper *obj, Error **errp)
>        {
>            if (!visit_type_T(v, "data", &obj->data, errp)) {
>                return false;
>            }
>            return true;
>        }
> 
> When T is an object type, visit_type_T() looks like this:
> 
>        bool visit_type_T(Visitor *v, const char *name,
>                         T **obj, Error **errp)
>        {
>            bool ok = false;
> 
>            if (!visit_start_struct(v, name, (void **)obj, sizeof(T), errp)) {
>                return false;
>            }
>            if (!*obj) {
>                /* incomplete */
>                assert(visit_is_dealloc(v));
>                ok = true;
>                goto out_obj;
>            }
>            if (!visit_type_T_members(v, *obj, errp)) {
>                goto out_obj;
>            }
>            ok = visit_check_struct(v, errp);
>        out_obj:
>            visit_end_struct(v, (void **)obj);
>            if (!ok && visit_is_input(v)) {
>                qapi_free_T(*obj);
>                *obj = NULL;
>            }
>            return ok;
>        }
> 
> Compare to the new code:
> 
> 1. The new code passes NULL to visit_start_struct() and
>    visit_end_struct(), i.e. the visit of "data" becomes virtual.
> 
> 2. The new code passes &obj->u.BRANCH instead of &obj->u.BRANCH->data.
> 
> 3. The new code doesn't have the /* incomplete */ conditional.
> 
> 4. The new code doesn't have the conditional qapi_free_T().
> 
> The first two compensate for the wrapper type's removal from the C type.
> 
> Why are the last two not needed?

Because we're parsing fields for an pre-existing C struct now instead of
creating malloc'ed objects - which is also why visit_start/end_struct()
get NULL instead of obj.

> 
> Case "unwrapped object type" (same as old general case):
> 
> >      case %(case)s:
>            return visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp);
>    ''',
>                                 case=case_str,
>                                 c_type=var.type.c_name(), c_name=c_name(var.name))
> 
>                ret += gen_endif(var.ifcond)
>            ret += mcgen('''
>        default:
>            abort();
>        }
>    ''')
> 
> Now I should go back to qapidoc.py and introspect.py.  But I think we
> have enough to discuss about this patch already, so I'm postponing their
> review, and move on the the next patch.

Ok.

Kevin


