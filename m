Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA02C4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2003120763
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaYgiAB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2003120763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAjU-00055y-5Q
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jCAhf-0002fT-5i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jCAhe-0005wR-4E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jCAhe-0005us-0R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583969033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZN4m+/PqtpyDtwq5UdVct/FSMkksce+UIeifqMZuiA=;
 b=TaYgiAB09kytkKAEvCgzvwEqeqrqMXjp5KDlB4gFU5uQYobkfcbSfPKa/y5wiGhkfC8av1
 J8doauWGv6xcn/nIagU4BMyqDfWYMwzPPrpDZIhu+hl4+t2lADOIOdb7JUBtGPKwLfNmUt
 ZH7Ih3Q1gehqmrxobBOYMcePHx4eA40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Es2TVU5FPU2VwlhRXc3kkg-1; Wed, 11 Mar 2020 19:23:50 -0400
X-MC-Unique: Es2TVU5FPU2VwlhRXc3kkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685D6800D4E;
 Wed, 11 Mar 2020 23:23:49 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A488460BF1;
 Wed, 11 Mar 2020 23:23:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] Use -isystem for linux-headers dir
Date: Wed, 11 Mar 2020 19:23:41 -0400
Message-Id: <20200311232342.1614944-2-ehabkost@redhat.com>
In-Reply-To: <20200311232342.1614944-1-ehabkost@redhat.com>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, jtomko@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

glibc and Linux-provided headers are known to generate macro
redefinition warnings when used together.  For example:
<linux/mman.h> and <sys/mman.h> duplicate some macro definitions.

We normally never see those warnings because GCC suppresses
warnings generated by system headers.  We carry our own copy of
Linux header files, though, and this makes those warnings not be
suppressed when glibc headers are included before Linux headers
(e.g. if <sys/mman.h> is included before <linux/mman.h>).

Use -isystem instead of -I for linux-headers.  This makes the
compiler treat our linux-headers directory the same way it treats
system-provided Linux headers, and suppress warnings generated by
them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Use -isystem for $PWD/linux-headers too
  Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
---
 Makefile.target | 2 +-
 configure       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 2d43dc586a..934a9f7431 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -12,7 +12,7 @@ endif
=20
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
-QEMU_CFLAGS +=3D -I../linux-headers
+QEMU_CFLAGS +=3D -isystem ../linux-headers
 endif
 QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH)=
 -DNEED_CPU_H
=20
diff --git a/configure b/configure
index cbf864bff1..bf5bf70600 100755
--- a/configure
+++ b/configure
@@ -899,7 +899,7 @@ Linux)
   linux=3D"yes"
   linux_user=3D"yes"
   kvm=3D"yes"
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU=
_INCLUDES"
+  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -isystem $PWD/linux=
-headers $QEMU_INCLUDES"
   supported_os=3D"yes"
   libudev=3D"yes"
 ;;
--=20
2.24.1


