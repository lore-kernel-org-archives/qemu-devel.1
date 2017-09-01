Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUs-0000Tg-V4
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0007P1-1b
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUk-0007Nf-N9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9136B769E9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE37A63AC
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:56:06 +0200
Message-Id: <20170901125611.29295-43-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/47] qapi: Avoid unnecessary use of enum
 lookup table's sentinel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently, the FOO_lookup[] generated for QAPI enum types are
terminated by a NULL sentinel.

A future patch will generate enums with "holes".  NULL-termination
will cease to work then.

To prepare for that, replace "have we reached the sentinel?"
predicates by "have we reached the FOO__MAX value?" predicates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-12-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c                          | 4 ++--
 tests/test-qobject-input-visitor.c | 2 +-
 tests/test-string-input-visitor.c  | 2 +-
 ui/input-legacy.c                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 135ec2de8f..86438f4b75 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3249,7 +3249,7 @@ void netdev_add_completion(ReadLineState *rs, int n=
b_args, const char *str)
     }
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
-    for (i =3D 0; NetClientDriver_lookup[i]; i++) {
+    for (i =3D 0; i < NET_CLIENT_DRIVER__MAX; i++) {
         add_completion_option(rs, str, NetClientDriver_lookup[i]);
     }
 }
@@ -3537,7 +3537,7 @@ void watchdog_action_completion(ReadLineState *rs, =
int nb_args, const char *str)
         return;
     }
     readline_set_completion_index(rs, strlen(str));
-    for (i =3D 0; WatchdogExpirationAction_lookup[i]; i++) {
+    for (i =3D 0; i < WATCHDOG_EXPIRATION_ACTION__MAX; i++) {
         add_completion_option(rs, str, WatchdogExpirationAction_lookup[i=
]);
     }
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index bcf02617dc..5bbfb65a02 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -382,7 +382,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
     Visitor *v;
     EnumOne i;
=20
-    for (i =3D 0; EnumOne_lookup[i]; i++) {
+    for (i =3D 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res =3D -1;
=20
         v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
index 79313a7f7a..e7a7b80c92 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -279,7 +279,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
     Visitor *v;
     EnumOne i;
=20
-    for (i =3D 0; EnumOne_lookup[i]; i++) {
+    for (i =3D 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res =3D -1;
=20
         v =3D visitor_input_test_init(data, EnumOne_lookup[i]);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747404..a5f1e829c3 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -61,7 +61,7 @@ int index_from_key(const char *key, size_t key_length)
 {
     int i;
=20
-    for (i =3D 0; QKeyCode_lookup[i] !=3D NULL; i++) {
+    for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
         if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
             !QKeyCode_lookup[i][key_length]) {
             break;
--=20
2.13.5
