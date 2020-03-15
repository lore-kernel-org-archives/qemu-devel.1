Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D4C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE92E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8GHKdbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE92E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdbO-0004yS-PQ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8s-0003TG-Lk
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8r-00010S-IH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8r-0000z0-Dq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrqXLxTQz0mEYrpZdea1ftAFgDjw4GVpWcXSJKx0Kfk=;
 b=D8GHKdbJHO8oaPe6Mz3ax3pHuQLa0gl1huNvbSoWBEIPpTdeKxi7DwCO30cy0FuVdS+Zt8
 HopybHBXBd7y9pqBiWYDCv14zXqTszYcsMK8GDE3o6yaSYhUohvQWqEuECPr7HMcuHGxo4
 /lyVeVlSoZaS0ZqRRk04xNRFYNBkUnA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-a__Osr8gN9ybrFFtkJwyLw-1; Sun, 15 Mar 2020 19:57:59 -0400
X-MC-Unique: a__Osr8gN9ybrFFtkJwyLw-1
Received: by mail-wr1-f69.google.com with SMTP id u12so5688147wrw.10
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZnziEWWIqS/GPOcov+nb6Dnv8MFQCtODqZczgbWweM=;
 b=GUuWAAEi9Vhrju+CUVszUTctRqm9gid+xhitrEI2WqGg3tMheT8k1hnfR7NtdVWKn7
 NK6euQR4KK83tIqwS287oXunz3sXVqn8dfl1DD8tmoEjiny68lhyTf0XrL4RJhdA2Y4o
 5ySuC1JHBKEO+9ckNlNuY7VSlRbGbD8H0YTngRpmkpY3cBJSiHQNgpWsdw1dW+rxi7J3
 1HxUv5d15YMRq4VQ403GmIyPTP65PB7jvhS0QIha3GklGJKhraoV2x31cCpOaj4n5rSR
 C55arusJiNHYEaHdcBTVEZ1Nib6VVfgGzFyzfpmojqd9Hmkjw1QHEkOIEAIrHufc8XkF
 aNlQ==
X-Gm-Message-State: ANhLgQ1ypkYQ+4678tMizjy1tTzJk1J0k1EV0szvTyG+sOmfkhjFiYJ/
 thB/M1JQPCtpGserDLfNroIfcaS0JljH45dC+4p9LwQ9cEh29eRlrRsy6PwAoDFSrucaftoYXkG
 xyULVxHJCHv0eW9c=
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr31959725wrt.102.1584316678139; 
 Sun, 15 Mar 2020 16:57:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvFt9gU4znEJ4H91Jd+cteS6sghn/vl4FgyB2z0OHcVOS/QTpXxbRNQNhQnyf400OsrgpbWA==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr31959706wrt.102.1584316677988; 
 Sun, 15 Mar 2020 16:57:57 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id j39sm12580913wre.11.2020.03.15.16.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] target/riscv/cpu: Restrict CPU migration to
 system-mode
Date: Mon, 16 Mar 2020 00:57:11 +0100
Message-Id: <20200315235716.28448-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..b59e09209e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -475,10 +475,12 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
=20
+#ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_riscv_cpu =3D {
     .name =3D "cpu",
     .unmigratable =3D 1,
 };
+#endif
=20
 static Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
@@ -534,13 +536,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
     cc->do_transaction_failed =3D riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access =3D riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug =3D riscv_cpu_get_phys_page_debug;
+    /* For now, mark unmigratable: */
+    cc->vmsd =3D &vmstate_riscv_cpu;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize =3D riscv_translate_init;
     cc->tlb_fill =3D riscv_cpu_tlb_fill;
 #endif
-    /* For now, mark unmigratable: */
-    cc->vmsd =3D &vmstate_riscv_cpu;
     device_class_set_props(dc, riscv_cpu_properties);
 }
=20
--=20
2.21.1


