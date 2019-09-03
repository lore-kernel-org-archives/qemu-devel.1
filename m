Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63F122CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63F122CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Gca-0002UT-Vg
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwd-0004Mx-Or
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwc-0001RP-RJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5Fwc-0001RB-M3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F238C30832DC;
 Tue,  3 Sep 2019 21:02:29 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE035D6B2;
 Tue,  3 Sep 2019 21:02:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:58 -0300
Message-Id: <20190903210201.14627-11-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 03 Sep 2019 21:02:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 10/13] hostmem-file: fix pmem file size check
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 314aec4a6e06844937f1677f6cba21981005f389 ("hostmem-file: reject
invalid pmem file sizes") added a file size check that verifies the
hostmem object's size parameter against the actual devdax pmem file.
This is useful because getting the size wrong results in confusing
errors inside the guest.

However, the code doesn't work properly for files where struct
stat::st_size is zero.  Hostmem-file's ->alloc() function returns early
without setting an Error, causing the following assertion failure:

  qemu/memory.c:2215: memory_region_get_ram_ptr: Assertion `mr->ram_block=
' failed.

This patch handles the case where qemu_get_pmem_size() returns 0 but
there is no error.

Fixes: 314aec4a6e06844937f1677f6cba21981005f389
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190823135632.25010-1-stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 29e55c9195..ecc15e3eb0 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -67,12 +67,12 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
         uint64_t size;
=20
         size =3D qemu_get_pmem_size(fb->mem_path, &local_err);
-        if (!size) {
+        if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
=20
-        if (backend->size > size) {
+        if (size && backend->size > size) {
             error_setg(errp, "size property %" PRIu64 " is larger than "
                        "pmem file \"%s\" size %" PRIu64, backend->size,
                        fb->mem_path, size);
--=20
2.21.0


