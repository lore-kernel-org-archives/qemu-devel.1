Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAT-0007Tl-Cq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAS-0007Tx-AS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45464
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAS-0007TP-2O
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JHxQQr082539
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dpy0mpp0f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:30 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:36 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 02/21] tpm-tis: remove RAISE_STS_IRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This look like temporary hacking code. It shouldn't be necessary in
release code, or there should be a runtime option for it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a9e9cbd..c54dac3 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -43,9 +43,6 @@
     } \
 } while (0);
=20
-/* whether the STS interrupt is supported */
-#define RAISE_STS_IRQ
-
 /* tis registers */
 #define TPM_TIS_REG_ACCESS                0x00
 #define TPM_TIS_REG_INT_ENABLE            0x08
@@ -98,21 +95,11 @@
 #define TPM_TIS_INT_POLARITY_MASK         (3 << 3)
 #define TPM_TIS_INT_POLARITY_LOW_LEVEL    (1 << 3)
=20
-#ifndef RAISE_STS_IRQ
-
-#define TPM_TIS_INTERRUPTS_SUPPORTED (TPM_TIS_INT_LOCALITY_CHANGED | \
-                                      TPM_TIS_INT_DATA_AVAILABLE   | \
-                                      TPM_TIS_INT_COMMAND_READY)
-
-#else
-
 #define TPM_TIS_INTERRUPTS_SUPPORTED (TPM_TIS_INT_LOCALITY_CHANGED | \
                                       TPM_TIS_INT_DATA_AVAILABLE   | \
                                       TPM_TIS_INT_STS_VALID | \
                                       TPM_TIS_INT_COMMAND_READY)
=20
-#endif
-
 #define TPM_TIS_CAP_INTERFACE_VERSION1_3 (2 << 28)
 #define TPM_TIS_CAP_INTERFACE_VERSION1_3_FOR_TPM2_0 (3 << 28)
 #define TPM_TIS_CAP_DATA_TRANSFER_64B    (3 << 9)
@@ -377,12 +364,8 @@ static void tpm_tis_receive_bh(void *opaque)
         tpm_tis_abort(s, locty);
     }
=20
-#ifndef RAISE_STS_IRQ
-    tpm_tis_raise_irq(s, locty, TPM_TIS_INT_DATA_AVAILABLE);
-#else
     tpm_tis_raise_irq(s, locty,
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID=
);
-#endif
 }
=20
 /*
@@ -421,9 +404,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_=
t locty)
         if (tis->loc[locty].r_offset >=3D len) {
             /* got last byte */
             tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_VALID);
-#ifdef RAISE_STS_IRQ
             tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
-#endif
         }
         DPRINTF("tpm_tis: tpm_tis_data_read byte 0x%02x   [%d]\n",
                 ret, tis->loc[locty].r_offset-1);
@@ -912,9 +893,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
             if (tis->loc[locty].w_offset > 5 &&
                 (tis->loc[locty].sts & TPM_TIS_STS_EXPECT)) {
                 /* we have a packet length - see if we have all of it */
-#ifdef RAISE_STS_IRQ
                 bool need_irq =3D !(tis->loc[locty].sts & TPM_TIS_STS_VA=
LID);
-#endif
+
                 len =3D tpm_tis_get_size_from_buffer(&tis->loc[locty].w_=
buffer);
                 if (len > tis->loc[locty].w_offset) {
                     tpm_tis_sts_set(&tis->loc[locty],
@@ -923,11 +903,9 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr =
addr,
                     /* packet complete */
                     tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_VALID)=
;
                 }
-#ifdef RAISE_STS_IRQ
                 if (need_irq) {
                     tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
                 }
-#endif
             }
         }
         break;
--=20
2.5.5
