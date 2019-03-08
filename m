Received: from eggs.gnu.org ([209.51.188.92]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C5A-0002Ix-Ts
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C59-0006H8-Q0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:45:58 +0100
Message-Id: <20190308094610.21210-4-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/15] pflash_cfi01: Log use of flawed
 "write to buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

Our implementation of "write to buffer" (command 0xE8) is flawed.
LOG_UNIMP its use, and add some FIXME comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
