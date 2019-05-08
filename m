Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C128C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F13C20644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32851 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOHRE-0004Pp-5q
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 03:56:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOHQR-0003VS-2k
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOHQQ-0004Hv-5E
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hOHQQ-0004FP-0F; Wed, 08 May 2019 03:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEFA2307D850;
	Wed,  8 May 2019 07:55:36 +0000 (UTC)
Received: from thuth.com (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A346760BF3;
	Wed,  8 May 2019 07:55:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 09:55:27 +0200
Message-Id: <20190508075527.32164-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 08 May 2019 07:55:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] tests/Makefile: Remove unused test-obj-y
 variable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I recently noticed that test-obj-y contains a file called
tests/check-block-qtest.o which simply does not belong to any .c
file and thus wondered why this is not causing any trouble. It is
only used to add -Itests to the command line (which refers to the
build directory). However, it is not needed because "-iquote $(@D)"
already sets this up in rules.mak. Thus we can simply remove this
variable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Fixed patch description with the information that Paolo provided.

 tests/Makefile.include | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7c8b9c84b2..dfc4b7746f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -482,25 +482,6 @@ GENERATED_FILES +=3D tests/test-qapi-types.h \
 	tests/test-qapi-events-sub-sub-module.h \
 	tests/test-qapi-introspect.h
=20
-test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
-	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
-	tests/check-qjson.o tests/check-qlit.o \
-	tests/check-block-qtest.o \
-	tests/test-coroutine.o tests/test-string-output-visitor.o \
-	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
-	tests/test-clone-visitor.o \
-	tests/test-qobject-input-visitor.o \
-	tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
-	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
-	tests/test-opts-visitor.o tests/test-qmp-event.o \
-	tests/rcutorture.o tests/test-rcu-list.o \
-	tests/test-rcu-simpleq.o \
-	tests/test-rcu-tailq.o \
-	tests/test-qdist.o tests/test-shift128.o \
-	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o tests/atomic64-bench.o
-
-$(test-obj-y): QEMU_INCLUDES +=3D -Itests
 QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
=20
=20
--=20
2.21.0


