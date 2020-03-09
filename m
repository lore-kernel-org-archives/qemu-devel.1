Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1996DC18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4DE205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9NbdP7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4DE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHJ8-0000Kj-3w
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHFj-0003kS-HZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHFi-0008SC-Jt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHFi-0008Rp-GO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583755882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LM9DMNWiI760NtiO1+iofmugtapmqUkn1Z+NOomLjok=;
 b=Q9NbdP7lUHkwQ/7xCDLlnetDoqwR8I/cxiQO44MetNKzKoB42D/BMKWJUMenIWMFZ9smGl
 RhJltkW7Oji5C1bkoxV4ZRJfigDUGS3c1zUBHwzxiieqg8uGdLJxgpHYecfBslI79+XLtJ
 wQxrCpl5iueKE4MfRlz9523kZ/aQtzA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-mjFoLki7OkWkxLck-tHGvQ-1; Mon, 09 Mar 2020 08:11:20 -0400
X-MC-Unique: mjFoLki7OkWkxLck-tHGvQ-1
Received: by mail-ed1-f69.google.com with SMTP id y4so7822697edm.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WfHxGWmhrgeXSkoiuMTUncVrwHERBg1P30j9pqJHkrE=;
 b=dIYqt3PMg6rnhIa11JuvpNl+cIzTpK5GRFZUhDE9jm9N5a+ey12VOg26qub5jvNweS
 kMEvAst7v4s9GFZmdbFvh3qVx0Gjo5JdEmy57D2qVLYr0eoBHwolNa58XYcB6yknCtf7
 yVLJV2zdKTrZ0jQs8TH67iIII9WC+C2FAWMA13l5DQRhYPmNt4UklHK8S1/kpdoF+CvR
 T1fimSAWgXsHWulVjz5Mz36MXCpyn9u318TKlgYineLk5DJraB9aKXQJAxbDm+nwMfcE
 NE5zed+464w0VSExG92UhPi/y9al/M5CC4gTWD4cTo5z5g4q1CjDC88O0q1XJ0Hlb2iO
 JvJw==
X-Gm-Message-State: ANhLgQ0CSMDlpsm4ZaiiNfMYIo6Vh/j/uv/LpXPKoRZ2yBssTHiPO7a/
 j94QV4nJoiJJoW4JN+cfKR4KRi88W0DRFTmOicVXHMxaHBfMbUB/wxmXEUr4+ZVUMv5+qv23F/Q
 lGn3ojSS1XwKf25Q=
X-Received: by 2002:aa7:d689:: with SMTP id d9mr16927240edr.228.1583755879001; 
 Mon, 09 Mar 2020 05:11:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs6xnGbBLi2ziq5PuHRL2x6ef9phKTCiI0J3KHZiX1lNv19kEQVD0jVzxfGnTPw7HyF6lJ8Tw==
X-Received: by 2002:aa7:d689:: with SMTP id d9mr16927219edr.228.1583755878859; 
 Mon, 09 Mar 2020 05:11:18 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c13sm953733edf.36.2020.03.09.05.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:11:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] cpu: Assert a vCPU is created before resetting it
Date: Mon,  9 Mar 2020 13:11:03 +0100
Message-Id: <20200309121103.20234-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309121103.20234-1-philmd@redhat.com>
References: <20200309121103.20234-1-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_reset() might modify architecture-specific fields allocated
by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
commit 00d0f7cb66 when introducing new architectures, assert a
vCPU is created before resetting it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fe65ca62ac..09e49f8d6a 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -251,6 +251,7 @@ void cpu_reset(CPUState *cpu)
 {
     CPUClass *klass =3D CPU_GET_CLASS(cpu);
=20
+    assert(cpu->created);
     if (klass->reset !=3D NULL) {
         (*klass->reset)(cpu);
     }
--=20
2.21.1


