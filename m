Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF600C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA07206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd+KOQ/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA07206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4la1-0001hP-GZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXI-0005Mt-Js
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXE-0005FK-1u
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXD-0005EM-St
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FX3FXQX3OgJ73Ij27vj7Z7zPMOBdko14sr77VldpMU0=;
 b=fd+KOQ/JtZluiWrqw7X7t7pCKX1lN0Ek+zv0VS8zFMNmeqHHwktKH2u6d+0SayH6WMWbPR
 PeWoLDk19HZkMiRtSqWJUv+E4VI/m+1SVEfWO3LJpeVdE255WFe5zNNnbeWo826AaxEzNk
 VJQh10Q8t5w6zSHl37IP4w6pD5tUWYM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-BGgf0KZ_N6evfS_bAr0TkQ-1; Thu, 20 Feb 2020 08:06:29 -0500
X-MC-Unique: BGgf0KZ_N6evfS_bAr0TkQ-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1696593wrm.18
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8odk76d2z3izhK+yPuh+zYi/Cj4FHaZPMzDDqjJ0XeE=;
 b=cD5BLjMsgIB4XqaeAIPGbrbuSbpvanMEzIPOefTz0xgs9MUDFe/uK9DgfcRu1im5NP
 xpSlYhK8oZqZjKo8uG08kjNpIhAxv5oJd29L3+ihSYJjVRQTt+fgRa7tU8yADPq3c9Bh
 9MhNHS7cSXzUqGUCLQgTQanTSIfeagn/DEVTqr5czB7do/ssAio8G90tx2tCPaL2Lj2x
 BmK726a4f4YZSQJzbEYi9HF4/K5hoL83FlH+c157DuwEsXLzC/9pvxXqPrUUeMd6clwA
 C8+PvNHtb7QYRop8y5Dfqaf5Nmknha5z9DZ42sX8BKBf2YFeFJB5a0LoCFLEfZms/mSK
 7GMA==
X-Gm-Message-State: APjAAAWkPWiN5KnEWDeci2PskIFgIMbPv1a06GJSFd/6uLTwxdBXwfwH
 cPkOa6lV2F0HfEx0YXGLojwHqzSyRvJWdPAnOq1L4R+B/VSnG+S9YLnnJQiUknMsCUVN2q1WrNf
 UuqnJTtca3j8TxWQ=
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr40459254wru.233.1582203965282; 
 Thu, 20 Feb 2020 05:06:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYyC0rm9Zmq8Udvt5K4WfGoUA6AsKImvpwZLE6azxpWra0StVD53WtA0C45GVywJSMzTwuwQ==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr40459189wru.233.1582203964946; 
 Thu, 20 Feb 2020 05:06:04 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 03/20] exec: Let qemu_ram_*() functions take a const
 pointer argument
Date: Thu, 20 Feb 2020 14:05:31 +0100
Message-Id: <20200220130548.29974-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/cpu-common.h     | 6 +++---
 include/sysemu/xen-mapcache.h | 4 ++--
 exec.c                        | 8 ++++----
 hw/i386/xen/xen-mapcache.c    | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 81753bbb34..05ac1a5d69 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -48,11 +48,11 @@ typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr=
 addr);
=20
 void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
 /* This should not be used by devices.  */
-ram_addr_t qemu_ram_addr_from_host(void *ptr);
+ram_addr_t qemu_ram_addr_from_host(const void *ptr);
 RAMBlock *qemu_ram_block_by_name(const char *name);
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
                                    ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *de=
v);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..81e9aa2fa6 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -19,7 +19,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
                        uint8_t lock, bool dma);
-ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
+ram_addr_t xen_ram_addr_from_mapcache(const void *ptr);
 void xen_invalidate_map_cache_entry(uint8_t *buffer);
 void xen_invalidate_map_cache(void);
 uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
@@ -40,7 +40,7 @@ static inline uint8_t *xen_map_cache(hwaddr phys_addr,
     abort();
 }
=20
-static inline ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+static inline ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
 {
     abort();
 }
diff --git a/exec.c b/exec.c
index 8e9cc3b47c..02b4e6ea41 100644
--- a/exec.c
+++ b/exec.c
@@ -2614,7 +2614,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block,=
 ram_addr_t addr,
 }
=20
 /* Return the offset of a hostpointer within a ramblock */
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, const void *host)
 {
     ram_addr_t res =3D (uint8_t *)host - (uint8_t *)rb->host;
     assert((uintptr_t)host >=3D (uintptr_t)rb->host);
@@ -2640,11 +2640,11 @@ ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb,=
 void *host)
  * pointer, such as a reference to the region that includes the incoming
  * ram_addr_t.
  */
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+RAMBlock *qemu_ram_block_from_host(const void *ptr, bool round_offset,
                                    ram_addr_t *offset)
 {
     RAMBlock *block;
-    uint8_t *host =3D ptr;
+    const uint8_t *host =3D ptr;
=20
     if (xen_enabled()) {
         ram_addr_t ram_addr;
@@ -2705,7 +2705,7 @@ RAMBlock *qemu_ram_block_by_name(const char *name)
=20
 /* Some of the softmmu routines need to translate from a host pointer
    (typically a TLB entry) back to a ram offset.  */
-ram_addr_t qemu_ram_addr_from_host(void *ptr)
+ram_addr_t qemu_ram_addr_from_host(const void *ptr)
 {
     RAMBlock *block;
     ram_addr_t offset;
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 5b120ed44b..432ad3354d 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -363,7 +363,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
     return p;
 }
=20
-ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+ram_addr_t xen_ram_addr_from_mapcache(const void *ptr)
 {
     MapCacheEntry *entry =3D NULL;
     MapCacheRev *reventry;
--=20
2.21.1


