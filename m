Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D6CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB072173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5XBVYcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB072173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42rX-0003cD-1T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j42nl-0006a4-LZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j42nj-0000Wd-Rf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j42nj-0000WD-Mn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582032034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/sFMMkb4e3qwBsA4b31ISSU5c6HT2zaacb/ZY1KC50I=;
 b=P5XBVYcxdNka+WF/m0v3bEJPz1hCH6LZ8UJxg3H6pCwrjeB+7N8EcOdICBqDOmbp4pC/74
 PZXN+1li5WynPnNl26+BDbUsj9tAvLr+AQWy6/5pVAbYIQ1gtKerIqfA1NG9PEKDsNozgi
 LIMwZ4/4HWfFaSDM4j1gi9jIdWtgpGg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-3ZUpG6PJNUKP1nmoTCPu1A-1; Tue, 18 Feb 2020 08:20:27 -0500
Received: by mail-wr1-f69.google.com with SMTP id r1so10773354wrc.15
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q0b3JmegZIBOrzOx6D2WeXg3Fr4IgL8v1odhEcx6GCw=;
 b=jrDMtYrGGdTUZNifqvShunMW7q4LSW8QjGFqjKziky/MvnJcghSr/Ea3CBa2TRnGnD
 mdwlpeQH7ydp4SOpNgy0dGLsxrInOShLoCN5CqqMXwpEa+QxQiLuw/N40QnhcfhnTLW9
 rcrf3bqVAydDunTW9a0L6F3MMo4Ue/qZvxyANKEjXTuNTkBOQBMiVA+kbT5G6q3/age1
 /hBAEJxxKeuxU57dtZnbdkL/dFX3fEFR5bY4UlO8ph2BTZNzEidII9FhgTVZr69q6FJk
 rXk1J60B3NmrV0Plp4qkUSgcWf9Pn1/dTGr7wN0zMgvjyuVs/fFHJKd+ZBbxmnUrTITs
 5FPg==
X-Gm-Message-State: APjAAAVXpCS8h5btBs1vk0tAyoZciKKHl+04piPlqAEN048dy8eXx6Ky
 gCQ0wXPF0pFfcMUfWSJzsbL9hIV0iRmO4fNaJsZTXy46RW85lC8/9HagXqotjX/1uo7aw1ovBqi
 YdrAV0wN1uB5IOUA=
X-Received: by 2002:adf:f491:: with SMTP id l17mr31157129wro.149.1582032025046; 
 Tue, 18 Feb 2020 05:20:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKkQEDaHDISgH6qvq3pjfhjQ41Yebtgf20dAvgvUG3VIO2Qwt5nwgZHZ29Nv8QGZy+aHbmpw==
X-Received: by 2002:adf:f491:: with SMTP id l17mr31157097wro.149.1582032024834; 
 Tue, 18 Feb 2020 05:20:24 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m68sm3531219wme.48.2020.02.18.05.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 05:20:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
Date: Tue, 18 Feb 2020 14:20:23 +0100
Message-Id: <20200218132023.22936-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: 3ZUpG6PJNUKP1nmoTCPu1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the included Coccinelle script
scripts/coccinelle/as-rw-const.patch.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20200218112457.22712-1-peter.maydell@linaro.org>

Maybe can be squashed in Peter's patch?

Cocci script can be written as:

    @@
    expression E1, E2, E3, E4, E5;
    symbol true, false;
    @@
    (
    - address_space_rw(E1, E2, E3, E4, E5, false)
    + address_space_read(E1, E2, E3, E4, E5)
    |
    - address_space_rw(E1, E2, E3, E4, E5, 0)
    + address_space_read(E1, E2, E3, E4, E5)
    |
    - address_space_rw(E1, E2, E3, E4, E5, true)
    + address_space_write(E1, E2, E3, E4, E5)
    |
    - address_space_rw(E1, E2, E3, E4, E5, 1)
    + address_space_write(E1, E2, E3, E4, E5)
    )

    @@
    expression E1, E2, E3;
    @@
    (
    - cpu_physical_memory_rw(E1, E2, E3, false)
    + cpu_physical_memory_read(E1, E2, E3)
    |
    - cpu_physical_memory_rw(E1, E2, E3, 0)
    + cpu_physical_memory_read(E1, E2, E3)
    |
    - cpu_physical_memory_rw(E1, E2, E3, true)
    + cpu_physical_memory_write(E1, E2, E3)
    |
    - cpu_physical_memory_rw(E1, E2, E3, 1)
    + cpu_physical_memory_write(E1, E2, E3)
    )
---
 hw/xen/xen_pt_graphics.c             |  2 +-
 target/i386/hax-all.c                |  4 ++--
 scripts/coccinelle/as_rw_const.cocci | 20 +++++++++++++++++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index b69732729b..a3bc7e3921 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -222,7 +222,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHos=
tPCIDevice *dev,
     }
=20
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_rw(0xc0000, bios, bios_size, 1);
+    cpu_physical_memory_write(0xc0000, bios, bios_size);
 }
=20
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a8b6e5aeb8..f5971ccc74 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struc=
t hax_fastmmio *hft)
          *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size, 0)=
;
-        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->size, 1=
);
+        cpu_physical_memory_read(hft->gpa, (uint8_t *)&value, hft->size);
+        cpu_physical_memory_write(hft->gpa2, (uint8_t *)&value, hft->size)=
;
     }
=20
     return 0;
diff --git a/scripts/coccinelle/as_rw_const.cocci b/scripts/coccinelle/as_r=
w_const.cocci
index 30da707701..c9a39f1abe 100644
--- a/scripts/coccinelle/as_rw_const.cocci
+++ b/scripts/coccinelle/as_rw_const.cocci
@@ -1,6 +1,6 @@
 // Avoid uses of address_space_rw() with a constant is_write argument.
 // Usage:
-//  spatch --sp-file as-rw-const.spatch --dir . --in-place
+//  spatch --sp-file scripts/coccinelle/as_rw_const.cocci --dir . --in-pla=
ce
=20
 @@
 expression E1, E2, E3, E4, E5;
@@ -28,3 +28,21 @@ expression E1, E2, E3, E4, E5;
=20
 - address_space_rw(E1, E2, E3, E4, E5, 1)
 + address_space_write(E1, E2, E3, E4, E5)
+
+// Avoid uses of cpu_physical_memory_rw() with a constant is_write argumen=
t.
+@@
+expression E1, E2, E3;
+@@
+(
+- cpu_physical_memory_rw(E1, E2, E3, false)
++ cpu_physical_memory_read(E1, E2, E3)
+|
+- cpu_physical_memory_rw(E1, E2, E3, 0)
++ cpu_physical_memory_read(E1, E2, E3)
+|
+- cpu_physical_memory_rw(E1, E2, E3, true)
++ cpu_physical_memory_write(E1, E2, E3)
+|
+- cpu_physical_memory_rw(E1, E2, E3, 1)
++ cpu_physical_memory_write(E1, E2, E3)
+)
--=20
2.21.1


