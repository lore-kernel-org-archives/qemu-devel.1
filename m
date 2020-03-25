Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE2C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBED20658
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu7HCy5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBED20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHCDw-00022x-6P
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHCCj-0001cM-6A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHCCh-000775-Ph
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHCCh-00076e-Kr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585166443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Out3+up1KnYabG/lOAODomaCFL0g2H18za564DgpqiM=;
 b=Pu7HCy5dYmLJuTl91j5AKGJVfxQNJBgbIfyHwEsPUQYCp3bjVkuJ0VpUh3kVM8dzR8Siyg
 TMXdSf/rztzO/fYaCG7Q24roNj/PoynVCoEdDXWw+FlHznCgtqzP4udXSA/NHA/xpxDgHq
 AEajZTtJCOIhx9+jp5NklJi4qEDguHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Q32BP7-ZNGyHj-G2gPTQmw-1; Wed, 25 Mar 2020 16:00:41 -0400
X-MC-Unique: Q32BP7-ZNGyHj-G2gPTQmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D0C4107B765
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 20:00:40 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B537C19925;
 Wed, 25 Mar 2020 20:00:33 +0000 (UTC)
Date: Wed, 25 Mar 2020 20:00:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200325200031.GG2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-9-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Add a parameter for size of dirty ring.  If zero, dirty ring is
> disabled.  Otherwise dirty ring will be enabled with the per-vcpu size
> as specified.  If dirty ring cannot be enabled due to unsupported
> kernel, it'll fallback to dirty logging.  By default, dirty ring is
> not enabled (dirty-ring-size=3D=3D0).
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx     |  3 +++
>  2 files changed, 67 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ea7b8f7ca5..6d145a8b98 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -127,6 +127,8 @@ struct KVMState
>          KVMMemoryListener *ml;
>          AddressSpace *as;
>      } *as;
> +    int kvm_dirty_ring_size;
> +    int kvm_dirty_gfn_count;    /* If nonzero, then kvm dirty ring enabl=
ed */
>  };
> =20
>  KVMState *kvm_state;
> @@ -2077,6 +2079,33 @@ static int kvm_init(MachineState *ms)
>      s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_mmio_r=
egion;
>      s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesce_mmio=
_region;
> =20
> +    /*
> +     * Enable KVM dirty ring if supported, otherwise fall back to
> +     * dirty logging mode
> +     */
> +    if (s->kvm_dirty_ring_size > 0) {
> +        /* Read the max supported pages */
> +        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_RING=
);
> +        if (ret > 0) {
> +            if (s->kvm_dirty_ring_size > ret) {
> +                error_report("KVM dirty ring size %d too big (maximum is=
 %d). "
> +                             "Please use a smaller value.",
> +                             s->kvm_dirty_ring_size, ret);
> +                goto err;
> +            }
> +
> +            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0,
> +                                    s->kvm_dirty_ring_size);
> +            if (ret) {
> +                error_report("Enabling of KVM dirty ring failed: %d", re=
t);
> +                goto err;
> +            }
> +
> +            s->kvm_dirty_gfn_count =3D
> +                s->kvm_dirty_ring_size / sizeof(struct kvm_dirty_gfn);

What happens if I was to pass dirty-ring-size=3D1 ?
Then the count would be 0 and things would get upset somewhere?
Do you need to check for a minimum postive value?

> +        }
> +    }
> +
>      kvm_memory_listener_register(s, &s->memory_listener,
>                                   &address_space_memory, 0);
>      memory_listener_register(&kvm_io_listener,
> @@ -3037,6 +3066,33 @@ bool kvm_kernel_irqchip_split(void)
>      return kvm_state->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON;
>  }
> =20
> +static void kvm_get_dirty_ring_size(Object *obj, Visitor *v,
> +                                    const char *name, void *opaque,
> +                                    Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    int64_t value =3D s->kvm_dirty_ring_size;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void kvm_set_dirty_ring_size(Object *obj, Visitor *v,
> +                                    const char *name, void *opaque,
> +                                    Error **errp)
> +{
> +    KVMState *s =3D KVM_STATE(obj);
> +    Error *error =3D NULL;
> +    int64_t value;
> +
> +    visit_type_int(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    s->kvm_dirty_ring_size =3D value;
> +}
> +
>  static void kvm_accel_instance_init(Object *obj)
>  {
>      KVMState *s =3D KVM_STATE(obj);
> @@ -3044,6 +3100,8 @@ static void kvm_accel_instance_init(Object *obj)
>      s->kvm_shadow_mem =3D -1;
>      s->kernel_irqchip_allowed =3D true;
>      s->kernel_irqchip_split =3D ON_OFF_AUTO_AUTO;
> +    /* By default off */
> +    s->kvm_dirty_ring_size =3D 0;
>  }
> =20
>  static void kvm_accel_class_init(ObjectClass *oc, void *data)
> @@ -3065,6 +3123,12 @@ static void kvm_accel_class_init(ObjectClass *oc, =
void *data)
>          NULL, NULL, &error_abort);
>      object_class_property_set_description(oc, "kvm-shadow-mem",
>          "KVM shadow MMU size", &error_abort);
> +
> +    object_class_property_add(oc, "dirty-ring-size", "int",
> +        kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
> +        NULL, NULL, &error_abort);

I don't think someone passing in a non-number should cause an abort;
it should exit, but I don't think it should abort/core.

> +    object_class_property_set_description(oc, "dirty-ring-size",
> +        "KVM dirty ring size (<=3D0 to disable)", &error_abort);
>  }
> =20
>  static const TypeInfo kvm_accel_type =3D {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 224a8e8712..140bd38726 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "                kernel-irqchip=3Don|off|split controls accelerated =
irqchip support (default=3Don)\n"
>      "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
>      "                tb-size=3Dn (TCG translation block cache size)\n"
> +    "                dirty-ring-size=3Dn (KVM dirty ring size in Bytes)\=
n"
>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> @@ -140,6 +141,8 @@ irqchip completely is not recommended except for debu=
gging purposes.
>  Defines the size of the KVM shadow MMU.
>  @item tb-size=3D@var{n}
>  Controls the size (in MiB) of the TCG translation block cache.
> +@item dirty-ring-size=3D@val{n}
> +Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).

I don't see the point in allowing < 0 ; I'd ban it.

Dave


>  @item thread=3Dsingle|multi
>  Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
>  thread per vCPU therefor taking advantage of additional host cores. The =
default
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


