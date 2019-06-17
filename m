Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C10BC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1763E2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1763E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrRC-0006BJ-Cn
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hcrPn-0004uc-02
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hcrPj-0001Kx-0P
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hcrPh-0001Io-33
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 670337FDC9;
 Mon, 17 Jun 2019 13:11:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.22.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4EDF8BE5A;
 Mon, 17 Jun 2019 13:11:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 14:11:03 +0100
Message-Id: <20190617131103.1413-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 13:11:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably sized
 SIOCGSTAMP with new kernels
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SIOCGSTAMP symbol was previously defined in the
asm-generic/sockios.h header file. QEMU sees that header
indirectly via sys/socket.h

In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
Instead it provides only SIOCGSTAMP_OLD, which only uses a
32-bit time_t on 32-bit architectures.

The linux/sockios.h header then defines SIOCGSTAMP using
either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
on 32-bit architectures

To cope with this we must now define two separate syscalls,
with corresponding old and new sizes, as well as including
the new linux/sockios.h header.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  1 +
 linux-user/syscall_defs.h  |  5 +++++
 linux-user/syscall_types.h |  4 ++++
 4 files changed, 25 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 5e84dc7c3a..5a6d6def7e 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -222,8 +222,23 @@
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq))=
)
   IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
+
+#ifdef SIOCGSTAMP_OLD
+  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
+#else
   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
+#endif
+#ifdef SIOCGSTAMPNS_OLD
+  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
+#else
   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
+#endif
+#ifdef SIOCGSTAMP_NEW
+  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
+#endif
+#ifdef SIOCGSTAMPNS_NEW
+  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64)))
+#endif
=20
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
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
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7f141f699c..7830b600e7 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -750,6 +750,11 @@ struct target_pollfd {
=20
 #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
 #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) *=
/
+#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timeval) *=
/
+#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (timespec) =
*/
+#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6, size=
of(long long) + sizeof(long)) /* Get stamp (timeval64) */
+#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7, size=
of(long long) + sizeof(long)) /* Get stamp (timespec64) */
+
=20
 /* Networking ioctls */
 #define TARGET_SIOCADDRT       0x890B          /* add routing table entr=
y */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b98a23b0f1..de4c5a5b6f 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -20,6 +20,10 @@ STRUCT(timeval,
 STRUCT(timespec,
        MK_ARRAY(TYPE_LONG, 2))
=20
+STRUCT(timeval64, TYPE_LONGLONG, TYPE_LONG)
+
+STRUCT(timespec64, TYPE_LONGLONG, TYPE_LONG)
+
 STRUCT(rtentry,
        TYPE_ULONG, MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr=
), MK_STRUCT(STRUCT_sockaddr),
        TYPE_SHORT, TYPE_SHORT, TYPE_ULONG, TYPE_PTRVOID, TYPE_SHORT, TYP=
E_PTRVOID,
--=20
2.21.0


