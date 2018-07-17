Received: from eggs.gnu.org ([2001:4830:134:3::10]:48505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZN-0005Df-2x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZM-0007J1-3X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZL-0007Il-Ti
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BFA74075789
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:07:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:52 +0200
Message-Id: <1531840015-28804-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] i386: fix regression parsing multiboot
 initrd modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The logic for parsing the multiboot initrd modules was messed up in

  commit 950c4e6c94b15cd0d8b63891dddd7a8dbf458e6a
  Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Date:   Mon Apr 16 12:17:43 2018 +0100

    opts: don't silently truncate long option values

Causing the length to be undercounter, and the number of modules over
counted. It also passes NULL to get_opt_value() which was not robust
at accepting a NULL value.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180514171913.17664-2-berrange@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/multiboot.c | 3 +--
 util/qemu-option.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 7a2953e..8e26545 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -292,8 +292,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     cmdline_len +=3D strlen(kernel_cmdline) + 1;
     if (initrd_filename) {
         const char *r =3D get_opt_value(initrd_filename, NULL);
-        cmdline_len +=3D strlen(r) + 1;
-        mbs.mb_mods_avail =3D 1;
+        cmdline_len +=3D strlen(initrd_filename) + 1;
         while (1) {
             mbs.mb_mods_avail++;
             r =3D get_opt_value(r, NULL);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 19761e3..834217f 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -75,7 +75,9 @@ const char *get_opt_value(const char *p, char **value)
     size_t capacity =3D 0, length;
     const char *offset;
=20
-    *value =3D NULL;
+    if (value) {
+        *value =3D NULL;
+    }
     while (1) {
         offset =3D qemu_strchrnul(p, ',');
         length =3D offset - p;
--=20
1.8.3.1
