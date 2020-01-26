Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBAC35240
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 08:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7A22071A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 08:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atGuZKy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7A22071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivd0a-00005T-Eq
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 03:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ivczi-0007ko-VT
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 03:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ivczg-0002aK-0z
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 03:10:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ivczf-0002YN-F8
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 03:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580026206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgGGjs6Amj2lKqYaZAaHoJERKkdot2CavTWwbhr5S3I=;
 b=atGuZKy3/pjSKS/2ltm7p7y11KtJGv8eKmbEwNswOBGi2D0H7dqeaNkI43aDi46oY1G/XM
 THeGoJP+egRP7oaI54y/q9YXgiAnR+FmNMVD2aICmEsBon/lm2majEsHzXebPOqlhVg9co
 nkJfIKsRSDhXwb9eVgCw07TLsZMU8j0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-9_R3vjrCN1OhP3Jbxal3Dw-1; Sun, 26 Jan 2020 03:10:00 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so4066914wrs.13
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 00:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=M1JbT/I8DbCy9bieQ7xef6J8WswiWu1+8Gl/prXqvi4=;
 b=ZfTNXZmTSBb0Q/1VBB2ve+tzSLOyNoRk6xeqUcsOStVqOuTBinlGwDhtt/S9PKllf/
 ghCwezgEak/OGtARDroo6J8YA1SGCRAOAYWiaG0k6lk7Jt3RKvr0AeFKC/L/fTcxWXSw
 mRDweD7mLc9NIM0xcx4IUfuZeJiAUDjZXb48i779IHDllwalxae5TmhL6oKkpKjmJJF1
 3uSd/WeK4YBkPpvkd22PwHEblyu4Zj7VuE9xoNW2wDNuBAfe4XWKFpFBdXw++t7qCsqj
 9F47ZfIWWcOU+vecsh5WwEY+hUAmgNEqQb/B/obIWb/yinLlxRq2s6hEAaA36GsUr1LL
 uDNQ==
X-Gm-Message-State: APjAAAUy4ib6X0YfnAmvkWOHqKOj5+ya2zOYBhaxcT+XHIK+o4T0Ujed
 U9vsZLRCN/I7blDbctfNaSHMr91HWagyWiMtdQ+wG6oErM1Em8u9vt2aR8qfYhzyWSKV0v7+4Dx
 cg+Q2QdDs503Gt38=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr13759203wrp.321.1580026199111; 
 Sun, 26 Jan 2020 00:09:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3n2YJUgCtSUDGGqk3kcNDY/j5P0Ognk+bA8U5xUWk88p/cRtxFqq2zRTNOp/RCcWtB5zCRQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr13759156wrp.321.1580026198646; 
 Sun, 26 Jan 2020 00:09:58 -0800 (PST)
Received: from [10.1.251.124] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id m7sm15139735wrr.40.2020.01.26.00.09.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Jan 2020 00:09:57 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Integrating QOM into QAPI
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
Date: Sun, 26 Jan 2020 09:09:56 +0100
Message-Id: <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: 9_R3vjrCN1OhP3Jbxal3Dw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 21 Jan 2020, at 16:11, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com> wrote:
>=20
> Hi
>=20
> On Tue, Jan 21, 2020 at 7:01 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>=20
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>>>=20
>>>>> Hi
>>>>>=20
>>>>> On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>>>>=20
>>>>>> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
>>>>>>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>>>>>>=20
>>>>>>>> On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
>>>>>>>>> Christophe de Dinechin <dinechin@redhat.com> writes:
>>>>>>>>>>> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com>=
 wrote:
>>>>>>>>> * qemuMonitorJSONSetIOThread() uses it to control iothread's prop=
erties
>>>>>>>>>  poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>>>>>>>>>  documented (in qemu-options.hx), their use with qom-set is not.
>>>>>>>>=20
>>>>>>>> I'm happy to use a different interface.
>>>>>>>>=20
>>>>>>>> Writing a boilerplate "iothread-set-poll-params" QMP command in C =
would
>>>>>>>> be a step backwards.
>>>>>>>=20
>>>>>>> No argument.
>>>>>>>=20
>>>>>>>> Maybe the QAPI code generator could map something like this:
>>>>>>>>=20
>>>>>>>>  { 'command': 'iothread-set-poll-params',
>>>>>>>>    'data': {
>>>>>>>>        'id': 'str',
>>>>>>>>    '*max-ns': 'uint64',
>>>>>>>>    '*grow': 'uint64',
>>>>>>>>    '*shrink': 'uint64'
>>>>>>>>    },
>>>>>>>>    'map-to-qom-set': 'IOThread'
>>>>>>>>  }
>>>>>>>>=20
>>>>>>>> And turn it into QOM accessors on the IOThread object.
>>>>>>>=20
>>>>>>> I think a generic "set this configuration to that value" command is=
 just
