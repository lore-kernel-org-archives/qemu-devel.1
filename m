Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCFAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7E3214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+RPjMwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7E3214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M2t-00037W-79
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1o-0001Tt-JZ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1n-0001k2-Cm
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M1n-0001jv-9g
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPZDYVintvSdLtU0ZgbD5jWLO5AKlbV9L1uBhfdW6bY=;
 b=M+RPjMwtNXJEXvkD9coGiS7uSBqNIg0pc9FWHr51Uf6uoHTnMyLsb6oX2sO1XJDvTu38kO
 hy2WIzkhGUoyRDWYRh511tLtcw7uIobndrb5nTzlVnP2NlXwPY2b2yaUwxDsa1cRKwFC0M
 yVn3lOmqnltfQrK5o0m+s2wo7L16q9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-o9ieG1C0MJS7g8Cdrwz4bA-1; Sun, 01 Mar 2020 05:40:51 -0500
X-MC-Unique: o9ieG1C0MJS7g8Cdrwz4bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB89713E2;
 Sun,  1 Mar 2020 10:40:49 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DCE660C80;
 Sun,  1 Mar 2020 10:40:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 0/6] hw/arm/virt: kvm: allow gicv3 by default if v2 cannot
 work
Date: Sun,  1 Mar 2020 11:40:34 +0100
Message-Id: <20200301104040.15186-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: maz@kernel.org, drjones@redhat.com
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
provide a GICv2", which already allowed to output an explicit error
message.

This series keeps the default v2 selection in all cases except
in the KVM accelerated mode when v2 cannot work:
- either because the host does not support v2 in-kernel emulation or
- because more than 8 vcpus were requested.

Those cases did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-gic-version-v2

History:
RFC -> v2:
- 1904f9b5f1  hw/intc/arm_gic_kvm: Don't assume kernel can
  provide a GICv2" now has landed upstream
- Fix gic-version description
- Introduce finalize_gic_version and use switch/cases
- take into account smp value

Eric Auger (6):
  hw/arm/virt: Document 'max' value in gic-version property description
  hw/arm/virt: Use VIRT_GIC_VERSION defines
  hw/arm/virt: Introduce finalize_gic_version()
  target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
  hw/arm/virt: kvm: Check the chosen gic version is supported by the
    host
  hw/arm/virt: kvm: allow gicv3 by default if v2 cannot work

 hw/arm/virt.c         | 124 +++++++++++++++++++++++++++++++-----------
 include/hw/arm/virt.h |   8 ++-
 target/arm/kvm.c      |  14 +++--
 target/arm/kvm_arm.h  |   3 +
 4 files changed, 110 insertions(+), 39 deletions(-)

--=20
2.20.1


