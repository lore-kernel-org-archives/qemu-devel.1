Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45185C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 04:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFB5206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 04:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="dJBAV1li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsgMv-0000Y1-BS
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 00:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paulus@ozlabs.org>) id 1hsgMU-0008TI-OT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 00:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paulus@ozlabs.org>) id 1hsgMT-0005Tm-60
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 00:37:14 -0400
Received: from ozlabs.org ([203.11.71.1]:40625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <paulus@ozlabs.org>)
 id 1hsgMS-00056I-AJ; Wed, 31 Jul 2019 00:37:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45z0y52tY9z9sBF; Wed, 31 Jul 2019 14:37:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1564547821; bh=vx2RT6qoZjZbe3n1PLLehcFhxntjm5MZuNilM0hjAwQ=;
 h=Date:From:To:Cc:Subject:From;
 b=dJBAV1liTtOH5z70Yxfu8MIb4QtF8aOEDrkr2CxcTrTHLUJvrMUbRZvPNjF15PUSw
 5dL4wXvzumgVqMxML7vH79HdSdlCJeq6bdka6jez2pbZ6VvaWgiiGS326eFuIV/9+g
 yRxBd0C9b3IExVY7pBUzBzvDDX+OCbQQ4no1FYnfHmzLzjtE1aDbDjA+UDWSVyul+o
 K8S2RPv/NN5vOQ+X56PiiQr6Mx/VHdq4dwL2zWjMBc1wfWpy0e+Nu/oREWpWZ0ZmDM
 g/JKOmrQrbPKNu5//bHXdZ5klv9ECLgvyljoV4bkKBdT1a11t+lrFel1ALN6CRznIp
 /rGIW9y95X1yA==
Date: Wed, 31 Jul 2019 14:36:54 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <20190731043653.shdi5sizjp4t65op@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH] spapr: Implement better workaround in
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Fixes: 6c3bc244d3cb ("spapr: Implement bug in spapr-vty device to be compatible with PowerVM")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 hw/char/spapr_vty.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 617303dbaf..65a7c2ffbd 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -57,25 +57,19 @@ static int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
     int n = 0;
 
     while ((n < max) && (dev->out != dev->in)) {
-        buf[n++] = dev->buf[dev->out++ % VTERM_BUFSIZE];
-
-        /* PowerVM's vty implementation has a bug where it inserts a
-         * \0 after every \r going to the guest.  Existing guests have
-         * a workaround for this which removes every \0 immediately
-         * following a \r, so here we make ourselves bug-for-bug
-         * compatible, so that the guest won't drop a real \0-after-\r
-         * that happens to occur in a binary stream. */
-        if (buf[n - 1] == '\r') {
-            if (n < max) {
-                buf[n++] = '\0';
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
+        if (n > 0 && (buf[n - 1] == '\r') &&
+                (dev->buf[dev->out % VTERM_BUFSIZE] == '\0')) {
+            break;
         }
+        buf[n++] = dev->buf[dev->out++ % VTERM_BUFSIZE];
     }
 
     qemu_chr_fe_accept_input(&dev->chardev);
-- 
2.11.0


