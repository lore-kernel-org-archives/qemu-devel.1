Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328DC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5020207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFv/L8Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5020207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMEX-0002qc-PT
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irLrx-0005yR-Qc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irLrr-0003p7-6E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:04:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irLrr-0003ox-0w
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579007062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JccXzs0A3TZ5huSRIz3mDwwdNIc9Me5G0KzBq6RPCA=;
 b=XFv/L8JpyUdrIzZ8RSd8XgTQzd9IoK1WHTJ0caXuJxRd0XyYeNcLLBz7/etIwEK48XVdAH
 2ZpOSNBqmmSiUcyqs8yW0DTddxGTL4DjO+mMpiAfXDdqQpB4if8eykho+mAWKZnvb29CqD
 qj6f5/Xoet3h43Agtsm01WT7pvLfrg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-7M-eCoVMPJ-xnxZ4kNeqxA-1; Tue, 14 Jan 2020 08:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3385593B0;
 Tue, 14 Jan 2020 13:04:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B42A675AE;
 Tue, 14 Jan 2020 13:04:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B9E91138600; Tue, 14 Jan 2020 14:04:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
Date: Tue, 14 Jan 2020 14:04:07 +0100
In-Reply-To: <20200108133842.GE5057@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Wed, 8 Jan 2020 14:38:42 +0100")
Message-ID: <87d0bmchq0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7M-eCoVMPJ-xnxZ4kNeqxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 08.01.2020 um 12:40 hat Christophe de Dinechin geschrieben:
>> > On 8 Jan 2020, at 11:43, Kevin Wolf <kwolf@redhat.com> wrote:
>> > Am 07.01.2020 um 18:11 hat Christophe de Dinechin geschrieben:
>> >> So I think that it might help, in the long run, to start defining the
>> >> language in question in some abstract way, and then to have rules
>> >> for how to transform that abstract language into concrete bindings.
>> >=20
>> > I think this abstract language is QAPI.
>>=20
>> Currently, yes, that=E2=80=99s the closest we have to a well-defined lan=
guage,
>> I pointed it out in my mail, and there is qapi-code-gen.txt to prove it.
>
> Oh, did you? I must have missed that point, sorry.
>
>> So it would certainly make sense for the language I=E2=80=99m describing=
 to
>> be a forward evolution of QAPI, or something that is trivially transform=
ed
>> to / from the existing json schema.
>
> I guess I need to be more specific about what I mean with "QAPI". Of
> course, many things you can't currently do in QAPI because they are not
> implemented. When I'm talking about that QAPI should be used more, I'm
> mostly talking about applying its core concepts and infrastructure with
> the obvious extensions in some places, not about the existing
> implementation.
>
> So I guess "a forward evoluion of QAPI" is what I really have in mind.
>
>> > The problem is that we're not even close to using QAPI for everything.
>>=20
>> That=E2=80=99s the symptom of the problem. The problem as I see it is th=
at
>> we could not. at least not with today=E2=80=99s QAPI (maybe I=E2=80=99m =
wrong).
>> A good example is shortcut command-line options. I don=E2=80=99t think
>> you can, today, derive a user-friendly command-line syntax from
>> qapi-schema.json, and even less so one that is compatible with what
>> we have today.
>
> Well, you can't because it's not implemented. Implementing it from
> scratch without compatibility requirements would be relatively easy, and
> we're in fact going to try it out with the qemu-storage-daemon.

Yes.

Prior art:

    Presentation
    KVM Forum 2017: Towards a More Expressive and Introspectable QEMU
    Command Line
    https://www.youtube.com/watch?v=3DgtpOLQgnwug
    https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf

    RFC patches
    https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00209.html
    Message-Id: <20171002152552.27999-1-armbru@redhat.com>
    https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qapi-cmdline

> But there is nothing in defining a command line option that would
> inherently be different in structure from defining a QMP command, so I
> would consider providing a command line option that is described by a
> QAPI type not a problem, even though it's not implemented yet.
>
> Compatibility is much harder, which is not the least because the
> existing command line options are bad (primarily: using inconsistent
> syntax).

Semantics are just as problematic.

>          The question is if we should make bad options work unchanged in
> the new infrastructure or if it wouldn't be better to replace them with
> something that behaves the same as the rest.
>
>> > Adding a new language on top of QAPI instead isn't going to make the
>> > conversion process any faster.
>>=20
>> I fully agree that whatever language we select has to have an easy,
>> systematic forward path from QAPI, but also from the other
>> existing meta-languages, like the .def files used for options,

You mean the qemu-options.hx.  qemu-options.def is generated from it.

We used to have qmp-commands.hx, until QAPI swallowed it.  Command line
QAPIfication will swallow qemu-options.hx.

>> or build configuration (there is a hint of the connection between
>> the two in the option =E2=80=98if=E2=80=99 member in the .json files).

I'm not sure what exactly you have in mind for build configuration.

