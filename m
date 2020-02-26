Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C2C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B861206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO2aWafY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B861206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j709e-0008HO-Nk
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j707b-0004z8-9H
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j707Z-0002bH-Ng
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j707Z-0002Vr-IH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582736716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q2FBRF2GnFjWJL/ZPum6bV29UkLuQo6IIE5h/kxtwqM=;
 b=gO2aWafY5AQfeDUOM9ibL7GLrWDy7y2DUZ/lrIi+ebnNkteiTAUOKdsclX+1LTZAs+1EYG
 QWIq1Fw52CCRZOi90N8cBrwYs2Z24y/3lh/ktoZwa7p80chau4B1guROHqwFCuTAXoCtw0
 7w+3dljD9eLaN+lsbClahpOCmajzTKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-9qGOtC0vMpSUnUlEKR1t6w-1; Wed, 26 Feb 2020 12:05:15 -0500
X-MC-Unique: 9qGOtC0vMpSUnUlEKR1t6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA13D8010F8;
 Wed, 26 Feb 2020 17:05:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB76760C63;
 Wed, 26 Feb 2020 17:05:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [RFC 0/2] hw/arm/virt: kvm: allow gicv3 by default if host does not
 support v2
Date: Wed, 26 Feb 2020 18:04:58 +0100
Message-Id: <20200226170500.17028-1-eric.auger@redhat.com>
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
compatibility. In that case we end up with this error:

qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
qemu-system-aarch64: failed to set irq for PMU
and qemu aborts.

This patch keeps the default v2 selection in all cases except
in the KVM accelerated mode when the host does not support v2.
This case did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case. Also if the end-user explicitly
sets v2 whereas this latter is not supported, we also are
informed that v2 is not selected by thos host instead of getting the
above PMU related message.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/gic_version_rfc_v1


Eric Auger (2):
  target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
  hw/arm/virt: kvm: allow gicv3 by default if host does not support v2

 hw/arm/virt.c         | 41 +++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h |  1 +
 target/arm/kvm.c      | 14 ++++++++------
 target/arm/kvm_arm.h  |  3 +++
 4 files changed, 51 insertions(+), 8 deletions(-)

--=20
2.20.1


