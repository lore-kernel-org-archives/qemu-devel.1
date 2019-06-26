Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E2AC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 09:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8746F2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 09:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM4pNdRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8746F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg4YL-0007eb-O5
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 05:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hg4Xe-00074s-AC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 05:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hg4Xc-0002ES-TX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 05:48:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hg4XZ-000296-8K; Wed, 26 Jun 2019 05:48:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so1383802wme.4;
 Wed, 26 Jun 2019 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LjIvz3kv6YIWcRRy1AXBCwQdG7Enx8lhh2xLhdkj9C0=;
 b=SM4pNdRJj+iGFe/8+WJCvK5X12eL0qgJPSXPeGALEO1LRTAG357yrZNU4s0cQ9IfLB
 lAwh8FTNc4HhWrjPekr5RHM8VRHkAqCldOvsFaoC/rAnS5LY88+AC1UbOwnw0gAmor4H
 gsu/3LWOBGb17btYVNF5C8MNmSJYqIdlfr4ARnR3hV/5GnvjRdECl4XPKa11+8zHU+Ex
 qLhgblAeyexzPM5IWyxozV9O1+FBtg8GqrQtXyoQpcyPokjCbDkxgEdRpWE/nqMDoSRl
 NjTMZITlPdKV2tQhmZ4AtouYgfbW8f8ry+q2VHdeOQGkO6inh8wHp2fOeQWu4e3QXGbD
 Blfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LjIvz3kv6YIWcRRy1AXBCwQdG7Enx8lhh2xLhdkj9C0=;
 b=YDUdpOcZCiJlqSAccCCq6tLYIKd16vNVK8xUCdDrDqzeBDHaFkGlwjgfTgIl2wjJAv
 i5EmQ7zqn1b/z32ObP3WAkngUzB1FBii57zlijN11fkfd+fDylLak/abMBkcnqpVKBAG
 KwT7X2Y1fy1UDIF9NLMJ07YfWQvQCbe3N7fUiEYqWG3XUVKScTT70IlZKz2QOJpqywLc
 skFQwHlM5xS0C1dODXEtuagGsmV+lWZU2d6l8lt/wSm55n5BPh8NtLbqgF6YR8wA7sUk
 fBTAkOZPEYB3wAtjLXt1TAe++VyZFGlF9qrLLnaUvx17yI7T0sDdaRVD6+vQn1jb6DfD
 2a2Q==
X-Gm-Message-State: APjAAAXi7v/C+xNfJrLWRrrXHwc412DWe9BAYBXtwvhJ3Uaich7sGNaM
 +yai19aP25Dm+ltlAXqe9tEBM4u1xTOttEFSJBA=
X-Google-Smtp-Source: APXvYqzlpZFpSe3eYUlzfgwLYszA6p3YCQr37Dn5ctxFV441Pxc6vIcVbS86i6K9jczIXw7/5Hm/fPzsyJPEd0wgznc=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr2002171wma.107.1561542511793; 
 Wed, 26 Jun 2019 02:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190625232333.30752-1-marcandre.lureau@redhat.com>
 <20190626015503.GX1862@habkost.net>