>> In other words, the language I have in mind would be something
>> that I could auto-generate from, say, the current qapi-schema.json
>> and the qemu-options.def. Maybe in the end, that would be simply
>> by having qemu-options.def being used to build qemu-options.json,
>> and then add the relevant entries in qemu-options.json. Maybe
>> there is a better way.
>
> I would rather say that .def should go away and its content should
> be converted to a JSON schema that becomes the new source format rather
> than an intermediate generated file. There is nothing in .def files that
> couldn't be represented in the schema.

Yes.

>> >> This definition itself is not obvious (at least not to me). For
>> >> example, do we have, anywhere but in the C code, the specification
>> >> of how one can add a disk to qemu, and what it means?
>> >> Say, looking at qemu-options.def, how do I tell that -hda has
>> >> anything to do with -device or -blockdev or -help?
>> >=20
>> > BlockdevOptions in the QAPI schema is what tells you how it _really_
>> > works.
>>=20
>> Not really, IMO, in the sense that it gives me no clue as to how -hda
>> or -device relate to it.
>>=20
>> An important point that you raise through your response, though, is
>> that the QAPI schema is only an IDL (interface definition language).
>> In other words, it can tell me what a BlockdevOptions look like on
>> the wire, but at least in the current state, it cannot tell me what happ=
ens
>> with it.

True.

>> This is probably a good thing (it=E2=80=99s already complicated enough a=
s is),
>> but it=E2=80=99s worth pointing out that, even sticking to a declarative=
 language,
>> one could add constraints, as hinted by HAS_ARG in the .def file
>> (but we could have a richer constraints language, e.g. describing
>> -m option so that there can be at most one, the arg is a number,
>> can=E2=80=99t be negative or floating-point, and so on.
>
> To a certain degree, QAPI does just that, by supporting different data
> types for options. If necessary, I'm sure the type system could be
> extended, but it's not clear to me to which degree we actually need
> this.

QAPI is much more expressive than qemu-options.hx.  All the latter can
do is "has option argument" and "option is arch-specific".  QAPI lets
you specify an option argument's structure, and supports compile-time
conditionals.  It can't do things like "must specify either argument A
or B", or "numeric argument C must not exceed argument D", or "multiple
options combine vs. last one wins".  Mostly because "it=E2=80=99s already
complicated enough as is".

> Just drawing parallels from what we do for QMP commands, I imagine
> something like this to describe the -m option as it actually exists in
> qemu-options.def today:
>
> ##
> # @m:
> #
> # Configure guest RAM.
> #
> # @size: initial amount of guest memory
> # @slots: number of hotplug slots (default: none)
> # @maxmem: maximum amount of guest memory (default: none)
> ##
> { 'cmdline-option': 'm',
>   'arguments': {
>     'size': 'size',
>     'slots': '*int',
>     'maxmem': '*size'
>   },
>   'default-key': 'size',
>   'repeat': 'OVERRIDE' }
>
> HAS_ARG is automatically covered simply by 'arguments' being non-empty.
>
> (Markus probably already has a prototype with slightly different syntax,
> but the idea should be similar.)

A similar example from my RFC patches:

##
# @--add-fd:
# !texinfo
# -add-fd fd=3D@var{fd},set=3D@var{set}[,opaque=3D@var{opaque}]@*
#
# Add a file descriptor to an fd set.  Valid options are:
#
# @table @option
# @item fd=3D@var{fd}
# This option defines the file descriptor of which a duplicate is added to =
fd set.
# The file descriptor cannot be stdin, stdout, or stderr.
# @item set=3D@var{set}
# This option defines the ID of the fd set to add the file descriptor to.
# @item opaque=3D@var{opaque}
# This option defines a free-form string that can be used to describe @var{=
fd}.
# @end table
#
# You can open an image using pre-opened file descriptors from an fd set:
# @example
# qemu-system-i386
# -add-fd fd=3D3,set=3D2,opaque=3D"rdwr:/path/to/file"
# -add-fd fd=3D4,set=3D2,opaque=3D"rdonly:/path/to/file"
# -drive file=3D/dev/fdset/2,index=3D0,media=3Ddisk
# @end example
# !end texinfo
##
{ 'option': '--add-fd',
  'data': { 'fd': 'int', 'set': 'int', '*opaque': 'str' },
  'help': [
"-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]",
"                Add 'fd' to fd 'set'"] }

>> And of course, we could decide to not stick to a declarative language,
>> but to have a way to have some, possibly limited, processing
>> described in the language. I=E2=80=99m thinking notably of what is calle=
d
>> =E2=80=9Cdesugaring=E2=80=9D in other threads.
>
> We could. But is it actually worth inventing a new programming language?
> I think this is something that should be done in C code even in the
> future. I think what we're looking for is a way to describe interfaces,
> not implementations.

Sane sugar can be described declaratively as macro expansion.

Less than sane sugar takes code.

Desugaring in code promotes (accidental) abandonment of sanity.

That said, we have to keep things simple to succeed.  Declarative
desugaring seems beyond our reach.

> Even just for adding more sophisticated constraints, like in the example
> above that maxmem >=3D size, it's questionable whether doing this in the
> schema provides enough value for actually implementing it there.

