Received: from eggs.gnu.org ([2001:4830:134:3::10]:43822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQurt-0003HZ-KO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQurp-0004aA-KH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQurp-0004ZF-EH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:50:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 694E4C04AC5E
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:50:00 +0000 (UTC)
References: <20171215181810.4122-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
Date: Mon, 18 Dec 2017 13:49:52 +0100
MIME-Version: 1.0
In-Reply-To: <20171215181810.4122-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn when using volatile with
 a comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, lersek@redhat.com

On 15/12/2017 19:18, Marc-Andr=C3=A9 Lureau wrote:
> Instead of an error, lower to a warning message, assuming the comment
> gives some justification.
>=20
> Discussed in:
> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that with=
out a process to debug"'
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We can drop the error at all if there is a comment.  Also, "volatile sig_=
atomic_t" is probably self-explanatory and usually correct.  So what abou=
t this:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f5a523af10..3dc27d9656 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2475,13 +2475,11 @@ sub process {
=20
 # no volatiles please
 		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
-		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
-			my $msg =3D "Use of volatile is usually wrong: see Documentation/vola=
tile-considered-harmful.txt\n" . $herecurr;
-			if (ctx_has_comment($first_line, $linenr)) {
-				WARN($msg);
-			} else {
-				ERROR($msg);
-			}
+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
+                    $line !~ /sig_atomic_t/ &&
+                    !ctx_has_comment($first_line, $linenr)) {
+			my $msg =3D "Use of volatile is usually wrong, please add a comment\n=
" . $herecurr;
+                        ERROR($msg);
 		}
=20
 # warn about #if 0
