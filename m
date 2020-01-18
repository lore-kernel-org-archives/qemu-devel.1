Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B8624699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irNcaoWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B8624699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ison5-0003m3-O8
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isokW-0000J9-RL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isokU-0007cI-22
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isokT-0007c4-Us
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579356409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZj2pvblHJa9UwEi0es74uPfzOzPt0N71PoumxhKULs=;
 b=irNcaoWfV0jONPj8ocUp3m4MkLrxqkbwekwY++Q/ZPlbrJMI6ZIUbo3fbDUO+mR5+5ggRV
 TNrIwt2AniUNfoWfRB6JdW2KZLScdqWheoYyeGq+9J8ml57v8hoVwtIBP2c1sdWABGwaBa
 5DFiS+HSIOTLb3S09FV5zVJgnVU5/SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-CaQLed4zMDmJYfrlD8_28A-1; Sat, 18 Jan 2020 09:06:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E89C800D48;
 Sat, 18 Jan 2020 14:06:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A733D5C1D4;
 Sat, 18 Jan 2020 14:06:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 3/6] Makefile: Restrict system emulation and tools objects
Date: Sat, 18 Jan 2020 15:06:16 +0100
Message-Id: <20200118140619.26333-4-philmd@redhat.com>
In-Reply-To: <20200118140619.26333-1-philmd@redhat.com>
References: <20200118140619.26333-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: CaQLed4zMDmJYfrlD8_28A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restrict all the system emulation and tools objects with a
Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.

Using the same description over and over is not very helpful.
Use it once, just before the if() block.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5aae561984..395dd1e670 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -4,16 +4,15 @@ stub-obj-y =3D stubs/
 util-obj-y =3D crypto/ util/ qobject/ qapi/
 qom-obj-y =3D qom/
=20
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
 chardev-obj-y =3D chardev/
=20
-#######################################################################
-# authz-obj-y is code used by both qemu system emulation and qemu-img
-
 authz-obj-y =3D authz/
=20
-#######################################################################
-# block-obj-y is code used by both qemu system emulation and qemu-img
-
 block-obj-y =3D nbd/
 block-obj-y +=3D block.o blockjob.o job.o
 block-obj-y +=3D block/ scsi/
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
2.21.1


