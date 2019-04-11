Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D59DC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145402082E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145402082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdsb-0001jX-D0
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:52:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hEdrh-0001QQ-VS
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hEdrg-0005ke-1U
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:51:57 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:48681
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hEdre-0005ZR-6X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:51:54 -0400
Received: from brogers1.provo.novell.com (brogers1.dnsdhcp.provo.novell.com
	[137.65.133.7]) by mail.novell.com with ESMTP (NOT encrypted);
	Thu, 11 Apr 2019 11:51:43 -0600
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 11:51:38 -0600
Message-Id: <20190411175138.12838-1-brogers@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.124
Subject: [Qemu-devel] [PATCH] hw/smbios: handle both file formats regardless
 of machine type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bruce Rogers <brogers@suse.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411175138.tbW2i4VkqeVfPQESIm2POk-0qZsUT24PqTFT_pt1I5o@z>

It's easy enough to handle either per-spec or legacy smbios structures
in the smbios file input without regard to the machine type used, by
simply applying the basic smbios formatting rules. then depending on
what is detected. terminal numm bytes are added or removed for machine
type specific processing.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/smbios/smbios.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 47be9071fa..d4b95ebc84 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -960,6 +960,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         struct smbios_structure_header *header;
         int size;
         struct smbios_table *table; /* legacy mode only */
+        uint8_t *dbl_nulls, *orig_end;
 
         qemu_opts_validate(opts, qemu_smbios_file_opts, &err);
         if (err) {
@@ -974,11 +975,21 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         }
 
         /*
-         * NOTE: standard double '\0' terminator expected, per smbios spec.
-         * (except in legacy mode, where the second '\0' is implicit and
-         *  will be inserted by the BIOS).
+         * NOTE: standard double '\0' terminator expected, per smbios spec,
+         * unless the data is formatted for legacy mode, which is used by
+         * pc-i440fx-2.0 and earlier machine types. Legacy mode structures
+         * without strings have no '\0' terminators, and those with strings
+         * also don't have an additional '\0' terminator at the end of the
+         * final string '\0' terminator. The BIOS will add the '\0' terminators
+         * to comply with the smbios spec.
+         * For greater compatibility, regardless of the machine type used,
+         * either format is accepted.
          */
-        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
+        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size + 2);
+        orig_end = smbios_tables + smbios_tables_len + size;
+        /* add extra null bytes to end in case of legacy file data */
+        *orig_end = '\0';
+        *(orig_end + 1) = '\0';
         header = (struct smbios_structure_header *)(smbios_tables +
                                                     smbios_tables_len);
 
@@ -993,6 +1004,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                        header->type);
             return;
         }
+        for (dbl_nulls = smbios_tables + smbios_tables_len + header->length;
+             dbl_nulls + 2 <= orig_end; dbl_nulls++) {
+            if (*dbl_nulls == '\0' && *(dbl_nulls + 1) == '\0') {
+                break;
+            }
+        }
+        if (dbl_nulls + 2  < orig_end) {
+            error_setg(errp, "SMBIOS file data malformed");
+            return;
+        }
+        /* increase size by how many extra nulls were actually needed */
+        size += dbl_nulls + 2 - orig_end;
+        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
         set_bit(header->type, have_binfile_bitmap);
 
         if (header->type == 4) {
@@ -1013,6 +1037,17 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
          *       delete the one we don't need from smbios_set_defaults(),
          *       once we know which machine version has been requested.
          */
+        if (dbl_nulls + 2 == orig_end) {
+            /* chop off nulls to get legacy format */
+            if (header->length + 2 == size) {
+                size -= 2;
+            } else {
+                size -= 1;
+            }
+        } else {
+            /* undo conversion from legacy format to per-spec format */
+            size -= dbl_nulls + 2 - orig_end;
+        }
         if (!smbios_entries) {
             smbios_entries_len = sizeof(uint16_t);
             smbios_entries = g_malloc0(smbios_entries_len);
-- 
2.21.0


