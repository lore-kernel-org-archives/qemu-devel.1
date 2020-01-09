Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416FFC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F352064C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUPBzeEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F352064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZmd-0002Pk-W1
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZeO-00080B-F9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZeN-0006ky-9g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZeN-0006hl-3j
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEMOGD26t+fMYjJ4LobtAf8vZNWvIS3QswsuquGMzqE=;
 b=XUPBzeErMU4voED02hCBgbSNJbEX5rPbNJdT3z+AgyeVO84x5TvQciFuNx61X2TxPArZcf
 No6DIR1wlg5Jnn+yXA0snHobfINsnKxvZ6EqHPlpFOf3JGakg7sOgSOKaswc8N8tkAnmXE
 NlreojCh8ndelr5G0iFedjeM9ZNriyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-wgHZV1PxPwGTHcuUwuI7bA-1; Thu, 09 Jan 2020 10:23:05 -0500
X-MC-Unique: wgHZV1PxPwGTHcuUwuI7bA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C531005513;
 Thu,  9 Jan 2020 15:23:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CF5F1CB;
 Thu,  9 Jan 2020 15:22:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] memory: Replace current_machine by qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:28 +0100
Message-Id: <20200109152133.23649-11-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index d7b9bb6951..57e38b1f50 100644
--- a/memory.c
+++ b/memory.c
@@ -3004,6 +3004,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
     int n =3D view->nr;
     int i;
     AddressSpace *as;
+    MachineState *ms;
=20
     qemu_printf("FlatView #%d\n", fvi->counter);
     ++fvi->counter;
@@ -3026,6 +3027,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
         return;
     }
=20
+    ms =3D MACHINE(qdev_get_machine());
     while (n--) {
         mr =3D range->mr;
         if (range->offset_in_region) {
@@ -3057,7 +3059,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
         if (fvi->ac) {
             for (i =3D 0; i < fv_address_spaces->len; ++i) {
                 as =3D g_array_index(fv_address_spaces, AddressSpace*, i=
);
-                if (fvi->ac->has_memory(current_machine, as,
+                if (fvi->ac->has_memory(ms, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) =
{
                     qemu_printf(" %s", fvi->ac->name);
--=20
2.21.1


