Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D748C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7D321569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFMmkU9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7D321569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itv7J-0001Wx-GP
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itv2P-0004xd-SJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itv2K-0003wb-Kb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:01:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itv2K-0003vM-BS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579618907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kBqOx1hRD9kVrL51S+4U7bEpHAJi8NRgt3eDVWDsLY=;
 b=hFMmkU9nxLJf9+909+W71GU/UckJOVB9HLVs3cOU0JgHCEwdxWGoFYyRnU/GFhc2IpqmJS
 CUCIFanwP1myOXZcEVJT/vcZ8SzrPNQEghgznROHEWsMJHRwLjWUxmEbfrIRK4bnB+yHDJ
 LcE+AVnAlL29Rf24A22ZWTQ1l8R55ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-l38tWXEXNzGGvDjxPhN5TA-1; Tue, 21 Jan 2020 10:01:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE3EDB67;
 Tue, 21 Jan 2020 15:01:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD59010016E8;
 Tue, 21 Jan 2020 15:01:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60DED1138600; Tue, 21 Jan 2020 16:01:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Integrating QOM into QAPI
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
 <20200121143658.GB597037@redhat.com>
Date: Tue, 21 Jan 2020 16:01:34 +0100
In-Reply-To: <20200121143658.GB597037@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 21 Jan 2020 14:36:58 +0000")
Message-ID: <871rrs97ld.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: l38tWXEXNzGGvDjxPhN5TA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>=20
>> > Hi
>> >
>> > On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
>> >>
>> >> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
>> >> > Stefan Hajnoczi <stefanha@gmail.com> writes:
>> >> >
>> >> > > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote=
:
>> >> > >> Christophe de Dinechin <dinechin@redhat.com> writes:
>> >> > >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.co=
m> wrote:
>> >> > >> * qemuMonitorJSONSetIOThread() uses it to control iothread's pro=
perties
>> >> > >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object i=
s
>> >> > >>   documented (in qemu-options.hx), their use with qom-set is not=
.
>> >> > >
>> >> > > I'm happy to use a different interface.
>> >> > >
>> >> > > Writing a boilerplate "iothread-set-poll-params" QMP command in C=
 would
>> >> > > be a step backwards.
>> >> >
>> >> > No argument.
>> >> >
>> >> > > Maybe the QAPI code generator could map something like this:
>> >> > >
>> >> > >   { 'command': 'iothread-set-poll-params',
>> >> > >     'data': {
>> >> > >         'id': 'str',
>> >> > >     '*max-ns': 'uint64',
>> >> > >     '*grow': 'uint64',
>> >> > >     '*shrink': 'uint64'
>> >> > >     },
>> >> > >     'map-to-qom-set': 'IOThread'
>> >> > >   }
>> >> > >
>> >> > > And turn it into QOM accessors on the IOThread object.
>> >> >
>> >> > I think a generic "set this configuration to that value" command is=
 just
>> >> > fine.  qom-set fails on several counts, though:
>> >> >
>> >> > * Tolerable: qom-set is not actually generic, it applies only to QO=
M.
>> >> >
>> >> > * qom-set lets you set tons of stuff that is not meant to be change=
d at
>> >> >   run time.  If it breaks your guest, you get to keep the pieces.
>> >> >
>> >> > * There is virtually no documentation on what can be set to what va=
lues,
>> >> >   and their semantics.
>> >> >
>> >> > In its current state, QOM is a user interface superfund site.
>> >>
>> >> Thoughts about a solution:
>> >>
>> >> Static QOM properties should be declared via QAPI instead of
>> >> imperatively via QOM APIs.  That way they are introspectable and type
>> >> information is present in the schema.
>> >>
>> >> The QAPI code generator could emit a function that is callable from
>> >> .class_init().  This eliminates the need to manually call
>> >> object_class_property_add().
>>=20
>> We need to make up our minds what exactly we want generated.  Then we
>> can design the QAPI language, and code up the generator.
>>=20
>> Skeleton QOM type, to help with the discussion:
>>=20
>>     #define TYPE_FOO "foo"
>>=20
>>     #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
>>     #define FOO_CLASS(klass) \
>>         OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
>>     #define FOO_GET_CLASS(obj) \
>>         OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)
>>=20
>>     typedef FooClass {
>>         ParentClass parent_class;
>>         ... // hand-written per-class state
>>     }
>>=20
>>     struct Chardev {
>>         ParentObject parent_obj;
>>         ... // hand-written instance (per-object) state
>>     };
>>=20
>>     static const TypeInfo char_type_info =3D {
>>         .name =3D TYPE_FOO,
>>         .parent =3D TYPE_OBJECT,
>>         .instance_size =3D sizeof(Foo),
>>         .instance_init =3D ...,                   // methods to initiali=
ze
>>         .instance_post_init =3D ...,              // and finalize instan=
ces,
>>         .instance_finalize =3D ...,               // all optional
>>         .abstract =3D ...,                        // true or false (d'oh=
)
>>         .class_size =3D sizeof(FooClass),
>>         .class_init =3D ...,                      // methods to initiali=
ze
>>         .class_base_init =3D ...,                 // classes, optional
>>         .class_data =3D ...,                      // extra argument for =
them
>>         .interfaces =3D ...
>>     };
>>=20
>> There's substantial boilerplate, with plenty of hand-written code in the
>> gaps.  What of the boilerplate do we plan to generate?  How do we plan
>> to fill the gaps, if any?
>
> FWIW, even without a QOM generator, we can do waaaaaaay better on the
> amount of boilerplate needed for QOM without very much work. It just
> needs a few convenience macros writing.
>
> QOM is not GObject, but is heavily inspired by it and so looking at
> GObject gives us a design pattern we can aim to match in terms of
> amount of boilerplate.
>
> What we do manually with TypeInfo struct there has essentially always
> been done by a 1 line macro in GObject:
>
>   G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)
>
> If implementing interfaces, there's 1 extra line needed per interface
> to associate them.
>
>   https://developer.gnome.org/gobject/stable/gobject-Type-Information.htm=
l#G-DEFINE-TYPE:CAPS
>  =20
>
> And what we do in the header file to add the 4 or more FOO_XXX macros,
> and the class struct and the object struct has recently been turned
> into a 2-liner:
>
>   #define VIR_TYPE_IDENTITY vir_identity_get_type()
>   G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObject)=
;
>
>   https://developer.gnome.org/gobject/stable/gobject-Type-Information.htm=
l#G-DECLARE-FINAL-TYPE:CAPS
>
> Or=20
>
>   #define VIR_TYPE_IDENTITY vir_identity_get_type()
>   G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObj=
ect);
>
>   https://developer.gnome.org/gobject/stable/gobject-Type-Information.htm=
l#G-DECLARE-DERIVABLE-TYPE:CAPS
>
>
> It would be nice to have a QOM code generator so that we can statically
> declare properties & parent/child/interface relationships, but for an
> immediate low cost win, better macros would be very useful IMHO.

Volunteers?


