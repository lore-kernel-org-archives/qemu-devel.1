Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4989C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812292067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQKdjH2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812292067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZsg-0002qi-GG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZea-0008Ff-1U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZeX-0007Zm-St
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZeX-0007WD-FP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOe6/URSftxgo5ESkRc2DJBElz4tXj5Z8utyHCtsD8A=;
 b=RQKdjH2vFMBWkXFR1vH8Px3wLfPEeyCAYVOlECXZhwA0wI4TBxNB4aUHU7JqAlnKz+/fu/
 /6fVSoQBRFPcava8nOAfZocHjZcpqmQa2yHP5ITONMAhx5GkPTytlLnmlTk8C6Fmg858kW
 00uOnRGOZucuHRXL7rDd+S/4jZbkJN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-QJIASVVyPyuGiKmHhZaWnw-1; Thu, 09 Jan 2020 10:23:15 -0500
X-MC-Unique: QJIASVVyPyuGiKmHhZaWnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B137DB20;
 Thu,  9 Jan 2020 15:23:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5AC80618;
 Thu,  9 Jan 2020 15:23:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] exec: Replace current_machine by qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:29 +0100
Message-Id: <20200109152133.23649-12-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to remove the global current_machine,
replace 'current_machine' by MACHINE(qdev_get_machine()).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index d4b769d0d4..98f5b049ca 100644
--- a/exec.c
+++ b/exec.c
@@ -1984,11 +1984,11 @@ static unsigned long last_ram_page(void)
=20
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
 {
-    int ret;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
=20
     /* Use MADV_DONTDUMP, if user doesn't want the guest memory in the c=
ore */
-    if (!machine_dump_guest_core(current_machine)) {
-        ret =3D qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
+    if (!machine_dump_guest_core(ms)) {
+        int ret =3D qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
         if (ret) {
             perror("qemu_madvise");
             fprintf(stderr, "madvise doesn't support MADV_DONTDUMP, "
@@ -2108,7 +2108,9 @@ size_t qemu_ram_pagesize_largest(void)
=20
 static int memory_try_enable_merging(void *addr, size_t len)
 {
-    if (!machine_mem_merge(current_machine)) {
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    if (!machine_mem_merge(ms)) {
         /* disabled by the user */
         return 0;
     }
--=20
2.21.1


