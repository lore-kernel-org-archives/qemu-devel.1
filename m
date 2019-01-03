Received: from eggs.gnu.org ([208.118.235.92]:34374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gezbK-00015N-EG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gezbI-000575-GI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:47:42 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  3 Jan 2019 09:47:28 +0000
Message-Id: <20190103094728.31747-2-rjones@redhat.com>
In-Reply-To: <20190103094728.31747-1-rjones@redhat.com>
References: <20190103094728.31747-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not 0)
 before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On FreeBSD 11.2:

  $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512" =
$nbd'
  Parsing error: non-numeric argument, or extraneous/unrecognized suffix =
-- aio_write

After main option parsing, we reinitialize optind so we can parse each
command.  However reinitializing optind to 0 does not work on FreeBSD.
What happens when you do this is optind remains 0 after the option
parsing loop, and the result is we try to parse argv[optind] =3D=3D
argv[0] =3D=3D "aio_write" as if it was the first parameter.

The FreeBSD manual page says:

  In order to use getopt() to evaluate multiple sets of arguments, or to
  evaluate a single set of arguments multiple times, the variable optrese=
t
  must be set to 1 before the second and each additional set of calls to
  getopt(), and the variable optind must be reinitialized.

(From the rest of the man page it is clear that optind must be
reinitialized to 1).

The glibc man page says:

  A program that scans multiple argument vectors,  or  rescans  the  same
  vector  more than once, and wants to make use of GNU extensions such as
  '+' and '-' at  the  start  of  optstring,  or  changes  the  value  of
  POSIXLY_CORRECT  between scans, must reinitialize getopt() by resetting
  optind to 0, rather than the traditional value of 1.  (Resetting  to  0
  forces  the  invocation  of  an  internal  initialization  routine that
  rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)

Note I didn't set optreset.  It's not present in glibc and the "hard
reset" is not necessary in this context.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 qemu-io-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124036..aa10ed5a20 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -114,7 +114,7 @@ static int command(BlockBackend *blk, const cmdinfo_t=
 *ct, int argc,
         }
     }
=20
-    optind =3D 0;
+    optind =3D 1;
     return ct->cfunc(blk, argc, argv);
 }
=20
--=20
2.19.2
