Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CFC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2382173E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqfzoUyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2382173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkcL-0007nd-N5
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkX7-0008O5-UK
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:42:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkX6-0002iC-TX
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0F6ldTOd8VBTvynMaD5KXJRN63vFzeEfQeG4bxiOT0=;
 b=SqfzoUyB8uSoXuB79zskW9FqokzilEIcSWyElXmqM+IPIZVjhmn5ka7KgI0lspQ85bvHtO
 GosvvbgAj3cnhoN7cmHXHXvG7oEoC5ZvR2D7oRI2zOxcJVvoVWhXuF05Vt3Dt6ODc9HJLc
 SuY48HvhHtEbOhJ0xJ6Mk9e1z5N77Gs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-OOhdLuMnN6i88QPVjipWjA-1; Thu, 07 May 2020 13:42:02 -0400
X-MC-Unique: OOhdLuMnN6i88QPVjipWjA-1
Received: by mail-wr1-f71.google.com with SMTP id p8so3865036wrj.5
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2IryXDavM4F6hNiL5uGphYz9XWPkFL2dN/mkNIfy2I=;
 b=B93oqm1z0UrWy68iiJh5c+SECepkW2uYHAd/9m2E0mDS+g9AlM3zVAPjuY8hAWVVa1
 XQ4Di73JLapHkmEEjNVhmEYmdjOseAkBSKnCLBXOd/vpMAcFGHjfij5VAuUX5eh541FV
 i8ZvliXICWyG10kTxolmfWqMU4ZmHpFLtOJVhmMbORwlHzDSTwyOBAQbrXf2L1KIkNbL
 Tky3GsWJ+OuWwxQndTbx5fmE5K0LwMaGHSeYWNRQ9rct04vhKht8HehxlqsppEeD7diB
 RGSuS/RenBDR+ajDCYWjtodFRcIQ7EYQhePelK6GofAOOYUVFka2yCml3yPDigh6BivI
 bhow==
X-Gm-Message-State: AGi0PuY/utM/qxaYxWc+lZppKM6cUdGQxBZBlH/+nLtUDBrXN/sWvINh
 J1G/gctAJfljGD4sM44Fyrvz3K9cvw1LTK4dsHzUAxMTd6pLlSKH+57OD3+0jO+uWgdsf5+5OAM
 NHx7O5dUVLoXnmYc=
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr16063870wrn.209.1588873320737; 
 Thu, 07 May 2020 10:42:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIHd5xsiLMMK2BzwSmY5On55OLx9kYf3R0jmh8d4ZLvAY3P/ejD7CzHKZ3d5OGk5MyJ2W+0A==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr16063857wrn.209.1588873320555; 
 Thu, 07 May 2020 10:42:00 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q14sm9428007wrc.66.2020.05.07.10.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:42:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 09/10] exec: Update coding style to make checkpatch.pl happy
Date: Thu,  7 May 2020 19:39:57 +0200
Message-Id: <20200507173958.25894-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will move this code in the next commit. Clean it up
first to avoid checkpatch.pl errors.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ram_addr.h | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 0deffad66f..6acde47a0f 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -95,7 +95,8 @@ static inline bool cpu_physical_memory_all_dirty(ram_addr=
_t start,
     while (page < end) {
         unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
         unsigned long num =3D next - base;
-        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx], nu=
m, offset);
+        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx],
+                                                 num, offset);
         if (found < num) {
             dirty =3D false;
             break;
@@ -120,14 +121,14 @@ static inline bool cpu_physical_memory_is_clean(ram_a=
ddr_t addr)
 {
     bool vga =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA=
);
     bool code =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CO=
DE);
-    bool migration =3D
-        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
+    bool migration =3D cpu_physical_memory_get_dirty_flag(addr,
+                                                        DIRTY_MEMORY_MIGRA=
TION);
     return !(vga && code && migration);
 }
=20
 static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t =
start,
-                                                               ram_addr_t =
length,
-                                                               uint8_t mas=
k)
+                                                            ram_addr_t len=
gth,
+                                                            uint8_t mask)
 {
     uint8_t ret =3D 0;
=20
@@ -272,7 +273,8 @@ static inline void cpu_physical_memory_set_dirty_lebitm=
ap(unsigned long *bitmap,
=20
         xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
     } else {
-        uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIE=
NTS_NOCODE;
+        uint8_t clients =3D tcg_enabled()
+                          ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
=20
         if (!global_dirty_log) {
             clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
@@ -304,8 +306,11 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr=
_t start,
                                               ram_addr_t length,
                                               unsigned client);
=20
-DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
+DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty(
+                                                            MemoryRegion *=
mr,
+                                                            hwaddr offset,
+                                                            hwaddr length,
+                                                            unsigned clien=
t);
=20
 bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
@@ -314,7 +319,8 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmap=
Snapshot *snap,
 static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
                                                          ram_addr_t length=
)
 {
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_M=
IGRATION);
+    cpu_physical_memory_test_and_clear_dirty(start, length,
+                                             DIRTY_MEMORY_MIGRATION);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_V=
GA);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_C=
ODE);
 }
--=20
2.21.3


