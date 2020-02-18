Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA86C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E8520659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="attFcFDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zZT-0000v9-F6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQa-0001nn-Tk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQZ-00062F-Uv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQY-0005zr-R6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCQCf8OR1kY+/p5b4mHJ3QG09v3lGeftuZ/e10MXqmo=;
 b=attFcFDn/PAl2t/iz7ta77weDRVagqe/M8+3yrDaHrGxFeoFgl/XPisz3nVZOVJzAUWlUP
 3ptYFuNlw4NJMHpx0Wmckps4VYen+l1sAiA7bYbBLNIWwLIa3UBrkR4erN6MMz9AqIyxtM
 yoAgsyAe87ihVzG2kWp1CLGc1jO2sbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-7vf33f-kNcuHsWr5FpMYiA-1; Tue, 18 Feb 2020 04:44:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so10555374wrw.14
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JTAYCeyl+pNe1lk0kNlsj14Fj0ev9DGEUp2oxJFg1Hs=;
 b=NkV9mmGgx+3UNrPbBAl6LDhikyBmJIZgIwR3eubvHJnTAhOWYApIPtKxJBFCSwqTVO
 FcWGqTNFY4Dc7ha9cHjLNyRRhTpkQkNzLXoEzNmUsPGX8qGaK61q6Zngdk/k2pDjzd6c
 5Y0DmrOWu0NUYsrSiu8gT4vmmcN8/VToq5w4M1bpEakSVvcuZl3DaK55Sej23xeq8ypE
 ITIiUejtRpE/17WRpOJ4t1W7WL/bQ6RbKM3vbx6BhwEvTppRy/nzvb5H3f7Pz2iS7sju
 r3wguA1ucUm5gh2dugLfRWhYCqbXtMiqlDSHGYw+bvZdgs/Jg043uToqM2iZSSFxAz1S
 xzvg==
X-Gm-Message-State: APjAAAV9imC/539dXpd31k00gBaTE85SlpyQwHCWOyhzkqndYm8be4yt
 k9Plu3cOL8KT73sm/RQqIMWOluGHZxhFaZVjVgSfKZmJrkbiUlH4jPUsQ/6MCENZyGPxMbrjCjD
 NFEnD2MFSOKY3YxE=
X-Received: by 2002:adf:de86:: with SMTP id w6mr29018416wrl.115.1582019055798; 
 Tue, 18 Feb 2020 01:44:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzD3WAqCTdNNHxCg7SaFclNwM4okabSxUgrIr/k78N7Ojb2sIYWq5/FjLXEWQXGej3Q7K1WA==
X-Received: by 2002:adf:de86:: with SMTP id w6mr29018383wrl.115.1582019055600; 
 Tue, 18 Feb 2020 01:44:15 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 05/13] hw/arm/xlnx-versal: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:54 +0100
Message-Id: <20200218094402.26625-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 7vf33f-kNcuHsWr5FpMYiA-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 6f16da53ffe
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c467..0d2e3bdda1 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -350,7 +350,7 @@ static void create_virtio_regions(VersalVirt *s)
     int i;
=20
     for (i =3D 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        char *name =3D g_strdup_printf("virtio%d", i);;
+        char *name =3D g_strdup_printf("virtio%d", i);
         hwaddr base =3D MM_TOP_RSVD + i * virtio_mmio_size;
         int irq =3D VERSAL_RSVD_IRQ_FIRST + i;
         MemoryRegion *mr;
--=20
2.21.1


