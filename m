Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A2C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C39924680
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2zOg7aB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C39924680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9iW-0005xU-Qk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iw9hX-00050c-Mz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iw9hV-0004xS-TG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iw9hV-0004w5-Og
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580151933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4I6vnOIl8xsfv5K1F23drwF+M2luXQVIl2fRkRJ+4=;
 b=X2zOg7aBW3UV2DyeUuDvgK9r7+Gnd7Lvd82+9YuxbLvHbrGvUoHyeIdB6htCMM0+UqCNXR
 b8czj7JJyz7XbTsnkIeWUNAox3cuv/hgXjw61X7MT+EwWlgiy6QbQJaGVnCG1QYGnmrl0D
 BgQzU9LlwQNKlCOd219K8KhNPwALhZI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-bGn4vEDLOJyAdZotjItu2w-1; Mon, 27 Jan 2020 14:05:26 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so6618244wrt.21
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=kJBufNliXfRJx6OEtgwjB34dp8p5QyEBngBgep/jseo=;
 b=RRbQMjtUGuke7q4Xe+0C5kIx8tSr2FAT0E3jaA4CEMTGRwlUsxV9bie2EQxMQibJ1g
 bmx91DuZ5Loxm741boFgVUAaFIJOQ45Jf3OglW6WK5QJtZXWEArT5qvDrbjIeVl9SiF4
 UbYFcSlb3kFzx4fpCSq7q/hFpJMZ1Ip3H66WX2+dUXTdGrr5x0XGy0+tSa8TtQn0EL0n
 2HBycNl8kAGITrEkTsc3SjBoDBFypxgqO/hxvivKVlH0IISsxISES3dgNHzhzoYbhFsV
 3htSkBF7BNxe7tqIBF5mYAg/ILRU8rnDhz8bg+qVLcaKKJ7TQ/mmMUqnzt66JOQ8Mnb0
 pFUw==
X-Gm-Message-State: APjAAAXBJMEOQWDT8Y/B61vIPUal6+cpudtvU0JBOABJ6knyhri9/xXX
 dzqSh7vo3azHU/lqw7fWjy7RlboenK8L/dt1WAGvt08m/Mwl50mb3iHTt7FEoF6obx/bxtQfUt6
 p5bDExIm+5kITzik=
X-Received: by 2002:adf:8541:: with SMTP id 59mr23560600wrh.307.1580151924808; 
 Mon, 27 Jan 2020 11:05:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOXf7hkRQYpRhinjr2UMUggPMesEepgf9Jm2e11ISGC6mIel2rFGU6P0dn6brsw4IxDD7pJQ==
X-Received: by 2002:adf:8541:: with SMTP id 59mr23560569wrh.307.1580151924441; 
 Mon, 27 Jan 2020 11:05:24 -0800 (PST)
