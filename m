Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94EC35242
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B142077C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEQPKtSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B142077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivHl4-0008Fw-LG
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 04:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivHkM-0007K4-QL
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 04:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivHkH-0005df-7E
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 04:28:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivHkG-0005cb-AI
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 04:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579944526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtNQ9rrYKcknnGHOzccIlXBRzgoWYu7FcEJFt787aWo=;
 b=GEQPKtSNUrD4zgVEAZsbYlwTWn5seDoDzCopUTy6OWLZOrIpAlewEMMgqjVwamHpdij3ul
 NaxjWwhf+HwHA0uiMaYcKbx/EuBT15feRdqwVEI8MCoAS5cn7ataMN6c78KszdvItAUF5N
 XrFkvlNmQRUNnbgfzGq+DGf7wJ+x/GE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-G4L1OpCbODCY8Z1iWFMy6g-1; Sat, 25 Jan 2020 04:28:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so2738242wrm.16
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 01:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=32dqtyR5TBV35DUTqXrUjfhlXbgSaeuZ36JHPNNxpUo=;
 b=tipBFwqRlbx6EAJdGZdd/ViaUagh+SKgk05FRL2RyiW3ZQqCSyT+jKc558eAfUpOqI
 YvsVMZnnEouFmqD8h1W4a9d9WWZJd7YNucK2XYEeSUM/t5vStVHGNVlFfxz1VOge2sXW
 ck8jOmCXkLcE/cjUJaRwvLLJR/b5/Ay+cGT/142yaNZDrwsrfHZQEwNH3+6PfPXvvhNM
 i8OrLZoP7VFbQ2uAN0R2STl5qJcMFDCu2lQhLYqqKAWnOSWBZ3KdwJTgOqjYLQtoaYJw
 0BPepBa3dzuHBGBPhM3wbVxxB66sZ1yQETIinCWEBWCkC0XasMG6Pp9Yhz3nSqSgS2sF
 /RQQ==
X-Gm-Message-State: APjAAAW0USltfhvfIDc1uH+hBLp7sjxXbmBa3tNubXZyv6NX5c4b8Mjr
 dckCXBHkhxA27KxdZWXo+PAgnpFZ/y5EgTnnk5U2zCfmnhnzSA24dUSlhIUbNXsx5u4DiSYHNY9
 LNXbIc+kqxm4VUP8=
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr9114789wrs.424.1579944522721; 
 Sat, 25 Jan 2020 01:28:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwR1Y4GennUua/OAie/sflnQewgnsl0Ybq4QyRyVzPSVigGg/4h2wk6BKNAS7Kjmdnz+U0LKQ==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr9114761wrs.424.1579944522458; 
 Sat, 25 Jan 2020 01:28:42 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d12sm10997779wrp.62.2020.01.25.01.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 01:28:41 -0800 (PST)
Subject: Re: Integrating QOM into QAPI
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
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
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
 <c68f8ffd-dc8a-f282-3195-aa9e8760de7a@redhat.com>
 <CAJ+F1CKukvqb+=q922Eh1HHHFe6nOkLsnCwWamc0303F14QFqQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2da6836-87f3-5d91-b969-198e00317a62@redhat.com>
Date: Sat, 25 Jan 2020 10:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKukvqb+=q922Eh1HHHFe6nOkLsnCwWamc0303F14QFqQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: G4L1OpCbODCY8Z1iWFMy6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/01/20 05:44, Marc-Andr=C3=A9 Lureau wrote:
>     On 22/01/20 13:42, Marc-Andr=C3=A9 Lureau wrote:
>     > From the top of my mind, this is the pain point when trying to use
>     GObject:
>     > - static/inlined object, not supported by GObject, unlikely to ever=
 be
>     > - few users in qemu, transition possible.
>     > - 64k limit of GObject, for some reason, unlikely to change but I w=
ill
>     > take a look. Some users in qemu, code adaptation possible.
>     > - dynamic properties, possible in GObject with hacks, but not
>     > recommended and going to be deprecated from what I remember
>     > - "array" properties - would need extra layer/tweaks for compatibil=
ity
>     > - link properties - would need special handling
>     > - different limitations for type names and properties names
>=20
>     The properties in general are very different between QOM and QAPI.=C2=
=A0 They
>     have different limitations and features as Marc-Andr=C3=A9 mentioned,=
 but an
>     especially important one is the integration with QAPI visitors.=C2=A0=
 This is
>     what allows us to support -object and object-add with the same code, =
and
>     is what separates QOM from GObject the most.
>=20
>     Maybe it would be possible to build an adapter, but having written in
>     the past code that uses GType to do marshalling and unmarshalling, I'=
m
>     not really fond of repeating the experience...
>=20
> I agree it is one of the things that look very different from gobject.
> At the same time, I think defining conventions/types or interface to
> describe hierarchy isn't so difficult, and then adapting the visitors
> shouldn't be either.

Note that there are a few "structured" properties that export a QAPI
struct rather than a scalar.  Those would be a bit more complex.  Links
might also be tricky.

Another small difference that came to mind is the different object
liveness model; GObject is mostly plain old reference counting (plus the
"floating reference" idea), while in QOM reference counting is secondary
and lifetime is mostly dictated by the object tree and "unparenting".
This is more of a conceptual difference; it could be easily retrofitted
in GObject.

> I try to find a good reason qom was chosen over gobject, and I can't
> find it.

The main reasons were integration with QAPI, and the object tree.
Though everything I say here is a kind of reverse engineering of
Anthony's brain because there aren't really any design documents besides
what's in include/qom/object.h (and he overlooked some aspects, for
example "unparent" was introduced a few months later).

Overall I don't think there would be much benefit in reusing GObject.
It's about 3k lines of code, quite a few would stay (those implementing
the tree) and a bunch more would have to be rewritten.  I don't think
we'd have any use for most of the features that QOM lacks, such as
signals.  Also, QOM is quite well documented and we should include its
documentation in docs/devel instead.

That said, coccinell-ing efforts on QOM code are definitely a good idea
since it's quite mature now and we know better what we need.  And there
are practical advantages too, it's not just code cleanups---see how your
series shows the default value of the properties in -device foo,help.

Paolo


