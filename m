Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F5C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96841208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZK42+6Iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96841208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzN4-0003MC-O6
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBzLt-0001dP-RU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBzLs-0000EE-Cw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:16:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39633
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBzLs-0000Dw-9F
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583925399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=phRumhE1rAWX2v5bZGRmT4c3AaXfOjTFNz+2YKyVy+E=;
 b=ZK42+6IvZyRPsuj2VLPeUFyrluTSPKXRbr1nzM8sWwoWY3u3CqNey3uhQ//Mb2TLADU0Ge
 zpFOEuoZrGALpMl7vqEZjdJ3bzUxJS23PW0yeSHlddgOY7dDpPo3qqpnf5CT/hQqfpjLJY
 30qf4nY+h7twiivE6kz0tbQisT82D7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-FhRxC7afNHC6MJciYRNxyA-1; Wed, 11 Mar 2020 07:16:37 -0400
X-MC-Unique: FhRxC7afNHC6MJciYRNxyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0508018A2;
 Wed, 11 Mar 2020 11:16:36 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39A1492D2A;
 Wed, 11 Mar 2020 11:16:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 0/6] hw/arm/virt: kvm: allow gicv3 by default if v2 cannot
 work
Date: Wed, 11 Mar 2020 12:16:20 +0100
Message-Id: <20200311111626.5705-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: maz@kernel.org, drjones@redhat.com, richard.henderson@linaro.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment if the end-user does not specify the gic-version along
with KVM acceleration, v2 is set by default. However most of the
systems now have GICv3 and sometimes they do not support GICv2
compatibility. In that case we now end up with the following error:

"qemu-system-aarch64: Initialization of device kvm-arm-gic failed:
error creating in-kernel VGIC: No such device
Perhaps the host CPU does not support GICv2?"

since "1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
provide a GICv2" which already allowed to output an explicit error
message.

This patch keeps the default v2 selection in all cases except
in the KVM accelerated mode when v2 cannot work:
- either because the host does not support v2 in-kernel emulation or
- because more than 8 vcpus were requested.

Those cases did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-gic-version-v4

History:

v3 -> v4:
- do not probe the host GIC version if kernel-irqchip=3Doff
- In KVM mode / userspace irqchip we immediatly output an error
  in case the end-user explicitly selected v3. Also we warn the
  end-user about the weird usage of host in that case (only
  userspace GICv2 is supported).
- Removed R-b on last 2 patches

v2 -> v3:
- replaced defines by VirtGICType enum type
- fixed some style issue
- collected Richard and Dres's R-b
  except on "hw/arm/virt: Introduce VirtGICType enum type" just
  to make sure this matches their expectation.

RFC -> v1:
- 1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
provide a GICv2" now has landed upstream
- Fix gic-version description
- Introduce finalize_gic_version and use switch/cases
- take into account smp value


Eric Auger (6):
  hw/arm/virt: Document 'max' value in gic-version property description
  hw/arm/virt: Introduce VirtGICType enum type
  hw/arm/virt: Introduce finalize_gic_version()
  target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
  hw/arm/virt: kvm: Restructure finalize_gic_version()
  hw/arm/virt: kvm: allow gicv3 by default if v2 cannot work

 include/hw/arm/virt.h |  12 +++-
 target/arm/kvm_arm.h  |   3 +
 hw/arm/virt.c         | 146 +++++++++++++++++++++++++++++++++---------
 target/arm/kvm.c      |  14 ++--
 4 files changed, 135 insertions(+), 40 deletions(-)

--=20
2.20.1


