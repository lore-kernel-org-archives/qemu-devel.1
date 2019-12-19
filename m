Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AFBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3133524650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swo8TF/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3133524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuuq-0004QM-SC
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqi-0007Hg-PB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqh-0005lb-HB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqh-0005i4-AF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtALf0rmGbFrQn1hpqABDHjCWNaum13GWaizSDkJnFA=;
 b=Swo8TF/StTrSSqiWEfdwht9S/coICiu6rNoNQv4olOLRW/LSp/QOZ85T0S7MmQHgfvd8k/
 +hIDkEP4P0CUJ9cZUDhOujT4o5oOF+U1p07GTUr1acCD/ZMWVN0QQQhSbEiidAfYycMBcD
 sE5TgFGMKaGt7jez9/7iJTzHN95e318=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-IL9d6mZAOUeynl13-hAz7Q-1; Thu, 19 Dec 2019 07:24:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76FE1005513
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:08 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 282CE60C18;
 Thu, 19 Dec 2019 12:24:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 096/132] meson: convert hw/cpu
Date: Thu, 19 Dec 2019 13:23:16 +0100
Message-Id: <1576758232-12439-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IL9d6mZAOUeynl13-hAz7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/cpu/Makefile.objs | 5 -----
 hw/cpu/meson.build   | 6 ++++++
 hw/meson.build       | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)
 delete mode 100644 hw/cpu/Makefile.objs
 create mode 100644 hw/cpu/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index acc6bee..67a2bb5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -6,7 +6,6 @@ devices-dirs-y +=3D audio/
 devices-dirs-y +=3D block/
 devices-dirs-y +=3D bt/
 devices-dirs-y +=3D char/
-devices-dirs-y +=3D cpu/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
deleted file mode 100644
index 8db9e8a..0000000
--- a/hw/cpu/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_ARM11MPCORE) +=3D arm11mpcore.o
-obj-$(CONFIG_REALVIEW) +=3D realview_mpcore.o
-obj-$(CONFIG_A9MPCORE) +=3D a9mpcore.o
-obj-$(CONFIG_A15MPCORE) +=3D a15mpcore.o
-common-obj-y +=3D core.o cluster.o
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
new file mode 100644
index 0000000..9e52fee
--- /dev/null
+++ b/hw/cpu/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('core.c', 'cluster.c'))
+
+specific_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'=
))
+specific_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c=
'))
+specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
+specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 3f40df2..5850b07 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('cpu')
 subdir('display')
 subdir('dma')
 subdir('gpio')
--=20
1.8.3.1



