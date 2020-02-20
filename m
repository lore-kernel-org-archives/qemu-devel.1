Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F08C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D64206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhM6j2TF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D64206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lar-0003Yi-3y
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lX0-0004ay-6a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lWy-0004vs-VL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60433
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lWy-0004vY-RQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kamW98p66sN+eur3Q7AqsRMR1uwJ8MHCAydSaAKz21s=;
 b=BhM6j2TFlxilShmuQPG5GLYUxvP0mmPW+ZSUvi0Ddl9fdEqtLJUsOCn1HuTqCuKoVm0Rtd
 196j19umV8AZsPmrFilPrfDdmx6Dwk0frkW3cjjIP4L6GyDu8qVgf7CnPGVOBCw2Un1hMH
 z+2zK6Lji9ZBlEHGJKtFlZbih2bFqV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-4dUiJntRMn6ktmMCFzlW2A-1; Thu, 20 Feb 2020 08:06:13 -0500
Received: by mail-wm1-f69.google.com with SMTP id z7so583498wmi.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HHWlfXnpQqqcljyzd6YNAX2WRGDbItCch3DvOI+vpOQ=;
 b=CQfKH4QGDTQjHunwmV8Nmaa2IR9e+3GcJ333Yeh0DDgV2gXtr7JqoPa+MEUlrs3Hop
 9q+INz7/8hkDwzFdvPtPW+5F3jrpUOt4o6wrtI+A/V//O9KJQVlP1+w3HjQAdcn29is7
 CDuuFRxlHBjxgFPNKvBk59G+/jvKIvXkwx9YuUSYrSm2fXlhNzFu4Lr3o4X6DaCuZt9L
 MtK712Al3tMrIdMOGp+fO5mhssKHJJREgqQyU4NF4mY2YzPq0u7NlrPQg3MOwZM0/XF4
 E9lg/BNityn8iSfZfVJGFotd5mHeDiuwbhqGmdwAJFgfjhEL7sHwt1nCtMWGx12vFoBn
 +mLA==
X-Gm-Message-State: APjAAAU7AZYl/URxefs2V2ZABsxOIq1zB8ELFYAD+KYhAvY4Ek0FboAe
 PgCRMIcx/+YN+tA+rH1tWw4+mbrlBZxSbyyLES0uIsNxFDzdValrH4ypEunLtmgn5O2TB2AauUa
 iBlIuIob4UEoFYLA=
X-Received: by 2002:adf:e781:: with SMTP id n1mr45107538wrm.56.1582203972575; 
 Thu, 20 Feb 2020 05:06:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKBcX8rH6rx55ITZPEmcOIUOejSB/5dplr56Z6ALR3ecPn0w2hMCkhVWEBs3126xsvrTMCAw==
X-Received: by 2002:adf:e781:: with SMTP id n1mr45107502wrm.56.1582203972354; 
 Thu, 20 Feb 2020 05:06:12 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 05/20] exec: Let flatview API take void pointer arguments
Date: Thu, 20 Feb 2020 14:05:33 +0100
Message-Id: <20200220130548.29974-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 4dUiJntRMn6ktmMCFzlW2A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only flatview_[read/write]_continue use a byte pointer to increment
an offset. For the users, we are only dealing with a blob buffer.
Use a void pointer argument. This will let us simplify the
address_space API in the next commit.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h |  2 +-
 exec.c                | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de99a..6f8084f45e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2336,7 +2336,7 @@ void address_space_unmap(AddressSpace *as, void *buff=
er, hwaddr len,
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, hwaddr=
 len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
-                                   MemTxAttrs attrs, uint8_t *buf,
+                                   MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
diff --git a/exec.c b/exec.c
index 06e386dc72..980cc0e2b2 100644
--- a/exec.c
+++ b/exec.c
@@ -2780,9 +2780,9 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, =
vaddr len,
 }
=20
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, hwaddr le=
n);
+                                 MemTxAttrs attrs, void *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs at=
trs,
-                                  const uint8_t *buf, hwaddr len);
+                                  const void *buf, hwaddr len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
=20
@@ -3147,7 +3147,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 /* Called within RCU critical section.  */
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
-                                           const uint8_t *buf,
+                                           const void *ptr,
                                            hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
@@ -3155,6 +3155,7 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
     uint64_t val;
     MemTxResult result =3D MEMTX_OK;
     bool release_lock =3D false;
+    const uint8_t *buf =3D ptr;
=20
     for (;;) {
         if (!memory_access_is_direct(mr, true)) {
@@ -3194,7 +3195,7 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
=20
 /* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs at=
trs,
-                                  const uint8_t *buf, hwaddr len)
+                                  const void *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3211,7 +3212,7 @@ static MemTxResult flatview_write(FlatView *fv, hwadd=
r addr, MemTxAttrs attrs,
=20
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
-                                   MemTxAttrs attrs, uint8_t *buf,
+                                   MemTxAttrs attrs, void *ptr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
@@ -3219,6 +3220,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
     uint64_t val;
     MemTxResult result =3D MEMTX_OK;
     bool release_lock =3D false;
+    uint8_t *buf =3D ptr;
=20
     for (;;) {
         if (!memory_access_is_direct(mr, false)) {
@@ -3256,7 +3258,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
=20
 /* Called from RCU critical section.  */
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, hwaddr le=
n)
+                                 MemTxAttrs attrs, void *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
--=20
2.21.1


