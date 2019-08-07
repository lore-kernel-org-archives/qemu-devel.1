Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDECC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E0E2238C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E0E2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHVy-00023E-GN
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hvHVH-0000ok-8H
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hvHVG-0007Nf-8E
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hvHVG-0007MH-2a
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECBD93081CF6
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 08:40:58 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2437525261;
 Wed,  7 Aug 2019 08:40:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:40:48 +0400
Message-Id: <20190807084048.4258-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 07 Aug 2019 08:40:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on vmload
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If interface_count is NO_INTERFACE_INFO, let's not access the arrays
out-of-bounds.

=3D=3D994=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
READ of size 1 at 0x625000243930 thread T0
    #0 0x5642068086a7 in usbredir_check_bulk_receiving /home/elmarco/src/=
qemu/hw/usb/redirect.c:1503
    #1 0x56420681301c in usbredir_post_load /home/elmarco/src/qemu/hw/usb=
/redirect.c:2154
    #2 0x5642068a56c2 in vmstate_load_state /home/elmarco/src/qemu/migrat=
ion/vmstate.c:168
    #3 0x56420688e2ac in vmstate_load /home/elmarco/src/qemu/migration/sa=
vevm.c:829
    #4 0x5642068980cb in qemu_loadvm_section_start_full /home/elmarco/src=
/qemu/migration/savevm.c:2211
    #5 0x564206899645 in qemu_loadvm_state_main /home/elmarco/src/qemu/mi=
gration/savevm.c:2395
    #6 0x5642068998cf in qemu_loadvm_state /home/elmarco/src/qemu/migrati=
on/savevm.c:2467
    #7 0x56420685f3e9 in process_incoming_migration_co /home/elmarco/src/=
qemu/migration/migration.c:449
    #8 0x564207106c47 in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:115
    #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/redirect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 998fc6e4b0..9764a57987 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1495,6 +1495,11 @@ static void usbredir_check_bulk_receiving(USBRedir=
Device *dev)
     for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
         dev->endpoint[i].bulk_receiving_enabled =3D 0;
     }
+
+    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) {
+        return;
+    }
+
     for (i =3D 0; i < dev->interface_info.interface_count; i++) {
         quirks =3D usb_get_quirks(dev->device_info.vendor_id,
                                 dev->device_info.product_id,
--=20
2.23.0.rc1


