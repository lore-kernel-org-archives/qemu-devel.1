Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70108C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA0224683
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhZZoAtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA0224683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Eqz-0005IO-8S
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j7EqD-0004kG-Bt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j7EqC-0005me-1p
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:48:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j7EqB-0005m0-U5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582793299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKDsKeYxc2XaqDiCeMiQ7YVrNowDCw+zbv4mr2h4Ay0=;
 b=VhZZoAtVh4jKNmmCnoNpOdkNHNXlkpwFsdES27B7evLI1+i7SNDlhzIrzBP5H3zLMaNbTA
 C4a12B2cfIfH3+MvHZbmJRpt75X1RyB574bmpSWGp/VV56FMQnIXE2jPlFsp6oGAyR3+2v
 ewuvBgnUbv07mpJCiKSsHN+sjRPxdo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-mTz4GkQBOTWtzyKXSjx7OQ-1; Thu, 27 Feb 2020 03:48:15 -0500
X-MC-Unique: mTz4GkQBOTWtzyKXSjx7OQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110EE107ACC4;
 Thu, 27 Feb 2020 08:48:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D20B1CB;
 Thu, 27 Feb 2020 08:48:09 +0000 (UTC)
Date: Thu, 27 Feb 2020 09:48:07 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 2/2] hw/arm/virt: kvm: allow gicv3 by default if host does
 not support v2
Message-ID: <20200227084807.of4yduk3kz7zh627@kamzik.brq.redhat.com>
References: <20200226170500.17028-1-eric.auger@redhat.com>
 <20200226170500.17028-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226170500.17028-3-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 06:05:00PM +0100, Eric Auger wrote:
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility. In that case we end up with this error:
>=20
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> and qemu aborts.
>=20
> This patch keeps the default v2 selection in all cases except
> in the KVM accelerated mode when the host does not support v2.
> This case did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case. Also if the end-user explicitly
> sets v2 whereas this latter is not supported, we also are
> informed that v2 is not selected by thos host instead of getting the
> above PMU related message.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a196bbf0d5..b37b0c40c1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1554,6 +1554,33 @@ static void machvirt_init(MachineState *machine)
>                  }
>              }
>          }
> +    } else if (kvm_enabled()) {
> +        int probe_bitmap =3D kvm_arm_vgic_probe();
> +
> +        if (!probe_bitmap) {
> +            error_report(
> +                "Unable to determine GIC version supported by host");
> +            exit(1);
> +        }
> +        if (!vms->gic_version_user_selected) {
> +            /*
> +             * by default v2 is supposed to be chosen: check it is
> +             * supported by the host. Otherwise take v3.
> +             */
> +            if (probe_bitmap & KVM_ARM_VGIC_V2) {

How about 'if ((probe_bitmap & KVM_ARM_VGIC_V2) && max_cpus <=3D GIC_NCPU)'=
,
because even on gicv3 hosts that support gicv2 guests command lines that
didn't specify a gic version and did specify more than 8 vcpus were also
broken. We can now automagically allow those to work too.

Thanks,
drew


