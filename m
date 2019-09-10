Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E01C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB46F20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB46F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fhS-0006NE-Dk
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7fZQ-00081Q-Nd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7fZP-0008JQ-EQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7fZP-0008J3-9S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:48:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 884CAA2FC4E;
 Tue, 10 Sep 2019 12:48:30 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-150.ams2.redhat.com
 [10.36.117.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1469F5D6B2;
 Tue, 10 Sep 2019 12:48:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 14:48:28 +0200
Message-Id: <20190910124828.39794-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 12:48:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] elf-ops.h: fix int overflow in load_elf()
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes a possible integer overflow when we calculate
the total size of ELF segments loaded.

Reported-by: Coverity (CID 1405299)
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
 - not use error_report in load_elf() [Peter]
 - return ELF_LOAD_TOO_BIG
 - add Alex's R-b
---
 include/hw/elf_ops.h | 5 +++++
 include/hw/loader.h  | 1 +
 hw/core/loader.c     | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 1496d7e753..e07d276df7 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -485,6 +485,11 @@ static int glue(load_elf, SZ)(const char *name, int =
fd,
                 }
             }
=20
+            if (mem_size > INT_MAX - total_size) {
+                ret =3D ELF_LOAD_TOO_BIG;
+                goto fail;
+            }
+
             /* address_offset is hack for kernel images that are
                linked at the wrong physical address.  */
             if (translate_fn) {
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 07fd9286e7..48a96cd559 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -89,6 +89,7 @@ int load_image_gzipped(const char *filename, hwaddr add=
r, uint64_t max_sz);
 #define ELF_LOAD_NOT_ELF      -2
 #define ELF_LOAD_WRONG_ARCH   -3
 #define ELF_LOAD_WRONG_ENDIAN -4
+#define ELF_LOAD_TOO_BIG      -5
 const char *load_elf_strerror(int error);
=20
 /** load_elf_ram_sym:
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 32f7cc7c33..75eb56ddbb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -338,6 +338,8 @@ const char *load_elf_strerror(int error)
         return "The image is from incompatible architecture";
     case ELF_LOAD_WRONG_ENDIAN:
         return "The image has incorrect endianness";
+    case ELF_LOAD_TOO_BIG:
+        return "The image segments are too big to load";
     default:
         return "Unknown error";
     }
--=20
2.21.0


