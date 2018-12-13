Received: from eggs.gnu.org ([2001:4830:134:3::10]:40075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXVE0-000822-BQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXVDx-00053G-36
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXVDw-0004zF-Ro
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37ED23082127
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 17:56:35 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Thu, 13 Dec 2018 12:55:52 -0500
Message-Id: <20181213175552.14857-2-wainersm@redhat.com>
In-Reply-To: <20181213175552.14857-1-wainersm@redhat.com>
References: <20181213175552.14857-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/1] checkpatch: check for malformed comment
 block.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, thuth@redhat.com, ehabkost@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>

Currently scripts/checkpatch.pl does not check if multiline
comments follow the QEMU's coding sytle.

It is added a check for multiline comments that warns about:
    1. block doesn't begin on its own line.
    2. line in the block doesn't start with asterisk.
    3. block doesn't end on its own line.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 60f6f89a27..5abb579ed7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1858,6 +1858,38 @@ sub process {
 		$line =3D~ s@//.*@@;
 		$opline =3D~ s@//.*@@;
=20
+# check for malformed comment block.
+		if ($rawline =3D~ m{/\*} && $rawline !~ m{\*\/}) {
+			if ($rawline !~ m{^.\s*/\*+$}) {
+				WARN("comment block should begin on its own" .
+					" line\n" . $herecurr);
+			}
+
+			my $rel_line =3D 1;
+			my $reported =3D 0;
+			my $comment_line =3D '';
+			my $herecurr =3D '';
+			do {
+				$comment_line =3D $rawlines[$rel_line + $linenr
+					- 1];
+				$herecurr =3D "#".($linenr + $rel_line) .
+					": FILE: ".$realfile .
+					":".($realline + $rel_line)."\n" .
+					$comment_line."\n";
+				if (!$reported && $comment_line !~ m{^.\s*\*}) {
+					WARN("line in comment block should" .
+						" start with asterisk\n" .
+						$herecurr);
+					$reported =3D 1;
+				}
+				$rel_line++;
+			} while ($comment_line && $comment_line !~ m{\*\/});
+
+			if ($comment_line && $comment_line !~ m{^.\s*\*+\/}) {
+				WARN("comment block should end on its own" .
+					" line\n".$herecurr);
+			}
+		}
 # check for global initialisers.
 		if ($line =3D~ /^.$Type\s*$Ident\s*(?:\s+$Modifier)*\s*=3D\s*(0|NULL|f=
alse)\s*;/) {
 			ERROR("do not initialise globals to 0 or NULL\n" .
--=20
2.19.1
