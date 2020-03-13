Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29633C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A6C20746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnarlCla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A6C20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjTH-0003rl-4D
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 08:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCjSJ-0002zz-Oa
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 08:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCjSH-0003ZW-NR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 08:30:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCjSH-0003Vj-GE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 08:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584102620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A1ldnhv11nZfha8GgNJ8X+vMuJA7v4vHSd/9cFLvZBE=;
 b=VnarlClaXYjJ8A9JW67C9EUTB9/CFUKZ7ZwVQuAbGKv2ghk1DYaIgVGnrkJNWVkcJPJVAq
 aVSVNVE8vkCp/lEHQ+x4hlBze7DVZ5GPSK4Ng69v4XBNnEPPRWqRAcqXMdwhkbMWmcbFjk
 jtprnMMNeD94lL69c3ibvoAkcvprsts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-nr0s2XdzP1em65DXBOKYSA-1; Fri, 13 Mar 2020 08:30:18 -0400
X-MC-Unique: nr0s2XdzP1em65DXBOKYSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A5A1107ACC7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:30:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDA61001925;
 Fri, 13 Mar 2020 12:30:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 yvugenfi@redhat.com
Subject: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
Date: Fri, 13 Mar 2020 12:30:14 +0000
Message-Id: <20200313123014.206828-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Commit 355477f8c73e9 skips rom reset when we're an incoming migration
so as not to overwrite shared ram in the ignore-shared migration
optimisation.
However, it's got an unexpected side effect that because it skips
freeing the ROM data, when rom_reset gets called later on, after
migration (e.g. during a reboot), the ROM does get reset to the original
file contents.  Because of seabios/x86's weird reboot process
this confuses a reboot into hanging after a migration.

Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incoming migrat=
ion")
https://bugzilla.redhat.com/show_bug.cgi?id=3D1809380

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/core/loader.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d1b78f60cd..4e583eb3bd 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1119,19 +1119,24 @@ static void rom_reset(void *unused)
 {
     Rom *rom;
=20
-    /*
-     * We don't need to fill in the RAM with ROM data because we'll fill
-     * the data in during the next incoming migration in all cases.  Note
-     * that some of those RAMs can actually be modified by the guest on AR=
M
-     * so this is probably the only right thing to do here.
-     */
-    if (runstate_check(RUN_STATE_INMIGRATE))
-        return;
-
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
         }
+        /*
+         * We don't need to fill in the RAM with ROM data because we'll fi=
ll
+         * the data in during the next incoming migration in all cases.  N=
ote
+         * that some of those RAMs can actually be modified by the guest o=
n ARM
+         * so this is probably the only right thing to do here.
+         */
+        if (runstate_check(RUN_STATE_INMIGRATE) && rom->data) {
+            /*
+             * Free it so that a rom_reset after migration doesn't overwri=
te a
+             * potentially modified 'rom'.
+             */
+            rom_free_data(rom);
+        }
+
         if (rom->data =3D=3D NULL) {
             continue;
         }
--=20
2.24.1


