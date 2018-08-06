Received: from eggs.gnu.org ([2001:4830:134:3::10]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOp-0001XN-5K
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOm-00088Q-On
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fmZOm-00087X-Im
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:48 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Aug 2018 08:53:34 +0200
Message-Id: <20180806065344.7103-14-armbru@redhat.com>
In-Reply-To: <20180806065344.7103-1-armbru@redhat.com>
References: <20180806065344.7103-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/23] cpu-plug-test: Don't pass integers as
 strings to device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

test_plug_with_device_add_x86() plugs Haswell-i386-cpu and
Haswell-x86_64-cpu with device_add.  It passes socket-id, core-id,
thread-id as JSON strings.  The properties are actually integers.

test_plug_with_device_add_coreid() plugs power8_v2.0-spapr-cpu-core
and qemu-s390x-cpu with device_add.  It passes core-id as JSON string.
The properties are actually integers.

Passing JSON string values to integer properties works only due to
device_add implementation accidents.  Fix the test to pass JSON
numbers.  While there, use %u rather than %i with unsigned int.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/cpu-plug-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 5f39ba0df3..ab3bf6df90 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -88,8 +88,8 @@ static void test_plug_with_device_add_x86(gconstpointer=
 data)
         for (c =3D 0; c < td->cores; c++) {
             for (t =3D 0; t < td->threads; t++) {
                 char *id =3D g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(td->device_model, id, "'socket-id':=
'%i', "
-                                     "'core-id':'%i', 'thread-id':'%i'",
+                qtest_qmp_device_add(td->device_model, id, "'socket-id':=
%u, "
+                                     "'core-id':%u, 'thread-id':%u",
                                      s, c, t);
                 g_free(id);
             }
@@ -114,7 +114,7 @@ static void test_plug_with_device_add_coreid(gconstpo=
inter data)
=20
     for (c =3D td->cores; c < td->maxcpus / td->sockets / td->threads; c=
++) {
         char *id =3D g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(td->device_model, id, "'core-id':'%i'", c);
+        qtest_qmp_device_add(td->device_model, id, "'core-id':%u", c);
         g_free(id);
     }
=20
--=20
2.17.1
