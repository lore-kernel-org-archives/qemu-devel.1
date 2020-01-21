Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBEC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF46217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBT4Ud5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF46217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsHT-0003jx-Ax
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1itsGY-0003HE-Ll
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1itsGU-0006Pq-Rl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:04:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1itsGU-0006PA-Lc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:04:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id g17so2919306wro.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 04:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k1TkXyfFViHdG9bbAz7j/Li+NHk2pk6ubWkrZ+AedF8=;
 b=VBT4Ud5nETzs8nm8Z/tUhgSY7txeJSBz3NXY7SpfEUtMYFWBRakN8oCgii7mXWzFV2
 HEm4xiVQwAUXvTcrPr/qDCBL5pYf0n1p0qLYNy+Iv4vAZgr3wQafOTlrHnty4C5ucYLq
 knP/+BbQ7S34ppm4Osigvq/uZ5H8wRJI/ImupCVSKjgOmxYjdzqsGT/vfm4XFL67WiHm
 GhJzqMeqzOoi5Ygi4yg0Mc3ezW0EZG6Pk2kWzdSIZFlmAnNFHpKFnT84B2gV0h9z7phQ
 Y45iNWwgx9wkt8X5Hwv5hQI0Ad+wFIDv7LACN7zhU8NsSNJKXxFDKl4rq6oV/Pc7keF4
 lpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k1TkXyfFViHdG9bbAz7j/Li+NHk2pk6ubWkrZ+AedF8=;
 b=hXBcowGAkN+KChJVdNS3CpDr+tjbKRJgFF4kzD8c+fmgULmagMIaBlBJBx3JHqocJz
 XgBibPfzV/MCK6pwau8ME1xwhU5V2eG4gH0dc3Kj4JCHhGl7ZJzXtoX+51tV08CfkcLE
 sfCNGfyGJDJbHzSlThToZknWv2/E3YZQzOofh/ggcBrKNTBhdN6Blvn9sICumlERC+4g
 JJnZohMdOpSZb8z/8HGYt393FkFa79je2w8wYSH9+hm+50SMl4lde/nwEzVfEY4+XoQZ
 evC58kJClo082zyfEA3atruHyHjeBRdc+Te4XHJ2lBvC66qU4ksaRsELaIgL+X+hFMYQ
 UY5Q==
X-Gm-Message-State: APjAAAUHEkEL88bEQdVRpeXcHzsbPqE3hSmg+l2pxiLU/CE5UnsaQgvC
 +5MMTlDR85FDKSnzWZpg3loIO7gT8Zmc7FhYGZg=
X-Google-Smtp-Source: APXvYqwGks5ykBLxSLjOO8feLSVBgkOqqcDZV5DC28MBe2zHRCg4Qic+s5gM4x1RfkXXzlQhq/U+352BISGv9A7hokw=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr5097975wrp.2.1579608252918;
 Tue, 21 Jan 2020 04:04:12 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <20200121113224.GD630615@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Jan 2020 16:03:59 +0400
Message-ID: <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jan 21, 2020 at 3:32 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >
> > > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
> > >> Christophe de Dinechin <dinechin@redhat.com> writes:
> > >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> w=
rote:
> > >> * qemuMonitorJSONSetIOThread() uses it to control iothread's propert=
ies
> > >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
> > >>   documented (in qemu-options.hx), their use with qom-set is not.
> > >
> > > I'm happy to use a different interface.
> > >
> > > Writing a boilerplate "iothread-set-poll-params" QMP command in C wou=
ld
> > > be a step backwards.
> >
> > No argument.
> >
> > > Maybe the QAPI code generator could map something like this:
> > >
> > >   { 'command': 'iothread-set-poll-params',
> > >     'data': {
> > >         'id': 'str',
> > >     '*max-ns': 'uint64',
> > >     '*grow': 'uint64',
> > >     '*shrink': 'uint64'
> > >     },
> > >     'map-to-qom-set': 'IOThread'
> > >   }
> > >
> > > And turn it into QOM accessors on the IOThread object.
> >
> > I think a generic "set this configuration to that value" command is jus=
t
> > fine.  qom-set fails on several counts, though:
> >
> > * Tolerable: qom-set is not actually generic, it applies only to QOM.
> >
> > * qom-set lets you set tons of stuff that is not meant to be changed at
> >   run time.  If it breaks your guest, you get to keep the pieces.
> >
> > * There is virtually no documentation on what can be set to what values=
,
> >   and their semantics.
> >
> > In its current state, QOM is a user interface superfund site.
>
> Thoughts about a solution:
>
> Static QOM properties should be declared via QAPI instead of
> imperatively via QOM APIs.  That way they are introspectable and type
> information is present in the schema.
>
> The QAPI code generator could emit a function that is callable from
> .class_init().  This eliminates the need to manually call
> object_class_property_add().

I have this in mind too. First step is probably to move as much as
possible as class properties. Please review
https://patchew.org/QEMU/20200110153039.1379601-1-marcandre.lureau@redhat.c=
om/,
I have more of this kind of qdev/qom cleanups pending.



--=20
Marc-Andr=C3=A9 Lureau

