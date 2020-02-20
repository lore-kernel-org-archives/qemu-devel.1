Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27747C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D08206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhxgHIVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D08206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lce-00073L-Vn
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lWw-0004RW-SS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lWv-0004st-Hl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lWv-0004sZ-DX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3U8RUDrkQxMnVOOW0OCE6S37E2RIVx9bINi/XXS02Y4=;
 b=KhxgHIVkUDuYVOm6JJkYCP8eRrERMOLmKZp5leu6GoT3BE/JhOzqX8lxi+SuN/SB7ILW+M
 PtHgWmJ1KxL9idIj7Cuf1fNOWN8YfyEpdhWzcnWG7ei537OPD78hyGX0zfCf5nE2tN1y5z
 +WflVHg5RZ7f5VlOYp8N/3ZchaE7VJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-IDHSw1WzOTybIF6eoIfNsA-1; Thu, 20 Feb 2020 08:06:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id f66so577573wmf.9
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uQu7r5A36ZEekF4m32GxNBlLjnOkqxofIVmsz5VZ5cY=;
 b=HNiVRgjKa5TfvREPD2uz2fVayBbaQeMS7r2nUrGme3LlIgSdJdFY313gLU0bUdi0Rh
 Vdf07u7L7/wAjFgrHPQtx1bCwINiC6wZBHQWisqC8qWiRxCSyc/YEoE3621pc4MacstF
 +Apj7kA7UbiZRev2m2zemOY1ANqHkm7a7aCFXs5wCuD5mSZVG76xKRAumFwjQAsk/OVW
 J02FAyiS59EE36oC4YJbR2BTV78x+6LLzmCYXtybL1xd0pwB7gkuHo72J98IKNaYov6W
 BFys4g7j+koDSb7D5McPg3TIiwclJ9z9YNwmtmK+D45g2nIzlrcAC+gOTItB0vYY/EDO
 SUvg==
X-Gm-Message-State: APjAAAWp+HAdj6geYIoGwnQA8NQ5AJt0lGkXRlN3Cfl8IcMluzEvJ+jL
 0np/7+79eyMWlZXee0kzullKgHM9wu4pJm25mR6U8oKALSwX4FmKC1puCr0LByqlQHNc5pLQ7Ot
 I54voRBdMnt7I7N4=
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr4784713wmi.152.1582203968767; 
 Thu, 20 Feb 2020 05:06:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyE66uIDK1qcY0whocMHGuc5UiGXXzMSpfPUxCMQ6ki2ViRoHWEoIvgwkFHTsmW7YQNGkg7QA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr4784676wmi.152.1582203968575; 
 Thu, 20 Feb 2020 05:06:08 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 04/20] exec: Rename ram_ptr variable
Date: Thu, 20 Feb 2020 14:05:32 +0100
Message-Id: <20200220130548.29974-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: IDHSw1WzOTybIF6eoIfNsA-1
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

As we are going to use a different 'ptr' variable, rename the 'ram
pointer' variable.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 02b4e6ea41..06e386dc72 100644
--- a/exec.c
+++ b/exec.c
@@ -3151,7 +3151,7 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
                                            hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     uint64_t val;
     MemTxResult result =3D MEMTX_OK;
     bool release_lock =3D false;
@@ -3167,8 +3167,8 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
                                                    size_memop(l), attrs);
         } else {
             /* RAM case */
-            ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(ptr, buf, l);
+            ram_ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, fals=
e);
+            memcpy(ram_ptr, buf, l);
             invalidate_and_set_dirty(mr, addr1, l);
         }
=20
@@ -3215,7 +3215,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     uint64_t val;
     MemTxResult result =3D MEMTX_OK;
     bool release_lock =3D false;
@@ -3230,8 +3230,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-            ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(buf, ptr, l);
+            ram_ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, fals=
e);
+            memcpy(buf, ram_ptr, l);
         }
=20
         if (release_lock) {
@@ -3329,7 +3329,7 @@ static inline MemTxResult address_space_write_rom_int=
ernal(AddressSpace *as,
                                                            enum write_rom_=
type type)
 {
     hwaddr l;
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     hwaddr addr1;
     MemoryRegion *mr;
=20
@@ -3343,14 +3343,14 @@ static inline MemTxResult address_space_write_rom_i=
nternal(AddressSpace *as,
             l =3D memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-            ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
+            ram_ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
             switch (type) {
             case WRITE_DATA:
-                memcpy(ptr, buf, l);
+                memcpy(ram_ptr, buf, l);
                 invalidate_and_set_dirty(mr, addr1, l);
                 break;
             case FLUSH_CACHE:
-                flush_icache_range((uintptr_t)ptr, (uintptr_t)ptr + l);
+                flush_icache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr =
+ l);
                 break;
             }
         }
--=20
2.21.1