>>>>>>> fine.  qom-set fails on several counts, though:
>>>>>>>=20
>>>>>>> * Tolerable: qom-set is not actually generic, it applies only to QO=
M.
>>>>>>>=20
>>>>>>> * qom-set lets you set tons of stuff that is not meant to be change=
d at
>>>>>>>  run time.  If it breaks your guest, you get to keep the pieces.
>>>>>>>=20
>>>>>>> * There is virtually no documentation on what can be set to what va=
lues,
>>>>>>>  and their semantics.
>>>>>>>=20
>>>>>>> In its current state, QOM is a user interface superfund site.
>>>>>>=20
>>>>>> Thoughts about a solution:
>>>>>>=20
>>>>>> Static QOM properties should be declared via QAPI instead of
>>>>>> imperatively via QOM APIs.  That way they are introspectable and typ=
e
>>>>>> information is present in the schema.
>>>>>>=20
>>>>>> The QAPI code generator could emit a function that is callable from
>>>>>> .class_init().  This eliminates the need to manually call
>>>>>> object_class_property_add().
>>>>=20
>>>> We need to make up our minds what exactly we want generated.  Then we
>>>> can design the QAPI language, and code up the generator.
>>>>=20
>>>> Skeleton QOM type, to help with the discussion:
>>>>=20
>>>>    #define TYPE_FOO "foo"
>>>>=20
>>>>    #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
>>>>    #define FOO_CLASS(klass) \
>>>>        OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
>>>>    #define FOO_GET_CLASS(obj) \
>>>>        OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)
>>>>=20
>>>>    typedef FooClass {
>>>>        ParentClass parent_class;
>>>>        ... // hand-written per-class state
>>>>    }
>>>>=20
>>>>    struct Chardev {
>>>>        ParentObject parent_obj;
>>>>        ... // hand-written instance (per-object) state
>>>>    };
>>>>=20
>>>>    static const TypeInfo char_type_info =3D {
>>>>        .name =3D TYPE_FOO,
>>>>        .parent =3D TYPE_OBJECT,
>>>>        .instance_size =3D sizeof(Foo),
>>>>        .instance_init =3D ...,                   // methods to initial=
ize
>>>>        .instance_post_init =3D ...,              // and finalize insta=
nces,
>>>>        .instance_finalize =3D ...,               // all optional
>>>>        .abstract =3D ...,                        // true or false (d'o=
h)
>>>>        .class_size =3D sizeof(FooClass),
>>>>        .class_init =3D ...,                      // methods to initial=
ize
>>>>        .class_base_init =3D ...,                 // classes, optional
>>>>        .class_data =3D ...,                      // extra argument for=
 them
>>>>        .interfaces =3D ...
>>>>    };
>>>>=20
>>>> There's substantial boilerplate, with plenty of hand-written code in t=
he
>>>> gaps.  What of the boilerplate do we plan to generate?  How do we plan
>>>> to fill the gaps, if any?
>>>=20
>>> FWIW, even without a QOM generator, we can do waaaaaaay better on the
>>> amount of boilerplate needed for QOM without very much work. It just
>>> needs a few convenience macros writing.
>>>=20
>>> QOM is not GObject, but is heavily inspired by it and so looking at
>>> GObject gives us a design pattern we can aim to match in terms of
>>> amount of boilerplate.
>>>=20
>>> What we do manually with TypeInfo struct there has essentially always
>>> been done by a 1 line macro in GObject:
>>>=20
>>>  G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)
>>>=20
>>> If implementing interfaces, there's 1 extra line needed per interface
>>> to associate them.
>>>=20
>>>  https://developer.gnome.org/gobject/stable/gobject-Type-Information.ht=
ml#G-DEFINE-TYPE:CAPS
>>>=20
>>>=20
>>> And what we do in the header file to add the 4 or more FOO_XXX macros,
>>> and the class struct and the object struct has recently been turned
>>> into a 2-liner:
>>>=20
>>>  #define VIR_TYPE_IDENTITY vir_identity_get_type()
>>>  G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObject=
);
>>>=20
>>>  https://developer.gnome.org/gobject/stable/gobject-Type-Information.ht=
ml#G-DECLARE-FINAL-TYPE:CAPS
>>>=20
>>> Or
>>>=20
>>>  #define VIR_TYPE_IDENTITY vir_identity_get_type()
>>>  G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GOb=
ject);
>>>=20
>>>  https://developer.gnome.org/gobject/stable/gobject-Type-Information.ht=
ml#G-DECLARE-DERIVABLE-TYPE:CAPS
>>>=20
>>>=20
>>> It would be nice to have a QOM code generator so that we can statically
>>> declare properties & parent/child/interface relationships, but for an
>>> immediate low cost win, better macros would be very useful IMHO.
>>=20
>> Volunteers?
>>=20
>=20
> Actually, we are not that far off from being able to use GObject
> altogether (I hacked something like that to play with), but I
> disgress...
>=20
> So introducing GObject-like macros? sure!

I=E2=80=99m still puzzled as to why anybody would switch to something like
GObject when there is C++.

I=E2=80=99m serious.

>=20
> There are plenty of refactoring to do. The problem when touching the
> whole code-base, imho, is review time. It may take a couple of
> hours/days to come up with a cocci/spatch, and make various patches
> here and there. But it takes often weeks and a lot of constant push to
> various folks to get all the reviews (as seens by the qdev prop-ptr
> series earlier for example). How can we better address whole code-base
> changes?
>=20
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
>=20


