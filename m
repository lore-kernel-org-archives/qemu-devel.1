Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFAFC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266612072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtWDpctZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266612072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJDl-0004iA-8L
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jFJD0-0004BZ-V3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jFJCz-0004ea-GZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:05:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jFJCy-0004Vc-TD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584716712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2s+RuwgIkJMzwLNbUJw79v0XPHLUwu6+3Hl6Oz8WBpE=;
 b=DtWDpctZFRcTZK5iB4AhQgGOtsd9NI6xZGtuh4KJoxMk4H++e4XQ84vLhOHoBJrEkRPCLC
 pfHfmbEMHdFWCKa4m5IbaqmOmGrgaywrevG4PQUSXGlXYSeiTLmxE18ARAXS0yIhLPqN6t
 WXLF+bPVD9SWxTsfKIje3J9kVUtinqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-qRvTKxH_PkSfiC-qSAZQmg-1; Fri, 20 Mar 2020 11:05:10 -0400
X-MC-Unique: qRvTKxH_PkSfiC-qSAZQmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70195801E53;
 Fri, 20 Mar 2020 15:05:09 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1DD19756;
 Fri, 20 Mar 2020 15:05:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] qga: Fix undefined C behavior
Date: Fri, 20 Mar 2020 10:05:07 -0500
Message-Id: <20200320150507.994744-1-eblake@redhat.com>
MIME-Version: 1.0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QAPI struct GuestFileWhence has a comment about how we are
exploiting equivalent values between two different integer types
shared in a union. But C says behavior is undefined on assignments to
overlapping storage when the two types are not the same width, and
indeed, 'int64_t value' and 'enum QGASeek name' are very likely to be
different in width.  Utilize a temporary variable to fix things.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 0b4b49387
Fixes: Coverity CID 1421990
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qga/commands.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index f8852beb9ca4..4471a9f08d38 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -482,10 +482,15 @@ done:
  * the guest's SEEK_ constants.  */
 int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 {
-    /* Exploit the fact that we picked values to match QGA_SEEK_*. */
+    /*
+     * Exploit the fact that we picked values to match QGA_SEEK_*;
+     * however, we have to use a temporary variable since the union
+     * members may have different size.
+     */
     if (whence->type =3D=3D QTYPE_QSTRING) {
+        int value =3D whence->u.name;
         whence->type =3D QTYPE_QNUM;
-        whence->u.value =3D whence->u.name;
+        whence->u.value =3D value;
     }
     switch (whence->u.value) {
     case QGA_SEEK_SET:
--=20
2.25.1


