Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BF520850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BF520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbqU-0006Q5-Bu
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:08:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQblp-00031u-26
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQblo-0002a1-5o
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQblo-0002ZM-0a
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B137309B15C
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 18:03:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EAC45D72A;
	Tue, 14 May 2019 18:03:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 001D011385D0; Tue, 14 May 2019 20:03:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 20:03:08 +0200
Message-Id: <20190514180311.16028-4-armbru@redhat.com>
In-Reply-To: <20190514180311.16028-1-armbru@redhat.com>
References: <20190514180311.16028-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 18:03:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/6] gdbstub: Reject invalid RLE repeat
 counts
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
Cc: thuth@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 gdbstub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..c41eb1de07 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2064,7 +2064,11 @@ static void gdb_read_byte(GDBState *s, int ch)
             }
             break;
         case RS_GETLINE_RLE:
-            if (ch < ' ') {
+            /*
+             * Run-length encoding is explained in "Debugging with GDB /
+             * Appendix E GDB Remote Serial Protocol / Overview".
+             */
+            if (ch < ' ' || ch =3D=3D '#' || ch =3D=3D '$' || ch > 126) =
{
                 /* invalid RLE count encoding */
                 trace_gdbstub_err_invalid_repeat((uint8_t)ch);
                 s->state =3D RS_GETLINE;
--=20
2.17.2


