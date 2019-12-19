Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D1F227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZebZTCGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D1F227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv7v-0005u9-6P
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihura-0008Tk-0V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurY-0001KA-RJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurY-0001GI-FO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxM519PDR8MUQ5auUJML+qbNF8cdzpZsMmwVqKmE5+0=;
 b=ZebZTCGbCqBooEBo2XjEXEIteh3cX7hpJxBwLPz2t6bIeqwTmYCQHEJjpUGVxC7SVVlh+Q
 Hfon7oVwaTX24bnJhGMfCKCL6QMEUisI+Pf/AqMwF5VCDnG7s3/kPX7LzmPUSmUk+Gb20A
 DzRemJ5M9lbBGIBjiaQgRqvjWxjKmZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-koVrUG5fMGi5MVWmJv2rRg-1; Thu, 19 Dec 2019 07:24:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5E30107ACFA
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:56 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B845F60C18;
 Thu, 19 Dec 2019 12:24:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 111/132] meson: softmmu
Date: Thu, 19 Dec 2019 13:23:31 +0100
Message-Id: <1576758232-12439-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: koVrUG5fMGi5MVWmJv2rRg-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target |  4 ----
 meson.build     | 12 ++++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 7b5b254..32c0521 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -134,10 +134,6 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
-obj-y +=3D qtest.o
-obj-y +=3D memory.o
-obj-y +=3D memory_mapping.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
 # Temporary until emulators are linked by Meson
diff --git a/meson.build b/meson.build
index 6f2c838..655571c 100644
--- a/meson.build
+++ b/meson.build
@@ -498,6 +498,18 @@ specific_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.=
c', 'tcg/tci.c'))
=20
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'gdbstub.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'migration/ram.c',
+  'qtest.c',
+))
+
 # TODO: add each directory to the subdirs from its own meson.build, once
 # we have those
 trace_events_subdirs =3D [
--=20
1.8.3.1



