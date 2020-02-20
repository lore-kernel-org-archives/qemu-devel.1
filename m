Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53134C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFB1206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejLdCo6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFB1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lbK-0004ml-7j
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lX3-0004iw-5V
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lX1-0004z5-MR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lX1-0004yc-I2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9T2fAo+6xtdSOASO+MDoJq7z4DL4xf6hcEaFpq9VX4A=;
 b=ejLdCo6ZIYmc5j4rtA/084C1L1YWVd9T9NhuBuNyWgx6KvqT+UmgWOqUJVJwM3f6pRQUAV
 73zUMcTHpOhpk2gFnz6iZmx4ES9188atg5qUlu2oTpXqpw7bu0TT+y9e4bSOhlmJQDuwno
 LrcpC4JBbuaXJILnjfrkMrZJ4he4+2o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-GMxDok0VM6mX7O5TWXkYwA-1; Thu, 20 Feb 2020 08:06:17 -0500
Received: by mail-wr1-f70.google.com with SMTP id d15so1715201wru.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f0ShsBpyUInIOkeskmM477n/0YX3Rn03mTxtkP3QCEQ=;
 b=kcH9ve9rDgNV2BA/uiTdHeHfp1jKTRh7UmUu35A09a0lRPWfBd1vs6GDavgr4R59JB
 W9FpEqZQWqWeU7QLwJ+1jaVBSLTAAJrwTDKf4uPEHb0O4UiEVbcRti7w31ErDK+6Ozvn
 Yhal3ToG3rvcV09CZlqaVBlbj4nLcmf/70n15qVB6csWmrSdTQbAy3PHHF6MSzag1Nnp
 a3dOVcLTznmahSiXd4Fa1QTr8ziQSW+P4A5FMVB+1Ryz10dVERe6H3ghJQbg21yFJmxe
 l6DkdmkZZbUXKCoe+osNKvoYI1DMg62pBf+WaD1d0BsHQbfpVb3G/tyue6ByjkzE/Zl7
 zaIA==
X-Gm-Message-State: APjAAAXYwtd5vx4cI0RCeGmEwiyoBY0NIBnaoS8UTNwxQHQv4ERkmbIA
 Xc3MM8DUbDzfQGDUly3Jir44xYVHlGzl2lfcHSbqL/TxQx2WQFznPLFJ4MYdt/17fmnukRrtESd
 B9cietcsJmA9fP68=
X-Received: by 2002:adf:ec02:: with SMTP id x2mr9464156wrn.8.1582203976197;
 Thu, 20 Feb 2020 05:06:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxvhyunneK2qPGr0PvPMnzbnKoLc1KRvHi/EZUPnye+P/5CWZaGi4Yc+u50TlNAyrnI1YoAA==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr9464128wrn.8.1582203975917;
 Thu, 20 Feb 2020 05:06:15 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 06/20] exec: Let the address_space API use void pointer
 arguments
Date: Thu, 20 Feb 2020 14:05:34 +0100
Message-Id: <20200220130548.29974-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: GMxDok0VM6mX7O5TWXkYwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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

As we are only dealing with a blob buffer, use a void pointer
argument. This will let us simplify other APIs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h | 12 ++++++------
 exec.c                | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6f8084f45e..afee185eae 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2052,7 +2052,7 @@ void address_space_remove_listeners(AddressSpace *as)=
;
  * @is_write: indicates the transfer direction
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs, uint8_t *buf,
+                             MemTxAttrs attrs, void *buf,
                              hwaddr len, bool is_write);
=20
 /**
@@ -2070,7 +2070,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr=
 addr,
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, hwaddr len);
+                                const void *buf, hwaddr len);
=20
 /**
  * address_space_write_rom: write to address space, including ROM.
@@ -2096,7 +2096,7 @@ MemTxResult address_space_write(AddressSpace *as, hwa=
ddr addr,
  */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, hwaddr len);
+                                    const void *buf, hwaddr len);
=20
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -2334,7 +2334,7 @@ void address_space_unmap(AddressSpace *as, void *buff=
er, hwaddr len,
=20
 /* Internal functions, part of the implementation of address_space_read.  =
*/
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, hwaddr=
 len);
+                                    MemTxAttrs attrs, void *buf, hwaddr le=
n);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
@@ -2374,7 +2374,7 @@ static inline bool memory_access_is_direct(MemoryRegi=
on *mr, bool is_write)
  */
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-                               MemTxAttrs attrs, uint8_t *buf,
+                               MemTxAttrs attrs, void *buf,
                                hwaddr len)
 {
     MemTxResult result =3D MEMTX_OK;
@@ -2433,7 +2433,7 @@ address_space_read_cached(MemoryRegionCache *cache, h=
waddr addr,
  */
 static inline void
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           void *buf, hwaddr len)
+                           const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <=3D cache->len - addr);
     if (likely(cache->ptr)) {
diff --git a/exec.c b/exec.c
index 980cc0e2b2..1a80159996 100644
--- a/exec.c
+++ b/exec.c
@@ -3271,7 +3271,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr=
 addr,
 }
=20
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, hwaddr=
 len)
+                                    MemTxAttrs attrs, void *buf, hwaddr le=
n)
 {
     MemTxResult result =3D MEMTX_OK;
     FlatView *fv;
@@ -3287,7 +3287,7 @@ MemTxResult address_space_read_full(AddressSpace *as,=
 hwaddr addr,
=20
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, hwaddr len)
+                                const void *buf, hwaddr len)
 {
     MemTxResult result =3D MEMTX_OK;
     FlatView *fv;
@@ -3302,7 +3302,7 @@ MemTxResult address_space_write(AddressSpace *as, hwa=
ddr addr,
 }
=20
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs att=
rs,
-                             uint8_t *buf, hwaddr len, bool is_write)
+                             void *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
@@ -3326,7 +3326,7 @@ enum write_rom_type {
 static inline MemTxResult address_space_write_rom_internal(AddressSpace *a=
s,
                                                            hwaddr addr,
                                                            MemTxAttrs attr=
s,
-                                                           const uint8_t *=
buf,
+                                                           const void *ptr=
,
                                                            hwaddr len,
                                                            enum write_rom_=
type type)
 {
@@ -3334,6 +3334,7 @@ static inline MemTxResult address_space_write_rom_int=
ernal(AddressSpace *as,
     uint8_t *ram_ptr;
     hwaddr addr1;
     MemoryRegion *mr;
+    const uint8_t *buf =3D ptr;
=20
     RCU_READ_LOCK_GUARD();
     while (len > 0) {
@@ -3366,7 +3367,7 @@ static inline MemTxResult address_space_write_rom_int=
ernal(AddressSpace *as,
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, hwaddr len)
+                                    const void *buf, hwaddr len)
 {
     return address_space_write_rom_internal(as, addr, attrs,
                                             buf, len, WRITE_DATA);
--=20
2.21.1