Received: from [10.200.153.205] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id b67sm20388348wmc.38.2020.01.27.11.05.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:05:23 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Integrating QOM into QAPI
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <CAJ+F1CL_nREHOyh4YffWwbES+wgq8tZTkd4n8Vf568b+hbzgDQ@mail.gmail.com>
Date: Mon, 27 Jan 2020 20:05:23 +0100
Message-Id: <24B41D90-0F94-422C-AE90-142AD21EFBD0@redhat.com>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAJ+F1CL_nREHOyh4YffWwbES+wgq8tZTkd4n8Vf568b+hbzgDQ@mail.gmail.com>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: bGn4vEDLOJyAdZotjItu2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 26 Jan 2020, at 10:11, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com> wrote:
>=20
> Hi
>=20
> On Sun, Jan 26, 2020 at 9:10 AM Christophe de Dinechin
> <dinechin@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 21 Jan 2020, at 16:11, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com> wrote:
>>>=20
>>> Hi
>>>=20
>>> On Tue, Jan 21, 2020 at 7:01 PM Markus Armbruster <armbru@redhat.com> w=
rote:
>>>>=20
>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>=20
>>>>> On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
>>>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>>>>>=20
>>>>>>> Hi
>>>>>>>=20
>>>>>>> On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>>>>>>>>=20
>>>>>>>> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
>>>>>>>>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>>>>>>>>=20
>>>>>>>>>> On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrot=
e:
>>>>>>>>>>> Christophe de Dinechin <dinechin@redhat.com> writes:
>>>>>>>>>>>>> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.co=
m> wrote:
>>>>>>>>>>> * qemuMonitorJSONSetIOThread() uses it to control iothread's pr=
operties
>>>>>>>>>>> poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>>>>>>>>>>> documented (in qemu-options.hx), their use with qom-set is not.
>>>>>>>>>>=20
>>>>>>>>>> I'm happy to use a different interface.
>>>>>>>>>>=20
>>>>>>>>>> Writing a boilerplate "iothread-set-poll-params" QMP command in =
C would
>>>>>>>>>> be a step backwards.
>>>>>>>>>=20
>>>>>>>>> No argument.
>>>>>>>>>=20
>>>>>>>>>> Maybe the QAPI code generator could map something like this:
>>>>>>>>>>=20
>>>>>>>>>> { 'command': 'iothread-set-poll-params',
>>>>>>>>>>   'data': {
>>>>>>>>>>       'id': 'str',
>>>>>>>>>>   '*max-ns': 'uint64',
>>>>>>>>>>   '*grow': 'uint64',
>>>>>>>>>>   '*shrink': 'uint64'
>>>>>>>>>>   },
>>>>>>>>>>   'map-to-qom-set': 'IOThread'
>>>>>>>>>> }
>>>>>>>>>>=20
>>>>>>>>>> And turn it into QOM accessors on the IOThread object.
>>>>>>>>>=20
>>>>>>>>> I think a generic "set this configuration to that value" command =
is just
>>>>>>>>> fine.  qom-set fails on several counts, though:
>>>>>>>>>=20
>>>>>>>>> * Tolerable: qom-set is not actually generic, it applies only to =
QOM.
>>>>>>>>>=20
>>>>>>>>> * qom-set lets you set tons of stuff that is not meant to be chan=
ged at
>>>>>>>>> run time.  If it breaks your guest, you get to keep the pieces.
>>>>>>>>>=20
>>>>>>>>> * There is virtually no documentation on what can be set to what =
values,
>>>>>>>>> and their semantics.
>>>>>>>>>=20
>>>>>>>>> In its current state, QOM is a user interface superfund site.
>>>>>>>>=20
>>>>>>>> Thoughts about a solution:
>>>>>>>>=20
>>>>>>>> Static QOM properties should be declared via QAPI instead of
>>>>>>>> imperatively via QOM APIs.  That way they are introspectable and t=
ype
>>>>>>>> information is present in the schema.
>>>>>>>>=20
>>>>>>>> The QAPI code generator could emit a function that is callable fro=
m
>>>>>>>> .class_init().  This eliminates the need to manually call
>>>>>>>> object_class_property_add().
>>>>>>=20
>>>>>> We need to make up our minds what exactly we want generated.  Then w=
e
>>>>>> can design the QAPI language, and code up the generator.
>>>>>>=20
>>>>>> Skeleton QOM type, to help with the discussion:
>>>>>>=20
>>>>>>   #define TYPE_FOO "foo"
>>>>>>=20
>>>>>>   #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
>>>>>>   #define FOO_CLASS(klass) \
>>>>>>       OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
>>>>>>   #define FOO_GET_CLASS(obj) \
>>>>>>       OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)
>>>>>>=20
>>>>>>   typedef FooClass {
>>>>>>       ParentClass parent_class;
>>>>>>       ... // hand-written per-class state
>>>>>>   }
>>>>>>=20
>>>>>>   struct Chardev {
>>>>>>       ParentObject parent_obj;
>>>>>>       ... // hand-written instance (per-object) state
>>>>>>   };
>>>>>>=20
>>>>>>   static const TypeInfo char_type_info =3D {
>>>>>>       .name =3D TYPE_FOO,
>>>>>>       .parent =3D TYPE_OBJECT,
>>>>>>       .instance_size =3D sizeof(Foo),
>>>>>>       .instance_init =3D ...,                   // methods to initia=
lize
>>>>>>       .instance_post_init =3D ...,              // and finalize inst=
ances,
>>>>>>       .instance_finalize =3D ...,               // all optional
>>>>>>       .abstract =3D ...,                        // true or false (d'=
oh)
>>>>>>       .class_size =3D sizeof(FooClass),
>>>>>>       .class_init =3D ...,                      // methods to initia=
lize
>>>>>>       .class_base_init =3D ...,                 // classes, optional
>>>>>>       .class_data =3D ...,                      // extra argument fo=
r them
>>>>>>       .interfaces =3D ...
>>>>>>   };
>>>>>>=20
>>>>>> There's substantial boilerplate, with plenty of hand-written code in=
 the
