Received: from eggs.gnu.org ([2001:4830:134:3::10]:33769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQv51-0004Tu-Bs
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQv4p-0000yR-UU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQv4p-0000y5-Nk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC617C0AC90E
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:03:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Dec 2017 14:03:09 +0100
Message-Id: <20171218130309.2682-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] checkpatch: volatile with a comment or
 sig_atomic_t is okay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, famz@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This assumes that the comment gives some justification;
"volatile sig_atomic_t" is also self-explanatory and usually
correct.

Discussed in:
'[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that withou=
t a process to debug"'

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20171215181810.4122-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34df753571..3dc27d9656 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2475,8 +2475,11 @@ sub process {
=20
 # no volatiles please
 		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
-		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
-			ERROR("Use of volatile is usually wrong: see Documentation/volatile-c=
onsidered-harmful.txt\n" . $herecurr);
+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
+                    $line !~ /sig_atomic_t/ &&
+                    !ctx_has_comment($first_line, $linenr)) {
+			my $msg =3D "Use of volatile is usually wrong, please add a comment\n=
" . $herecurr;
+                        ERROR($msg);
 		}
=20
 # warn about #if 0
--=20
2.14.3
