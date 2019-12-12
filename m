Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91126C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6056F2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E64n/rde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6056F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP2k-0003tC-VV
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ifO3N-0001i7-DD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ifO3K-0005Nx-L1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ifO3K-0005Ml-G5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576155525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2llVOPrvcn3hE8GA6L5vIGd9hGWg3jgKIe+gOU4In1M=;
 b=E64n/rdeXZLPs6xjRqryJYut7PuZmK8+9D3Xm+fv1f86uNOS8670Mh53WV3rOtEGNOr5BF
 LUDCAWXCyWp4RiBf9+V4BdifjhesYZTlzieg90th2NhMMEJgeksb2Rve2/4/H1rYxzErb0
 DSzIDjQCO/Uh9y0BHx5xQ5DiZyUGo2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-jBS7BZ2JPhKjjG68bexh0g-1; Thu, 12 Dec 2019 07:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8748718B9FC9;
 Thu, 12 Dec 2019 12:58:41 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA49810013A1;
 Thu, 12 Dec 2019 12:58:40 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] python/qemu: accel: Add tcg_available() method
Date: Thu, 12 Dec 2019 07:58:30 -0500
Message-Id: <20191212125831.2654-5-wainersm@redhat.com>
In-Reply-To: <20191212125831.2654-1-wainersm@redhat.com>
References: <20191212125831.2654-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jBS7BZ2JPhKjjG68bexh0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 alex.bennee@linaro.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a method to check if the tcg accelerator is enabled
in the QEMU binary.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/accel.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 833f9431ce..2823bb0cc3 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -67,3 +67,11 @@ def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
     if qemu_bin and "kvm" not in list_accel(qemu_bin):
         return False
     return True
+
+def tcg_available(qemu_bin):
+    """
+    Check if TCG is available.
+
+    @param qemu_bin (str): path to the QEMU binary
+    """
+    return 'tcg' in list_accel(qemu_bin)
--=20
2.21.0


