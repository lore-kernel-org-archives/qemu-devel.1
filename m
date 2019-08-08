Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA79C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C722171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C722171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvi6v-0008Qk-Cw
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvi6Q-0007lY-9a
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvi6O-000608-Oj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hvi6L-0005y3-Hq; Thu, 08 Aug 2019 09:05:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDB3130253EC;
 Thu,  8 Aug 2019 13:05:04 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A4E05D70D;
 Thu,  8 Aug 2019 13:04:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 15:04:54 +0200
Message-Id: <20190808130454.9930-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 13:05:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hw/ide/atapi: Use the ldst API
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The big-endian load/store functions are already provided
by "qemu/bswap.h".
Avoid code duplication, use the generic API.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/atapi.c | 80 ++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 1b0f66cc08..17a9d635d8 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -45,30 +45,6 @@ static void padstr8(uint8_t *buf, int buf_size, const =
char *src)
     }
 }
=20
-static inline void cpu_to_ube16(uint8_t *buf, int val)
-{
-    buf[0] =3D val >> 8;
-    buf[1] =3D val & 0xff;
-}
-
-static inline void cpu_to_ube32(uint8_t *buf, unsigned int val)
-{
-    buf[0] =3D val >> 24;
-    buf[1] =3D val >> 16;
-    buf[2] =3D val >> 8;
-    buf[3] =3D val & 0xff;
-}
-
-static inline int ube16_to_cpu(const uint8_t *buf)
-{
-    return (buf[0] << 8) | buf[1];
-}
-
-static inline int ube32_to_cpu(const uint8_t *buf)
-{
-    return (buf[0] << 24) | (buf[1] << 16) | (buf[2] << 8) | buf[3];
-}
-
 static void lba_to_msf(uint8_t *buf, int lba)
 {
     lba +=3D 150;
@@ -485,7 +461,7 @@ static inline uint8_t ide_atapi_set_profile(uint8_t *=
buf, uint8_t *index,
     uint8_t *buf_profile =3D buf + 12; /* start of profiles */
=20
     buf_profile +=3D ((*index) * 4); /* start of indexed profile */
-    cpu_to_ube16 (buf_profile, profile);
+    stw_be_p(buf_profile, profile);
     buf_profile[2] =3D ((buf_profile[0] =3D=3D buf[6]) && (buf_profile[1=
] =3D=3D buf[7]));
=20
     /* each profile adds 4 bytes to the response */
@@ -518,9 +494,9 @@ static int ide_dvd_read_structure(IDEState *s, int fo=
rmat,
                 buf[7] =3D 0;   /* default densities */
=20
                 /* FIXME: 0x30000 per spec? */
-                cpu_to_ube32(buf + 8, 0); /* start sector */
-                cpu_to_ube32(buf + 12, total_sectors - 1); /* end sector=
 */
-                cpu_to_ube32(buf + 16, total_sectors - 1); /* l0 end sec=
tor */
+                stl_be_p(buf + 8, 0); /* start sector */
+                stl_be_p(buf + 12, total_sectors - 1); /* end sector */
+                stl_be_p(buf + 16, total_sectors - 1); /* l0 end sector =
*/
=20
                 /* Size of buffer, not including 2 byte size field */
                 stw_be_p(buf, 2048 + 2);
@@ -839,7 +815,7 @@ static void cmd_get_configuration(IDEState *s, uint8_=
t *buf)
     }
=20
     /* XXX: could result in alignment problems in some architectures */
-    max_len =3D ube16_to_cpu(buf + 7);
+    max_len =3D lduw_be_p(buf + 7);
=20
     /*
      * XXX: avoid overflow for io_buffer if max_len is bigger than
@@ -859,16 +835,16 @@ static void cmd_get_configuration(IDEState *s, uint=
8_t *buf)
      * to use as current.  0 means there is no media
      */
     if (media_is_dvd(s)) {
-        cpu_to_ube16(buf + 6, MMC_PROFILE_DVD_ROM);
+        stw_be_p(buf + 6, MMC_PROFILE_DVD_ROM);
     } else if (media_is_cd(s)) {
-        cpu_to_ube16(buf + 6, MMC_PROFILE_CD_ROM);
+        stw_be_p(buf + 6, MMC_PROFILE_CD_ROM);
     }
=20
     buf[10] =3D 0x02 | 0x01; /* persistent and current */
     len =3D 12; /* headers: 8 + 4 */
     len +=3D ide_atapi_set_profile(buf, &index, MMC_PROFILE_DVD_ROM);
     len +=3D ide_atapi_set_profile(buf, &index, MMC_PROFILE_CD_ROM);
-    cpu_to_ube32(buf, len - 4); /* data length */
+    stl_be_p(buf, len - 4); /* data length */
=20
     ide_atapi_cmd_reply(s, len, max_len);
 }
@@ -878,7 +854,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *buf)
     int action, code;
     int max_len;
=20
-    max_len =3D ube16_to_cpu(buf + 7);
+    max_len =3D lduw_be_p(buf + 7);
     action =3D buf[2] >> 6;
     code =3D buf[2] & 0x3f;
=20
@@ -886,7 +862,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *buf)
     case 0: /* current values */
         switch(code) {
         case MODE_PAGE_R_W_ERROR: /* error recovery */
-            cpu_to_ube16(&buf[0], 16 - 2);
+            stw_be_p(&buf[0], 16 - 2);
             buf[2] =3D 0x70;
             buf[3] =3D 0;
             buf[4] =3D 0;
@@ -905,7 +881,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *buf)
             ide_atapi_cmd_reply(s, 16, max_len);
             break;
         case MODE_PAGE_AUDIO_CTL:
