Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317DC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C83F20749
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drPpIGyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C83F20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCADK-0005uP-4T
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jCACV-00058P-MK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jCACU-00019v-7O
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jCACU-00018E-41
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583967101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9M+fk402aDyMTIond6ySEoZWgIvegTFPDDHFMIDsNpk=;
 b=drPpIGyz1sA/cXcBisq8XG4dkC+Cx7wTp9buOweueXJqn9nhO+YKC3MHV4Rglg7urUoNzP
 7z9lztTLuSEeranSqfRDpmVWWHf98wnJ/92BvqJr1fmDDHCf6PAcQpR0i31UTKUQZ/9+OZ
 egeGJj8iout7jj4Qe67rF6GAcfu1je4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-LQWFiLgyMqSoywHrxe0kPw-1; Wed, 11 Mar 2020 18:51:38 -0400
X-MC-Unique: LQWFiLgyMqSoywHrxe0kPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A460018AB2C0;
 Wed, 11 Mar 2020 22:51:37 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 024028F374;
 Wed, 11 Mar 2020 22:51:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] Use -isystem for linux-headers dir
Date: Wed, 11 Mar 2020 18:51:29 -0400
Message-Id: <20200311225130.1599619-2-ehabkost@redhat.com>
In-Reply-To: <20200311225130.1599619-1-ehabkost@redhat.com>
References: <20200311225130.1599619-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index cbf864bff1..04a2a7f2dd 100755
--- a/configure
+++ b/configure
@@ -899,7 +899,7 @@ Linux)
   linux=3D"yes"
   linux_user=3D"yes"
   kvm=3D"yes"
-  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU=
_INCLUDES"
+  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -I$PWD/linux-header=
s $QEMU_INCLUDES"
   supported_os=3D"yes"
   libudev=3D"yes"
 ;;
--=20
2.24.1


