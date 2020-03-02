Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A3F24699
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVKaif3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A3F24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fvM-0003O4-3i
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j8fuj-0002n1-0e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j8fuh-0000cA-M6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:54:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j8fuh-0000bz-IL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583135694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrXbkd8m0hj4ygGWfWHfZZQ6PiLRRuxAxtX1+g6Jfow=;
 b=NVKaif3eSk9FYBcv6WzAehlIpx12Nd5mVhK3esEbzAQkcYGV5bmSD7sd2G1ZTuoGhh66Q4
 fPY3qpCiEHcwcRVHh2z/cOIzWCvWK81q1AelI6KQKV0C9w7bmo+Jy89+GeNGKBSZDCo+Ub
 zYOXNJwMqR4n5mD4MduxmqVCgCWdzy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-aZGTcf3TMQmOJ4g3stI37Q-1; Mon, 02 Mar 2020 02:54:51 -0500
X-MC-Unique: aZGTcf3TMQmOJ4g3stI37Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D11CC13E6;
 Mon,  2 Mar 2020 07:54:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 800DC5C1C3;
 Mon,  2 Mar 2020 07:54:45 +0000 (UTC)
Date: Mon, 2 Mar 2020 08:54:43 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 6/6] hw/arm/virt: kvm: allow gicv3 by default if v2
 cannot work
Message-ID: <20200302075443.xzbxjawfdamtse44@kamzik.brq.redhat.com>
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-7-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-7-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 01, 2020 at 11:40:40AM +0100, Eric Auger wrote:
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
> ---
>  hw/arm/virt.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 610bfc9ee9..2d12a7b0b8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1542,6 +1542,8 @@ static void virt_set_memmap(VirtMachineState *vms)
>   */
>  static void finalize_gic_version(VirtMachineState *vms)
>  {
> +    unsigned int max_cpus =3D MACHINE(vms)->smp.max_cpus;
> +
>      if (kvm_enabled()) {
>          int probe_bitmap =3D kvm_arm_vgic_probe();
> =20
> @@ -1552,7 +1554,17 @@ static void finalize_gic_version(VirtMachineState =
*vms)
> =20
>          switch (vms->gic_version) {
>          case VIRT_GIC_VERSION_NOSEL:
> -            vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            if ((probe_bitmap & KVM_ARM_VGIC_V2 && max_cpus <=3D GIC_NCP=
U) ||
> +                !kvm_irqchip_in_kernel()) {

nit: () around the bitmap & would be nice

> +                vms->gic_version =3D VIRT_GIC_VERSION_2;
> +            } else {
> +                /*
> +                 * in case the host does not support v2 in-kernel emulat=
ion or
> +                 * the end-user requested more than 8 VCPUs we now defau=
lt
> +                 * to v3. In any case defaulting to v2 would be broken.
> +                 */
> +                vms->gic_version =3D VIRT_GIC_VERSION_3;
> +            }
>              break;
>          case VIRT_GIC_VERSION_HOST:
>          case VIRT_GIC_VERSION_MAX:
> --=20
> 2.20.1
>=20
>=20


