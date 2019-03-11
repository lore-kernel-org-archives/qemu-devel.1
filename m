Received: from eggs.gnu.org ([209.51.188.92]:35691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6N-00005d-Sq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6M-0004ae-D0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6K-0004Wu-Es
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE10059454
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 649AF19724
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:19 +0100
Message-Id: <20190311220843.4026-4-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] pflash_cfi01: Log use of flawed "write to
 buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Our implementation of "write to buffer" (command 0xE8) is flawed.
LOG_UNIMP its use, and add some FIXME comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190308094610.21210-4-armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index e6d933a06d..d381f14e3c 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -502,6 +502,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
             break;
         case 0xe8: /* Write to buffer */
             DPRINTF("%s: Write to buffer\n", __func__);
+            /* FIXME should save @offset, @width for case 1+ */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Write to buffer emulation is flawed\n",
+                          __func__);
             pfl->status |=3D 0x80; /* Ready! */
             break;
         case 0xf0: /* Probe for AMD flash */
@@ -545,6 +549,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             /* Mask writeblock size based on device width, or bank width=
 if
              * device width not specified.
              */
+            /* FIXME check @offset, @width */
             if (pfl->device_width) {
                 value =3D extract32(value, 0, pfl->device_width * 8);
             } else {
@@ -582,7 +587,13 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
     case 2:
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
+            /* FIXME check @offset, @width */
             if (!pfl->ro) {
+                /*
+                 * FIXME writing straight to memory is *wrong*.  We
+                 * should write to a buffer, and flush it to memory
+                 * only on confirm command (see below).
+                 */
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
                 pfl->status |=3D 0x10; /* Programming error */
@@ -598,6 +609,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                 pfl->wcycle++;
                 if (!pfl->ro) {
                     /* Flush the entire write buffer onto backing storag=
e.  */
+                    /* FIXME premature! */
                     pflash_update(pfl, offset & mask, pfl->writeblock_si=
ze);
                 } else {
                     pfl->status |=3D 0x10; /* Programming error */
@@ -614,6 +626,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             if (cmd =3D=3D 0xd0) {
+                /* FIXME this is where we should write out the buffer */
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else {
--=20
2.17.2
