Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CEC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D3A2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D3A2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hixK7-0002KK-0j
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 04:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hixJG-0001X3-7J
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hixJF-0000BD-7w
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hixJF-000079-2S
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E69F03092651;
 Thu,  4 Jul 2019 08:41:24 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-109.ams2.redhat.com
 [10.36.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14F5A98429;
 Thu,  4 Jul 2019 08:41:15 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 10:41:15 +0200
Message-Id: <20190704084115.24713-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 04 Jul 2019 08:41:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] linux-user: check valid address in access_ok()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: R=C3=A9mi Denis-Courmont <remi@remlab.net>

Fix a crash with LTP testsuite and aarch64:

  tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
  qemu-aarch64: .../qemu/accel/tcg/translate-all.c:2522: page_check_range=
: Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x60=
001554

page_check_range() should never be called with address outside the guest
address space. This patch adds a guest_addr_valid() check in access_ok()
to only call page_check_range() with a valid address.

Fixes: f6768aa1b4c6 ("target/arm: fix AArch64 virtual address space size"=
)
Signed-off-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: Check addr + size - 1
        guest_addr_valid() is always true if
        HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS

 include/exec/cpu_ldst.h | 4 ++++
 linux-user/qemu.h       | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a08b11bd2c07..06080d27ba15 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -62,7 +62,11 @@ typedef uint64_t abi_ptr;
 /* All direct uses of g2h and h2g need to go away for usermode softmmu. =
 */
 #define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
=20
+#if HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS
+#define guest_addr_valid(x) (1)
+#else
 #define guest_addr_valid(x) ((x) <=3D GUEST_ADDR_MAX)
+#endif
 #define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
=20
 static inline int guest_range_valid(unsigned long start, unsigned long l=
en)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index fab287b7ec50..4258e4162d26 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -456,7 +456,9 @@ extern unsigned long guest_stack_size;
=20
 static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
 {
-    return page_check_range((target_ulong)addr, size,
+    return guest_addr_valid(addr) &&
+           (size =3D=3D 0 || guest_addr_valid(addr + size - 1)) &&
+           page_check_range((target_ulong)addr, size,
                             (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAG=
E_READ | PAGE_WRITE)) =3D=3D 0;
 }
=20
--=20
2.21.0


