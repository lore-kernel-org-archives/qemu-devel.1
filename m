Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFAAC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBE120873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrRzut3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBE120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0Pz-0003xW-FT
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jC0Oz-0003DX-Rp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jC0Oy-0000Pr-Gy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jC0Oy-0000Pl-Cy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583929435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBuiODKRxkaRVL2hQqHCpTe1BuPlp8I9j0M96k7lkTg=;
 b=JrRzut3yYKPzPlqqn5omCa+JP5w0lllmbtzWs26pakSyXTBMclzypnKZSPez9nde7QVpjM
 cjzt4R72NQ4dyJUyh1DXKd12je5AqsVoHkqVr1r+0XLfBOr8SvD3HSuhZnnO9/+79JP/QB
 b/XT8XLRFSL9PFCLsW93LBxoPMGPFwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-lj48Q7GPPsGWSL-CZHCwtQ-1; Wed, 11 Mar 2020 08:23:54 -0400
X-MC-Unique: lj48Q7GPPsGWSL-CZHCwtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0405D18CA240;
 Wed, 11 Mar 2020 12:23:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-206-80.brq.redhat.com
 [10.40.206.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22D0D8F364;
 Wed, 11 Mar 2020 12:23:48 +0000 (UTC)
Date: Wed, 11 Mar 2020 13:23:46 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 5/6] hw/arm/virt: kvm: Restructure
 finalize_gic_version()
Message-ID: <20200311122346.a3cizebacaipgbyl@kamzik.brq.redhat.com>
References: <20200311111626.5705-1-eric.auger@redhat.com>
 <20200311111626.5705-6-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311111626.5705-6-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, maz@kernel.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:16:25PM +0100, Eric Auger wrote:
> Restructure the finalize_gic_version with switch cases and
> clearly separate the following cases:
>=20
> - KVM mode / in-kernel irqchip
> - KVM mode / userspace irqchip
> - TCG mode
>=20
> In KVM mode / in-kernel irqchip , we explictly check whether
> the chosen version is supported by the host. If the end-user
> explicitly sets v2/v3 and this is not supported by the host,
> then the user gets an explicit error message. Note that for
> old kernels where the CREATE_DEVICE ioctl doesn't exist then
> we will now fail if the user specifically asked for gicv2,
> where previously we (probably) would have succeeded.
>=20
> In KVM mode / userspace irqchip we immediatly output an error
> in case the end-user explicitly selected v3. Also we warn the
> end-user about the unexpected usage of gic-version=3Dhost in
> that case as only userspace GICv2 is supported.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v3 -> v4:
> - introduce a separate switch case for KVM mode / userspace
>   irqchip
> - don't probe the host GIC version in case of userspace
>   GIC
> - add error/warning messages in v3/host mode in userspace
>   mode
> - mention old kernel case with explicit v2/v3 regression
>=20
> v2 -> v3:
> - explictly list V2 and V3 in the switch/case
> - fix indent
> ---
>  hw/arm/virt.c | 89 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 68 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f798b6ec10..f5ff2d9006 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1543,33 +1543,80 @@ static void virt_set_memmap(VirtMachineState *vms=
)
>   */
>  static void finalize_gic_version(VirtMachineState *vms)
>  {
> -    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
> -        vms->gic_version =3D=3D VIRT_GIC_VERSION_MAX) {
> -        if (!kvm_enabled()) {
> -            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
> -                error_report("gic-version=3Dhost requires KVM");
> -                exit(1);
> -            } else {
> -                /* "max": currently means 3 for TCG */
> -                vms->gic_version =3D VIRT_GIC_VERSION_3;
> -            }
> -        } else {
> -            int probe_bitmap =3D kvm_arm_vgic_probe();
> +    if (kvm_enabled()) {
> +        int probe_bitmap;
> =20
> -            if (!probe_bitmap) {
> +        if (!kvm_irqchip_in_kernel()) {
> +            switch (vms->gic_version) {
> +            case VIRT_GIC_VERSION_HOST:
> +                warn_report(
> +                    "gic-version=3Dhost not relevant with kernel-irqchip=
=3Doff "
> +                     "as only userspace GICv2 is supported. Using v2 ...=
");
> +                return;
> +            case VIRT_GIC_VERSION_MAX:
> +            case VIRT_GIC_VERSION_NOSEL:
> +                vms->gic_version =3D VIRT_GIC_VERSION_2;
> +                return;
> +            case VIRT_GIC_VERSION_2:
> +                return;
> +            case VIRT_GIC_VERSION_3:
>                  error_report(
> -                    "Unable to determine GIC version supported by host")=
;
> +                    "gic-version=3D3 is not supported with kernel-irqchi=
p=3Doff");
>                  exit(1);
> -            } else {
> -                if (probe_bitmap & KVM_ARM_VGIC_V3) {
> -                    vms->gic_version =3D VIRT_GIC_VERSION_3;
> -                } else {
> -                    vms->gic_version =3D VIRT_GIC_VERSION_2;
> -                }
>              }
>          }
> -    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_NOSEL) {
> +
> +        probe_bitmap =3D kvm_arm_vgic_probe();
> +        if (!probe_bitmap) {
> +            error_report(
> +                "Unable to determine GIC version supported by host");

No need for this line break

> +            exit(1);
> +        }
> +
> +        switch (vms->gic_version) {
> +        case VIRT_GIC_VERSION_HOST:
> +        case VIRT_GIC_VERSION_MAX:
> +            if (probe_bitmap & KVM_ARM_VGIC_V3) {
> +                vms->gic_version =3D VIRT_GIC_VERSION_3;
> +            } else {
> +                vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            }
> +            return;
> +        case VIRT_GIC_VERSION_NOSEL:
> +            vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            break;
> +        case VIRT_GIC_VERSION_2:
> +        case VIRT_GIC_VERSION_3:
> +            break;
> +        }
> +
> +        /* Check chosen version is effectively supported by the host */
> +        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2 &&
> +            !(probe_bitmap & KVM_ARM_VGIC_V2)) {
> +            error_report("host does not support in-kernel GICv2 emulatio=
n");
> +            exit(1);
> +        } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3 &&
> +                   !(probe_bitmap & KVM_ARM_VGIC_V3)) {
> +            error_report("host does not support in-kernel GICv3 emulatio=
n");
> +            exit(1);
> +        }
> +        return;
> +    }
> +
> +    /* TCG mode */
> +    switch (vms->gic_version) {
> +    case VIRT_GIC_VERSION_NOSEL:
>          vms->gic_version =3D VIRT_GIC_VERSION_2;
> +        break;
> +    case VIRT_GIC_VERSION_MAX:
> +        vms->gic_version =3D VIRT_GIC_VERSION_3;
> +        break;
> +    case VIRT_GIC_VERSION_HOST:
> +        error_report("gic-version=3Dhost requires KVM");
> +        exit(1);
> +    case VIRT_GIC_VERSION_2:
> +    case VIRT_GIC_VERSION_3:
> +        break;
>      }
>  }
> =20
> --=20
> 2.20.1
>

Other than the nit,

Reviewed-by: Andrew Jones <drjones@redhat.com>
=20