In-Reply-To: <20190626015503.GX1862@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Jun 2019 11:48:20 +0200
Message-ID: <CAJ+F1CKWRvuDxNuidWPE6+A7gKmbJ2h9G3DcDDVbd24y1XMYKw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: fix missing device properties
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jun 26, 2019 at 3:56 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Wed, Jun 26, 2019 at 01:23:33AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Since commit a4ee4c8baa37154 ("virtio: Helper for registering virtio
> > device types"), virtio-gpu-pci, virtio-vga, and virtio-crypto-pci lost
> > some properties: "ioeventfd" and "vectors". This may cause various
> > issues, such as failing migration or invalid properties.
> >
> > Since those VirtioPCI devices do not have a base name, their class are
> > initialized with virtio_pci_generic_base_class_init(). However, if the
> > VirtioPCIDeviceTypeInfo provided a class_init which sets dc->props,
> > the properties were overwritten by virtio_pci_generic_class_init().
> >
> > Instead, introduce an intermediary base-type to register the generic
> > properties.
> >
> > Fixes: a4ee4c8baa37154f42b4dc6a13fee79268d15238
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index e6d5467e54..62c4977332 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(Object=
Class *klass, void *data)
> >      dc->props =3D virtio_pci_generic_properties;
> >  }
> >
> > -/* Used when the generic type and the base type is the same */
> > -static void virtio_pci_generic_base_class_init(ObjectClass *klass, voi=
d *data)
> > -{
> > -    virtio_pci_base_class_init(klass, data);
> > -    virtio_pci_generic_class_init(klass, NULL);
> > -}
> > -
> >  static void virtio_pci_transitional_instance_init(Object *obj)
> >  {
> >      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
> > @@ -1938,14 +1931,13 @@ static void virtio_pci_non_transitional_instanc=
e_init(Object *obj)
> >
> >  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
> >  {
> > +    char *base_name =3D NULL;
> >      TypeInfo base_type_info =3D {
> >          .name          =3D t->base_name,
> >          .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
> >          .instance_size =3D t->instance_size,
> >          .instance_init =3D t->instance_init,
> >          .class_size    =3D t->class_size,
> > -        .class_init    =3D virtio_pci_base_class_init,
> > -        .class_data    =3D (void *)t,
> >          .abstract      =3D true,
> >      };
> >      TypeInfo generic_type_info =3D {
> > @@ -1961,13 +1953,20 @@ void virtio_pci_types_register(const VirtioPCID=
eviceTypeInfo *t)
> >
> >      if (!base_type_info.name) {
> >          /* No base type -> register a single generic device type */
> > -        base_type_info.name =3D t->generic_name;
> > -        base_type_info.class_init =3D virtio_pci_generic_base_class_in=
it;
> > -        base_type_info.interfaces =3D generic_type_info.interfaces;
> > -        base_type_info.abstract =3D false;
> > -        generic_type_info.name =3D NULL;
> > +        /* use intermediate %s-base-type to add generic device props *=
/
> > +        base_name =3D g_strdup_printf("%s-base-type", t->generic_name)=
;
> > +        base_type_info.name =3D base_name;
> > +        base_type_info.class_init =3D virtio_pci_generic_class_init;
> > +
> > +        generic_type_info.parent =3D base_name;
> > +        generic_type_info.class_init =3D virtio_pci_base_class_init;
> > +        generic_type_info.class_data =3D (void *)t;
>
> Why are you using virtio_pci_generic_class_init for the base
> class, and virtio_pci_base_class_init for the subclass, but doing
> exactly the opposite when t->base_name is set?
>
> Isn't it simpler to just initialize base_type_info.name and leave
> all the rest alone?  Patch below.

That was my initial approach. But then I tested the backport on v4.0.0, you=
 get:

hw/display/virtio-vga.c:200:virtio_vga_class_init: Object
0x56247edbc0e0 is not an instance of type virtio-vga

The problem is that the introduced base class calls the t->class_init,
which expects the final class (virtio-vga, not virtio-vga-base-type).

This seems to be limited to virtio-vga, and gone in upstream since the
registration changed. But I would rather have the same patch
reviewed/applied.


>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index e6d5467e54..3ee50a0783 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(ObjectCl=
ass *klass, void *data)
>      dc->props =3D virtio_pci_generic_properties;
>  }
>
> -/* Used when the generic type and the base type is the same */
> -static void virtio_pci_generic_base_class_init(ObjectClass *klass, void =
*data)
> -{
> -    virtio_pci_base_class_init(klass, data);
> -    virtio_pci_generic_class_init(klass, NULL);
> -}
> -
>  static void virtio_pci_transitional_instance_init(Object *obj)
>  {
>      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
> @@ -1938,8 +1931,11 @@ static void virtio_pci_non_transitional_instance_i=
nit(Object *obj)
>
>  void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
>  {
> +    char *base_name =3D t->base_name ?
> +                      NULL :
> +                      g_strdup_printf("%s-base-type", t->generic_name);
>      TypeInfo base_type_info =3D {
> -        .name          =3D t->base_name,
> +        .name          =3D t->base_name ?: base_name,
>          .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
>          .instance_size =3D t->instance_size,
>          .instance_init =3D t->instance_init,
> @@ -1959,21 +1955,8 @@ void virtio_pci_types_register(const VirtioPCIDevi=
ceTypeInfo *t)
>          },
>      };
>
> -    if (!base_type_info.name) {
> -        /* No base type -> register a single generic device type */
> -        base_type_info.name =3D t->generic_name;
> -        base_type_info.class_init =3D virtio_pci_generic_base_class_init=
;
> -        base_type_info.interfaces =3D generic_type_info.interfaces;
> -        base_type_info.abstract =3D false;
> -        generic_type_info.name =3D NULL;
> -        assert(!t->non_transitional_name);
> -        assert(!t->transitional_name);
> -    }
> -
>      type_register(&base_type_info);
> -    if (generic_type_info.name) {
> -        type_register(&generic_type_info);
> -    }
> +    type_register(&generic_type_info);

t->generic_name can't be NULL anymore? I thought the condition was
done for a good reason.

>
>      if (t->non_transitional_name) {
>          const TypeInfo non_transitional_type_info =3D {
> @@ -2005,6 +1988,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
>          };
>          type_register(&transitional_type_info);
>      }
> +    g_free(base_name);
>  }
>
>  /* virtio-pci-bus */
>
>
> --
> Eduardo
>


--=20
Marc-Andr=C3=A9 Lureau

