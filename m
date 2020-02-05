Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D762C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342F32082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYl6UivP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIai-0007nc-E9
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1izIVM-0008Ow-Jr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1izIVL-0005u1-Im
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1izIVL-0005sG-FO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qh2lAYN9mfnlZ3ypiOWt9zSlEsUPgnszltHhu5G8D08=;
 b=WYl6UivPNoETyERrAmWMBR0qqcbff9M8SVhoFr896OZl5kZm3jx9WCazuZIsQSb9lNtUdf
 oGEvO24xT8FfhAKZbcy3/tX0LXM7fJ4jpnXq8z16jwsaeYL1Y0zC91mtBYkM6Iz470HbWl
 EDdZ3vTHf5ldqzuFypZM6kmvwxQ7EOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-YsqQFv4sOFe8bLs6_ywzmg-1; Wed, 05 Feb 2020 06:05:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB55DB25;
 Wed,  5 Feb 2020 11:05:53 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-31.bne.redhat.com
 [10.64.54.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D92A5790C0;
 Wed,  5 Feb 2020 11:05:46 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RESEND RFC PATCH v2 0/2] Support NMI Injection
Date: Wed,  5 Feb 2020 22:05:39 +1100
Message-Id: <20200205110541.37811-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YsqQFv4sOFe8bLs6_ywzmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This intends to support HMP/QMP "nmi" command. When it's issued, the
SError interrupt is injected to the guest. The guest is expected to
crash with it. The behavior is similar to x86: NMI is injected to
guest as error indication. The guest possiblly crashes and reboots
with the injected NMI. Note that the functionality is currently
supported on "virt" machine and {"host", "max"} CPU models only.

PATCH[1/2] allows to inject SError interrupt, which will be used by
the subsequent patch. PATH[2/2] injects SError interrupt when "nmi"
command is issued. With that, the guest is expected to crash and
possiblly reboot.

Testing
=3D=3D=3D=3D=3D=3D=3D
Start linux 5.5 guest with "virt"+"host", or "virt"+"max". The
guest crashes and reboot if "/proc/sys/core/panic" had been configured
properly, after "nmi" command is issued. The following error message
is given on "virt"+"cortext-a72": "Error: NMI injection not supported"

Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D
v2:
   * Redesigned to fully exploit SError interrupt

Gavin Shan (2):
  target/arm: Allow to inject SError interrupt
  target/arm: Support NMI injection

 hw/arm/virt.c          | 18 +++++++++++++
 target/arm/cpu-qom.h   |  1 +
 target/arm/cpu.c       | 59 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h       | 12 ++++++---
 target/arm/cpu64.c     | 25 +++++++++++++++---
 target/arm/helper.c    |  4 +++
 target/arm/internals.h |  8 ++++++
 7 files changed, 120 insertions(+), 7 deletions(-)

--=20
2.23.0


