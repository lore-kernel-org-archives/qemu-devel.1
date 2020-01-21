Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503CDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D6321569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpy46U0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D6321569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvCj-0004Ew-3u
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1itvC4-0003oY-5C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1itvC2-0002Y8-7h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:11:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:38481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1itvC2-0002Xc-0p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:11:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id u2so3455344wmc.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U723RPDZaZSWopBWJdUHc2C21cX536JMt3CC3+lohb4=;
 b=Jpy46U0LCubcl40Tp7NRZQlxticJJUdUDwmJXsaV6QZ8CBGK4F6xYC6yp+/Jn4u7+L
 Ocr+BHOAJxi18pxzc78UjYUo0BF+zgLz0a5FFqqtLWhlpSg+2FROVB5bZNEFLVK2mTQ6
 HJRMv0EefUudYDTGh8uuRxv553LZyjpuENxp+0UQ0LAJOrJagJ5+eqVis1IuXJ1V730h
 rZHGfReppZio1H236cnUN+2nIvK9IPNJjTy6q8kiyDIgwzAaHT+sAl5VCSeW3sRd0tqN
 FyaFdNod2TAwFCTn11E7aQ+FVUk3HsknM86jChKC0t6i7GKy7ALdHUtxvk6N/8OUL4Nx
 RmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U723RPDZaZSWopBWJdUHc2C21cX536JMt3CC3+lohb4=;
 b=O7qBJ9h5USV+lI80wwh9dOCJP1kKx5KfvM0i+ZX4EeW43v3BWX2CnbsRygFpvZ9xqM
 Bc7nmqW0E+psxWcWSXFk7pgjhge/3ANT0hBcKzNLrsRlN4A1C41aPSHpASgCxEo/bb/N
 96OjCLL0PNzdQpjOJMVqKKWs6UtmawK42BkJM2Bv4lFbbetBoQWEA0JE2A59BTVeClGa
 hLlyDmdmATnh02RJqriqiWeWBX1t5+Mg6lYbl4TvF/4IzfYBaw2QbJ4X8AJ1uqda5r05
 w4/wE89xhz/BqYT9vBl3SPD+YargAqgghrWohuID0EF6sZGdXPYOiEdI5/YOklyPeBnQ
 jhmA==
X-Gm-Message-State: APjAAAWGkQpAqJq12LGFDgHRMq28sWNSAlM3Kmd+X1LU3aCEndbanbJg
 j/fxsnNZHIUTh3Q83QWfefDJRUYByCTt+LWIQ8Q=
X-Google-Smtp-Source: APXvYqxbEo65KRTp3goo5RAGF5+k1HidYpbBHTlht7j+gdqzw9jqJNj7w5FFfyBmHAFvlgg+k+Owa8HPnobyM/6r4os=
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr4969835wma.32.1579619508679; 
 Tue, 21 Jan 2020 07:11:48 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <871rrs97ld.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Jan 2020 19:11:35 +0400
Message-ID: <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jan 21, 2020 at 7:01 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> >> >>
> >> >> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
> >> >> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> >> >
> >> >> > > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wro=
te:
> >> >> > >> Christophe de Dinechin <dinechin@redhat.com> writes:
> >> >> > >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.=
com> wrote:
> >> >> > >> * qemuMonitorJSONSetIOThread() uses it to control iothread's p=
roperties
> >> >> > >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object=
 is
> >> >> > >>   documented (in qemu-options.hx), their use with qom-set is n=
ot.
> >> >> > >
> >> >> > > I'm happy to use a different interface.
> >> >> > >
> >> >> > > Writing a boilerplate "iothread-set-poll-params" QMP command in=
 C would
