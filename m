Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePuYw-0002js-NW
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePuYr-0005Vw-NA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:18:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePuYr-0005VU-H4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B2C74E334
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:18:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 19:18:10 +0100
Message-Id: <20171215181810.4122-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] checkpatch: warn when using volatile with a
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Instead of an error, lower to a warning message, assuming the comment
gives some justification.

Discussed in:
'[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that withou=
t a process to debug"'

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/checkpatch.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34df753571..f5a523af10 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2476,7 +2476,12 @@ sub process {
 # no volatiles please
 		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
 		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
-			ERROR("Use of volatile is usually wrong: see Documentation/volatile-c=
onsidered-harmful.txt\n" . $herecurr);
+			my $msg =3D "Use of volatile is usually wrong: see Documentation/vola=
tile-considered-harmful.txt\n" . $herecurr;
+			if (ctx_has_comment($first_line, $linenr)) {
+				WARN($msg);
+			} else {
+				ERROR($msg);
+			}
 		}
=20
 # warn about #if 0
--=20
2.15.1.355.g36791d7216
