Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC8C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E9220769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcPMO2Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E9220769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaw8-00044k-8w
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMavX-0003c9-02
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMavV-0001f4-VJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:25:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMavV-0001es-S9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586453117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YVVOB7piyvBYduzoVgeiZFUHFafTaja7XKty8+Jzn58=;
 b=AcPMO2FyYo9QdQI/4weqZboojcYRLgd/c5Q0gz2gG6O8H+u4z2dxYTPXzuBWUlgFA36cNK
 /p3cNzzhXx1/Aot++GpzyOeT+86cl4WcYBBVtzOmYm7QIiEf0q7DoMDXSsYBWEqR7ZArWg
 pM6x5sRI+f0a+GBdk0IitdLs3fszY3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-NPqHGKrDOne6l7RIh3g47w-1; Thu, 09 Apr 2020 13:25:14 -0400
X-MC-Unique: NPqHGKrDOne6l7RIh3g47w-1
Received: by mail-wm1-f70.google.com with SMTP id b203so162169wmd.6
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jDgeQzwFpOkE+RV13h1WdRCe2ZSb3MDfV8dB4086ZlY=;
 b=LSQiQpht/J9po8l/V+RKOMl2x2lKoKCn47qocOxcrgwv3TakYAL99Uy28SrtenmV1s
 X9aEpuqXf3JHSqJjDhL8VomZ2HJ0nRxv3XcfBSasoRByjxuyjH/FAW5A3xpGh20kc1x5
 7fWR4+HOKp0i+fkTareuidQGh/6EzthYoDwsOq08E53iLGLnZ138KEY84hLm6sfbm4+6
 yZqsrHBhWNJfnBlAPHUt3TTqUoD8gvoP3JO0qyRUDoDSH5zSQM8YY5hpfk1bxAsr9rpc
 0G4T6t+yCr/ryMMpbP1yck0Sr4V2m7fVGbA91hRocgp1lPbQMa5bddFLvcF6l2cbTFR/
 DVCQ==
X-Gm-Message-State: AGi0PuZVrG8/DWKY1b5w0/C/a4Bz8QMk8XFcvpv/dtaTNVeU/KBxtZKD
 RPvDkcW1Is2/r1ZrY/KiVz1k0mBpvj42IBTOTRpNlKH79ieSCXzIvf/gbxDA3VYi3GgRp1svw/9
 Jalw0u3qIVkF1HmA=
X-Received: by 2002:a1c:4c0f:: with SMTP id z15mr885936wmf.95.1586453112751;
 Thu, 09 Apr 2020 10:25:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8LqtdPtcVKrSxafgEUmqZUG/HmZCwoCHKG2r/IOMl1+LL+UfqV65JJQUEY6bvorAxm7zIAw==
X-Received: by 2002:a1c:4c0f:: with SMTP id z15mr885928wmf.95.1586453112590;
 Thu, 09 Apr 2020 10:25:12 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n4sm4372836wmi.20.2020.04.09.10.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 10:25:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use of
 GByteArray
Date: Thu,  9 Apr 2020 19:25:08 +0200
Message-Id: <20200409172509.4078-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since a010bdbe719 the gdbstub API takes a GByteArray*.
Unfortunately we forgot to update the gdb_get_reg*()
calls.  Do it now.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20200409164954.36902-1-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/m68k/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c637..cad4083895 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByt=
eArray *mem_buf, int n)
 {
     if (n < 8) {
         int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len +=3D gdb_get_reg16(mem_buf + len, 0);
-        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        len +=3D gdb_get_reg16(mem_buf, 0);
+        len +=3D gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
         return len;
     }
     switch (n) {
--=20
2.21.1


