Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA06206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGudjeIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA06206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiyj-0002qn-L4
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ibixi-0002B6-V7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ibixg-0007OO-Ln
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:29:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ibixg-0007O2-Eg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575282587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dRYMmns54KP9jM2E7s+3jTALRNYFs80n7jHgi6SrKU=;
 b=DGudjeIO77PBggdvWbN5SQpq4/V9iKz1C8mNCpQQ1GFyjWE3RUsEIuE56k6gQ4VoETDvWJ
 9PNwZ174HcSQQMkxvRF8nFyPv8GR0lhFc6Dwd0p/E8A+PsBhJit4HY+YoKDZHdw6ux0Px2
 y1dAl61ucV72Ymllil04e4VtAS755y8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-QPjIZsInPKSwfmHRA7FxDA-1; Mon, 02 Dec 2019 05:29:46 -0500
Received: by mail-oi1-f198.google.com with SMTP id z9so1026112oic.19
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 02:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7dRYMmns54KP9jM2E7s+3jTALRNYFs80n7jHgi6SrKU=;
 b=ivudaXBQvBs0ZTctiQgQGebLJBGhfrIVPfkQl/zRDneWKivcW9f3pjSWltkpJpTTtt
 kIuVTly5dHZZ0oECRa9xo5iP2aP/8KpjHd8oguGVCE+zDXUHJl5UXLV3IJ4oB+jAERKG
 140HSXr8zvSCptxsQWYF7FM8CK8wyIkmmN2I8viGZtFu8vJKIdK7XXrC+tXWE574Mk+p
 PzInrBApGpK62bYdHhhYR+CGGnH4VD4GXHqvudtO6Isj4e8nQne9AvDTYekVzzgt80+u
 g5ZHrp6MKTCQwScyMvIZqicaJXBV++ghRkRG1xz8y1x4baUyjueojEzwJnVB1RosMCR3
 WyKg==
X-Gm-Message-State: APjAAAUWREcNg7Jlr6XaUBixUMqrd3H0ADuqmph4lLRYM6eoYNLv/8YF
 xqh3mGBgdmkSKsNdgjJJ+ww/be6edHmLb6Um8vGewJn0io7zyjuKa82ZboTfeD/Liay6IDKf62H
 Fke1ZrnIDztPamcnthPfblu14hwxHUg8=
X-Received: by 2002:aca:cc87:: with SMTP id c129mr11051919oig.13.1575282585398; 
 Mon, 02 Dec 2019 02:29:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcGQzrObTNaNfEVV2EGmC9buEj049zhMnbVE1LVpcbRsk0AynjUNKmfgivbeYJ+1vltCZa35pETOVDwxjxjts=
X-Received: by 2002:aca:cc87:: with SMTP id c129mr11051908oig.13.1575282585159; 
 Mon, 02 Dec 2019 02:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-2-marcandre.lureau@redhat.com>
 <878snvnvx3.fsf@dusky.pond.sub.org>
