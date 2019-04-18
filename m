Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA1C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F11C206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F11C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8ZI-000684-8y
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:03:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8Uz-0002P9-Nw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002CG-4F
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002B5-Qw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBF7281E1C
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D0CB600C2
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E51BB1132B74; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:53 +0200
Message-Id: <20190418145355.21100-5-armbru@redhat.com>
In-Reply-To: <20190418145355.21100-1-armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 18 Apr 2019 14:53:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/6] gdbstub: Fix misuse of isxdigit()
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
Message-ID: <20190418145353.-kBp3M_kzGlw8646Tq0vEzn1OsRf7bBi7BzyqFOQdr0@z>

gdb_read_byte() passes its @ch argument to isxdigit().  Undefined
behavior when the value is negative.  Two callers:

* gdb_chr_receive() passes an uint8_t value.  Safe.

* gdb_handlesig() a char value.  Unsafe.  Not a security issue,
  because the characters come from the gdb client, which is trusted.

The obvious fix would be casting @ch to unsigned char.  But note that
gdb_read_byte() already casts @ch to uint8_t in many places.  Uses of
@ch without such a cast:

(1) Compare to a character constant with == or !=

(2) s->linesum += ch

(3) Store ch or ch ^ 0x20 into s->line_buf[]

(4) Check for invalid RLE count:
    ch < ' ' || ch == '#' || ch == '$' || ch > 126

(5) Pass to isxdigit()

(6) Pass to fromhex()

Change the parameter type from int to uint8_t, and drop the now
redundant casts.  Affects the above uses as follows:

(1) No change: the character constants are all non-negative.

(2) Effectively no change: we only ever use s->linesum & 0xff, and
    s->linesum is int.

(3) No change: s->line_buf[] is char[].

(4) No change.

(5) Avoid undefined behavior.

(6) No change: only reached when isxdigit(ch)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 gdbstub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a6dce1b027..166ccbfbf4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1987,7 +1987,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
     va_end(va);
 }
 
-static void gdb_read_byte(GDBState *s, int ch)
+static void gdb_read_byte(GDBState *s, uint8_t ch)
 {
     uint8_t reply;
 
@@ -2001,7 +2001,7 @@ static void gdb_read_byte(GDBState *s, int ch)
         } else if (ch == '+') {
             trace_gdbstub_io_got_ack();
         } else {
-            trace_gdbstub_io_got_unexpected((uint8_t)ch);
+            trace_gdbstub_io_got_unexpected(ch);
         }
 
         if (ch == '+' || ch == '$')
@@ -2024,7 +2024,7 @@ static void gdb_read_byte(GDBState *s, int ch)
                 s->line_sum = 0;
                 s->state = RS_GETLINE;
             } else {
-                trace_gdbstub_err_garbage((uint8_t)ch);
+                trace_gdbstub_err_garbage(ch);
             }
             break;
         case RS_GETLINE:
@@ -2066,11 +2066,11 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_GETLINE_RLE:
             if (ch < ' ' || ch == '#' || ch == '$' || ch > 126) {
                 /* invalid RLE count encoding */
-                trace_gdbstub_err_invalid_repeat((uint8_t)ch);
+                trace_gdbstub_err_invalid_repeat(ch);
                 s->state = RS_GETLINE;
             } else {
                 /* decode repeat length */
-                int repeat = (unsigned char)ch - ' ' + 3;
+                int repeat = ch - ' ' + 3;
                 if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
                     /* that many repeats would overrun the command buffer */
                     trace_gdbstub_err_overrun();
@@ -2092,7 +2092,7 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM1:
             /* get high hex digit of checksum */
             if (!isxdigit(ch)) {
-                trace_gdbstub_err_checksum_invalid((uint8_t)ch);
+                trace_gdbstub_err_checksum_invalid(ch);
                 s->state = RS_GETLINE;
                 break;
             }
@@ -2103,7 +2103,7 @@ static void gdb_read_byte(GDBState *s, int ch)
         case RS_CHKSUM2:
             /* get low hex digit of checksum */
             if (!isxdigit(ch)) {
-                trace_gdbstub_err_checksum_invalid((uint8_t)ch);
+                trace_gdbstub_err_checksum_invalid(ch);
                 s->state = RS_GETLINE;
                 break;
             }
-- 
2.17.2


