Received: from eggs.gnu.org ([208.118.235.92]:44449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gdfWj-0004oj-4p
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 13:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gdfWi-000153-E6
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 13:09:29 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Sun, 30 Dec 2018 18:09:12 +0000
Message-Id: <20181230180912.14614-2-rjones@redhat.com>
In-Reply-To: <20181230180912.14614-1-rjones@redhat.com>
References: <20181230180912.14614-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-io: Reinitialize optind correctly before
 parsing inner command.
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

  $ ./qemu-io -f raw -c "aio_write 0 512" "nbd:localhost:10809"
  Parsing error: non-numeric argument, or extraneous/unrecognized suffix =
-- aio_write

After main option parsing, we reinitialize optind so we can parse each
command.  The error happens when parsing the aio_write command.  After
the aio_write getopt loop, optind =3D=3D 0 and argv[optind] points to the
command name ("aio_write" in this case).  The code fails because it
tries to parse argv[optind] (which it thinks is the first argument) as
an integer.

In fact optind _starts_ the loop as 0, because we set it to 0.

The FreeBSD manual page says:

  In order to use getopt() to evaluate multiple sets of arguments, or to
  evaluate a single set of arguments multiple times, the variable optrese=
t
  must be set to 1 before the second and each additional set of calls to
  getopt(), and the variable optind must be reinitialized.

(From the rest of the man page it is clear that optind must be
reinitialized to 1).

Unfortunately this conflicts with the glibc man page which says:

  A program that scans multiple argument vectors,  or  rescans  the  same
  vector  more than once, and wants to make use of GNU extensions such as
  '+' and '-' at  the  start  of  optstring,  or  changes  the  value  of
  POSIXLY_CORRECT  between scans, must reinitialize getopt() by resetting
  optind to 0, rather than the traditional value of 1.  (Resetting  to  0
  forces  the  invocation  of  an  internal  initialization  routine that
  rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)

Reinitialize optind to either 0 or 1 depending on whether we're using
glibc or not.

I didn't set optreset - it's not present in glibc and it doesn't seem
to make any difference on FreeBSD.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 qemu-io-cmds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124036..ca4e258579 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -114,7 +114,11 @@ static int command(BlockBackend *blk, const cmdinfo_=
t *ct, int argc,
         }
     }
=20
+#ifdef __GNU_LIBRARY__
     optind =3D 0;
+#else
+    optind =3D 1;
+#endif
     return ct->cfunc(blk, argc, argv);
 }
=20
--=20
2.19.2
