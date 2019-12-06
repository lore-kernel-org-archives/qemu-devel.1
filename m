Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D2C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26D2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcBgcTAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idLIG-0005U7-RJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 16:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1idLFV-0003Z9-Vd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1idLFS-0001kp-M4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1idLFS-0001gl-Ci
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575668086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylAwq9HRT1FF4g6dhw//bDpZh9XCzHLItaBmGhOsz/4=;
 b=VcBgcTACO1N7xdSEDuVh87254pN5aZfQkOLfxtS4GLXkJ2d3HOTHbnNJ8fPMlk7PDjZ3Um
 EOSoI7qP8OAByzbmqNljbJC03NkIDUINIeNk/1uOuq6ZVk98SVLEbzzoov9FDjBnKDZbvN
 KW9ceW3ygayVPNuDB/zi7JKH8HSAjv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-nFF31C_UNCecDaSkvrdywg-1; Fri, 06 Dec 2019 16:34:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6510CDBA3;
 Fri,  6 Dec 2019 21:34:43 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A10D5C1D4;
 Fri,  6 Dec 2019 21:34:42 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] python/qemu: accel: Add tcg_available() method
Date: Fri,  6 Dec 2019 16:34:33 -0500
Message-Id: <20191206213433.11305-5-wainersm@redhat.com>
In-Reply-To: <20191206213433.11305-1-wainersm@redhat.com>
References: <20191206213433.11305-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nFF31C_UNCecDaSkvrdywg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 philmd@redhat.com, crosa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a method to check if the tcg accelerator is enabled
in the QEMU binary.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/accel.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 9fecffb44b..f4ff31825d 100644
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