>>>>>> gaps.  What of the boilerplate do we plan to generate?  How do we pl=
an
>>>>>> to fill the gaps, if any?
>>>>>=20
>>>>> FWIW, even without a QOM generator, we can do waaaaaaay better on the
>>>>> amount of boilerplate needed for QOM without very much work. It just
>>>>> needs a few convenience macros writing.
>>>>>=20
>>>>> QOM is not GObject, but is heavily inspired by it and so looking at
>>>>> GObject gives us a design pattern we can aim to match in terms of
>>>>> amount of boilerplate.
>>>>>=20
>>>>> What we do manually with TypeInfo struct there has essentially always
>>>>> been done by a 1 line macro in GObject:
>>>>>=20
>>>>> G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)
>>>>>=20
>>>>> If implementing interfaces, there's 1 extra line needed per interface
>>>>> to associate them.
>>>>>=20
>>>>> https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DEFINE-TYPE:CAPS
>>>>>=20
>>>>>=20
>>>>> And what we do in the header file to add the 4 or more FOO_XXX macros=
,
>>>>> and the class struct and the object struct has recently been turned
>>>>> into a 2-liner:
>>>>>=20
>>>>> #define VIR_TYPE_IDENTITY vir_identity_get_type()
>>>>> G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObjec=
t);
>>>>>=20
>>>>> https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DECLARE-FINAL-TYPE:CAPS
>>>>>=20
>>>>> Or
>>>>>=20
>>>>> #define VIR_TYPE_IDENTITY vir_identity_get_type()
>>>>> G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GO=
bject);
>>>>>=20
>>>>> https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DECLARE-DERIVABLE-TYPE:CAPS
>>>>>=20
>>>>>=20
>>>>> It would be nice to have a QOM code generator so that we can statical=
ly
>>>>> declare properties & parent/child/interface relationships, but for an
>>>>> immediate low cost win, better macros would be very useful IMHO.
>>>>=20
>>>> Volunteers?
>>>>=20
>>>=20
>>> Actually, we are not that far off from being able to use GObject
>>> altogether (I hacked something like that to play with), but I
>>> disgress...
>>>=20
>>> So introducing GObject-like macros? sure!
>>=20
>> I=E2=80=99m still puzzled as to why anybody would switch to something li=
ke
>> GObject when there is C++.
>=20
> C++ is another level of complexity.

Migrating an existing code base to C++ object, I agree.

In the absolute, however, the boilerplate code is clearly
another level of complexity in qom or gobject. And I don=E2=80=99t
think it=E2=80=99s particularly hard to add dynamic properties to a
Object class either, including in a form that would call the
existing C functions.

>=20
> Replacing QOM with GObject would mainly bring us a more solid type
> system with better tooling/features, gobject-introspection support,
> and remove the burden of having our own OO from QEMU code base.

Agree with that.

>=20
> It sufficiently hard for GObject developers to allow writing GObjects
> from Rust, I don't think anyone want to repeat that work for QOM/QDev.
> I don't know how c++ and rust would interoperate, but that seems even
> more complicated to me.

Good point. But C++ has tools to solve that. Please see my response
to Paolo.

>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau


