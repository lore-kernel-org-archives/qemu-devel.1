Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjdw-0006Uh-07
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjdt-0003JS-JO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fPjdt-0003JG-EO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  4 Jun 2018 15:10:49 +0800
Message-Id: <20180604071050.12492-2-famz@redhat.com>
In-Reply-To: <20180604071050.12492-1-famz@redhat.com>
References: <20180604071050.12492-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] tests/docker/Makefile.include: handle empty
 TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

If the user doesn't specify a TARGET_LIST they get the current
configuration but with spaces and hilarity ensues. This adds some make
magic to turn the TARGET_LIST back into a comma separated list.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Message-Id: <20180521103504.26432-1-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 rules.mak                     | 3 +++
 tests/docker/Makefile.include | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/rules.mak b/rules.mak
index 04c7f74d07..bbb2667928 100644
--- a/rules.mak
+++ b/rules.mak
@@ -1,4 +1,7 @@
=20
+# These are used when we want to do substitutions without confusing Make
+NULL  :=3D
+SPACE :=3D $(NULL) #
 COMMA :=3D ,
=20
 # Don't use implicit rules or variables
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 31f21a43f5..9d5749887a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -140,7 +140,7 @@ docker-run: docker-qemu-src
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=3D$(NETWORK)),--net=
=3Dnone) \
-			-e TARGET_LIST=3D$(TARGET_LIST) 			\
+			-e TARGET_LIST=3D$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
 			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=3D$V -e J=3D$J -e DEBUG=3D$(DEBUG)		\
 			-e SHOW_ENV=3D$(SHOW_ENV) 			\
--=20
2.17.0
