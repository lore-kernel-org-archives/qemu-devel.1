Received: from eggs.gnu.org ([2001:4830:134:3::10]:59896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33W-0003fK-NY
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33V-0006hf-Or
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33V-0006hF-K3
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C834464C5
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:33 +0100
Message-Id: <20170113144135.5150-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 19/21] build-sys: use a generic TEXI2MAN rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The recipe for making a man page from .texi is duplicated several
times over.  Capture it in suitable pattern rules instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile  | 24 ------------------------
 rules.mak | 10 ++++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 1d6a31deb3..4a4a34ed8b 100644
--- a/Makefile
+++ b/Makefile
@@ -552,35 +552,11 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(=
SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< qemu.pod && \
-	  $(POD2MAN) --section=3D1 --center=3D" " --release=3D" " qemu.pod > $@=
, \
-	  "GEN","$@")
 qemu.1: qemu-option-trace.texi
-
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< qemu-img.pod && \
-	  $(POD2MAN) --section=3D1 --center=3D" " --release=3D" " qemu-img.pod =
> $@, \
-	  "GEN","$@")
-
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< fsdev/virtfs-proxy-hel=
per.pod && \
-	  $(POD2MAN) --section=3D1 --center=3D" " --release=3D" " fsdev/virtfs-=
proxy-helper.pod > $@, \
-	  "GEN","$@")
-
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< qemu-nbd.pod && \
-	  $(POD2MAN) --section=3D8 --center=3D" " --release=3D" " qemu-nbd.pod =
> $@, \
-	  "GEN","$@")
-
 qemu-ga.8: qemu-ga.texi
-	$(call quiet-command, \
-	  perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< qemu-ga.pod && \
-	  $(POD2MAN) --section=3D8 --center=3D" " --release=3D" " qemu-ga.pod >=
 $@, \
-	  "GEN","$@")
=20
 html: qemu-doc.html
 info: qemu-doc.info
diff --git a/rules.mak b/rules.mak
index ce9e7e6ffe..a7b6c0b020 100644
--- a/rules.mak
+++ b/rules.mak
@@ -363,3 +363,13 @@ define unnest-vars
         $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
         $(eval $v :=3D $(filter-out %/,$($v))))
 endef
+
+TEXI2MAN =3D $(call quiet-command, \
+	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< $@.pod && \
+	$(POD2MAN) --section=3D$(subst .,,$(suffix $@)) --center=3D" " --releas=
e=3D" " $@.pod > $@, \
+	"GEN","$@")
+
+%.1:
+	$(call TEXI2MAN)
+%.8:
+	$(call TEXI2MAN)
--=20
2.11.0
