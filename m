Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC37C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D0B20753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGkWRQg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D0B20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFry-0006Aq-Hd
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnT-00078x-ML
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnS-0002fC-NF
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnS-0002en-Jm
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NElMZv7xB8ujsMJq+AMXJHMuopsAeHg0/AO5YX2yeoI=;
 b=OGkWRQg4XYE8Oel2F+d4oiiirDfq/RR55kz2gGKxJVeXUFdjxwOc2bfMJo0smKa8UUvTDx
 Mmc/xODmduf6qsD5C1dSFtUC8Hgzko4H1c1j6hE1D//L231j3d/RleDMnBaZ+Q8bN59M/A
 /Isl9s3I2flvf/Gw4IBWspeqZFrBAXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-92-nWAk3O6ifErFVWJFG6Q-1; Sat, 11 Apr 2020 09:03:37 -0400
X-MC-Unique: 92-nWAk3O6ifErFVWJFG6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9347E8018A4;
 Sat, 11 Apr 2020 13:03:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23BA798A2B;
 Sat, 11 Apr 2020 13:03:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] memory: Do not allow direct write access to rom_device
 regions
Date: Sat, 11 Apr 2020 09:03:29 -0400
Message-Id: <20200411130330.1993-8-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

According to the documentation in memory.h a ROM memory region will be
backed by RAM for reads, but is supposed to go through a callback for
writes. Currently we were not checking for the existence of the rom_device
flag when determining if we could perform a direct write or not.

To correct that add a check to memory_region_is_direct so that if the
memory region has the rom_device flag set we will return false for all
checks where is_write is set.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200410034150.24738.98143.stgit@localhost.localdomain>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1614d9a02c..e000bd2f97 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegionCach=
e *cache,
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write=
)
 {
     if (is_write) {
-        return memory_region_is_ram(mr) &&
-               !mr->readonly && !memory_region_is_ram_device(mr);
+        return memory_region_is_ram(mr) && !mr->readonly &&
+               !mr->rom_device && !memory_region_is_ram_device(mr);
     } else {
         return (memory_region_is_ram(mr) && !memory_region_is_ram_device(m=
r)) ||
                memory_region_is_romd(mr);
--=20
2.18.2



