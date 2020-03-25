Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F86C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E7B2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qi6DuVww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E7B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCs8-0003o1-HI
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHCr3-0002tR-4t
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHCr1-0004o0-SE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:42:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHCr1-0004nR-8G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585168942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQ/pXoflOGfJOU6g7cKsqOilsIP1o1YJCp/zOfd2mLc=;
 b=Qi6DuVww3MTSSVuDN949HV9iEXwSC+frhnX4UyyzO/k9AMFoMiefovQcpeYGR0+qQ29qF2
 wH3qZ0r6yW4n4em6cku7daUzPJph9Jy4XoPmUxvrWkHvaACvcCYijvwrtlOWJH59GQLF1d
 3IWZo24+vs1Y4FqvbyPlmbfw5TfSqI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-gGUyeUluOYSMHE3U8O-9jw-1; Wed, 25 Mar 2020 16:42:20 -0400
X-MC-Unique: gGUyeUluOYSMHE3U8O-9jw-1
Received: by mail-wm1-f69.google.com with SMTP id m4so1390836wmi.5
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q0tmDZXRUvlxM5nV4lAPrjHT6bJhkoDNcDSFpQrntxs=;
 b=CXXl2GLp0RDsm0sB24JrQJdD+kEyQmgpDqBsfD8cSntWrE2ut9cf7Et0Eu9EdbyZw5
 XwVElVy9sM1MbJxrS5ZKqsMb7/eW9Bv8hE8JfzvRHA+NucycKf83TJ4YtE4TwxonlRDY
 ePLfc3uWKZQSvujS1fGByOt5/krAJXiTTSMh18LAEZSy46u50NwzLz+REqRgpCAcgdhL
 ISKfbhEKksaS4FJm6LmjWgTXz/0vWKLq0khzx+4QO5/7EP+ANOqRDy208kOk6p8mQ6rJ
 tytPAzAn4kF4odqPEXEqlJ3pRomNmQESYEyCXqKosIxuSkqAqcYng7OXWB6+BNkzgv9g
 JS2A==
X-Gm-Message-State: ANhLgQ0s4jgEaDch8QLt3ZCE99MRRoG9SeUiBtqbvmmjVc4owqH+2y95
 0ZKdKglHjYCeH8nXWgMndT7ZGnwMu3cTF4RnGo/h077gU6w5TphDEiC4gf2Qjyw203OomZDlT7e
 rvZ+44BgulIgzfI0=
X-Received: by 2002:adf:f38e:: with SMTP id m14mr5523131wro.54.1585168939617; 
 Wed, 25 Mar 2020 13:42:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvg+Ofd4/vixkWZBjTvOiTIq5DYbQqr/3hpWE2kkXRl49Mf0VQGpUknHbJezMjQPkA3Zx2QuA==
X-Received: by 2002:adf:f38e:: with SMTP id m14mr5523098wro.54.1585168939290; 
 Wed, 25 Mar 2020 13:42:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a192sm337032wme.5.2020.03.25.13.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 13:42:18 -0700 (PDT)
Date: Wed, 25 Mar 2020 16:42:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200325204214.GD404034@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
 <20200325200031.GG2635@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200325200031.GG2635@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 08:00:31PM +0000, Dr. David Alan Gilbert wrote:
> > @@ -2077,6 +2079,33 @@ static int kvm_init(MachineState *ms)
> >      s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_mmio=
_region;
> >      s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesce_mm=
io_region;
> > =20
> > +    /*
> > +     * Enable KVM dirty ring if supported, otherwise fall back to
> > +     * dirty logging mode
> > +     */
> > +    if (s->kvm_dirty_ring_size > 0) {
> > +        /* Read the max supported pages */
> > +        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_RI=
NG);
> > +        if (ret > 0) {
> > +            if (s->kvm_dirty_ring_size > ret) {
> > +                error_report("KVM dirty ring size %d too big (maximum =
is %d). "
> > +                             "Please use a smaller value.",
> > +                             s->kvm_dirty_ring_size, ret);
> > +                goto err;
> > +            }
> > +
> > +            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0,
> > +                                    s->kvm_dirty_ring_size);
> > +            if (ret) {
> > +                error_report("Enabling of KVM dirty ring failed: %d", =
ret);
> > +                goto err;
> > +            }
> > +
> > +            s->kvm_dirty_gfn_count =3D
> > +                s->kvm_dirty_ring_size / sizeof(struct kvm_dirty_gfn);
>=20
> What happens if I was to pass dirty-ring-size=3D1 ?
> Then the count would be 0 and things would get upset somewhere?
> Do you need to check for a minimum postive value?

The above kvm_vm_enable_cap() should fail directly and QEMU will stop.
Yes we should check it, but kernel will do that in all cases, so I
just didn't do that explicitly again in the userspace.

I was planning this to be an advanced feature so the user of this
parameter should know the rules to pass values in.

Of course we can introduce another global knob to enable/disable this
feature as a whole, then I can offer a default value for the size
parameter.  I just didn't bother that in this RFC version, but I can
switch to that if that's preferred.

[...]

> > @@ -3065,6 +3123,12 @@ static void kvm_accel_class_init(ObjectClass *oc=
, void *data)
> >          NULL, NULL, &error_abort);
> >      object_class_property_set_description(oc, "kvm-shadow-mem",
> >          "KVM shadow MMU size", &error_abort);
> > +
> > +    object_class_property_add(oc, "dirty-ring-size", "int",
> > +        kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
> > +        NULL, NULL, &error_abort);
>=20
> I don't think someone passing in a non-number should cause an abort;
> it should exit, but I don't think it should abort/core.

It won't - &error_abort is for the operation to add the property.  It
should never fail.

User illegal input will look like this (a graceful exit):

$ ./x86_64-softmmu/qemu-system-x86_64 -accel kvm,dirty-ring-size=3Da
qemu-system-x86_64: -accel kvm,dirty-ring-size=3Da: Parameter 'dirty-ring-s=
ize' expects int64

>=20
> > +    object_class_property_set_description(oc, "dirty-ring-size",
> > +        "KVM dirty ring size (<=3D0 to disable)", &error_abort);
> >  }
> > =20
> >  static const TypeInfo kvm_accel_type =3D {
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 224a8e8712..140bd38726 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> >      "                kernel-irqchip=3Don|off|split controls accelerate=
d irqchip support (default=3Don)\n"
> >      "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\=
n"
> >      "                tb-size=3Dn (TCG translation block cache size)\n"
> > +    "                dirty-ring-size=3Dn (KVM dirty ring size in Bytes=
)\n"
> >      "                thread=3Dsingle|multi (enable multi-threaded TCG)=
\n", QEMU_ARCH_ALL)
> >  STEXI
> >  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> > @@ -140,6 +141,8 @@ irqchip completely is not recommended except for de=
bugging purposes.
> >  Defines the size of the KVM shadow MMU.
> >  @item tb-size=3D@var{n}
> >  Controls the size (in MiB) of the TCG translation block cache.
> > +@item dirty-ring-size=3D@val{n}
> > +Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).
>=20
> I don't see the point in allowing < 0 ; I'd ban it.

Sure; I can switch to an uint64.

Thanks,

--=20
Peter Xu


