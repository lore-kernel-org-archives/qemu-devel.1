Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3132C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB80208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB80208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdbM8-0000mB-26
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdbJy-0007Ra-QG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdbJw-0004KG-P4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:12:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58724 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hdbJr-0003WP-0r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:12:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C493A1A23C5;
 Wed, 19 Jun 2019 16:10:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A36111A1E7D;
 Wed, 19 Jun 2019 16:10:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 16:10:26 +0200
Message-Id: <1560953429-29203-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560953429-29203-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1560953429-29203-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v11 2/5] linux-user: Add support for
 setsockopt() option SOL_ALG
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
Cc: lvivier@redhat.com, Yunqiang Su <ysu@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yunqiang Su <ysu@wavecomp.com>

Add support for options SOL_ALG of the syscall setsockopt(). This
option is used in relation to Linux kernel Crypto API, and allows
a user to set additional information for the cipher operation via
syscall setsockopt(). The field "optname" must be one of the
following:

  - ALG_SET_KEY =E2=80=93 seting the key
  - ALG_SET_AEAD_AUTHSIZE =E2=80=93 set the authentication tag size

SOL_ALG is relatively newer setsockopt() option. Therefore, the
code that handles SOL_ALG is enclosed in "ifdef" so that the build
does not fail for older kernels that do not contain support for
SOL_ALG. "ifdef" also contains check if ALG_SET_KEY and
ALG_SET_AEAD_AUTHSIZE are defined.

Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f267ad0..d116287 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -102,6 +102,7 @@
 #include <linux/blkpg.h>
 #include <netpacket/packet.h>
 #include <linux/netlink.h>
+#include <linux/if_alg.h>
 #include "linux_loop.h"
 #include "uname.h"
=20
@@ -1989,6 +1990,36 @@ static abi_long do_setsockopt(int sockfd, int leve=
l, int optname,
             goto unimplemented;
         }
         break;
+#if defined(SOL_ALG) && defined(ALG_SET_KEY) && defined(ALG_SET_AEAD_AUT=
HSIZE)
+    case SOL_ALG:
+        switch (optname) {
+        case ALG_SET_KEY:
+        {
+            char *alg_key =3D g_malloc(optlen);
+
+            if (!alg_key) {
+                return -TARGET_ENOMEM;
+            }
+            if (copy_from_user(alg_key, optval_addr, optlen)) {
+                g_free(alg_key);
+                return -TARGET_EFAULT;
+            }
+            ret =3D get_errno(setsockopt(sockfd, level, optname,
+                                       alg_key, optlen));
+            g_free(alg_key);
+            break;
+        }
+        case ALG_SET_AEAD_AUTHSIZE:
+        {
+            ret =3D get_errno(setsockopt(sockfd, level, optname,
+                                       NULL, optlen));
+            break;
+        }
+        default:
+            goto unimplemented;
+        }
+        break;
+#endif
     case TARGET_SOL_SOCKET:
         switch (optname) {
         case TARGET_SO_RCVTIMEO:
--=20
2.7.4


