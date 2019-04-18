Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91208C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A0F206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A0F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8Wq-00047n-CK
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:00:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8Uz-0002PV-OK
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002Bs-27
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002An-RM
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9283F301BE65
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 641755C206
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E19DE1132B6C; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:52 +0200
Message-Id: <20190418145355.21100-4-armbru@redhat.com>
In-Reply-To: <20190418145355.21100-1-armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/6] gdbstub: Reject invalid RLE repeat counts
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418145352.Ixm7hCBGkbRzxMSNV7zR4Rc3HOSTxiX04l-V0pU6sOE@z>

"Debugging with GDB / Appendix E GDB Remote Serial Protocol /
Overview" specifies "The printable characters '#' and '$' or with a
numeric value greater than 126 must not be used."  gdb_read_byte()
only rejects values < 32.  This is wrong.  Impact depends on the caller:

* gdb_handlesig() passes a char.  Incorrectly accepts '#', '$' and
  '\127'.

* gdb_chr_receive() passes an uint8_t.  Additionally accepts
  characters with the most-significant bit set.

Correct the validity check to match the specification.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..a6dce1b027 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2064,7 +2064,7 @@ static void gdb_read_byte(GDBState *s, int ch)
             }
             break;
         case RS_GETLINE_RLE:
-            if (ch < ' ') {
+            if (ch < ' ' || ch == '#' || ch == '$' || ch > 126) {
                 /* invalid RLE count encoding */
                 trace_gdbstub_err_invalid_repeat((uint8_t)ch);
                 s->state = RS_GETLINE;
-- 
2.17.2


