Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EEDC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751F9217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPzbTGZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751F9217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRNE-00007S-Jc
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRM8-0006iV-Pq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRM7-0004FH-P7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRM7-0004Ak-Ll
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjKDdskZ2C0qnl6/P4NRgUHjmFbpHvatwx7sQXn5eyw=;
 b=CPzbTGZ5cOrigZRzqRuKtOvU0dNpzAvnq//zbK+Z/oMlV0dZwwNxR6FoW/aEJk4QzQTBZh
 SZuGl4Z6nFYNBvMwZIPf6e7JRoilhMfv4BeEGU+kkfJIPJZH2k+089EtWmfVmZL8+7jAdE
 OaMKAiIDPObBDPcCeT4iyiXe5ymPwN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-y2qWjA7XMHqCFQ-TP4HUWQ-1; Wed, 05 Feb 2020 15:32:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB4C1137841;
 Wed,  5 Feb 2020 20:32:57 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5A0410013A1;
 Wed,  5 Feb 2020 20:32:56 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/8] python/qemu: accel: Fix kvm_available() on ppc64le
Date: Wed,  5 Feb 2020 15:32:46 -0500
Message-Id: <20200205203250.30526-5-wainersm@redhat.com>
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
References: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: y2qWjA7XMHqCFQ-TP4HUWQ-1
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ppc64le, the accel.kvm_available() check may wrongly
return False because the host arch (as returned by os.uname[4])
and the target arch (ppc64) mismatch. In order to solve this
it is added an ppc64le -> ppc64 mapping which is used as an
fallback verification.

Fixes: 53a049d7d78e5ccf6d4c0d7
Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 python/qemu/accel.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 0b38ddf0ab..36ae85791e 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -24,7 +24,8 @@ LOG =3D logging.getLogger(__name__)
 # support which often includes its 32 bit cousin.
 ADDITIONAL_ARCHES =3D {
     "x86_64" : "i386",
-    "aarch64" : "armhf"
+    "aarch64" : "armhf",
+    "ppc64le" : "ppc64",
 }
=20
 def list_accel(qemu_bin):
--=20
2.24.1


