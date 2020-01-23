Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1293B2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf4uW2Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuft2-0004e9-Fn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctE-0007uh-N8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctD-0007Hd-Ca
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctD-0007Fg-9X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkN0Hs0386ovqGyh0tX92ZIyDFdjOBkkpk1SQxdeXc4=;
 b=Gf4uW2LufcZQoSKaYv03DodJbeq0Zusp0x6BcA0kyN7VCoW2jVZ3fZjh9kEhstEogsxEZ9
 OIghek4xYf544uMwlYcjLZYZiIjvjdbB4iiLw1vv4bssHtCjUS7tiPK3uqL04yshq4Acqq
 mycyWbG/TEdKATSklKXINaToQTioS6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-QXwlACAfM0CuQRGPz-Cm8A-1; Thu, 23 Jan 2020 08:51:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E512E8010D9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:16 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1F2E1CB;
 Thu, 23 Jan 2020 13:51:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/59] Makefile: Restrict system emulation and tools objects
Date: Thu, 23 Jan 2020 14:50:04 +0100
Message-Id: <1579787449-27599-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QXwlACAfM0CuQRGPz-Cm8A-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Restrict all the system emulation and tools objects with a
Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.

Using the same description over and over is not very helpful.
Use it once, just before the if() block.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5aae561..395dd1e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -4,15 +4,14 @@ stub-obj-y =3D stubs/
 util-obj-y =3D crypto/ util/ qobject/ qapi/
 qom-obj-y =3D qom/
=20
-chardev-obj-y =3D chardev/
-
 #######################################################################
-# authz-obj-y is code used by both qemu system emulation and qemu-img
+# code used by both qemu system emulation and qemu-img
=20
-authz-obj-y =3D authz/
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
=20
-#######################################################################
-# block-obj-y is code used by both qemu system emulation and qemu-img
+chardev-obj-y =3D chardev/
+
+authz-obj-y =3D authz/
=20
 block-obj-y =3D nbd/
 block-obj-y +=3D block.o blockjob.o job.o
@@ -22,16 +21,12 @@ block-obj-$(CONFIG_REPLICATION) +=3D replication.o
=20
 block-obj-m =3D block/
=20
-#######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
 crypto-obj-y =3D crypto/
=20
-#######################################################################
-# io-obj-y is code used by both qemu system emulation and qemu-img
-
 io-obj-y =3D io/
=20
+endif # CONFIG_SOFTMMU or CONFIG_TOOLS
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
--=20
1.8.3.1



