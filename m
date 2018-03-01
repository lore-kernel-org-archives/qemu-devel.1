Received: from eggs.gnu.org ([2001:4830:134:3::10]:40990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7g-0001bN-5V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7f-0000Jb-2k
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7e-0000Id-IM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA6C062E90
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:44:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:42 -0600
Message-Id: <20180301194245.29854-28-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/30] docs: Correct outdated information on QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

* Fix guidance on error classes

* Point to generated documentation

* Drop plea for documentation, because the QAPI code generator
  enforces it since commit 3313b6124b

* Minor tweaks here and there

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-27-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 25 +++++++++----------------
 docs/interop/qmp-intro.txt          |  3 ++-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 776b3b41ca0..50385eff27c 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -36,9 +36,9 @@ very simple and get more complex as we progress.
 For all the examples in the next sections, the test setup is the same an=
d is
 shown here.

-First, QEMU should be started as:
+First, QEMU should be started like this:

-# /path/to/your/source/qemu [...] \
+# qemu-system-TARGET [...] \
     -chardev socket,id=3Dqmp,port=3D4444,host=3Dlocalhost,server \
     -mon chardev=3Dqmp,mode=3Dcontrol,pretty=3Don

@@ -179,7 +179,7 @@ described in the "Testing" section and then send two =
commands:
     }
 }

-You should see "Hello, world" and "we love qemu" in the terminal running=
 qemu,
+You should see "Hello, world" and "We love qemu" in the terminal running=
 qemu,
 if you don't see these strings, then something went wrong.

 =3D=3D=3D Errors =3D=3D=3D
@@ -221,30 +221,23 @@ The QMP server's response should be:
     }
 }

-As a general rule, all QMP errors should use ERROR_CLASS_GENERIC_ERROR
-(done by default when using error_setg()). There are two exceptions to
-this rule:
+Note that error_setg() produces a "GenericError" class.  In general,
+all QMP errors should have that error class.  There are two exceptions
+to this rule:

- 1. A non-generic ErrorClass value exists* for the failure you want to r=
eport
-    (eg. DeviceNotFound)
+ 1. To support a management application's need to recognize a specific
+    error for special handling

- 2. Management applications have to take special action on the failure y=
ou
-    want to report, hence you have to add a new ErrorClass value so that=
 they
-    can check for it
+ 2. Backward compatibility

 If the failure you want to report falls into one of the two cases above,
 use error_set() with a second argument of an ErrorClass value.

- * All existing ErrorClass values are defined in the qapi-schema.json fi=
le
-
 =3D=3D=3D Command Documentation =3D=3D=3D

 There's only one step missing to make "hello-world"'s implementation com=
plete,
 and that's its documentation in the schema file.

-This is very important. No QMP command will be accepted in QEMU without =
proper
-documentation.
-
 There are many examples of such documentation in the schema file already=
, but
 here goes "hello-world"'s new entry for qapi/misc.json:

diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index adbc94abb1d..430fe1b7472 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -78,7 +78,8 @@ Escape character is '^]'.
     }
 }

-Please, refer to the qapi-schema.json file for a complete command refere=
nce.
+Please refer to docs/interop/qemu-qmp-ref.* for a complete command
+reference, generated from qapi-schema.json.

 QMP wiki page
 -------------
--=20
2.14.3
