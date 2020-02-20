Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53224C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CA2208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuITvZ+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CA2208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4liU-0002HX-6V
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXn-0006Lm-BI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXl-0005t0-FQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXl-0005sF-8i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwD83MRmvk9U4szTuvQnf8dMN/lBsu/ps/CgrjG/jog=;
 b=AuITvZ+Nps5lmurVgIAuEObN9X8ceztUdaRkZpru/lLXOBxm1f9lGBGEHWQVJid4YwYt6f
 Op+Gw4w8tMqRFEI5kik/IQFOO5NdP0WZ1MvYP5WtTL4M/HreQd3vPkuoZumUZOFXss083r
 eVxbF5mMKvt4hVaL4ejwM3mG/z+v1V0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-ct5_aLWNMNiOJhXNrAN1Fw-1; Thu, 20 Feb 2020 08:07:02 -0500
Received: by mail-wm1-f69.google.com with SMTP id w12so804738wmc.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GOpiWMITxx9TtgKrEdUBt5MYBhcyKxmOeh0GtNqL3Q=;
 b=NQuYsehmzyWIY6+ZQZT/l/nHUOz7xdOSEcy47/I6vmLpyJC+zP0ex0pJnoFKMi94os
 /HOnb55y3n198CMBaWp4J5Ca0cAHac3hEcu2lfMgPJVLgErtwB64pxfhVtFSdB9UkvOa
 2rs0bC8IvTdDsEcWAhEIrOhB+UdTc/pdPx3z3rJiw7OKZzXnKhMPPXMH+4zwdlRz2kQD
 EGIcQujNKH9iGRcSfNtoKsMNLZOrN1KtiAhUfYY5eCZFZ/gOdlZFTYqlsb4pXZiJRKDw
 TxXO+B9ijupIHQ1+JDyk2Og+De8fiOc/K8xNpTxL4+RQcU7TDBxviQBg2zSPsiBlMpIZ
 CSVw==
X-Gm-Message-State: APjAAAXa/O3rLjO0gz8xSlun1AJ8QZYX5Ok3VprMSOMINiOL661UfEgy
 EpZ8dtdodjFQPJq5mx+UmIVAbr7kIib+hbpAunqyQFoQrt5yAj2+C2Z/U01dkjforuv4Z9tMqMg
 W7P13fCTqvT1UeYM=
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr4438678wme.28.1582204021859; 
 Thu, 20 Feb 2020 05:07:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5fs9il9OncKFrjhrarKjFKFUysaRlKljcdDwQycfDDjjbJaA7nUH+Kd8+rszknwLmOaxWsA==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr4438660wme.28.1582204021604; 
 Thu, 20 Feb 2020 05:07:01 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:07:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 18/20] exec: Let cpu_[physical]_memory API use a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:46 +0100
Message-Id: <20200220130548.29974-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ct5_aLWNMNiOJhXNrAN1Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h |  6 +++---
 exec.c                    | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 49e96caa3f..49384bb66a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -388,7 +388,7 @@ void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
=20
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write);
+                        void *ptr, target_ulong len, bool is_write);
=20
 int cpu_exec(CPUState *cpu);
=20
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 165f8fb621..6bfe201779 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -70,7 +70,7 @@ size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
=20
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, int is_write);
+                            hwaddr len, bool is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, hwaddr len)
 {
@@ -83,9 +83,9 @@ static inline void cpu_physical_memory_write(hwaddr addr,
 }
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
-                              int is_write);
+                              bool is_write);
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               int is_write, hwaddr access_len);
+                               bool is_write, hwaddr access_len);
 void cpu_register_map_client(QEMUBH *bh);
 void cpu_unregister_map_client(QEMUBH *bh);
=20
diff --git a/exec.c b/exec.c
index b79919a4f7..6c39b43155 100644
--- a/exec.c
+++ b/exec.c
@@ -3019,7 +3019,7 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, bool is_write)
 {
     int flags;
     target_ulong l, page;
@@ -3313,7 +3313,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr=
 addr, MemTxAttrs attrs,
 }
=20
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, int is_write)
+                            hwaddr len, bool is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                      buf, len, is_write);
@@ -3632,14 +3632,14 @@ void address_space_unmap(AddressSpace *as, void *bu=
ffer, hwaddr len,
=20
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
-                              int is_write)
+                              bool is_write)
 {
     return address_space_map(&address_space_memory, addr, plen, is_write,
                              MEMTXATTRS_UNSPECIFIED);
 }
=20
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               int is_write, hwaddr access_len)
+                               bool is_write, hwaddr access_len)
 {
     return address_space_unmap(&address_space_memory, buffer, len, is_writ=
e, access_len);
 }
@@ -3790,7 +3790,7 @@ address_space_write_cached_slow(MemoryRegionCache *ca=
che, hwaddr addr,
=20
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, bool is_write)
 {
     hwaddr phys_addr;
     target_ulong l, page;
--=20
2.21.1


