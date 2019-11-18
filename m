Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33E222AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftESPiX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33E222AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWmBu-0007Hf-SQ
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iWmAx-000622-CT
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iWmAw-00055c-6N
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:55:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iWmAw-00055M-26
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574103301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wuC6zZgRTcwujJGj51sXk4BJT33h+rRfRk2wdXELLE=;
 b=ftESPiX0C9CxgE0Bil8i5MvhODMovrhs1EDuFtLkY6qcNOxFiyIHlj+Iw8f7ct9YY6594r
 A6bA5J1HXfXubCysFHmjwcEphLN6LBfa71xqgB6CN9lDBQ/MytWG3Qosi41FlAXnqSxXYK
 a3judA5cGJqOSLbQI3QNeYgH9RQdjdo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Hc5APrXTMq6FI_pSV-KEPg-1; Mon, 18 Nov 2019 13:55:00 -0500
Received: by mail-oi1-f199.google.com with SMTP id w20so9203362oie.17
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2wuC6zZgRTcwujJGj51sXk4BJT33h+rRfRk2wdXELLE=;
 b=lJxZbjcBCh87MiEuvgbICn3ihEfs4AZGGsBD6rTT6+p0Ea+nf+JMbP1qhXSpKyjsT4
 dp6MEpxnOY6xyNgwrjnfgZBbEMdmdf/ViVlgqXIMMArzX63zTNDgbI8IY8jcj495MPG1
 5bMqxkMjQD2Og6zwalQ/2NW/sp71oi1QXL2OyBNtTTVa/V9Y7ZJTXkdxxluXxL2HFups
 uKm/fcSsDh7yKzqEYd0foX5s5sWM6whxVeLxpkUxkA7yJWDfF+SFruk0KlOFPgUVMVT+
 xYhQv/bBrcm4lFXXgV13RExKD2k9ckBe801wM4yw90RFYpMPJLKgE0H68s6Pk55NeT7t
 J9Cw==
X-Gm-Message-State: APjAAAVeufrDZyaBXYl6zoo7gpz3USpKw4s6B7tEgtbvMxSS2/QvVy8l
 0jxyA0iG/6VnmQo6IsQL4go96DNQOYouFFoEqJI71kAoynhmIFpHtp/fOpKMsY9yCen1dc7l7S9
 P4GFazXle9En6pT/sm5+JFif9RvL30RM=
X-Received: by 2002:a9d:67ce:: with SMTP id c14mr575267otn.38.1574103299667;
 Mon, 18 Nov 2019 10:54:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+m3Ulvccx90jH6CTULFlaQC9UOEploe9KkG9u7UiA9yeFKuUicNs4koGcxnKFpJzwoNUIqU/SEGoUN5YJY3k=
X-Received: by 2002:a9d:67ce:: with SMTP id c14mr575242otn.38.1574103299298;
 Mon, 18 Nov 2019 10:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-5-marcandre.lureau@redhat.com>
 <CAFEAcA9oV-fHLmh3uJTwJrQW60=HFQmRb_brkRpB5BYYVDqF+g@mail.gmail.com>
In-Reply-To: <CAFEAcA9oV-fHLmh3uJTwJrQW60=HFQmRb_brkRpB5BYYVDqF+g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Nov 2019 22:54:48 +0400
Message-ID: <CAMxuvaxLKUYWjJTY0HN0zyFU-tFQk3_qTtvaQ9S9zDN6Xvg+Bw@mail.gmail.com>
Subject: Re: [PATCH v3 04/33] chardev: generate an internal id when none given
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: Hc5APrXTMq6FI_pSV-KEPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 18, 2019 at 6:12 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Internally, qemu may create chardev without ID. Those will not be
> > looked up with qemu_chr_find(), which prevents using qdev_prop_set_chr(=
).
> >
> > Use id_generate(), to generate an internal name (prefixed with #), so
> > no conflict exist with user-named chardev.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > -Chardev *qemu_chardev_new(const char *id, const char *typename,
> > -                          ChardevBackend *backend,
> > -                          GMainContext *gcontext,
> > -                          Error **errp)
> > +static Chardev *chardev_new(const char *id, const char *typename,
> > +                            ChardevBackend *backend,
> > +                            GMainContext *gcontext,
> > +                            Error **errp)
> >  {
> >      Object *obj;
> >      Chardev *chr =3D NULL;
> > @@ -991,6 +992,21 @@ end:
> >      return chr;
> >  }
> >
> > +Chardev *qemu_chardev_new(const char *id, const char *typename,
> > +                          ChardevBackend *backend,
> > +                          GMainContext *gcontext,
> > +                          Error **errp)
> > +{
> > +    g_autofree char *genid =3D NULL;
> > +
> > +    if (!id) {
> > +        genid =3D id_generate(ID_CHR);
> > +        id =3D genid;
> > +    }
> > +
> > +    return chardev_new(id, typename, backend, gcontext, errp);
> > +}
>
> So presumably the idea is that chardev_new() now must be
> called with a non-NULL id (should it assert() that?),

Not, it can still be called with NULL (mostly for qmp_chardev_change()).

> and qemu_chardev_new() can be called with a NULL id, in
> which case it will create one ?

Right

>
> > +
> >  ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
> >                                 Error **errp)
> >  {
> > @@ -1003,8 +1019,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Ch=
ardevBackend *backend,
> >          return NULL;
> >      }
> >
> > -    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc=
)),
> > -                           backend, NULL, errp);
> > +    chr =3D chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
> > +                      backend, NULL, errp);
> >      if (!chr) {
> >          return NULL;
> >      }
> > @@ -1061,8 +1077,8 @@ ChardevReturn *qmp_chardev_change(const char *id,=
 ChardevBackend *backend,
> >          return NULL;
> >      }
> >
> > -    chr_new =3D qemu_chardev_new(NULL, object_class_get_name(OBJECT_CL=
ASS(cc)),
> > -                               backend, chr->gcontext, errp);
> > +    chr_new =3D chardev_new(NULL, object_class_get_name(OBJECT_CLASS(c=
c)),
> > +                          backend, chr->gcontext, errp);
>
> ...but if that's so, why are we calling chardev_new() here
> and passing a NULL pointer ?

Because it's qmp_chardev_change(), it's a transient state, the id is
set after, and reparenting too. The code could probably be structured
differently.

>
> How many callsites actually pass NULL, anyway? My grep
> seems to show:
>  * this qmp_chardev_change() call
>  * gdbstub.c
>  * hw/bt/hci-csr.c
>  * tests/test-char.c
>
> Maybe we should just make them all pass in ID strings instead ?

Well, in this case, we must be sure it doesn't conflict with user ID
(presumably with # prefix), or duplicate etc. Why not leave it to
id_generate() then?


