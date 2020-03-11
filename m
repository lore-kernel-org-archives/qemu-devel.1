Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB18C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D8820873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO78TKZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D8820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0RF-00083e-8T
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jC0P0-0003Db-Rd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jC0Oz-0000QU-Kp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jC0Oz-0000Q3-GM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583929437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79OoemiBPvP+Aownz+G2JvwW07yPBd9IeWXNr4iX7Hg=;
 b=UO78TKZTX0bmndAE1IjOdGnkxTEOR0WzEqDf2cTrBxhPk+eHsATHM3Yko02rUnxIhT058m
 6/nP0PZYTmk/22fD6mU6jGTS+mYIsXYXNvTAPxURGJvzn1Oyen4cfXKQvlOkYwiUiej44c
 bzLGZuWUdJluynpVvDOl0LDUZFIPSfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Q1dETg8DNn-8_V0bCh-pfQ-1; Wed, 11 Mar 2020 08:23:23 -0400
X-MC-Unique: Q1dETg8DNn-8_V0bCh-pfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 738E4477;
 Wed, 11 Mar 2020 12:23:22 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-206-80.brq.redhat.com
 [10.40.206.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5987391;
 Wed, 11 Mar 2020 12:23:17 +0000 (UTC)
Date: Wed, 11 Mar 2020 13:23:14 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 6/6] hw/arm/virt: kvm: allow gicv3 by default if v2
 cannot work
Message-ID: <20200311122314.eleinzggae3ctaqe@kamzik.brq.redhat.com>
References: <20200311111626.5705-1-eric.auger@redhat.com>
 <20200311111626.5705-7-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311111626.5705-7-eric.auger@redhat.com>
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
Cc: peter.maydell@linaro.org, maz@kernel.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:16:26PM +0100, Eric Auger wrote:
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility.
>=20
> This patch keeps the default v2 selection in all cases except
> in the KVM accelerated mode when either
> - the host does not support GICv2 in-kernel emulation or
> - number of VCPUS exceeds 8.
>=20
> Those cases did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> ---
>=20
> v3 -> v4:
> - Deal with the case where v3 is not supported by the host and
>   the number of vcpus exceeds 8
>=20
> v2 -> v3:
> - add ()
> ---
>  hw/arm/virt.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f5ff2d9006..6becf9aaae 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1543,6 +1543,8 @@ static void virt_set_memmap(VirtMachineState *vms)
>   */
>  static void finalize_gic_version(VirtMachineState *vms)
>  {
> +    unsigned int max_cpus =3D MACHINE(vms)->smp.max_cpus;
> +
>      if (kvm_enabled()) {
>          int probe_bitmap;
> =20
> @@ -1583,7 +1585,20 @@ static void finalize_gic_version(VirtMachineState =
*vms)
>              }
>              return;
>          case VIRT_GIC_VERSION_NOSEL:
> -            vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            if ((probe_bitmap & KVM_ARM_VGIC_V2) && max_cpus <=3D GIC_NC=
PU) {
> +                vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            } else if (probe_bitmap & KVM_ARM_VGIC_V3) {
> +                /*
> +                 * in case the host does not support v2 in-kernel emulat=
ion or
> +                 * the end-user requested more than 8 VCPUs we now defau=
lt
> +                 * to v3. In any case defaulting to v2 would be broken.
> +                 */
> +                vms->gic_version =3D VIRT_GIC_VERSION_3;
> +            } else {

(probe & V3) is only =3D=3D !(probe & V2) since we don't have more versions=
.
If we did, then the assumption cpus > GIC_NCPU here wouldn't be correct.
I'd just make this an 'else if (cpus > GIC_NCPU)' to be explicit.

> +                error_report("host only supports in-kernel GICv2 emulati=
on "
> +                             "but more than 8 vcpus are requested");
> +                exit(1);
> +            }
>              break;
>          case VIRT_GIC_VERSION_2:
>          case VIRT_GIC_VERSION_3:
> --=20
> 2.20.1
>=20

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>


