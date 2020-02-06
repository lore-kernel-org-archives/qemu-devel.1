Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53946C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA4F21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOMgtr+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoaw-00010Z-8u
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZZ-0007Mu-SY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZY-0001dm-UN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZY-0001cH-PV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXLdV7Q9XL63JgMG/wm3Du/1Ceysw62MFT0qx70xvJ0=;
 b=YOMgtr+xoKd7jQCPEkqbgLVhW1joNpMsAK8X9LVXRiaSF+6mAuNmFMEtpgCHY8GgYAopjp
 ZVRugOhfm/VdvBXPC5bI7sF3ggLrSpemhoEpYWBEFuwRTp9/gOoMUWwvxNgvVbsNgwo9jK
 L/T/4guzqQIZ8EG50ZPUz2fY0vke8m8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-WGWsrg-zM3GiLvkI-OGylQ-1; Thu, 06 Feb 2020 16:20:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDAB62F2A
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:20:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E203760BEC;
 Thu,  6 Feb 2020 21:20:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/46] python/qemu: accel: Fix kvm_available() on ppc64le
Date: Thu,  6 Feb 2020 22:18:56 +0100
Message-Id: <20200206211936.17098-7-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WGWsrg-zM3GiLvkI-OGylQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

On ppc64le, the accel.kvm_available() check may wrongly
return False because the host arch (as returned by os.uname[4])
and the target arch (ppc64) mismatch. In order to solve this
it is added an ppc64le -> ppc64 mapping which is used as an
fallback verification.

Fixes: 53a049d7d78e5ccf6d4c0d7
Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200205203250.30526-5-wainersm@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
2.21.1


