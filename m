Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE5C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CC2233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CC2233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0gzf-0000xI-1P
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 02:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0gxp-0007Jf-Fl
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0gxl-0004gX-1D
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0gxk-0004el-O8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06C371801591
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 06:52:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38D145D713;
 Thu, 22 Aug 2019 06:52:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 776C197A1; Thu, 22 Aug 2019 08:52:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 08:52:38 +0200
Message-Id: <20190822065242.12496-2-kraxel@redhat.com>
In-Reply-To: <20190822065242.12496-1-kraxel@redhat.com>
References: <20190822065242.12496-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 22 Aug 2019 06:52:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/5] usbredir: fix buffer-overflow on vmload
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190807084048.4258-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index fc9fe0c00f4c..be15b9f30334 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1499,6 +1499,11 @@ static void usbredir_check_bulk_receiving(USBRedir=
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
2.18.1


