Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB50FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55B924699
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxUfGr0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55B924699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fwK-0004PH-Rx
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j8fvT-0003fe-2o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j8fvR-00012e-OG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:55:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j8fvR-00012U-Kc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583135741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n7atWwxs0eBK36OqGJP9Xr9a0PK2Mh9Tqpbr9clRgk=;
 b=fxUfGr0n8sETaMrZKcH1hQRewIZb9krMJH4uziwA5oAaTrX2hCQdOhNbDiZjlM0ngFnwPA
 Anfuc4DTen9E5gg2ptGofNlEIVpcn7ObUeL7yA7e+bWxMRGt4VvDYlJlUcGilH3PjZ58J9
 cz4JlOEbqgOVHf2LRm8pUfvdCCD3EL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-MEKt-iFzMVS3EU4J5N2YyQ-1; Mon, 02 Mar 2020 02:55:37 -0500
X-MC-Unique: MEKt-iFzMVS3EU4J5N2YyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 300FC100550E;
 Mon,  2 Mar 2020 07:55:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D498860C05;
 Mon,  2 Mar 2020 07:55:32 +0000 (UTC)
Date: Mon, 2 Mar 2020 08:55:29 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 0/6] hw/arm/virt: kvm: allow gicv3 by default if v2
 cannot work
Message-ID: <20200302075529.sfnehrrqqa3hvg4b@kamzik.brq.redhat.com>
References: <20200301104040.15186-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Sun, Mar 01, 2020 at 11:40:34AM +0100, Eric Auger wrote:
> At the moment if the end-user does not specify the gic-version along
> with KVM acceleration, v2 is set by default. However most of the
> systems now have GICv3 and sometimes they do not support GICv2
> compatibility. In that case we now end up with the following error:
>=20
> "qemu-system-aarch64: Initialization of device kvm-arm-gic failed:
> error creating in-kernel VGIC: No such device
> Perhaps the host CPU does not support GICv2?"
>=20
> since "1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
> provide a GICv2", which already allowed to output an explicit error
> message.
>=20
> This series keeps the default v2 selection in all cases except
> in the KVM accelerated mode when v2 cannot work:
> - either because the host does not support v2 in-kernel emulation or
> - because more than 8 vcpus were requested.
>=20
> Those cases did not work anyway so we do not break any compatibility.
> Now we get v3 selected in such a case.
>=20
> Best Regards
>=20
> Eric
>=20
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2.0-gic-version-v2
>=20
> History:
> RFC -> v2:
> - 1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
>   provide a GICv2" now has landed upstream
> - Fix gic-version description
> - Introduce finalize_gic_version and use switch/cases
> - take into account smp value
>=20
> Eric Auger (6):
>   hw/arm/virt: Document 'max' value in gic-version property description
>   hw/arm/virt: Use VIRT_GIC_VERSION defines
>   hw/arm/virt: Introduce finalize_gic_version()
>   target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
>   hw/arm/virt: kvm: Check the chosen gic version is supported by the
>     host
>   hw/arm/virt: kvm: allow gicv3 by default if v2 cannot work
>=20
>  hw/arm/virt.c         | 124 +++++++++++++++++++++++++++++++-----------
>  include/hw/arm/virt.h |   8 ++-
>  target/arm/kvm.c      |  14 +++--
>  target/arm/kvm_arm.h  |   3 +
>  4 files changed, 110 insertions(+), 39 deletions(-)
>=20
> --=20
> 2.20.1
>=20
>

With Richard's enum suggestions

For the series

Reviewed-by: Andrew Jones <drjones@redhat.com>


