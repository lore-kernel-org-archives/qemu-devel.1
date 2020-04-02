Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A17C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1E02073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBZH0rn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1E02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0IO-0000IX-NZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jJwU0-0005rh-0F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xadimgnik@gmail.com>) id 1jJwTy-0000yF-Jv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:49:55 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:35355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xadimgnik@gmail.com>) id 1jJwTy-0000xd-D5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:49:54 -0400
Received: by mail-ed1-x52f.google.com with SMTP id a20so3369757edj.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=8BXW3HQ9jIN1PK8/Ynmi2J5s9ajXZ+eaVpPcKxTAcNk=;
 b=nBZH0rn0E81F+R2nez36gvWmYGOU2otGb3GoyXWSHIiUIaFomyPmCPd7IIMzZOfpHZ
 lgZaO63OsuspTtdBhmUMgtUZgdDvAYpNTIYlOp8+WR8dz6UTljWpIqNkM/5CJNbP5SXR
 DEUTwy4kcc00Alfysne0FyLXDreE8pQZ+UCRC0OWv6XwBmeb/ypzoVyrqbQApuDtuDYT
 oHWFNrsUBDciPvrAn1/Mq46L0QTsWISeau508A9XP8g1RX0BFqqxiyOrml6iMYkWCxzf
 /2ubLC4SWwprYT+UJE0c0PrGiM3trIwA3+DkSS1u3uPHQz2v94+uysInvjXaZqX49Flc
 6X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=8BXW3HQ9jIN1PK8/Ynmi2J5s9ajXZ+eaVpPcKxTAcNk=;
 b=hGNzM4hhYB4pqcus8wj4dnKBjJO6CDle5fFDqcQJ5raA/y9XstJVwaORrvmq5OHg5O
 RoxSYgQh9uERLTFFiP5xt7JvKKUZuJHl+A8CWyaXXlbU4Q2cdM1H4fmpdR2szkQ1G4d4
 mSGGlk36nS0Dm7J6awvdlwy5n7AOHQg95cG9s0ouo5KqfzQtg7xUD97+1LRLdCisRbR6
 19AXsjf7zM1UNuvbK8owG+la5jFWweNO+7a85N1ZF95upUZRvNRDVp7OXL9NGNTKwKQM
 L4nN3QMkUKeJh6F4YsAothKaf9M1e20FYK2U1oW5aSPinWrdxkjkXY4t53Pjq96+97ud
 tjAQ==
X-Gm-Message-State: AGi0PuZLuoc2Ud2GOPVsk8kJCN9ThOaraxvC2xZACzRW+9J6a1u1+hox
 y7A2WUqq10ilT6gsqUu2AZM=
X-Google-Smtp-Source: APiQypJOhfeBLGylZMLkCkD7FprWLkParhrlxdKSMnXiT455KLlyVMHvvgdKy8q5UQl8VbbnorBYig==
X-Received: by 2002:aa7:c413:: with SMTP id j19mr2074824edq.100.1585820993093; 
 Thu, 02 Apr 2020 02:49:53 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.186])
 by smtp.gmail.com with ESMTPSA id d20sm851821edn.12.2020.04.02.02.49.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 02:49:52 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 "'Anthony PERARD'" <anthony.perard@citrix.com>, <qemu-devel@nongnu.org>
References: <20190114135154.16826-1-anthony.perard@citrix.com>
 <20190114135154.16826-7-anthony.perard@citrix.com>
 <772fab5a-59ab-050f-9fef-f3b050cfc5cd@redhat.com>
In-Reply-To: <772fab5a-59ab-050f-9fef-f3b050cfc5cd@redhat.com>
Subject: RE: [Qemu-devel] [PULL 06/25] xen: create xenstore areas for
 XenDevice-s
Date: Thu, 2 Apr 2020 10:49:50 +0100
Message-ID: <001001d608d4$0e7b9f40$2b72ddc0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLkG+zb+BC6iV9CP7Z29unUmtxq1wLn4V7uAn6DrKimHjyY8A==
Content-Language: en-gb
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52f
X-Mailman-Approved-At: Thu, 02 Apr 2020 09:52:34 -0400
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
Reply-To: paul@xen.org
Cc: xen-devel@lists.xenproject.org, 'Markus Armbruster' <armbru@redhat.com>,
 'Peter Maydell' <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 01 April 2020 17:14
