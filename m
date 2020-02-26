Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C924C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA9820714
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjO4vTvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sTl-00061t-HZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j6sQY-0000U8-Sr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j6sQW-0002bb-Qh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j6sQV-0002YU-7y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hE4ZjRT/EAvraI4ba6NiJZ5S8Rj+vZgtarqZfFcS7MI=;
 b=QjO4vTvVtublM3d5BvdbgaJp9PzS2qbLW/90b6YIdlCVQGuxhqhiVnNyY5pp61dQXRVVmV
 HcZgq/7IybY86WZycfXLNLMh5jh00WTqfifUJzPpHc001nAykXFyH9PX9/7YafhjyfMm+y
 TPnPYqHpjF9r61z0LieIQqrfoFcBOFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-01hASuuXPzS3OT3k3-Huig-1; Wed, 26 Feb 2020 03:52:14 -0500
X-MC-Unique: 01hASuuXPzS3OT3k3-Huig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 445108018A2;
 Wed, 26 Feb 2020 08:52:13 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4141419C58;
 Wed, 26 Feb 2020 08:52:12 +0000 (UTC)
Date: Wed, 26 Feb 2020 09:52:09 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
Message-ID: <20200226085209.ni7oph6odt24warq@kamzik.brq.redhat.com>
References: <20200225182435.1131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200225182435.1131-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 06:24:35PM +0000, Peter Maydell wrote:
> In our KVM GICv2 realize function, we try to cope with old kernels
> that don't provide the device control API (KVM_CAP_DEVICE_CTRL): we
> try to use the device control, and if that fails we fall back to
> assuming that the kernel has the old style KVM_CREATE_IRQCHIP and
> that it will provide a GICv2.
>=20
> This doesn't cater for the possibility of a kernel and hardware which
> only provide a GICv3, which is very common now.  On that setup we
> will abort() later on in kvm_arm_pmu_set_irq() when we try to wire up
> an interrupt to the GIC we failed to create:
>=20
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> Aborted
>=20
> If the kernel advertises KVM_CAP_DEVICE_CTRL we should trust it if it
> says it can't create a GICv2, rather than assuming it has one.  We
> can then produce a more helpful error message including a hint about
> the most probable reason for the failure.
>=20
> If the kernel doesn't advertise KVM_CAP_DEVICE_CTRL then it is truly
> ancient by this point but we might as well still fall back to a
> KVM_CREATE_IRQCHIP GICv2.
>=20
> With this patch then the user misconfiguration which previously
> caused an abort now prints:
> qemu-system-aarch64: Initialization of device kvm-arm-gic failed: error c=
reating in-kernel VGIC: No such device
> Perhaps the host CPU does not support GICv2?
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I spent a while wondering if the PMU code was broken before Marc
> put me on the right track about what was going wrong (ie that
> I hadn't put "-machine gic-version=3Dhost" on the commandline).
>=20
>  hw/intc/arm_gic_kvm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 9deb15e7e69..d7df423a7a3 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -551,7 +551,16 @@ static void kvm_arm_gic_realize(DeviceState *dev, Er=
ror **errp)
>                                KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
>                                &error_abort);
>          }
> +    } else if (kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
> +        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
> +        error_append_hint(errp,
> +                          "Perhaps the host CPU does not support GICv2?\=
n");
>      } else if (ret !=3D -ENODEV && ret !=3D -ENOTSUP) {
> +        /*
> +         * Very ancient kernel without KVM_CAP_DEVICE_CTRL: assume that
> +         * ENODEV or ENOTSUP mean "can't create GICv2 with KVM_CREATE_DE=
VICE",
> +         * and that we will get a GICv2 via KVM_CREATE_IRQCHIP.
> +         */
>          error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
>          return;
>      }
> --=20
> 2.20.1
>=20
>

This is nice, as some QEMU command line users may now be able to more
easily correct their command lines. So,

Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Andrew Jones <drjones@redhat.com>

Although, many QEMU command line users still won't know what to do
without an explicit "Try -machine gic-version=3Dhost" hint, so that
might be nice to add too.

Also, unless our command line compatibility policy is so strict that
we can't change failing command lines (which this patch does to some
degree as it fails with a new message now), then we might as well
just probe for a working GIC version when using KVM, as old command
lines that implicitly or explicitly selected '2' never worked with
KVM on gicv3-only hosts anyway. We just have to try '2' first in
order to continue providing a gicv2 to a guests on hosts that support
both, but if that fails, then we can try '3', and if that works, then
users don't have to try and correct their command lines at all.

Thanks,
drew


