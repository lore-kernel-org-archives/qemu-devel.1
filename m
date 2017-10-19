Received: from eggs.gnu.org ([2001:4830:134:3::10]:34406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e5H3q-00056U-0M
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e5H3m-0005fT-0P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:04:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alindsay@codeaurora.org>)
	id 1e5H3l-0005et-NG
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:04:53 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Thu, 19 Oct 2017 16:04:43 -0400
Message-Id: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build: Don't force preserving permissions on
 config-devices.mak.old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>, Paul Brook <paul@codesourcery.com>, Aaron Lindsay <alindsay@codeaurora.org>

I get the following error when building on an NFSv3 filesystem:

% make -j8
  GEN     aarch64-softmmu/config-devices.mak.tmp
  GEN     config-host.h
[snip]
  GEN     qmp-marshal.c
  GEN     aarch64-softmmu/config-devices.mak
cp: preserving permissions for =E2=80=98aarch64-softmmu/config-devices.ma=
k.old=E2=80=99: Operation not supported
make: *** Deleting file `aarch64-softmmu/config-devices.mak'
  GEN     qapi-types.c
[snip]
  CC      scsi/qemu-pr-helper.o
make: *** No rule to make target `config-all-devices.mak', needed by `sub=
dir-aarch64-softmmu'.  Stop.
make: *** Waiting for unfinished jobs....

Ideally you would only build on a filesystem with proper support, but I h=
aven't
been able to find a reason why preserving exact permissions is important =
in
this case.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9372742..952b6df 100644
--- a/Makefile
+++ b/Makefile
@@ -287,7 +287,7 @@ endif
 	$(call quiet-command, if test -f $@; then \
 	  if cmp -s $@.old $@; then \
 	    mv $@.tmp $@; \
-	    cp -p $@ $@.old; \
+	    cp $@ $@.old; \
 	  else \
 	    if test -f $@.old; then \
 	      echo "WARNING: $@ (user modified) out of date.";\
@@ -299,7 +299,7 @@ endif
 	  fi; \
 	 else \
 	  mv $@.tmp $@; \
-	  cp -p $@ $@.old; \
+	  cp $@ $@.old; \
 	 fi,"GEN","$@");
=20
 defconfig:
--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
