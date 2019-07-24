Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFADC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931EB2190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931EB2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFPf-0002yc-Ox
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqFPA-0000te-Pz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqFP9-0002Md-LP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqFP9-0002MK-EO
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDE363E2CB;
 Wed, 24 Jul 2019 11:25:54 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-46.ams2.redhat.com
 [10.36.117.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F288E19C67;
 Wed, 24 Jul 2019 11:25:49 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 13:25:31 +0200
Message-Id: <20190724112531.232260-4-sgarzare@redhat.com>
In-Reply-To: <20190724112531.232260-1-sgarzare@redhat.com>
References: <20190724112531.232260-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 24 Jul 2019 11:25:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/3] hw/i386/pc: Map into memory the initrd
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to reduce the memory footprint we map into memory
the initrd using g_mapped_file_new() instead of reading it.
In this way we can share the initrd pages between multiple
instances of QEMU.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
  - renamed 'GMappedFile *gmf' in 'GMappedFile *mapped_filed' for readabi=
lity
  - stored the initrd GMappedFile* in PCMachineState to avoid Coverity
    issue [Paolo]
---
 hw/i386/pc.c         | 17 +++++++++++++----
 include/hw/i386/pc.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..96f6b89f70 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1241,17 +1241,21 @@ static void load_linux(PCMachineState *pcms,
=20
             /* load initrd */
             if (initrd_filename) {
+                GMappedFile *mapped_file;
                 gsize initrd_size;
                 gchar *initrd_data;
                 GError *gerr =3D NULL;
=20
-                if (!g_file_get_contents(initrd_filename, &initrd_data,
-                            &initrd_size, &gerr)) {
+                mapped_file =3D g_mapped_file_new(initrd_filename, false=
, &gerr);
+                if (!mapped_file) {
                     fprintf(stderr, "qemu: error reading initrd %s: %s\n=
",
                             initrd_filename, gerr->message);
                     exit(1);
                 }
+                pcms->initrd_mapped_file =3D mapped_file;
=20
+                initrd_data =3D g_mapped_file_get_contents(mapped_file);
+                initrd_size =3D g_mapped_file_get_length(mapped_file);
                 initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_data=
_size - 1;
                 if (initrd_size >=3D initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot s=
upport."
@@ -1378,6 +1382,7 @@ static void load_linux(PCMachineState *pcms,
=20
     /* load initrd */
     if (initrd_filename) {
+        GMappedFile *mapped_file;
         gsize initrd_size;
         gchar *initrd_data;
         GError *gerr =3D NULL;
@@ -1387,12 +1392,16 @@ static void load_linux(PCMachineState *pcms,
             exit(1);
         }
=20
-        if (!g_file_get_contents(initrd_filename, &initrd_data,
-                                 &initrd_size, &gerr)) {
+        mapped_file =3D g_mapped_file_new(initrd_filename, false, &gerr)=
;
+        if (!mapped_file) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, gerr->message);
             exit(1);
         }
+        pcms->initrd_mapped_file =3D mapped_file;
+
+        initrd_data =3D g_mapped_file_get_contents(mapped_file);
+        initrd_size =3D g_mapped_file_get_length(mapped_file);
         if (initrd_size >=3D initrd_max) {
             fprintf(stderr, "qemu: initrd is too large, cannot support."
                     "(max: %"PRIu32", need %"PRId64")\n",
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c51d..44edc6955e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -42,6 +42,7 @@ struct PCMachineState {
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
     PFlashCFI01 *flash[2];
+    GMappedFile *initrd_mapped_file;
=20
     /* Configuration options: */
     uint64_t max_ram_below_4g;
--=20
2.20.1


