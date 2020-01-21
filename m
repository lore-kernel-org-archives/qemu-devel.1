Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE43C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433AC217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9ZBMktV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituQa-000245-VO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itthn-00076i-Lh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itthj-0001BY-OD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itthh-0001AY-63
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579613784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKFmG+VH3qtK/rSykzfEgRKOqBe5zdCv+opTMiziEwE=;
 b=b9ZBMktVUG+EnuBszIpc9WiPzulVkgqPHa95TIbhuQ2WDXu9CYpqMnKOjZKHkOhJ80ifND
 t5WJ6a09kic34K0WO8LmNuu2r36weKngWp149eQlWSVzUC0vfZC+iBKUfdGS5A6h5eHutv
 fV3FjX8rMPhSQhZR2TNc1O0SZUIqlJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-sBeNYlefNcK2wXTR3NtOKg-1; Tue, 21 Jan 2020 08:36:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0343E107ACC7;
 Tue, 21 Jan 2020 13:36:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A258C60BE0;
 Tue, 21 Jan 2020 13:36:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B5631138600; Tue, 21 Jan 2020 14:36:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Integrating QOM into QAPI (was: Making QEMU easier for management
 tools and applications)
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
Date: Tue, 21 Jan 2020 14:36:17 +0100
In-Reply-To: <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Jan 2020
 16:03:59 +0400")
Message-ID: <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sBeNYlefNcK2wXTR3NtOKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
>>
>> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
>> > Stefan Hajnoczi <stefanha@gmail.com> writes:
>> >
>> > > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
>> > >> Christophe de Dinechin <dinechin@redhat.com> writes:
>> > >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> =
wrote:
>> > >> * qemuMonitorJSONSetIOThread() uses it to control iothread's proper=
ties
>> > >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>> > >>   documented (in qemu-options.hx), their use with qom-set is not.
>> > >
>> > > I'm happy to use a different interface.
>> > >
>> > > Writing a boilerplate "iothread-set-poll-params" QMP command in C wo=
uld
>> > > be a step backwards.
>> >
>> > No argument.
>> >
>> > > Maybe the QAPI code generator could map something like this:
>> > >
>> > >   { 'command': 'iothread-set-poll-params',
>> > >     'data': {
>> > >         'id': 'str',
>> > >     '*max-ns': 'uint64',
>> > >     '*grow': 'uint64',
>> > >     '*shrink': 'uint64'
>> > >     },
>> > >     'map-to-qom-set': 'IOThread'
>> > >   }
>> > >
>> > > And turn it into QOM accessors on the IOThread object.
>> >
>> > I think a generic "set this configuration to that value" command is ju=
st
>> > fine.  qom-set fails on several counts, though:
>> >
>> > * Tolerable: qom-set is not actually generic, it applies only to QOM.
>> >
>> > * qom-set lets you set tons of stuff that is not meant to be changed a=
t
>> >   run time.  If it breaks your guest, you get to keep the pieces.
>> >
>> > * There is virtually no documentation on what can be set to what value=
s,
>> >   and their semantics.
>> >
>> > In its current state, QOM is a user interface superfund site.
>>
>> Thoughts about a solution:
>>
>> Static QOM properties should be declared via QAPI instead of
>> imperatively via QOM APIs.  That way they are introspectable and type
>> information is present in the schema.
>>
>> The QAPI code generator could emit a function that is callable from
>> .class_init().  This eliminates the need to manually call
>> object_class_property_add().

We need to make up our minds what exactly we want generated.  Then we
can design the QAPI language, and code up the generator.

Skeleton QOM type, to help with the discussion:

    #define TYPE_FOO "foo"

    #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
    #define FOO_CLASS(klass) \
        OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
    #define FOO_GET_CLASS(obj) \
        OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)

    typedef FooClass {
        ParentClass parent_class;
        ... // hand-written per-class state
    }

    struct Chardev {
        ParentObject parent_obj;
        ... // hand-written instance (per-object) state
    };

    static const TypeInfo char_type_info =3D {
        .name =3D TYPE_FOO,
        .parent =3D TYPE_OBJECT,
        .instance_size =3D sizeof(Foo),
        .instance_init =3D ...,                   // methods to initialize
        .instance_post_init =3D ...,              // and finalize instances=
,
        .instance_finalize =3D ...,               // all optional
        .abstract =3D ...,                        // true or false (d'oh)
        .class_size =3D sizeof(FooClass),
        .class_init =3D ...,                      // methods to initialize
        .class_base_init =3D ...,                 // classes, optional
        .class_data =3D ...,                      // extra argument for the=
m
        .interfaces =3D ...
    };

There's substantial boilerplate, with plenty of hand-written code in the
gaps.  What of the boilerplate do we plan to generate?  How do we plan
to fill the gaps, if any?

A "property" is always a property of an instance.  It can either be
registered with the instance (with object_property_add() & friends) or
the class (with object_class_property_add() & friends).  Yes, the naming
is confusing.

To have QAPI register properties with the class, it needs to generate
a variation of

    object_class_property_add(cls, prop_name, type_name,
                              get, set, release, opaque, &err)

for each property "somewhere", so it runs within .class_init().  For
real QAPI integration, the property's type must be a QAPI type.  QAPI
needs to generate the callbacks get(), set() and release() then.

Existing properties could conceivably do funny things in their
handwritten callbacks, defying conversion to this scheme.  There's just
one way to find out: attempt to convert all of them.

> I have this in mind too. First step is probably to move as much as
> possible as class properties.

We don't *have* to move "as much as possible" to support such a QAPI
integration, only the ones we want to expose to the user via QAPI.  But
we *want* to, because its an improvement on its own.

>                               Please review
> https://patchew.org/QEMU/20200110153039.1379601-1-marcandre.lureau@redhat=
.com/,
> I have more of this kind of qdev/qom cleanups pending.

Please lend Marc-Andr=C3=A9 a hand whenever this work touches your area of
expertise :)


