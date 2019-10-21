Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B681BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8133B2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO+viWWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8133B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbFd-0001G8-9h
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMbDN-0007CG-6D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMbDM-00070y-40
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:11:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMbDL-00070H-SU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571677887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=urZwjrB0hyZWYBw9TOwgAY1JXOm1yLurCxMDKdHVP1k=;
 b=LO+viWWwU0x7/ubfBGYMNr2cdFvT6xAG9QUBZ7Z4NEwTa1DKca/IDUDWHXxLmHQPPfMy77
 yztDR5OR0DnMOA349+dX6AJcOUcD5VSYh/tXdrjC13rzKV4QtUfNVprrVIJQ+7QEYhjza1
 8g4Vq41nGedNR9tkT7ywSuTKdklEsxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-EuqgLGh4P-m3k2y6k3Ni_g-1; Mon, 21 Oct 2019 13:11:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F0F6107AD31
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:11:25 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46BCA10016EB;
 Mon, 21 Oct 2019 17:11:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory-device: simplify Makefile.objs conditions
Date: Mon, 21 Oct 2019 19:11:20 +0200
Message-Id: <20191021171120.17947-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: EuqgLGh4P-m3k2y6k3Ni_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: thuth@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/mem/ is only included if CONFIG_MEM_DEVICE is true, so we need not
specify the condition again in hw/mem/Makefile.objs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 3e2f7c5ca2..56345befd0 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,3 @@
 common-obj-$(CONFIG_DIMM) +=3D pc-dimm.o
-common-obj-$(CONFIG_MEM_DEVICE) +=3D memory-device.o
+common-obj-y +=3D memory-device.o
 common-obj-$(CONFIG_NVDIMM) +=3D nvdimm.o
--=20
2.21.0


