Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C1C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3CC2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFfnMmpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3CC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2kOS-000175-HN
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 18:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevinb@redhat.com>) id 1j2kNu-0000SO-HJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevinb@redhat.com>) id 1j2kNt-0004Z0-0g
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:28:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevinb@redhat.com>) id 1j2kNs-0004Yk-Tf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581722911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zqAqgsDyJfdRbbxw4hBDvYNHFHYPCepiaSqrZ7CEBaM=;
 b=BFfnMmpfm5ctbNtr11vzTR2rRt6Ya7ZQvrpc7Ar9kwviQTBKnU2b0s/sMpetoyZaj32UFa
 h1MLlVhquf5ERsmvrIa6jHKSIHwAgYcewNLITKSrm2G7hh98PoNJpz69do2pW3T5svVg9e
 /0Iy0yNyZpg9hdnGFZBjNuFeDPzc3lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-KAD2fTgyNZGuO3abQ7-kTQ-1; Fri, 14 Feb 2020 18:28:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B80100550E
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 23:28:25 +0000 (UTC)
Received: from f31-1.lan (ovpn-116-54.phx2.redhat.com [10.3.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD048EA1B;
 Fri, 14 Feb 2020 23:28:25 +0000 (UTC)
From: Kevin Buettner <kevinb@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Handle gdb.MemoryError exception in dump-guest-memory.py
Date: Fri, 14 Feb 2020 16:26:50 -0700
Message-Id: <20200214232650.35381-1-kevinb@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KAD2fTgyNZGuO3abQ7-kTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Buettner <kevinb@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