Yes.

>> >> A big issue, though, is that of compatibility. Doing the above starti=
ng
>> >> from scratch does not seem that complicated. Doing it in a way that
>> >> preserves a minimum of interoperability with earlier-generation
>> >> software is another ordeal.
>> >=20
>> > Indeed, this is the major reason why QAPI isn't as pervasive as it
>> > should be.
>>=20
>> Probably, but also because QAPI does not address the needs of
>> some of the things a slightly more general language could do.
>
> So what are the things that you would like to describe, but can't see an
> easy way to actually describe them with QAPI concepts?
>
>> >> So I think that Daniel is right. We may need at some point to start
>> >> a NEMU-style offshoot that does not attempt to be compatible,
>> >> but explores describing an increasing surface of the API using a
>> >> new meta-language from which we can generate, in a consistent
>> >> way, at least:
>> >>=20
>> >> - C bindings
>> >> - Command-line options
>> >> - Shell bindings (or =E2=80=9CHMP=E2=80=9D)
>> >> - JSON schema or qom description
>> >> - Bindings in other languages (Rust, Go, Python)
>> >> - Networked versions of the API (socket, REST)
>> >> - Client-side code e.g. for libvirt.
>> >> - Serialization / deserialization, e.g. for configuration files
>> >> - Documentation, including man page and API docs
>> >> - Command-line help
>> >=20
>> > I think the only thing in this list that can't obviously be covered
>> > easily by QAPI is QOM. Or rather, it's covered by passing through
>> > key=3Dvalue lists without describing their structure
>>=20
>> That=E2=80=99s close enough to me. (In my mind, that part was already =
=E2=80=9Cdone=E2=80=9D
>> by QAPI, even if in the convoluted way you describe)
>
> That's not really close enough. If you are happy with this level of
> abstraction, you can define any command line option to be either a flag
> or take a string as its argument and be done. This is obviously not very
> helpful because it says nothing about the structure of that string.

Similar to all QMP commands taking a single 'any' argument.

>                                                                     In
> the same way, QAPI can't say anything about the structure of a QOM
> object, and I think that's a problem.
>
>> > - which, as far as I
>> > understand, is mainly because QOM properties aren't necessarily static=
,
>> > so we can't provide a statically defined interface for them. Probably
>> > solvable in QEMU, but not without a major effort.
>>=20
>> Or maybe extend the language so that it=E2=80=99s internal semantics
>> knows about this aspect of QOM?
>
> My point is that for example you can't generate a C struct (which is
> statically defined) from something that has a dynamic structure. The
> best you could do is fall back to key=3Dvalue even in the C source, both
> key and value being strings. But then you still have to parse these
> strings manually, so it doesn't actually help much compared to a state
> without C bindings.

QOM and QAPI sabotage each other.  Ironic, considering they were dreamed
up by the same guy :)

QAPI is compile-time static by design.

QOM is run-time dynamic by design.  Some support for static definitions
has been grafted on since.

We use QAPI type system escapes for QOM.  Defeats QAPI introspection and
doc generation.  We provide separate QOM introspection instead, which is
clumsier and less expressive.  QOM documentation doesn't exist.

> Maybe what could be done is covering at least the static properties and
> then having key=3Dvalue for the dynamic part (which should be the
> exception).

To make this worthwhile, we'd have to replace dynamic QOM properties by
static ones when possible.  Monumental task.

>> >> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=
=9Cderives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
>> >> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9C=
attaches to=E2=80=9D=E2=80=A6
>> >> - States, e.g. how do we represent the machine configuration,
>> >> or the desired new disk setting
>> >> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnec=
t=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
>> >> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we de=
scribe the kind of input they need.
>> >> - Possibly more subtle things like support for transactions, commit/r=
ollback,
>> >> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, bu=
t if anything
>> >> along the way fails, I=E2=80=99d like all the cleanup to happen autom=
atically)
>> >=20
>> > This sounds like a different approach from our current QAPI command se=
t
>>=20
>> Well, except for purposefully trying to use a different wording to avoid
>> the risk of getting your mind stuck in one of the particular existing
>> meta-languages in QEMU, the approach is not very different.
>
> I didn't necessarily mean relations/state/verbs, which obviously exist,
> but the examples that seemed to express things in a deliberately
> different way from what we have today.
>
>> - Transactions do not exist today that I know of, although we see
>> signs of them in discussions about the fact that this options destroys
>> that back end but that option does not.
>
> We have a 'transaction' QMP command, but they are not an integral part
> of the language. Considering the trouble to implement transactional
> commands, I suppose we don't even want it to be a fundamental part of
> the language.
>
>> > Does it actually provide more functionality, though?
>>=20
>> It=E2=80=99s not intended to provide more, but to require less to do the=
 same thing.
>
> Though we always need to keep in mind that if requiring less for future
> additions requires a huge effort now, the investment may pay off only in
> a very distant future (if the abstraction we build even survives until
> then).

Worse is better.

http://dreamsongs.com/RiseOfWorseIsBetter.html


