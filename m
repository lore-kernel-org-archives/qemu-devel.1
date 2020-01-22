Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24087C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA965205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxOwBFQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA965205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDbi-0003nK-1C
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDan-0003I6-Nk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDal-0008Af-KR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:50:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuDal-00089l-CX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:50:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id b6so6768525wrq.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=70xTOGX+uoohi9KmNwuvSO8+VpG1D7iiBrsZBql4ct8=;
 b=XxOwBFQ1x9CQrXrF2kmUAvmfhA3vhbJWgtSA/jPVfnXaAycYDeq/sxmpt6eVYEFjJw
 1jPQBaHDu4Xa9tRM9Ja8kfcbVMIMxio2A7YQOg1bnTm0Agngh6+lwGveUpSA18XB2Gzu
 kr7NZLgcq/m7Gt2YVbaPFLA7qm/1mMreSMIZ6RK2z5WTJJAV+9q8s6oSkMikk9+thY35
 rUFINEkxJNadNYcbzKqkEtCVreVxCHUfSGMGTizsBfHdyraTWLofJOt2ukBpSNmSypjS
 LNEzhwnFcEY5cyJOBk8CRMIW7tFB5k5Sq/vimwANMEx03gh2DVaBOXKMMWCtb8/CfRhv
 /3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=70xTOGX+uoohi9KmNwuvSO8+VpG1D7iiBrsZBql4ct8=;
 b=oer+gMB6TXjrIbVqJJG1Qm4sDv4D+/oWHbNEbvt0FDUwHwXxNFN/XtN6thKUdeX0LI
 3pJll7FuaM06WRyF6/yDBvjCT1Y0PUlL3GO6Q2NmQBTQ5yPRlYtGzWDe5i0ekITIUFjh
 0+VPRqmGiMyg1qfJDIbioHFtNqzFAm/uEOdZF0SvZcJ3qG1/1GOPTvsKRGgNSnJDhVgb
 hT4fzFl7p6WW6Rv8j+V5Lhmmd6Bt6kHZlF07SocGjMqn+nhIvUP8njYyWyl2yB9nLdbL
 Za7Efyt+lFooFVLvHUR3yzszonfJf79sZ7YjrtRsWHwqbqsVbmIEhhrs/YwqTEjG8ySA
 chWw==
X-Gm-Message-State: APjAAAXiwMriwWmd2ke2hg6qYk1cjbFx8OhMl5wHHRWVGi/L6L4koilj
 cdWyZQayd2jYQT9PKPz4gBsrAQ==
X-Google-Smtp-Source: APXvYqwCWnS4Wum/WDE/fDuUYjzVUcAIHy43C1gGeDcFAleEF2dpSqPoGHPxMpX5qVux28QizZl/Kg==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr10108643wrq.37.1579690233330; 
 Wed, 22 Jan 2020 02:50:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x16sm3387641wmk.35.2020.01.22.02.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:50:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F90A1FF87;
 Wed, 22 Jan 2020 10:50:31 +0000 (GMT)
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
 <20200121143658.GB597037@redhat.com> <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: Integrating QOM into QAPI
In-reply-to: <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
Date: Wed, 22 Jan 2020 10:50:31 +0000
Message-ID: <87y2tzzrwo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jan 21, 2020 at 7:01 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > On Tue, Jan 21, 2020 at 02:36:17PM +0100, Markus Armbruster wrote:
<snip>
>> >>     static const TypeInfo char_type_info =3D {
>> >>         .name =3D TYPE_FOO,
>> >>         .parent =3D TYPE_OBJECT,
>> >>         .instance_size =3D sizeof(Foo),
>> >>         .instance_init =3D ...,                   // methods to initi=
alize
>> >>         .instance_post_init =3D ...,              // and finalize ins=
tances,
>> >>         .instance_finalize =3D ...,               // all optional
>> >>         .abstract =3D ...,                        // true or false (d=
'oh)
>> >>         .class_size =3D sizeof(FooClass),
>> >>         .class_init =3D ...,                      // methods to initi=
alize
>> >>         .class_base_init =3D ...,                 // classes, optional
>> >>         .class_data =3D ...,                      // extra argument f=
or them
>> >>         .interfaces =3D ...
>> >>     };
>> >>
>> >> There's substantial boilerplate, with plenty of hand-written code in =
the
>> >> gaps.  What of the boilerplate do we plan to generate?  How do we plan
>> >> to fill the gaps, if any?
>> >
>> > FWIW, even without a QOM generator, we can do waaaaaaay better on the
>> > amount of boilerplate needed for QOM without very much work. It just
>> > needs a few convenience macros writing.
>> >
>> > QOM is not GObject, but is heavily inspired by it and so looking at
>> > GObject gives us a design pattern we can aim to match in terms of
>> > amount of boilerplate.
>> >
>> > What we do manually with TypeInfo struct there has essentially always
>> > been done by a 1 line macro in GObject:
>> >
>> >   G_DEFINE_TYPE(virIdentity, vir_identity, G_TYPE_OBJECT)
>> >
>> > If implementing interfaces, there's 1 extra line needed per interface
>> > to associate them.
>> >
>> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.=
html#G-DEFINE-TYPE:CAPS
>> >
>> >
>> > And what we do in the header file to add the 4 or more FOO_XXX macros,
>> > and the class struct and the object struct has recently been turned
>> > into a 2-liner:
>> >
>> >   #define VIR_TYPE_IDENTITY vir_identity_get_type()
>> >   G_DECLARE_FINAL_TYPE(virIdentity, vir_identity, VIR, IDENTITY, GObje=
ct);
>> >
>> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.=
html#G-DECLARE-FINAL-TYPE:CAPS
>> >
>> > Or
>> >
>> >   #define VIR_TYPE_IDENTITY vir_identity_get_type()
>> >   G_DECLARE_DERIVABLE_TYPE(virIdentity, vir_identity, VIR, IDENTITY, G=
Object);
>> >
>> >   https://developer.gnome.org/gobject/stable/gobject-Type-Information.=
html#G-DECLARE-DERIVABLE-TYPE:CAPS
>> >
>> >
>> > It would be nice to have a QOM code generator so that we can statically
>> > declare properties & parent/child/interface relationships, but for an
>> > immediate low cost win, better macros would be very useful IMHO.
>>
>> Volunteers?
>>
>
> Actually, we are not that far off from being able to use GObject
> altogether (I hacked something like that to play with), but I
> disgress...

As a mostly hands off observer who mainly c&p's QOM code when he has to
I have to ask is this a long term plan?

I've always found having our own hand rolled object system a little
incongruous given we lean heavily on the rest of glib.

> So introducing GObject-like macros? sure!
>
> There are plenty of refactoring to do. The problem when touching the
> whole code-base, imho, is review time. It may take a couple of
> hours/days to come up with a cocci/spatch, and make various patches
> here and there. But it takes often weeks and a lot of constant push to
> various folks to get all the reviews (as seens by the qdev prop-ptr
> series earlier for example). How can we better address whole code-base
> changes?

The problem with review time - especially for QOM - is having domain
knowledge to understand what is happening.

Are we happy that the existing qdev/qmp tests sufficiently exercise
QEMU's object model? Perhaps with a little extra tweaking of the tests
we could dump the object hierarchy and then compare it to the hierarchy
presented after modification. That might make it easier to have
confidence that these large scale but mostly mechanical changes don't
change anything externally visible?

--
Alex Benn=C3=A9e

