Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C64A20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCVIrjvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C64A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOXo-0005L3-Iv
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOPN-0007Jd-Lx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOPM-0007Zo-8B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:27:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLfQ-0008P6-5J
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fjs4yVSzX/t7eIZ4BMJCeGD5o8nvdl+6NyWwA/aHCM0=;
 b=fCVIrjvANftPw/cpB8vc7GG2NPioQJ7Z3AUnVzDsLd8yUWu7dH9dsNYx8A0nZhEdBe12PQ
 KPrIaEvm8vF3a66ADEwLEkKpNUMql4RkKMRx3V5TEp0iJ1foSypHn3UKxC9XfWj2Al/nVN
 +zVlOZ3jTXgrxaPT8PJdoTH2q4ZJfJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-_fImy4kmMVWZ7V47WhgILQ-1; Tue, 14 Apr 2020 09:31:54 -0400
X-MC-Unique: _fImy4kmMVWZ7V47WhgILQ-1
Received: by mail-wr1-f70.google.com with SMTP id j16so8003354wrw.20
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RxFffFGRSs8+HS+rlE7EgcZ1aLnSCjkXM0Jmxf700XU=;
 b=jwEuGYIg8w5PKRqVQyATdwRSZpDQrtUFoSe9rRl7b4v9uhkSkYy0+wYjFA1yjQ4MAR
 oPBc/Uh3+JLW/k1F+SYT42PlOmFQ1Kzu5BJg17Asjz7L8d5eNAeifYLW1yf4BEgfv4UF
 hpf6UTZTTRNyRrANFKyF12LyHI6alu8Ds6RbF3At+zMnr0IY9Y9rNEJleZulhBTNLd0R
 QBZNcfNhhgVRWFShVSFFqf753az6QI8T7DSon3WnYbx95cEwiqqX3aFvlzNkb5e/HU4P
 Dp6vCKmYzEP6UuyluElc06kIwn/eMVkcPSzvpFa6EJ/pdyioZ3v3EIeGpWX0Tf2P7MZs
 KUQQ==
X-Gm-Message-State: AGi0PuZJfhvKWw9iJjdFRsWn4uCGm7VByDRQD9Nd+zAMeaL/MaJOwoTR
 lP4pRzOLzHJKQmwWKRxgLnXaw2DKot3kPbkvSRdoNtMAob+qz8Al57/s2r4ffyXhEsegp5EqWlk
 +QFqdgFIw2KwQmdU=
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr23597880wmu.146.1586871112676; 
 Tue, 14 Apr 2020 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJRJH2vy/dj6LD4fLL4gnrOHkxWz7ywj/Mxkgl91RzwfuK8MqCUULM6H1h+c2ndOXnhvXAG4g==
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr23597795wmu.146.1586871111491; 
 Tue, 14 Apr 2020 06:31:51 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s14sm19592651wme.33.2020.04.14.06.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 11/12] gdbstub: Do not use memset() on GByteArray
Date: Tue, 14 Apr 2020 15:30:51 +0200
Message-Id: <20200414133052.13712-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Since v1: Use memset (pm215)
---
 include/exec/gdbstub.h  | 10 ++++++++++
 target/arm/gdbstub.c    |  3 +--
 target/xtensa/gdbstub.c |  6 ++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 30b909ebd2..f44bdd2270 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,16 @@ static inline int gdb_get_reg128(GByteArray *buf, uint=
64_t val_hi,
     return 16;
 }
=20
+static inline int gdb_get_zeroes(GByteArray *array, size_t len)
+{
+    guint oldlen =3D array->len;
+
+    g_byte_array_set_size(array, oldlen + len);
+    memset(array->data + oldlen, 0, len);
+
+    return len;
+}
+
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8efc535f2a..063551df23 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -47,8 +47,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *m=
em_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
-        memset(mem_buf, 0, 12);
-        return 12;
+        return gdb_get_zeroes(mem_buf, 12);
     }
     switch (n) {
     case 24:
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 0ee3feabe5..4d43f1340a 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -105,8 +105,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
         default:
             qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size %=
d\n",
                           __func__, n, reg->size);
-            memset(mem_buf, 0, reg->size);
-            return reg->size;
+            return gdb_get_zeroes(mem_buf, reg->size);
         }
=20
     case xtRegisterTypeWindow: /*a*/
@@ -115,8 +114,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
     default:
         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n"=
,
                       __func__, n, reg->type);
-        memset(mem_buf, 0, reg->size);
-        return reg->size;
+        return gdb_get_zeroes(mem_buf, reg->size);
     }
 }
=20
--=20
2.21.1


