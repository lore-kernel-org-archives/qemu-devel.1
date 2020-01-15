Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEFC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14030207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6V3nKlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14030207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iresJ-0000Qu-6C
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irerZ-0007AM-5W
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irerV-0008D6-S6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:21:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54040
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irerV-0008Bs-NV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579080076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsDd7rBJDwiAOUMgUoAmCdvK/ix34tceHhFI2GUkYpA=;
 b=P6V3nKlWYugs/VyeZ+YY2AjxgWfYMxDIz8uFlRp+DeeavTvEz5Iy6G6SLfwUokyggjTkHz
 oggej/2w7JAzLsLdZ5kfUei+z2Fyg5923+tyEQ3uj4V8NdpPlQmW8NXGjh2eJhxk/BUEAa
 P6itOPoC5V0gm3Vq3ym5MSKiqsvXhiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-DhKYDxMAN1WWhVUWhGheQQ-1; Wed, 15 Jan 2020 04:21:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A3C18543A4;
 Wed, 15 Jan 2020 09:21:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B695326182;
 Wed, 15 Jan 2020 09:20:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43CBE1138600; Wed, 15 Jan 2020 10:20:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
Date: Wed, 15 Jan 2020 10:20:58 +0100
In-Reply-To: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com> (Christophe de
 Dinechin's message of "Tue, 14 Jan 2020 18:31:11 +0100")
Message-ID: <87o8v52hz9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DhKYDxMAN1WWhVUWhGheQQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

> I started cutting some stuff out.
>
>> On 14 Jan 2020, at 14:04, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> Prior art:
>>=20
>>    Presentation
>>    KVM Forum 2017: Towards a More Expressive and Introspectable QEMU
>>    Command Line
>>    https://www.youtube.com/watch?v=3DgtpOLQgnwug
>>    https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf
>>=20
>>    RFC patches
>>    https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00209.htm=
l
>>    Message-Id: <20171002152552.27999-1-armbru@redhat.com>
>>    https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qapi-cmdline
>
> Very useful, thanks.
>
>>=20
>>> Compatibility is much harder, which is not the least because the
>>> existing command line options are bad (primarily: using inconsistent
>>> syntax).
>>=20
>> Semantics are just as problematic.
>
> Yes, but often you can leverage something (e.g. JSON, XML, etc)
>
> We could decide that the new QAPI language is a custom implementation
> of Python ;-) Or more seriously, we could have some part of the JSON
> schema that are =E2=80=9Cescapes=E2=80=9D to C code that we put in some g=
enerated file.
> I used {{ }} below for this escape, in which case the semantics would be
> that of C plus some specific macros we insert in it.
>
> { 'option': '--add-fd',
>  'data': { 'fd': 'int', 'set': 'int', '*opaque': 'str' },
>  'help': [
> "-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]",
> "                Add 'fd' to fd 'set'=E2=80=9D]=20
>  =E2=80=98validate=E2=80=99 : {{
>     error_if(QOPT.fd < 0, =E2=80=9Cfd option cannot be negative=E2=80=9D)=
;
>     error_if(QOPT.fd <=3D STDERR_FILENO, =E2=80=9Cfd cannot be a standard=
 I/O stream=E2=80=9D);
>  }},
>  =E2=80=98exec=E2=80=99 : {{
>     if (do_add_fd(QOPT.fd, QOPT.fset, QOPT.opaque) < 0) {
>         exit(1);
>     }
>  }},
>
> I=E2=80=99m not necessarily saying this is a good idea, mind you.

Precedence: the value of 'if' is also a C snippet.

>> You mean the qemu-options.hx.  qemu-options.def is generated from it.
>
> Oh, I had missed that, thanks.
>
>>>> or build configuration (there is a hint of the connection between
>>>> the two in the option =E2=80=98if=E2=80=99 member in the .json files).
>>=20
>> I'm not sure what exactly you have in mind for build configuration.
>
> I meant what you pointed out wrt. options, that this =E2=80=9Clanguage=E2=
=80=9D needs to
> know about the qemu configuration. There is =E2=80=98if=E2=80=99 today, y=
ou pointed
> out arch-specific for options. But the configuration itself is yet
> another =E2=80=9Clanguage=E2=80=9D with its own semantics=E2=80=A6 which =
JSON knows
> nothing about.

QAPI 'if' is a pragmatic design balancing simplicty with expressiveness.

It's part of the QAPI language except for the actual conditions.  The
QAPI generator blindly wraps whatever it generates for the thing
carrying an 'if': 'COND' in #if COND ... #endif /* COND */.  In other
words, we express "what is conditional" in the QAPI language, but resort
to the C language for expressing the actual conditionals.

PRO:
* Supports arbitrary #if.
* QAPI language impact is light: just another (string-valued) property
  of definitions and members.
* Generated code is the same regardless of QEMU configuration.

CON:
* Generating anything but C is problematic.  Currently that's just
  documentation.  Having C conditionals there isn't exactly great, but
  tolerable.

>>>> In other words, the language I have in mind would be something
>>>> that I could auto-generate from, say, the current qapi-schema.json
>>>> and the qemu-options.def. Maybe in the end, that would be simply
>>>> by having qemu-options.def being used to build qemu-options.json,
>>>> and then add the relevant entries in qemu-options.json. Maybe
>>>> there is a better way.
>>>=20
>>> I would rather say that .def should go away and its content should
>>> be converted to a JSON schema that becomes the new source format rather
>>> than an intermediate generated file. There is nothing in .def files tha=
t
>>> couldn't be represented in the schema.
>>=20
>> Yes.
>
> Agreed too. The meta-schema would need to be extended.
>
>>>=20
>>> To a certain degree, QAPI does just that, by supporting different data
>>> types for options. If necessary, I'm sure the type system could be
>>> extended, but it's not clear to me to which degree we actually need
>>> this.
>>=20
>> QAPI is much more expressive than qemu-options.hx.  All the latter can
>> do is "has option argument" and "option is arch-specific".  QAPI lets
>> you specify an option argument's structure, and supports compile-time
>> conditionals.  It can't do things like "must specify either argument A
>> or B", or "numeric argument C must not exceed argument D", or "multiple
>> options combine vs. last one wins".  Mostly because "it=E2=80=99s alread=
y
>> complicated enough as is".
>
> Understood.
>
>
>>>=20
>>> We could. But is it actually worth inventing a new programming language=
?
>>> I think this is something that should be done in C code even in the
>>> future. I think what we're looking for is a way to describe interfaces,
>>> not implementations.
>>=20
>> Sane sugar can be described declaratively as macro expansion.
>>=20
>> Less than sane sugar takes code.
>>=20
>> Desugaring in code promotes (accidental) abandonment of sanity.
>>=20
>> That said, we have to keep things simple to succeed.  Declarative
>> desugaring seems beyond our reach.
>
> Well, =E2=80=9Ckeeping things simple=E2=80=9D is a complicated thing.

True!

>>> Even just for adding more sophisticated constraints, like in the exampl=
e
>>> above that maxmem >=3D size, it's questionable whether doing this in th=
e
>>> schema provides enough value for actually implementing it there.
>>=20
>> Yes.
>
> If we do it, yes. If we delegate to an existing language (I showed C abov=
e),
> maybe it adds clarity without too much of an additional cost.

Possible.

>>>>> I think the only thing in this list that can't obviously be covered
>>>>> easily by QAPI is QOM. Or rather, it's covered by passing through
>>>>> key=3Dvalue lists without describing their structure
>>>>=20
>>>> That=E2=80=99s close enough to me. (In my mind, that part was already =
=E2=80=9Cdone=E2=80=9D
>>>> by QAPI, even if in the convoluted way you describe)
>>>=20
>>> That's not really close enough. If you are happy with this level of
>>> abstraction, you can define any command line option to be either a flag
>>> or take a string as its argument and be done. This is obviously not ver=
y
>>> helpful because it says nothing about the structure of that string.
>>=20
>> Similar to all QMP commands taking a single 'any' argument.
>
> Hmmm, I guess I have not understood what you meant by
> "QOM could not be covered easily by QAPI" then.

I think Kevin's point is that QAPI can't fully describe QOM.

Let's talk specifics.  Here's how QAPI defines blockdev-add:

    { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
    { 'union': 'BlockdevOptions',
      'base': { 'driver': 'BlockdevDriver',
                [...]
                '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
      'discriminator': 'driver',
      'data': {
          'blkdebug':   'BlockdevOptionsBlkdebug',
          'blklogwrites':'BlockdevOptionsBlklogwrites',
          [...]
          'vxhs':       'BlockdevOptionsVxHS'
      } }
    { 'enum': 'BlockdevDriver',
      'data': [ 'blkdebug', 'blklogwrites', [...], 'vxhs' ] }

QAPI specifies the available blockdev object types and their properties,
with types.

Compare object-add:

    { 'command': 'object-add',
      'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }

QAPI specifies neither the available QOM object types, nor their
properties.  Consequently, QAPI/QMP introspection tells you nothing
about them.  You need to use QOM introspection instead.  qom-list-types
shows what QOM object types are available, and qom-list-properties shows
an object type's properties.  Except for dynamic ones created only after
object creation).  With undocumented type name strings instead of types.

> We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
> be modified, do we?

We already do: QMP command qom-set.  If it breaks your guest, you get to
keep the pieces.

> As for the =E2=80=9Cpublic=E2=80=9D aspects of a QOM object, that is stat=
ic if it
> comes from QAPI, so why couldn=E2=80=99t we define it there?

QAPI specifies a certain kind of data types.

QOM "specifies" data types as an imperative program for creating them.
Maximally flexible, and fundamentally at odds with static analysis.
I've hated this since day one.

There's no hard reason why QOM could not specify static aspects
declaratively.  It just doesn't, and changing it now would be a
monumental task.

The imperative program mostly creates identical data types every time.
In other words, the data types are static.  Two problems.  One,
converting such a program to an equivalent declaration takes manual
labor.  Two, there are exceptions, and identifying them is more manual
labor.

>>> the same way, QAPI can't say anything about the structure of a QOM
>>> object, and I think that's a problem.
>>>=20
>>>>> - which, as far as I
>>>>> understand, is mainly because QOM properties aren't necessarily stati=
c,
>>>>> so we can't provide a statically defined interface for them. Probably
>>>>> solvable in QEMU, but not without a major effort.
>>>>=20
>>>> Or maybe extend the language so that it=E2=80=99s internal semantics
>>>> knows about this aspect of QOM?
>>>=20
>>> My point is that for example you can't generate a C struct (which is
>>> statically defined) from something that has a dynamic structure. The
>>> best you could do is fall back to key=3Dvalue even in the C source, bot=
h
>>> key and value being strings. But then you still have to parse these
>>> strings manually, so it doesn't actually help much compared to a state
>>> without C bindings.
>
> I really don=E2=80=99t understand that point. To me, all these operations
> seem relatively simple to generate.

Yes, if the QAPI fairy gives us a declarative specification equivalent
to the existing imperative one, then replacing the hand-written
imperative code by code generated from the declarative specification
would be relatively simple.

> I think that what confuses me is when you write =E2=80=9Csomething that h=
as a
> dynamic structure=E2=80=9D. I understand that as referring to the structu=
re
> defined in the schema. But the schema itself is static. So you can
> generate static code from it, and it=E2=80=99s already done today.

QAPI data types are static.

QOM types are not.  They're effectively almost static in practice.

> Another hypothesis on my side is that we don=E2=80=99t want, ever, to
> have the API provide for example the option to create its own
> arbitrary QOM classes, or to tag arbitrary properties to an object,
> where by =E2=80=9Carbitrary=E2=80=9D I mean not explicitly mentioned some=
where in
> something like the schema.
>
> So I suspect you are talking about something else.

Kevin's talking about the imperative code creating different QOM
properties depending on how and in what context it is run.

QOM is perfectly capable of supporting a QMP command to add arbitrary
QOM properties to an object at run time, or even add arbitrary QOM
types, but as you wrote we don't want that.

>> QOM and QAPI sabotage each other.  Ironic, considering they were dreamed
>> up by the same guy :)
>>=20
>> QAPI is compile-time static by design.
>>=20
>> QOM is run-time dynamic by design.  Some support for static definitions
>> has been grafted on since.
>>=20
>> We use QAPI type system escapes for QOM.  Defeats QAPI introspection and
>> doc generation.  We provide separate QOM introspection instead, which is
>> clumsier and less expressive.  QOM documentation doesn't exist.
>
> But back to the original discussion about management tools,
> do we let upper layers tag their own arbitrary stuff in QOM objects?

We don't want management applications to add QOM properties for their
own purposes.

>>> Maybe what could be done is covering at least the static properties and
>>> then having key=3Dvalue for the dynamic part (which should be the
>>> exception).
>>=20
>> To make this worthwhile, we'd have to replace dynamic QOM properties by
>> static ones when possible.  Monumental task.
>
> I=E2=80=99m sure you are right, but it=E2=80=99s hard for me to evaluate,=
 given how
> many ways there are to access an object. Naively, grepping for
> set_prop and for new_with_prop does not give me that many hits.

Look for object_property_add*().  Some 450 hits.

See also object_class_property_add(), grafted on in

commit 16bf7f522a2ff68993f80631ed86254c71eaf5d4
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Tue Oct 13 13:37:46 2015 +0100

    qom: Allow properties to be registered against classes
   =20
    When there are many instances of a given class, registering
    properties against the instance is wasteful of resources. The
    majority of objects have a statically defined list of possible
    properties, so most of the properties are easily registerable
    against the class. Only those properties which are conditionally
    registered at runtime need be recorded against the klass.
   =20
    Registering properties against classes also makes it possible
    to provide static introspection of QOM - currently introspection
    is only possible after creating an instance of a class, which
    severely limits its usefulness.
   =20
    This impl only supports simple scalar properties. It does not
    attempt to allow child object / link object properties against
    the class. There are ways to support those too, but it would
    make this patch more complicated, so it is left as an exercise
    for the future.
   =20
    There is no equivalent to object_property_del() provided, since
    classes must be immutable once they are defined.
   =20
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

>>>>>> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=
=80=9Cderives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
>>>>>> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=
=9Cattaches to=E2=80=9D=E2=80=A6
>>>>>> - States, e.g. how do we represent the machine configuration,
>>>>>> or the desired new disk setting
>>>>>> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconne=
ct=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
>>>>>> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we d=
escribe the kind of input they need.
>>>>>> - Possibly more subtle things like support for transactions, commit/=
rollback,
>>>>>> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, b=
ut if anything
>>>>>> along the way fails, I=E2=80=99d like all the cleanup to happen auto=
matically)
>>>>>=20
>>>>> This sounds like a different approach from our current QAPI command s=
et
>>>>=20
>>>> Well, except for purposefully trying to use a different wording to avo=
id
>>>> the risk of getting your mind stuck in one of the particular existing
>>>> meta-languages in QEMU, the approach is not very different.
>>>=20
>>> I didn't necessarily mean relations/state/verbs, which obviously exist,
>>> but the examples that seemed to express things in a deliberately
>>> different way from what we have today.
>>>=20
>>>> - Transactions do not exist today that I know of, although we see
>>>> signs of them in discussions about the fact that this options destroys
>>>> that back end but that option does not.
>>>=20
>>> We have a 'transaction' QMP command, but they are not an integral part
>>> of the language. Considering the trouble to implement transactional
>>> commands, I suppose we don't even want it to be a fundamental part of
>>> the language.
>>>=20
>>>>> Does it actually provide more functionality, though?
>>>>=20
>>>> It=E2=80=99s not intended to provide more, but to require less to do t=
he same thing.
>>>=20
>>> Though we always need to keep in mind that if requiring less for future
>>> additions requires a huge effort now, the investment may pay off only i=
n
>>> a very distant future (if the abstraction we build even survives until
>>> then).
>>=20
>> Worse is better.
>>=20
>> http://dreamsongs.com/RiseOfWorseIsBetter.html
>
> You know that I positively hate this ;-)

It's been a tough lesson for me, too.

> Well, I guess we can expand the schema. #ILoveJSON.

Basing the QAPI language on JSON was a poor choice.  Not sure that's
fixable at a reasonable cost.


