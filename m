Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDCC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56AD620719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARYEi5Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AD620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5E7-0007i7-G4
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5At-0002OW-Qv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5As-0000BF-Mp
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5As-00009k-JK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhyHSwnvPzmZ8Yxw/i98vXCiGBqNI3f3CCkkiY3LjfU=;
 b=ARYEi5Cd2wZR4ATq2U/wzGt4xEKX+HewH9m/dG85SvK3NgJrhzvj9lHV26wLNoNvasYG4n
 ppdKRSb7UqP/nyWo7NRmJucZ8X+g5dEeLRMfggtELU+m07aRUyB3NzHE3qJEFplt3CcbKJ
 d/Dyp0Dnj+HH2sOPvo3691WxRChTkNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ioGVWgRbMRakLxLskAMGiw-1; Thu, 02 Apr 2020 15:06:44 -0400
X-MC-Unique: ioGVWgRbMRakLxLskAMGiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5386C100550D
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D10350BEE
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] virtio-iommu: depend on PCI
Date: Thu,  2 Apr 2020 15:06:28 -0400
Message-Id: <20200402190640.1693-4-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-iommu device attaches itself to a PCI bus, so it makes
no sense to include it unless PCI is supported---and in fact
compilation fails without this change.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index d29525b36f..83122424fa 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -12,7 +12,7 @@ config VIRTIO_RNG
 config VIRTIO_IOMMU
     bool
     default y
-    depends on VIRTIO
+    depends on PCI && VIRTIO
=20
 config VIRTIO_PCI
     bool
--=20
2.18.2