In-Reply-To: <878snvnvx3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Dec 2019 14:29:34 +0400
Message-ID: <CAMxuvayxJ5RJxZYQ5Zh98ykQ3wfLdMU2Wpq6G8Xg8KeSA=DbyA@mail.gmail.com>
Subject: Re: [PATCH v4 01/37] qdev: remove unused qdev_prop_int64
To: Markus Armbruster <armbru@redhat.com>
X-MC-Unique: QPjIZsInPKSwfmHRA7FxDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Dec 2, 2019 at 9:23 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties.c    | 32 --------------------------------
> >  include/hw/qdev-properties.h |  3 ---
> >  2 files changed, 35 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index ac28890e5a..be4cb01f0b 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -409,31 +409,6 @@ static void set_uint64(Object *obj, Visitor *v, co=
nst char *name,
> >      visit_type_uint64(v, name, ptr, errp);
> >  }
> >
> > -static void get_int64(Object *obj, Visitor *v, const char *name,
> > -                      void *opaque, Error **errp)
> > -{
> > -    DeviceState *dev =3D DEVICE(obj);
> > -    Property *prop =3D opaque;
> > -    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> > -
> > -    visit_type_int64(v, name, ptr, errp);
> > -}
> > -
> > -static void set_int64(Object *obj, Visitor *v, const char *name,
> > -                      void *opaque, Error **errp)
> > -{
> > -    DeviceState *dev =3D DEVICE(obj);
> > -    Property *prop =3D opaque;
> > -    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> > -
> > -    if (dev->realized) {
> > -        qdev_prop_set_after_realize(dev, name, errp);
> > -        return;
> > -    }
> > -
> > -    visit_type_int64(v, name, ptr, errp);
> > -}
> > -
> >  const PropertyInfo qdev_prop_uint64 =3D {
> >      .name  =3D "uint64",
> >      .get   =3D get_uint64,
> > @@ -441,13 +416,6 @@ const PropertyInfo qdev_prop_uint64 =3D {
> >      .set_default_value =3D set_default_value_uint,
> >  };
> >
> > -const PropertyInfo qdev_prop_int64 =3D {
> > -    .name  =3D "int64",
> > -    .get   =3D get_int64,
> > -    .set   =3D set_int64,
> > -    .set_default_value =3D set_default_value_int,
> > -};
> > -
> >  /* --- string --- */
> >
> >  static void release_string(Object *obj, const char *name, void *opaque=
)
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> > index c6a8cb5516..690ff07ae2 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -13,7 +13,6 @@ extern const PropertyInfo qdev_prop_uint16;
> >  extern const PropertyInfo qdev_prop_uint32;
> >  extern const PropertyInfo qdev_prop_int32;
> >  extern const PropertyInfo qdev_prop_uint64;
> > -extern const PropertyInfo qdev_prop_int64;
> >  extern const PropertyInfo qdev_prop_size;
> >  extern const PropertyInfo qdev_prop_string;
> >  extern const PropertyInfo qdev_prop_chr;
> > @@ -164,8 +163,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width=
;
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
> >  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
> >      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> > -#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
> >  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
> >      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> >  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>
> History of its use:
>
>     Author: Peter Xu <peterx@redhat.com>
>     Date:   Tue Jul 18 11:39:01 2017 +0800
>
>         qdev: provide DEFINE_PROP_INT64()
>
>         We have nearly all the stuff, but this one is missing. Add it in.
>
>         Am going to use this new helper for MigrationParameters fields, s=
ince
>         most of them are int64_t.
>
>         CC: Markus Armbruster <armbru@redhat.com>
>         CC: Eduardo Habkost <ehabkost@redhat.com>
>         CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>         CC: Peter Xu <peterx@redhat.com>
>         CC: Juan Quintela <quintela@redhat.com>
>         CC: Marcel Apfelbaum <marcel@redhat.com>
>         CC: Eric Blake <eblake@redhat.com>
>         Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>         Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>         Reviewed-by: Juan Quintela <quintela@redhat.com>
>         Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>         Signed-off-by: Peter Xu <peterx@redhat.com>
>         Message-Id: <1500349150-13240-2-git-send-email-peterx@redhat.com>
>         Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>     commit 89632fafdc64927647b6f45416307cd3d4c746db
>     Author: Peter Xu <peterx@redhat.com>
>     Date:   Tue Jul 18 11:39:02 2017 +0800
>
>         migration: export parameters to props
>
>         Export migration parameters to qdev properties. Then we can use, =
for
>         example:
>
>           -global migration.x-cpu-throttle-initial=3Dxxx
>
>         To specify migration parameters during init.
>
>         Prefix "x-" is appended for each parameter exported to show that =
this is
>         not a stable interface, and only for debugging/testing purpose.
>
>         Reviewed-by: Juan Quintela <quintela@redhat.com>
>         Signed-off-by: Peter Xu <peterx@redhat.com>
>         Message-Id: <1500349150-13240-3-git-send-email-peterx@redhat.com>
>         Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>     [More commits adding uses...]
>
>     commit 741d4086c856320807a2575389d7c0505578270b
>     Author: Juan Quintela <quintela@redhat.com>
>     Date:   Fri Dec 1 13:08:38 2017 +0100
>
>         migration: Use proper types in json
>
>         We use int for everything (int64_t), and then we check that value=
 is
>         between 0 and 255.  Change it to the valid types.
>
>         This change only happens for HMP.  QMP always use bytes and simil=
ar.
>
>         Signed-off-by: Juan Quintela <quintela@redhat.com>
>         Reviewed-by: Eric Blake <eblake@redhat.com>
>
>     [All uses gone again]
>
> We can remove it now, and revert the removal when new uses pop up.
> Churn.  I'd say remove if we think new uses are unlikely.  I doubt they
> are.
>

Oh, somehow I missed those users. I thought the code had never been
exercised. Ok, let's keep it for now.