> To: Anthony PERARD <anthony.perard@citrix.com>; qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org; Peter Maydell =
<peter.maydell@linaro.org>; Paul Durrant
> <paul@xen.org>; Markus Armbruster <armbru@redhat.com>
> Subject: Re: [Qemu-devel] [PULL 06/25] xen: create xenstore areas for =
XenDevice-s
>=20
> Hi Anthony, Paul.
>=20
> Cc'ing Markus too.
>=20
> On 1/14/19 2:51 PM, Anthony PERARD wrote:
> > From: Paul Durrant <paul.durrant@citrix.com>
> >
> > This patch adds a new source module, xen-bus-helper.c, which builds =
on
> > basic libxenstore primitives to provide functions to create (setting
> > permissions appropriately) and destroy xenstore areas, and functions =
to
> > 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
> > these primitives [1] to initialize and destroy the frontend and =
backend
> > areas for a XenDevice during realize and unrealize respectively.
> >
> > The 'xen-block' implementation is extended with a 'get_name' method =
that
> > returns the VBD number. This number is required to 'name' the =
xenstore
> > areas.
> >
> > NOTE: An exit handler is also added to make sure the xenstore areas =
are
> >        cleaned up if QEMU terminates without devices being =
unrealized.
> >
> > [1] The 'scanf' functions are actually not yet needed, but they will =
be
> >      needed by code delivered in subsequent patches.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > ---
> >   hw/block/xen-block.c            |   9 +
> >   hw/xen/Makefile.objs            |   2 +-
> >   hw/xen/trace-events             |  12 +-
> >   hw/xen/xen-bus-helper.c         | 150 +++++++++++++++
> >   hw/xen/xen-bus.c                | 321 =
+++++++++++++++++++++++++++++++-
> >   include/hw/xen/xen-bus-helper.h |  39 ++++
> >   include/hw/xen/xen-bus.h        |  12 ++
> >   7 files changed, 540 insertions(+), 5 deletions(-)
> >   create mode 100644 hw/xen/xen-bus-helper.c
> >   create mode 100644 include/hw/xen/xen-bus-helper.h
> >
> [...]
> > +static void xen_device_exit(Notifier *n, void *data)
> > +{
> > +    XenDevice *xendev =3D container_of(n, XenDevice, exit);
> > +
> > +    xen_device_unrealize(DEVICE(xendev), &error_abort);
> >   }
> >
> >   static void xen_device_realize(DeviceState *dev, Error **errp)
> >   {
> >       XenDevice *xendev =3D XEN_DEVICE(dev);
> >       XenDeviceClass *xendev_class =3D XEN_DEVICE_GET_CLASS(xendev);
> > +    XenBus *xenbus =3D =
XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> >       const char *type =3D object_get_typename(OBJECT(xendev));
> >       Error *local_err =3D NULL;
> >
> > -    trace_xen_device_realize(type);
> > +    if (xendev->frontend_id =3D=3D DOMID_INVALID) {
> > +        xendev->frontend_id =3D xen_domid;
> > +    }
> > +
> > +    if (xendev->frontend_id >=3D DOMID_FIRST_RESERVED) {
> > +        error_setg(errp, "invalid frontend-id");
> > +        goto unrealize;
> > +    }
> > +
> > +    if (!xendev_class->get_name) {
> > +        error_setg(errp, "get_name method not implemented");
> > +        goto unrealize;
> > +    }
> > +
> > +    xendev->name =3D xendev_class->get_name(xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "failed to get device name: ");
> > +        goto unrealize;
> > +    }
> > +
> > +    trace_xen_device_realize(type, xendev->name);
> > +
> > +    xen_device_backend_create(xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto unrealize;
> > +    }
> > +
> > +    xen_device_frontend_create(xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto unrealize;
> > +    }
> >
> >       if (xendev_class->realize) {
> >           xendev_class->realize(xendev, &local_err);
> > @@ -72,18 +364,43 @@ static void xen_device_realize(DeviceState =
*dev, Error **errp)
> >           }
> >       }
> >
> > +    xen_device_backend_printf(xendev, "frontend", "%s",
> > +                              xendev->frontend_path);
> > +    xen_device_backend_printf(xendev, "frontend-id", "%u",
> > +                              xendev->frontend_id);
> > +    xen_device_backend_printf(xendev, "online", "%u", 1);
> > +    xen_device_backend_printf(xendev, "hotplug-status", =
"connected");
> > +
> > +    xen_device_backend_set_state(xendev, XenbusStateInitWait);
> > +
> > +    xen_device_frontend_printf(xendev, "backend", "%s",
> > +                               xendev->backend_path);
> > +    xen_device_frontend_printf(xendev, "backend-id", "%u",
> > +                               xenbus->backend_id);
> > +
> > +    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
> > +
> > +    xendev->exit.notify =3D xen_device_exit;
> > +    qemu_add_exit_notifier(&xendev->exit);
> >       return;
> >
> >   unrealize:
> >       xen_device_unrealize(dev, &error_abort);
>=20
> It seems if unrealize() fails, the error stored in &local_err is never
> reported. Not sure if this can be improved although.

In this case that's essentially a "don't care". We want to know why the =
realize failed but if the unrealize fails something is probably pretty =
seriously screwed (hence the error_abort).

  Paul


