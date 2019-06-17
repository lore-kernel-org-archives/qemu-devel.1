Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C0C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD36A2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD36A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqQ7-0003j1-Q7
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hcq0b-0004f7-B5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hcq0Y-0004wl-FY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hcq0T-0004Ft-TY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CBB0D309266A;
 Mon, 17 Jun 2019 11:40:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.22.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBFB15B2E6;
 Mon, 17 Jun 2019 11:40:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 12:40:05 +0100
Message-Id: <20190617114005.24603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 17 Jun 2019 11:40:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] linux-user: fix includes to find SIOCGSTAMP
 with latest kernel headers
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SIOCGSTAMP symbol was previously defined in the
asm-generic/sockios.h header file. QEMU sees that header
indirectly via

   sys/socket.h
    -> bits/socket.h
        -> asm/socket.h
            -> asm-generic/socket.h
                -> asm/sockios.h
                    -> asm-generic/sockios.h

In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
Instead it provides only SIOCGSTAMP_OLD.

The linux/sockios.h header now defines SIOCGSTAMP using either
SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. This linux only
header file is not pulled in by QEMU though, so we get a build
failure:

qemu/linux-user/ioctls.h:225:9: error: =E2=80=98SIOCGSTAMP=E2=80=99 undec=
lared here (not in a function); did you mean =E2=80=98SIOCSRARP=E2=80=99?
  225 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
      |         ^~~~~~~~~~
qemu/linux-user/syscall.c:4855:23: note: in definition of macro =E2=80=98=
IOCTL=E2=80=99
 4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~
qemu/linux-user/ioctls.h:226:9: error: =E2=80=98SIOCGSTAMPNS=E2=80=99 und=
eclared here (not in a function); did you mean =E2=80=98SIOCGSTAMP_OLD=E2=
=80=99?
  226 |   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
      |         ^~~~~~~~~~~~
qemu/linux-user/syscall.c:4855:23: note: in definition of macro =E2=80=98=
IOCTL=E2=80=99
 4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b187c1281d..f13e260b02 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -37,6 +37,7 @@
 #include <sched.h>
 #include <sys/timex.h>
 #include <sys/socket.h>
+#include <linux/sockios.h>
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <poll.h>
--=20
2.21.0


