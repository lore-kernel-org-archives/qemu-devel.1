Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZQ-0005HD-H8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZO-0007Kj-O1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZO-0007KR-J4
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40F017B2B3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:07:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:54 +0200
Message-Id: <1531840015-28804-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/13] opts: remove redundant check for NULL
 parameter
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

No callers of get_opt_value() pass in a NULL for the "value" parameter,
so the check is redundant.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180514171913.17664-4-berrange@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-option.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 834217f..01886ef 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -75,20 +75,16 @@ const char *get_opt_value(const char *p, char **value=
)
     size_t capacity =3D 0, length;
     const char *offset;
=20
-    if (value) {
-        *value =3D NULL;
-    }
+    *value =3D NULL;
     while (1) {
         offset =3D qemu_strchrnul(p, ',');
         length =3D offset - p;
         if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
             length++;
         }
-        if (value) {
-            *value =3D g_renew(char, *value, capacity + length + 1);
-            strncpy(*value + capacity, p, length);
-            (*value)[capacity + length] =3D '\0';
-        }
+        *value =3D g_renew(char, *value, capacity + length + 1);
+        strncpy(*value + capacity, p, length);
+        (*value)[capacity + length] =3D '\0';
         capacity +=3D length;
         if (*offset =3D=3D '\0' ||
             *(offset + 1) !=3D ',') {
--=20
1.8.3.1
