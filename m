Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F9C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B16207FF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNYK5RAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B16207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2lQI-0000aJ-9J
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevinb@redhat.com>) id 1j2lPh-00005t-LN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevinb@redhat.com>) id 1j2lPf-0001Gz-L7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:34:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevinb@redhat.com>) id 1j2lPf-0001Fg-Hq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581726866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eMam4nDTMqQQm5Ir1ppDiKogkOT7jDofuk409msA+iA=;
 b=DNYK5RAS2U17Vq2PUJP4CUPmtNperMEIwNErViOGFJVjymkadiu01LYBC/Jg4+9SjRCke/
 ZsLWkVxvqKsV+VctKM4lqId9mh8dpAsaqnfOFu3dPRKIBv2wPZzhnawq0y43eBeb/R8tOs
 Ar/pO7dOuZaaMlW8Xdce7cItmVX2krY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-VrauwYCmMGScWyj10W_6iQ-1; Fri, 14 Feb 2020 19:34:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 113351857341
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 00:34:21 +0000 (UTC)
Received: from f31-1.lan (ovpn-116-54.phx2.redhat.com [10.3.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39E8683865;
 Sat, 15 Feb 2020 00:34:18 +0000 (UTC)
From: Kevin Buettner <kevinb@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Handle gdb.MemoryError exception in dump-guest-memory.py
Date: Fri, 14 Feb 2020 17:33:56 -0700
Message-Id: <20200215003356.36352-1-kevinb@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VrauwYCmMGScWyj10W_6iQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: marcandre.lureau@redhat.com, Kevin Buettner <kevinb@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Included a "Signed-off-by" line in this version.]

I recently investigated a bug in which the dump-guest-memory.py script
sees a gdb.MemoryError exception while attempting to dump memory
obtained from a QEMU core dump.  (And, yes, dump-guest-core=3Don was
specified in the -machine option of the QEMU invocation.)

It turns out that memory region in question is not being placed in the
core dump and, after stepping through the kernel core dumping code
responsible for making this decision, it looks reasonable to me to not
include that region in the core dump.  The region in question consists
of all zeros and, according to the kernel's logic, has never been
written to.

This commit makes a small change to the dump-guest-memory script to
cause inaccessible memory to be dumped as zeroes.  This avoids the
exception and places the correct values in the guest memory dump.

Signed-off-by: Kevin Buettner <kevinb@redhat.com>
---
 scripts/dump-guest-memory.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 4177261d33..fbdfba458b 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -539,7 +539,12 @@ shape and this command should mostly work."""
=20
             while left > 0:
                 chunk_size =3D min(TARGET_PAGE_SIZE, left)
-                chunk =3D qemu_core.read_memory(cur, chunk_size)
+                try:
+                    chunk =3D qemu_core.read_memory(cur, chunk_size)
+                except gdb.MemoryError:
+                    # Consider blocks of memory absent from a core file
+                    # as being zeroed.
+                    chunk =3D bytes(chunk_size)
                 vmcore.write(chunk)
                 cur +=3D chunk_size
                 left -=3D chunk_size
--=20
2.24.1


