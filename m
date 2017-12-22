Received: from eggs.gnu.org ([2001:4830:134:3::10]:41774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkJ-00015L-Jl
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkG-0000hT-HO
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSTkG-0000gf-99
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMKG2Go054954
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:39 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f18sr8994-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:39 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 13:16:38 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 15:16:19 -0500
In-Reply-To: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513973785-14427-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 04/10] tpm_tis: remove TPMSizeBuffer usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Remove usage of TPMSizeBuffer. The size of the buffers is limited now
by s->be_buffer_size, which is the size of the buffer the TIS has
negotiated with the backend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 68 ++++++++++++++++++++++++--------------------------=
------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a6e2f6e..624c269 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -64,8 +64,8 @@ typedef struct TPMLocality {
=20
     uint16_t w_offset;
     uint16_t r_offset;
-    TPMSizedBuffer w_buffer;
-    TPMSizedBuffer r_buffer;
+    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
+    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
 } TPMLocality;
=20
 typedef struct TPMState {
@@ -215,23 +215,19 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr ad=
dr)
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
=20
-static uint32_t tpm_tis_get_size_from_buffer(const TPMSizedBuffer *sb)
-{
-    return tpm_cmd_get_size(sb->buffer);
-}
-
-static void tpm_tis_show_buffer(const TPMSizedBuffer *sb, const char *st=
ring)
+static void tpm_tis_show_buffer(const unsigned char *buffer,
+                                size_t buffer_size, const char *string)
 {
 #ifdef DEBUG_TIS
     uint32_t len, i;
=20
-    len =3D tpm_tis_get_size_from_buffer(sb);
+    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
     DPRINTF("tpm_tis: %s length =3D %d\n", string, len);
     for (i =3D 0; i < len; i++) {
         if (i && !(i % 16)) {
             DPRINTF("\n");
         }
-        DPRINTF("%.2X ", sb->buffer[i]);
+        DPRINTF("%.2X ", buffer[i]);
     }
     DPRINTF("\n");
 #endif
@@ -263,7 +259,8 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t loc=
ty)
 {
     TPMLocality *locty_data =3D &s->loc[locty];
=20
-    tpm_tis_show_buffer(&s->loc[locty].w_buffer, "tpm_tis: To TPM");
+    tpm_tis_show_buffer(s->loc[locty].w_buffer, s->be_buffer_size,
+                        "tpm_tis: To TPM");
=20
     /*
      * w_offset serves as length indicator for length of data;
@@ -273,10 +270,10 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t l=
octy)
=20
     s->cmd =3D (TPMBackendCmd) {
         .locty =3D locty,
-        .in =3D locty_data->w_buffer.buffer,
+        .in =3D locty_data->w_buffer,
         .in_len =3D locty_data->w_offset,
-        .out =3D locty_data->r_buffer.buffer,
-        .out_len =3D locty_data->r_buffer.size
+        .out =3D locty_data->r_buffer,
+        .out_len =3D s->be_buffer_size,
     };
=20
     tpm_backend_deliver_request(s->be_driver, &s->cmd);
@@ -427,7 +424,8 @@ static void tpm_tis_request_completed(TPMIf *ti)
     s->loc[locty].r_offset =3D 0;
     s->loc[locty].w_offset =3D 0;
=20
-    tpm_tis_show_buffer(&s->loc[locty].r_buffer, "tpm_tis: From TPM");
+    tpm_tis_show_buffer(s->loc[locty].r_buffer, s->be_buffer_size,
+                        "tpm_tis: From TPM");
=20
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s, locty);
@@ -446,9 +444,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8=
_t locty)
     uint16_t len;
=20
     if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
-        len =3D tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
+        len =3D MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                  s->be_buffer_size);
=20
-        ret =3D s->loc[locty].r_buffer.buffer[s->loc[locty].r_offset++];
+        ret =3D s->loc[locty].r_buffer[s->loc[locty].r_offset++];
         if (s->loc[locty].r_offset >=3D len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
@@ -494,11 +493,12 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
             "tpm_tis: result buffer : ",
             s->loc[locty].r_offset);
     for (idx =3D 0;
-         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
+         idx < MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                   s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].r_offset =3D=3D idx ? '>' : ' ',
-                s->loc[locty].r_buffer.buffer[idx],
+                s->loc[locty].r_buffer[idx],
                 ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
     }
     DPRINTF("\n"
@@ -506,11 +506,12 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
             "tpm_tis: request buffer: ",
             s->loc[locty].w_offset);
     for (idx =3D 0;
-         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].w_buffer);
+         idx < MIN(tpm_cmd_get_size(s->loc[locty].w_buffer),
+                   s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].w_offset =3D=3D idx ? '>' : ' ',
-                s->loc[locty].w_buffer.buffer[idx],
+                s->loc[locty].w_buffer[idx],
                 ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
     }
     DPRINTF("\n");
@@ -572,11 +573,11 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
         if (s->active_locty =3D=3D locty) {
             if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
                 val =3D TPM_TIS_BURST_COUNT(
-                       tpm_tis_get_size_from_buffer(&s->loc[locty].r_buf=
fer)
+                       MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                           s->be_buffer_size)
                        - s->loc[locty].r_offset) | s->loc[locty].sts;
             } else {
-                avail =3D s->loc[locty].w_buffer.size
-                        - s->loc[locty].w_offset;
+                avail =3D s->be_buffer_size - s->loc[locty].w_offset;
                 /*
                  * byte-sized reads should not return 0x00 for 0x100
                  * available bytes.
@@ -924,9 +925,9 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
             }
=20
             while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0)=
 {
-                if (s->loc[locty].w_offset < s->loc[locty].w_buffer.size=
) {
-                    s->loc[locty].w_buffer.
-                        buffer[s->loc[locty].w_offset++] =3D (uint8_t)va=
l;
+                if (s->loc[locty].w_offset < s->be_buffer_size) {
+                    s->loc[locty].w_buffer[s->loc[locty].w_offset++] =3D
+                        (uint8_t)val;
                     val >>=3D 8;
                     size--;
                 } else {
@@ -940,7 +941,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
                 /* we have a packet length - see if we have all of it */
                 bool need_irq =3D !(s->loc[locty].sts & TPM_TIS_STS_VALI=
D);
=20
-                len =3D tpm_tis_get_size_from_buffer(&s->loc[locty].w_bu=
ffer);
+                len =3D tpm_cmd_get_size(&s->loc[locty].w_buffer);
                 if (len > s->loc[locty].w_offset) {
                     tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VAL=
ID);
@@ -979,15 +980,6 @@ static int tpm_tis_do_startup_tpm(TPMState *s, size_=
t buffersize)
     return tpm_backend_startup_tpm(s->be_driver, buffersize);
 }
=20
-static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
-                                   size_t wanted_size)
-{
-    if (sb->size !=3D wanted_size) {
-        sb->buffer =3D g_realloc(sb->buffer, wanted_size);
-        sb->size =3D wanted_size;
-    }
-}
-
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1040,9 +1032,7 @@ static void tpm_tis_reset(DeviceState *dev)
         s->loc[c].state =3D TPM_TIS_STATE_IDLE;
=20
         s->loc[c].w_offset =3D 0;
-        tpm_tis_realloc_buffer(&s->loc[c].w_buffer, s->be_buffer_size);
         s->loc[c].r_offset =3D 0;
-        tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
=20
     tpm_tis_do_startup_tpm(s, s->be_buffer_size);
--=20
2.5.5
