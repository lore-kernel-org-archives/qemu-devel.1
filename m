Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B2AC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684F2218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F2218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIqz-0007fE-Jb
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hjIpX-0006jt-KL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hjIpW-000747-C1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:40:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hjIpW-00070t-6M; Fri, 05 Jul 2019 03:40:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E63A33082132;
 Fri,  5 Jul 2019 07:40:11 +0000 (UTC)
Received: from localhost (ovpn-112-40.ams2.redhat.com [10.36.112.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8418D80DA9;
 Fri,  5 Jul 2019 07:40:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 11:39:57 +0400
Message-Id: <20190705073957.2921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 05 Jul 2019 07:40:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on migration load
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
 kraxel@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NO_INTERFACE_INFO (255) is used to indicate no info.

/home/elmarco/src/qemu/hw/usb/redirect.c:1504:71: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
/home/elmarco/src/qemu/hw/usb/redirect.c:1503:71: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
/home/elmarco/src/qemu/hw/usb/redirect.c:1502:68: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D32073=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x625000252930 at pc 0x556c5126b0b6 bp 0x7fc7793ffa50 sp 0x7fc7793ffa40
READ of size 1 at 0x625000252930 thread T0
    #0 0x556c5126b0b5 in usbredir_check_bulk_receiving /home/elmarco/src/=
qemu/hw/usb/redirect.c:1504
    #1 0x556c51275a2a in usbredir_post_load /home/elmarco/src/qemu/hw/usb=
/redirect.c:2154
    #2 0x556c51306f5e in vmstate_load_state /home/elmarco/src/qemu/migrat=
ion/vmstate.c:168
    #3 0x556c512efb43 in vmstate_load /home/elmarco/src/qemu/migration/sa=
vevm.c:829
    #4 0x556c512f9967 in qemu_loadvm_section_start_full /home/elmarco/src=
/qemu/migration/savevm.c:2212
    #5 0x556c512faee1 in qemu_loadvm_state_main /home/elmarco/src/qemu/mi=
gration/savevm.c:2396
    #6 0x556c512fb16b in qemu_loadvm_state /home/elmarco/src/qemu/migrati=
on/savevm.c:2468
    #7 0x556c512c0d2b in process_incoming_migration_co /home/elmarco/src/=
qemu/migration/migration.c:449
    #8 0x556c51b62bcc in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:115
    #9 0x7fc80fba637f  (/lib64/libc.so.6+0x4d37f)

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/redirect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 998fc6e4b0..3bda19bd64 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1495,6 +1495,9 @@ static void usbredir_check_bulk_receiving(USBRedirD=
evice *dev)
     for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
         dev->endpoint[i].bulk_receiving_enabled =3D 0;
     }
+    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) {
+        return;
+    }
     for (i =3D 0; i < dev->interface_info.interface_count; i++) {
         quirks =3D usb_get_quirks(dev->device_info.vendor_id,
                                 dev->device_info.product_id,
--=20
2.22.0.214.g8dca754b1e


