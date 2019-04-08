Received: from eggs.gnu.org ([209.51.188.92]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPsi-0005xO-Pa
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hDPsh-0008Mv-96
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:56 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hDPsg-0008Jk-1K
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:43:55 -0400
Received: by mail-qt1-x843.google.com with SMTP id x12so14424554qts.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 01:43:53 -0700 (PDT)
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Mon,  8 Apr 2019 04:42:13 -0400
Message-Id: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
In-Reply-To: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
Subject: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Catherine Ho <catherine.hecx@gmail.com>

Commit 18269069c310 ("migration: Introduce ignore-shared capability")
addes ignore-shared capability to bypass the shared ramblock (e,g,
membackend + numa node). It does good to live migration.

As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
until VM starts, but it does on aarch64 qemu:
Backtrace:
1  0x000055f4a296dd84 in address_space_write_rom_internal () at
exec.c:3458
2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
6  0x000055f4a2c9851d in main () at vl.c:4552

Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
druing rom_reset. In ignore-shared incoming case, this rom filling
is not required since all the data has been stored in memory backend
file.

Further more, as suggested by Peter Xu, if we do rom_reset() now with
these ROMs then the RAM data should be re-filled again too with the
migration stream coming in.

Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
capability")
Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 hw/core/loader.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fe5cb24122..040109464b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1087,6 +1087,15 @@ static void rom_reset(void *unused)
 {
     Rom *rom;
 
+    /*
+     * We don't need to fill in the RAM with ROM data because we'll fill
+     * the data in during the next incoming migration in all cases.  Note
+     * that some of those RAMs can actually be modified by the guest on ARM
+     * so this is probably the only right thing to do here.
+     */
+    if (runstate_check(RUN_STATE_INMIGRATE))
+        return;
+
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
-- 
2.17.1
