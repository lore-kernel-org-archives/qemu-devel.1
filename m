Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE135208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpok0cX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE135208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios2c-0000d3-HT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlV-0008KI-P3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlT-0005fo-J5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlT-0005ey-Fa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=piqn6mX5WQ96VESO5T0tIJ0XhrZt2DhdjHLkZukt+8U=;
 b=Bpok0cX59L4ymg5tc27+VNkPl0w8olMeuNhRvvU28ldWJv0zuLYKQKdGi7i58HHrPESVd7
 C8d098OXXByD834OTt/XGB/mU2jegCzbAAKXcvja/+uL5P43TZzM+No+rtGJj5l/g6InB0
 1Dc19lj8EgvJWdaBx4DRZ+zetIe5vE4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-MtWvPTN0O1CKEkhqIFuc7A-1; Tue, 07 Jan 2020 11:31:28 -0500
Received: by mail-qk1-f200.google.com with SMTP id 65so113853qkl.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tN9j8nC8UNjEIUbDqAKywg3EszM5OfgJu5L0vZrOdtE=;
 b=fkg+8KNp1T030GV8wehSw9hCa6/Rl8i4+tmpzkgVdCEQ8UqnMAj2Ydm+K10odqQan9
 Uu8ckzgwbpUF2Cv6uOjSrOAlxsSdt6QtFnUmiKyuUkqGFwM1zZdNb2nvz/BkzQ/hU6cw
 YJOWLDT2HLQXzNfsfid5QaR5s8GipVy355UPI/m5h8qMaZgjEzE9+QHPr3hAkvuc2Gqh
 jrIMG4EG/ih6aCYLOhtvRRthECvMDcEqpk58J558STuqluEn0egN5c/2TW2uHE+zZu0R
 9nlYBrDcYUH6U85O8d1bmkSWbBdgk+njdb7sTeJ3k1koztWYIyMAcmRAlWG4MyshUO6R
 G7qQ==
X-Gm-Message-State: APjAAAVb7SBsycB0HUEswoePnwqLCr9e6M61d2xCjBN/9k0cItD/z7ja
 3ZULA/zI++kQEyhIX4+aCTX9Cgew43UJzTr+Go5lVnSJIYbUsUjlWIQ9Gr9IZyjXN7rwt+Slv1l
 NQev81KoPVOyikJc=
X-Received: by 2002:a0c:bd2c:: with SMTP id m44mr221783qvg.248.1578414687618; 
 Tue, 07 Jan 2020 08:31:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyf1dU1aJdCxWSZXf+xztBtirWgRPKsyzxoJC0/OAU7jMMoU1MnPn/pCQWCkvUz3TpW+PJVyw==
X-Received: by 2002:a0c:bd2c:: with SMTP id m44mr221735qvg.248.1578414687158; 
 Tue, 07 Jan 2020 08:31:27 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id s91sm102251qtd.50.2020.01.07.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:26 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 25/32] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Message-ID: <20200107162850.411448-26-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: MtWvPTN0O1CKEkhqIFuc7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

5.0 machine type uses 4.2 compats. This seems to be incorrect, since
the latests machine type by now is 5.0 and it should use its own
compat or shouldn't use any relying on the defaults.
Seems, like this appeared because of some problems on merge/rebase.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 721c7aa64e..fa12203079 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -425,7 +425,6 @@ static void pc_i440fx_5_0_machine_options(MachineClass =
*m)
     m->alias =3D "pc";
     m->is_default =3D 1;
     pcmc->default_cpu_version =3D 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 52f45735e4..84cf925cf4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,7 +354,6 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias =3D "q35";
     pcmc->default_cpu_version =3D 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
--=20
MST


