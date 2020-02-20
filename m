Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EDC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E8C20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa4hYfT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E8C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lh3-0007eY-8d
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXF-0005DD-3x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXD-0005Eu-Rw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXD-0005E5-N0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URr7V1M6RZkd8VsYjn8QuFWcMecDXO2sKYgxZu+xFU4=;
 b=fa4hYfT5l/CNj/9o5jpRBwRG4EwChaZHV0aLAB7O2pbgHxWZmCLL6p2hurqmas1ABM9i3v
 Kv/jWm1UGKpt3eB66id8ncLApVER97Q6vmWynuiyEDcEZBBWDBkUDaSQW7wSH12XlXqyws
 BRrYjPbefA3+82R5cF3E7vHF7nFBTEk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-g22Gwg_wPHiHXVVZeB1H4A-1; Thu, 20 Feb 2020 08:06:29 -0500
Received: by mail-wr1-f72.google.com with SMTP id r1so1700148wrc.15
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ijbOoyrS9Jz9oM+Px+EP5Y3MCyoKyJq//TyCsQeLfQM=;
 b=tKbZXoyfzganhYAvSov/eDR84ffMPS/RcPM0YxXHoCQYMWohmR+mJHwrdRGAPC72Qs
 wTfpy4637HXpdLbGdgyoGwNUemQ61off/+JQMz/+6XkjB68b85aSU43Cpv2gfankdP//
 8r248Vjk+uDf+FrijxnEwuH7syNUUzAw05xm3L0ra/3QCvpa76yhgSpEaMD9VQA2HhD4
 77t3jHOv4t6h0xI9A2pz4JiXD8JamTdJWiJnOyllgGnOEj1Zq4bjt4rcJ7Bi75duudJ7
 vV4qDoiWp+a2ZNMpthNZgfTWzdZPhlwTGX5+TT5CI013yuM7Uy62+C77gAgI5Xv3fqrd
 j0kw==
X-Gm-Message-State: APjAAAWru417O7unVrBFCy1L50ScQ6lmPWNMyjtimlJlCjpVX8q71m56
 LHFtqCBB3qgD9TMXwDJtIhazsA2WrSfZ3p3amQB4bM2AXLg7ymUY7hWAi0h3zPppsTljKp223w6
 l6e7QHTgMVLX8azU=
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr4786419wmi.152.1582203988199; 
 Thu, 20 Feb 2020 05:06:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ6/a+oKytvIxV32J43VlbJoelLuLW+rm04bNrtIDR5Tp2LK/nrGilhR3sl09VB9q8vLJTrw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr4786351wmi.152.1582203987812; 
 Thu, 20 Feb 2020 05:06:27 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 09/20] exec: Let the cpu_[physical]_memory API use void
 pointer arguments
Date: Thu, 20 Feb 2020 14:05:37 +0100
Message-Id: <20200220130548.29974-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: g22Gwg_wPHiHXVVZeB1H4A-1
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

As we are only dealing with a blob buffer, use a void pointer
argument. This will let us simplify other APIs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/cpu-all.h    | 2 +-
 include/exec/cpu-common.h | 2 +-
 exec.c                    | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e96781a455..49e96caa3f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -388,7 +388,7 @@ void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
=20
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write);
+                        void *ptr, target_ulong len, int is_write);
=20
 int cpu_exec(CPUState *cpu);
=20
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 05ac1a5d69..165f8fb621 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -69,7 +69,7 @@ void qemu_ram_unset_migratable(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
=20
-void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
+void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, int is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, hwaddr len)
diff --git a/exec.c b/exec.c
index 1a80159996..01437be691 100644
--- a/exec.c
+++ b/exec.c
@@ -3019,11 +3019,12 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, int is_write)
 {
     int flags;
     target_ulong l, page;
     void * p;
+    uint8_t *buf =3D ptr;
=20
     while (len > 0) {
         page =3D addr & TARGET_PAGE_MASK;
@@ -3311,7 +3312,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr=
 addr, MemTxAttrs attrs,
     }
 }
=20
-void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
+void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, int is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
@@ -3789,10 +3790,11 @@ address_space_write_cached_slow(MemoryRegionCache *=
cache, hwaddr addr,
=20
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, int is_write)
 {
     hwaddr phys_addr;
     target_ulong l, page;
+    uint8_t *buf =3D ptr;
=20
     cpu_synchronize_state(cpu);
     while (len > 0) {
--=20
2.21.1


