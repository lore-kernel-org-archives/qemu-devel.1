Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA0C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4153622DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D+66zVAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4153622DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LOz-0000qZ-8Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0r-0005Bz-E2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0q-0008UL-48
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:33 -0400
Received: from ozlabs.org ([203.11.71.1]:49305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0p-00089v-82; Wed, 21 Aug 2019 03:26:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjF2C7Rz9sQy; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372353;
 bh=5NEgZKDdcOaJCDCiAi3qAZVToJWd/48Fn/4AGJJvmnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D+66zVAnbnU6cpgNsHZl/FTd9/pSzz+MYZMAwmIXgHOPhYP134ttrlI7zILO5tdxy
 OtJx5chAObPJ2w60MYeBfm0ozlJtPrJ02hcst4QhR+OVeKsxrG9T4spBNKDif8lg+v
 zaTn+ROwgsv4g8Ku9DV//rZr4o8FrtBlt+kWin+k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:36 +1000
Message-Id: <20190821072542.23090-37-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 36/42] spapr: Implement better workaround in
 spapr-vty device
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 Paul Mackerras <paulus@ozlabs.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Mackerras <paulus@ozlabs.org>

Linux guest kernels have code which scans the string of characters
returned from the H_GET_TERM_CHAR hypercall and removes any \0
character which comes immediately after a \r character.  This is to
work around a bug which was present in some ancient versions of
PowerVM.  In order to avoid the corruption of the console byte stream
that this introduced, commit 6c3bc244d3cb ("spapr: Implement bug in
spapr-vty device to be compatible with PowerVM") added a workaround
which adds a \0 character after every \r character.  Unfortunately,
this corrupts the console byte stream for those operating systems,
such as AIX, which don't remove the null bytes.

We can avoid triggering the Linux kernel workaround if we avoid
returning a buffer which contains a \0 after a \r.  We can do that by
breaking out of the loop in vty_getchars() if we are about to insert a
\0 and the previous character in the buffer is a \r.  That means we
return the characters up to the \r for the current H_GET_TERM_CHAR,
and the characters starting with the \0 for the next one.

With this workaround, we don't insert any spurious characters and we
avoid triggering the Linux kernel workaround, so the guest will
receive an uncorrupted stream whether or not they have the workaround.

Fixes: 6c3bc244d3cb ("spapr: Implement bug in spapr-vty device to be comp=
atible with PowerVM")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Message-Id: <20190731043653.shdi5sizjp4t65op@oak.ozlabs.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/char/spapr_vty.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 7f860fcce7..087c93e4fa 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -59,25 +59,19 @@ static int vty_getchars(SpaprVioDevice *sdev, uint8_t=
 *buf, int max)
     int n =3D 0;
=20
     while ((n < max) && (dev->out !=3D dev->in)) {
-        buf[n++] =3D dev->buf[dev->out++ % VTERM_BUFSIZE];
-
-        /* PowerVM's vty implementation has a bug where it inserts a
-         * \0 after every \r going to the guest.  Existing guests have
-         * a workaround for this which removes every \0 immediately
-         * following a \r, so here we make ourselves bug-for-bug
-         * compatible, so that the guest won't drop a real \0-after-\r
-         * that happens to occur in a binary stream. */
-        if (buf[n - 1] =3D=3D '\r') {
-            if (n < max) {
-                buf[n++] =3D '\0';
-            } else {
-                /* No room for the extra \0, roll back and try again
-                 * next time */
-                dev->out--;
-                n--;
-                break;
-            }
+        /*
+         * Long ago, PowerVM's vty implementation had a bug where it
+         * inserted a \0 after every \r going to the guest.  Existing
+         * guests have a workaround for this which removes every \0
+         * immediately following a \r.  To avoid triggering this
+         * workaround, we stop before inserting a \0 if the preceding
+         * character in the output buffer is a \r.
+         */
+        if (n > 0 && (buf[n - 1] =3D=3D '\r') &&
+                (dev->buf[dev->out % VTERM_BUFSIZE] =3D=3D '\0')) {
+            break;
         }
+        buf[n++] =3D dev->buf[dev->out++ % VTERM_BUFSIZE];
     }
=20
     qemu_chr_fe_accept_input(&dev->chardev);
--=20
2.21.0


