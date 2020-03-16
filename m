Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD0EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF28205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUyTnoid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF28205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxgu-0008Lr-PV
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHq-00043p-8T
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHo-00067F-15
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHn-00064j-Ry
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKYQroT23jMsitGoxPZlSc59fsUSsrMk/phQvxBNmAo=;
 b=iUyTnoidDp52c33YkswfNx5D/r8J/TQTC2ip+87/NDxh6sfghu2Y8YdhwqTibjK3YrZdBC
 vh///QT33/zMCuT4y5Wt6CCPznUTy1sdet21VjgGNrRFo/nIZ9CdzPVrVR/4oTbwgGhSII
 BcMb/S1JNmacYmmW6DN+kaeMtMT8oRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-4qczhLZ4OMKbu1OZiaAI4A-1; Mon, 16 Mar 2020 17:28:33 -0400
X-MC-Unique: 4qczhLZ4OMKbu1OZiaAI4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97DFA800D50
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:32 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43D619C4F;
 Mon, 16 Mar 2020 21:28:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/61] Use -isystem for linux-headers dir
Date: Mon, 16 Mar 2020 22:26:59 +0100
Message-Id: <1584394048-44994-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target | 2 +-
 configure       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 2d43dc5..934a9f7 100644
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
index 44a70cf..06fcd07 100755
--- a/configure
+++ b/configure
@@ -900,7 +900,7 @@ Linux)
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
1.8.3.1



