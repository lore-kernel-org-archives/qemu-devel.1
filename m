Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FADC7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DFE2251A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DFE2251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqmG-0005Fg-FH
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpqln-0003bR-2z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpqll-00026B-2I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpqlj-00023S-37
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:07:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3913F30821A0;
 Tue, 23 Jul 2019 09:07:33 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.36.118.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E04B25D9DE;
 Tue, 23 Jul 2019 09:07:30 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 11:07:18 +0200
Message-Id: <20190723090718.14590-3-sgarzare@redhat.com>
In-Reply-To: <20190723090718.14590-1-sgarzare@redhat.com>
References: <20190723090718.14590-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 23 Jul 2019 09:07:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] hw/i386/pc: Map into memory the initrd
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
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
 hw/i386/pc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..b139589777 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1241,17 +1241,20 @@ static void load_linux(PCMachineState *pcms,
=20
             /* load initrd */
             if (initrd_filename) {
+                GMappedFile *gmf;
                 gsize initrd_size;
                 gchar *initrd_data;
                 GError *gerr =3D NULL;
=20
-                if (!g_file_get_contents(initrd_filename, &initrd_data,
-                            &initrd_size, &gerr)) {
+                gmf =3D g_mapped_file_new(initrd_filename, false, &gerr)=
;
+                if (!gmf) {
                     fprintf(stderr, "qemu: error reading initrd %s: %s\n=
",
                             initrd_filename, gerr->message);
                     exit(1);
                 }
=20
+                initrd_data =3D g_mapped_file_get_contents(gmf);
+                initrd_size =3D g_mapped_file_get_length(gmf);
                 initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_data=
_size - 1;
                 if (initrd_size >=3D initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot s=
upport."
@@ -1378,6 +1381,7 @@ static void load_linux(PCMachineState *pcms,
=20
     /* load initrd */
     if (initrd_filename) {
+        GMappedFile *gmf;
         gsize initrd_size;
         gchar *initrd_data;
         GError *gerr =3D NULL;
@@ -1387,12 +1391,15 @@ static void load_linux(PCMachineState *pcms,
             exit(1);
         }
=20
-        if (!g_file_get_contents(initrd_filename, &initrd_data,
-                                 &initrd_size, &gerr)) {
+        gmf =3D g_mapped_file_new(initrd_filename, false, &gerr);
+        if (!gmf) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, gerr->message);
             exit(1);
         }
+
+        initrd_data =3D g_mapped_file_get_contents(gmf);
+        initrd_size =3D g_mapped_file_get_length(gmf);
         if (initrd_size >=3D initrd_max) {
             fprintf(stderr, "qemu: initrd is too large, cannot support."
                     "(max: %"PRIu32", need %"PRId64")\n",
--=20
2.20.1


