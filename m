Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C31CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DB024125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg5Mxndj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DB024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuc4R-0000nY-5E
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuatx-0000F1-Ib
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuatw-0005K7-GL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuatw-0005JZ-4C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI+d7CIRUZu3ItcHk9K0DPGDMvnqS3KrSbSLjc8ydAU=;
 b=Zg5MxndjagdtqdzufoD7OZptnfH68SzN3lE4Yd89IvCRGZbuOTQfgWe+smMCsVVCiNcbOc
 GWRyp4xE3Z4kl39W2k6woKL6cTdyckZ4r+oLkqSi2ee9UFZhtWNMtST6Zb7TMWF/SKzJxU
 U6WERL0a75DTPBxtZvpI+tVF2OnMpFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-mCFZYx_6N4C6iEYcpGUTzQ-1; Thu, 23 Jan 2020 06:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4451C801E6C;
 Thu, 23 Jan 2020 11:43:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7AB21001B05;
 Thu, 23 Jan 2020 11:43:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 75/80] exec: drop bogus mem_path from
 qemu_ram_alloc_from_fd()
Date: Thu, 23 Jan 2020 12:38:40 +0100
Message-Id: <1579779525-20065-76-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: mCFZYx_6N4C6iEYcpGUTzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function will report error that will mention global mem_path,
which was valid the only if legacy -mem-path was used and
only in case of main RAM.

However it doesn't work with hostmem backends
(for example:
"
  qemu: -object memory-backend-file,id=3Dram0,size=3D128M,mem-path=3Dfoo:
    backing store (null) size 0x200000 does not match 'size' option 0x80000=
00
")
and couldn't possibly work in general FD case the function
is supposed to handle.

Taking in account that main RAM was converted into
memory-backend-foo object, there is no point in printing
file name (from inappropriate place) as failing path is
a part of backend's error message.

Hence drop bogus mem_path usage from qemu_ram_alloc_from_fd(),
it's a job of its user to add file name to error message if applicable.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: pbonzini@redhat.com
CC: rth@twiddle.net
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 809987c..dc844fd 100644
--- a/exec.c
+++ b/exec.c
@@ -2308,9 +2308,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, Mem=
oryRegion *mr,
     size =3D HOST_PAGE_ALIGN(size);
     file_size =3D get_file_size(fd);
     if (file_size > 0 && file_size < size) {
-        error_setg(errp, "backing store %s size 0x%" PRIx64
+        error_setg(errp, "backing store size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   mem_path, file_size, size);
+                   file_size, size);
         return NULL;
     }
=20
--=20
2.7.4