> >> >> > > be a step backwards.
> >> >> >
> >> >> > No argument.
> >> >> >
> >> >> > > Maybe the QAPI code generator could map something like this:
> >> >> > >
> >> >> > >   { 'command': 'iothread-set-poll-params',
> >> >> > >     'data': {
> >> >> > >         'id': 'str',
> >> >> > >     '*max-ns': 'uint64',
> >> >> > >     '*grow': 'uint64',
> >> >> > >     '*shrink': 'uint64'
> >> >> > >     },
> >> >> > >     'map-to-qom-set': 'IOThread'
> >> >> > >   }
> >> >> > >
> >> >> > > And turn it into QOM accessors on the IOThread object.
> >> >> >
> >> >> > I think a generic "set this configuration to that value" command =
is just
> >> >> > fine.  qom-set fails on several counts, though:
> >> >> >
> >> >> > * Tolerable: qom-set is not actually generic, it applies only to =
QOM.
> >> >> >
> >> >> > * qom-set lets you set tons of stuff that is not meant to be chan=
ged at
> >> >> >   run time.  If it breaks your guest, you get to keep the pieces.
> >> >> >
> >> >> > * There is virtually no documentation on what can be set to what =
values,
> >> >> >   and their semantics.
> >> >> >
> >> >> > In its current state, QOM is a user interface superfund site.
> >> >>
> >> >> Thoughts about a solution:
> >> >>
> >> >> Static QOM properties should be declared via QAPI instead of
> >> >> imperatively via QOM APIs.  That way they are introspectable and ty=
pe
> >> >> information is present in the schema.
> >> >>
> >> >> The QAPI code generator could emit a function that is callable from
> >> >> .class_init().  This eliminates the need to manually call
> >> >> object_class_property_add().
> >>
> >> We need to make up our minds what exactly we want generated.  Then we
> >> can design the QAPI language, and code up the generator.
> >>
> >> Skeleton QOM type, to help with the discussion:
> >>
> >>     #define TYPE_FOO "foo"
> >>
> >>     #define FOO(obj) OBJECT_CHECK(Foo, (obj), TYPE_FOO)
> >>     #define FOO_CLASS(klass) \
> >>         OBJECT_CLASS_CHECK(FooClass, (klass), TYPE_FOO)
> >>     #define FOO_GET_CLASS(obj) \
> >>         OBJECT_GET_CLASS(FooClass, (obj), TYPE_FOO)
> >>
> >>     typedef FooClass {
> >>         ParentClass parent_class;
> >>         ... // hand-written per-class state
> >>     }
> >>
> >>     struct Chardev {
> >>         ParentObject parent_obj;
> >>         ... // hand-written instance (per-object) state
> >>     };
> >>
> >>     static const TypeInfo char_type_info =3D {
> >>         .name =3D TYPE_FOO,
> >>         .parent =3D TYPE_OBJECT,
> >>         .instance_size =3D sizeof(Foo),
> >>         .instance_init =3D ...,                   // methods to initia=
lize
> >>         .instance_post_init =3D ...,              // and finalize inst=
ances,
> >>         .instance_finalize =3D ...,               // all optional
> >>         .abstract =3D ...,                        // true or false (d'=
oh)
> >>         .class_size =3D sizeof(FooClass),
> >>         .class_init =3D ...,                      // methods to initia=
lize
> >>         .class_base_init =3D ...,                 // classes, optional
> >>         .class_data =3D ...,                      // extra argument fo=
r them
> >>         .interfaces =3D ...
> >>     };
> >>
> >> There's substantial boilerplate, with plenty of hand-written code in t=
he
> >> gaps.  What of the boilerplate do we plan to generate?  How do we plan
> >> to fill the gaps, if any?
> >
> > FWIW, even without a QOM generator, we can do waaaaaaay better on the
> > amount of boilerplate needed for QOM without very much work. It just
> > needs a few convenience macros writing.
> >
> > QOM is not GObject, but is heavily inspired by it and so looking at
> > GObject gives us a design pattern we can aim to match in terms of
> > amount of boilerplate.
> >
> > What we do manually with TypeInfo struct there has essentially always
> > been done by a 1 line macro in GObject:
> >
> >   G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)
> >
> > If implementing interfaces, there's 1 extra line needed per interface
> > to associate them.
> >
> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DEFINE-TYPE:CAPS
> >
> >
> > And what we do in the header file to add the 4 or more FOO_XXX macros,
> > and the class struct and the object struct has recently been turned
> > into a 2-liner:
> >
> >   #define VIR_TYPE_IDENTITY vir_identity_get_type()
> >   G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObjec=
t);
> >
> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DECLARE-FINAL-TYPE:CAPS
> >
> > Or
> >
> >   #define VIR_TYPE_IDENTITY vir_identity_get_type()
> >   G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GO=
bject);
> >
> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.h=
tml#G-DECLARE-DERIVABLE-TYPE:CAPS
> >
> >
> > It would be nice to have a QOM code generator so that we can statically
> > declare properties & parent/child/interface relationships, but for an
> > immediate low cost win, better macros would be very useful IMHO.
>
> Volunteers?
>

Actually, we are not that far off from being able to use GObject
altogether (I hacked something like that to play with), but I
disgress...

So introducing GObject-like macros? sure!

There are plenty of refactoring to do. The problem when touching the
whole code-base, imho, is review time. It may take a couple of
hours/days to come up with a cocci/spatch, and make various patches
here and there. But it takes often weeks and a lot of constant push to
various folks to get all the reviews (as seens by the qdev prop-ptr
series earlier for example). How can we better address whole code-base
changes?



--=20
Marc-Andr=C3=A9 Lureau

