Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2638C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9EB2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS1hRj6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EB2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSn3-0005wY-Mp
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHSli-00052e-Mr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHSlg-00020d-2o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:41:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHSlf-00020Q-UI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585230115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4dMXh2qmZ3lSD/osxt7xqO3/C6o+ohC6ZeJuu9Wvbk=;
 b=jS1hRj6V5C10FwB2FCFHtslFET3M62BqzQed2y/wCClh/NfJdY0sBBSBPl5o1fmQ1RaGCV
 LCCiQ11Pl2zxvrXM2BiQ/T4FPG2S6NAp83+lr8VCpcffrYgbDBmqZH25omGOKEVg6b02se
 CU1Cpx1Hx2NyB29qSRH/lu7TNSIV2Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-8BYwCuNGOSS3eAH50NwcXw-1; Thu, 26 Mar 2020 09:41:53 -0400
X-MC-Unique: 8BYwCuNGOSS3eAH50NwcXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA634100550D
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 13:41:52 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 513365C1B0;
 Thu, 26 Mar 2020 13:41:46 +0000 (UTC)
Date: Thu, 26 Mar 2020 13:41:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200326134144.GC2713@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
 <20200325200031.GG2635@work-vm> <20200325204214.GD404034@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200325204214.GD404034@xz-x1>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Mar 25, 2020 at 08:00:31PM +0000, Dr. David Alan Gilbert wrote:
> > > @@ -2077,6 +2079,33 @@ static int kvm_init(MachineState *ms)
> > >      s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_mm=
io_region;
> > >      s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesce_=
mmio_region;
> > > =20
> > > +    /*
> > > +     * Enable KVM dirty ring if supported, otherwise fall back to
> > > +     * dirty logging mode
> > > +     */
> > > +    if (s->kvm_dirty_ring_size > 0) {
> > > +        /* Read the max supported pages */
> > > +        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_=
RING);
> > > +        if (ret > 0) {
> > > +            if (s->kvm_dirty_ring_size > ret) {
> > > +                error_report("KVM dirty ring size %d too big (maximu=
m is %d). "
> > > +                             "Please use a smaller value.",
> > > +                             s->kvm_dirty_ring_size, ret);
> > > +                goto err;
> > > +            }
> > > +
> > > +            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0,
> > > +                                    s->kvm_dirty_ring_size);
> > > +            if (ret) {
> > > +                error_report("Enabling of KVM dirty ring failed: %d"=
, ret);
> > > +                goto err;
> > > +            }
> > > +
> > > +            s->kvm_dirty_gfn_count =3D
> > > +                s->kvm_dirty_ring_size / sizeof(struct kvm_dirty_gfn=
);
> >=20
> > What happens if I was to pass dirty-ring-size=3D1 ?
> > Then the count would be 0 and things would get upset somewhere?
> > Do you need to check for a minimum postive value?
>=20
> The above kvm_vm_enable_cap() should fail directly and QEMU will stop.
> Yes we should check it, but kernel will do that in all cases, so I
> just didn't do that explicitly again in the userspace.

We probably should have that check since you can give them a more
obvious error message.

> I was planning this to be an advanced feature so the user of this
> parameter should know the rules to pass values in.

Advanced users just make advanced mistakes :-)

I did wonder if perhaps this option should be a count of entries rather
than a byte size.

> Of course we can introduce another global knob to enable/disable this
> feature as a whole, then I can offer a default value for the size
> parameter.  I just didn't bother that in this RFC version, but I can
> switch to that if that's preferred.
>=20
> [...]
>=20
> > > @@ -3065,6 +3123,12 @@ static void kvm_accel_class_init(ObjectClass *=
oc, void *data)
> > >          NULL, NULL, &error_abort);
> > >      object_class_property_set_description(oc, "kvm-shadow-mem",
> > >          "KVM shadow MMU size", &error_abort);
> > > +
> > > +    object_class_property_add(oc, "dirty-ring-size", "int",
> > > +        kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
> > > +        NULL, NULL, &error_abort);
> >=20
> > I don't think someone passing in a non-number should cause an abort;
> > it should exit, but I don't think it should abort/core.
>=20
> It won't - &error_abort is for the operation to add the property.  It
> should never fail.
>=20
> User illegal input will look like this (a graceful exit):
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -accel kvm,dirty-ring-size=3Da
> qemu-system-x86_64: -accel kvm,dirty-ring-size=3Da: Parameter 'dirty-ring=
-size' expects int64

OK good.

> >=20
> > > +    object_class_property_set_description(oc, "dirty-ring-size",
> > > +        "KVM dirty ring size (<=3D0 to disable)", &error_abort);
> > >  }
> > > =20
> > >  static const TypeInfo kvm_accel_type =3D {
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 224a8e8712..140bd38726 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> > >      "                kernel-irqchip=3Don|off|split controls accelera=
ted irqchip support (default=3Don)\n"
> > >      "                kvm-shadow-mem=3Dsize of KVM shadow MMU in byte=
s\n"
> > >      "                tb-size=3Dn (TCG translation block cache size)\=
n"
> > > +    "                dirty-ring-size=3Dn (KVM dirty ring size in Byt=
es)\n"
> > >      "                thread=3Dsingle|multi (enable multi-threaded TC=
G)\n", QEMU_ARCH_ALL)
> > >  STEXI
> > >  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> > > @@ -140,6 +141,8 @@ irqchip completely is not recommended except for =
debugging purposes.
> > >  Defines the size of the KVM shadow MMU.
> > >  @item tb-size=3D@var{n}
> > >  Controls the size (in MiB) of the TCG translation block cache.
> > > +@item dirty-ring-size=3D@val{n}
> > > +Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).
> >=20
> > I don't see the point in allowing < 0 ; I'd ban it.
>=20
> Sure; I can switch to an uint64.

Great.

Dave

> Thanks,
>=20
> --=20
> Peter Xu
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