-            cpu_to_ube16(&buf[0], 24 - 2);
+            stw_be_p(&buf[0], 24 - 2);
             buf[2] =3D 0x70;
             buf[3] =3D 0;
             buf[4] =3D 0;
@@ -924,7 +900,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *buf)
             ide_atapi_cmd_reply(s, 24, max_len);
             break;
         case MODE_PAGE_CAPABILITIES:
-            cpu_to_ube16(&buf[0], 30 - 2);
+            stw_be_p(&buf[0], 30 - 2);
             buf[2] =3D 0x70;
             buf[3] =3D 0;
             buf[4] =3D 0;
@@ -946,11 +922,11 @@ static void cmd_mode_sense(IDEState *s, uint8_t *bu=
f)
                 buf[14] |=3D 1 << 1;
             }
             buf[15] =3D 0x00; /* No volume & mute control, no changer */
-            cpu_to_ube16(&buf[16], 704); /* 4x read speed */
+            stw_be_p(&buf[16], 704); /* 4x read speed */
             buf[18] =3D 0; /* Two volume levels */
             buf[19] =3D 2;
-            cpu_to_ube16(&buf[20], 512); /* 512k buffer */
-            cpu_to_ube16(&buf[22], 704); /* 4x read speed current */
+            stw_be_p(&buf[20], 512); /* 512k buffer */
+            stw_be_p(&buf[22], 704); /* 4x read speed current */
             buf[24] =3D 0;
             buf[25] =3D 0;
             buf[26] =3D 0;
@@ -998,12 +974,12 @@ static void cmd_read(IDEState *s, uint8_t* buf)
     int nb_sectors, lba;
=20
     if (buf[0] =3D=3D GPCMD_READ_10) {
-        nb_sectors =3D ube16_to_cpu(buf + 7);
+        nb_sectors =3D lduw_be_p(buf + 7);
     } else {
-        nb_sectors =3D ube32_to_cpu(buf + 6);
+        nb_sectors =3D ldl_be_p(buf + 6);
     }
=20
-    lba =3D ube32_to_cpu(buf + 2);
+    lba =3D ldl_be_p(buf + 2);
     if (nb_sectors =3D=3D 0) {
         ide_atapi_cmd_ok(s);
         return;
@@ -1017,7 +993,7 @@ static void cmd_read_cd(IDEState *s, uint8_t* buf)
     int nb_sectors, lba, transfer_request;
=20
     nb_sectors =3D (buf[6] << 16) | (buf[7] << 8) | buf[8];
-    lba =3D ube32_to_cpu(buf + 2);
+    lba =3D ldl_be_p(buf + 2);
=20
     if (nb_sectors =3D=3D 0) {
         ide_atapi_cmd_ok(s);
@@ -1057,7 +1033,7 @@ static void cmd_seek(IDEState *s, uint8_t* buf)
     unsigned int lba;
     uint64_t total_sectors =3D s->nb_sectors >> 2;
=20
-    lba =3D ube32_to_cpu(buf + 2);
+    lba =3D ldl_be_p(buf + 2);
     if (lba >=3D total_sectors) {
         ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
         return;
@@ -1098,15 +1074,15 @@ static void cmd_start_stop_unit(IDEState *s, uint=
8_t* buf)
=20
 static void cmd_mechanism_status(IDEState *s, uint8_t* buf)
 {
-    int max_len =3D ube16_to_cpu(buf + 8);
+    int max_len =3D lduw_be_p(buf + 8);
=20
-    cpu_to_ube16(buf, 0);
+    stw_be_p(buf, 0);
     /* no current LBA */
     buf[2] =3D 0;
     buf[3] =3D 0;
     buf[4] =3D 0;
     buf[5] =3D 1;
-    cpu_to_ube16(buf + 6, 0);
+    stw_be_p(buf + 6, 0);
     ide_atapi_cmd_reply(s, 8, max_len);
 }
=20
@@ -1116,7 +1092,7 @@ static void cmd_read_toc_pma_atip(IDEState *s, uint=
8_t* buf)
     int max_len;
     uint64_t total_sectors =3D s->nb_sectors >> 2;
=20
-    max_len =3D ube16_to_cpu(buf + 7);
+    max_len =3D lduw_be_p(buf + 7);
     format =3D buf[9] >> 6;
     msf =3D (buf[1] >> 1) & 1;
     start_track =3D buf[6];
@@ -1154,15 +1130,15 @@ static void cmd_read_cdvd_capacity(IDEState *s, u=
int8_t* buf)
     uint64_t total_sectors =3D s->nb_sectors >> 2;
=20
     /* NOTE: it is really the number of sectors minus 1 */
-    cpu_to_ube32(buf, total_sectors - 1);
-    cpu_to_ube32(buf + 4, 2048);
+    stl_be_p(buf, total_sectors - 1);
+    stl_be_p(buf + 4, 2048);
     ide_atapi_cmd_reply(s, 8, 8);
 }
=20
 static void cmd_read_disc_information(IDEState *s, uint8_t* buf)
 {
     uint8_t type =3D buf[1] & 7;
-    uint32_t max_len =3D ube16_to_cpu(buf + 7);
+    uint32_t max_len =3D lduw_be_p(buf + 7);
=20
     /* Types 1/2 are only defined for Blu-Ray.  */
     if (type !=3D 0) {
@@ -1196,7 +1172,7 @@ static void cmd_read_dvd_structure(IDEState *s, uin=
t8_t* buf)
     int format =3D buf[7];
     int ret;
=20
-    max_len =3D ube16_to_cpu(buf + 8);
+    max_len =3D lduw_be_p(buf + 8);
=20
     if (format < 0xff) {
         if (media_is_cd(s)) {
--=20
2.20.1


