Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD44C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA42E20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoEEGg6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA42E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxV6-0005SE-3n
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHv-00045t-Dd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHs-0006Lt-1s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHq-0006E0-6d
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tag38lhnvG1hJ+kq614FsjPtBK+zW3BKx6L1S1mj9hw=;
 b=WoEEGg6af+E93BPoW0MPalrDHRnWUJgjV+jSy50SDOa/7xCsDDY4t6JIOWj0hsqQS/K82K
 9WJOazF8E6AmufQHc7QWwY6Fr1SkttmWSw7Zx/TJzyCS/HEP99iDCMMRXrzDeGaCIHmEnX
 P809C0jynpk5Ju0ByYpdXWE0MKMLRPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-AezbGN8wMjuQcjRhvaV06A-1; Mon, 16 Mar 2020 17:28:34 -0400
X-MC-Unique: AezbGN8wMjuQcjRhvaV06A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41221085925
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:33 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C9FA19C4F;
 Mon, 16 Mar 2020 21:28:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/61] exec/rom_reset: Free rom data during inmigrate skip
Date: Mon, 16 Mar 2020 22:27:00 +0100
Message-Id: <1584394048-44994-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/loader.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d1b78f6..eeef6da 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1119,19 +1119,26 @@ static void rom_reset(void *unused)
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
+         * that some of those RAMs can actually be modified by the guest.
+         */
+        if (runstate_check(RUN_STATE_INMIGRATE)) {
+            if (rom->data && rom->isrom) {
+                /*
+                 * Free it so that a rom_reset after migration doesn't
+                 * overwrite a potentially modified 'rom'.
+                 */
+                rom_free_data(rom);
+            }
+            continue;
+        }
+
         if (rom->data =3D=3D NULL) {
             continue;
         }
--=20
1.8.3.1



