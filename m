Received: from eggs.gnu.org ([2001:4830:134:3::10]:59781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33I-0003S1-Ie
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33H-0006Yh-K5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33H-0006YG-Bd
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F0206A6D3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:27 +0100
Message-Id: <20170113144135.5150-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 13/21] texi2pod: learn quotation,
 deftp and deftypefn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Learn a few more markups used for API documentation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/texi2pod.pl | 54 +++++++++++++++++++++++++++++++++++++++++++++++=
+++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 8767662d30..6e8fec41a1 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -37,6 +37,7 @@ $inf =3D "";
 $ibase =3D "";
 @ipath =3D ();
 $encoding =3D undef;
+@args =3D ();
=20
 while ($_ =3D shift) {
     if (/^-D(.*)$/) {
@@ -162,7 +163,8 @@ while(<$inf>) {
 	if ($ended =3D~ /^(?:ifset|ifclear|ignore|menu|iftex)$/) {
 	    $skipping =3D pop @skstack;
 	    next;
-	} elsif ($ended =3D~ /^(?:example|smallexample|display)$/) {
+	} elsif ($ended =3D~ /^(?:example|smallexample|display
+                            |quotation|deftp|deftypefn)$/x) {
 	    $shift =3D "";
 	    $_ =3D "";	# need a paragraph break
 	} elsif ($ended =3D~ /^(?:itemize|enumerate|[fv]?table)$/) {
@@ -303,6 +305,7 @@ while(<$inf>) {
 	$ic =3D~ s/\@(?:code|kbd)/C/;
 	$ic =3D~ s/\@(?:dfn|var|emph|cite|i)/I/;
 	$ic =3D~ s/\@(?:file)/F/;
+	$ic =3D~ s/\@(?:asis)//;
 	$_ =3D "\n=3Dover 4\n";
     };
=20
@@ -323,10 +326,54 @@ while(<$inf>) {
 	$_ =3D "\n=3Ditem ".join (" : ", @columns)."\n";
     };
=20
+    /^\@(quotation)\s*(.+)?$/ and do {
+        push @endwstack, $endw;
+        $endw =3D $1;
+        $_ =3D "\n$2:"
+    };
+
+    /^{(.*)}$|^(.*)$/ and $#args > 0 and do {
+        $kind =3D $args[0];
+        $arguments =3D $1 // "";
+        if ($endw eq "deftypefn") {
+            $ret =3D $args[1];
+            $fname =3D "B<$args[2]>";
+            $_ =3D $ret ? "$ret " : "";
+            $_ .=3D "$fname $arguments ($kind)";
+        } else {
+            $_ =3D "B<$args[1]> ($kind)\n\n$arguments";
+        }
+        @args =3D ();
+    };
+
+    /^\@(deftp)\s*(.+)?$/ and do {
+        push @endwstack, $endw;
+        $endw =3D $1;
+        $arg =3D $2;
+        $arg =3D~ s/{([^}]*)}/$1/g;
+        $arg =3D~ s/\@$//;
+        @args =3D split (/ /, $arg);
+        $_ =3D "";
+    };
+
+    /^\@(deftypefn)\s*(.+)?$/ and do {
+        push @endwstack, $endw;
+        $endw =3D $1;
+        $arg =3D $2;
+        $arg =3D~ s/{([^}]*)}/$1/g;
+        $arg =3D~ s/\@$//;
+        @args =3D split (/ /, $arg);
+        $_ =3D "";
+    };
+
     /^\@itemx?\s*(.+)?$/ and do {
 	if (defined $1) {
-	    # Entity escapes prevent munging by the <> processing below.
-	    $_ =3D "\n=3Ditem $ic\&LT;$1\&GT;\n";
+            if ($ic eq "") {
+                $_ =3D "\n=3Ditem $1\n";
+            } else {
+                # Entity escapes prevent munging by the <> processing be=
low.
+                $_ =3D "\n=3Ditem $ic\&LT;$1\&GT;\n";
+            }
 	} else {
 	    $_ =3D "\n=3Ditem $ic\n";
 	    $ic =3D~ y/A-Ya-y/B-Zb-z/;
@@ -388,6 +435,7 @@ sub postprocess
     s/\@sc\{([^\}]*)\}/\U$1/g;
     s/\@file\{([^\}]*)\}/F<$1>/g;
     s/\@w\{([^\}]*)\}/S<$1>/g;
+    s/\@t\{([^\}]*)\}/$1/g;
     s/\@(?:dmn|math)\{([^\}]*)\}/$1/g;
=20
     # keep references of the form @ref{...}, print them bold
--=20
2.11.0
